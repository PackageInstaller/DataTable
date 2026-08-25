local JSON = require("ejoysdk_lua.ejoysdk_json")
local E = require("ejoysdk_lua.ejoysdk")
local EC = require("ejoysdk_lua.ejoysdk_constants")
local M = {}
local TAG = "harmonyos#http_download"
local global_request_task_tag = math.random(1000, 9999)

local function gen_request_tag()
  local request_tag = global_request_task_tag
  global_request_task_tag = global_request_task_tag + 1
  return "ejoy_http_" .. tostring(request_tag)
end

local http_download_task_id_map

local function init_download_id_map()
  local http_download_task_id_map_content = E.SPRawKeyStore.get("ejoysdk_http_download", "id_map")
  if http_download_task_id_map_content then
    http_download_task_id_map = JSON.decode(http_download_task_id_map_content) or {}
  else
    http_download_task_id_map = {}
  end
end

local download_task_queue_size = 2
local current_task_queue_map = {}
local task_cache_array = {}

local function clear_ohos_task(cb)
  local request = lunate.import("@ohos.request")
  request.agent:search(function(err, _task_id_array)
    if err then
      E.LOG.debug(TAG, "search task fail, code is " .. tostring(err.code) .. ", msg is " .. tostring(err.message))
      cb(false)
    else
      E.LOG.debug(TAG, "search task success")
      local task_id_array = lunate.deepcopy(_task_id_array)
      if task_id_array and next(task_id_array) then
        local size = #task_id_array
        local index = 0
        local remove_size = 0
        for _, task_id in ipairs(task_id_array) do
          request.agent:show(task_id, function(show_err, task_info)
            index = index + 1
            if show_err then
              E.LOG.debug(TAG, "query task fail, code is " .. tostring(show_err.code) .. ", msg is " .. tostring(show_err.message))
            else
              E.LOG.debug(TAG, "query task success, task_id is " .. tostring(task_id) .. ", state is " .. tostring(task_info.progress.state))
              if 48 == task_info.progress.state then
                E.LOG.debug(TAG, "remove task " .. tostring(task_id))
                remove_size = remove_size + 1
                request.agent:remove(task_id)
              end
            end
            if index == size then
              E.LOG.debug(TAG, "clear ohos download task complete, remove_size is " .. tostring(remove_size))
              if remove_size > 0 then
                cb(true)
              else
                cb(false)
              end
            end
          end)
        end
      else
        cb(false)
      end
    end
  end)
end

local retry_task_cache = {}

function M.download(type, url, params, cb)
  if not E.Utils.start_with(url, "http") then
    cb({
      status = EC.DOWNLOAD_ERROR_CODES.DOWNLOAD_URL_INVALID
    })
    return
  end
  local jf = lunate.js_functions
  local ejoysdk_task_id = params.taskId
  if not ejoysdk_task_id then
    ejoysdk_task_id = gen_request_tag()
    params.taskId = ejoysdk_task_id
  end
  E.LOG.debug(TAG, "ejoysdk_task_id is " .. tostring(ejoysdk_task_id))
  local dirs = E.File.get_sys_dirs()
  local cache_dir = dirs.internal_downloads_dir
  local files_dir = dirs.internal_app_files_dir
  if not E.Utils.start_with(params.file, cache_dir) and not E.Utils.start_with(params.file, files_dir) then
    E.LOG.debug(TAG, "current file path is " .. tostring(params.file) .. ", must start with " .. tostring(cache_dir))
    cb({
      status = EC.DOWNLOAD_ERROR_CODES.INVALID_PARAMS
    })
    return
  end
  local download_file_parent_file = E.Path.parent_dir(params.file)
  E.File.make_dirs(download_file_parent_file)
  local relative_file_path = string.sub(params.file, #cache_dir + 1)
  relative_file_path = E.Utils.trim_start(relative_file_path, "/")
  local request = lunate.import("@ohos.request")
  local context = jf.get_context()
  local config = {
    action = 0,
    overwrite = true,
    mode = 1,
    method = type,
    saveas = relative_file_path,
    network = 0,
    metered = true,
    roaming = true,
    retry = true,
    redirect = true,
    url = url
  }
  if not http_download_task_id_map then
    init_download_id_map()
  end
  
  local function start_next_task()
    if task_cache_array and next(task_cache_array) then
      local task_cache_info = task_cache_array[1]
      table.remove(task_cache_array, 1)
      E.LOG.debug(TAG, "start next cache task, ejoysdk_task_id is " .. tostring(task_cache_info.params.taskId))
      M.download(task_cache_info.type, task_cache_info.url, task_cache_info.params, task_cache_info.cb)
    end
  end
  
  local function handle_download_callback(task)
    if params.progress then
      task:on("progress", function(progress_info)
        local _progress_info = lunate.deepcopy(progress_info)
        local task_idx = _progress_info.index + 1
        local size = _progress_info.sizes[task_idx]
        local _state = _progress_info.state
        local _extras = progress_info.extras ~= nil and lunate.deepcopy(progress_info.extras) or {}
        E.LOG.debug(TAG, "on_progress_info_changed:" .. tostring(task.tid) .. ", state:" .. tostring(_state) .. ", extras_empty:" .. tostring(nil == next(_extras)) .. ", per:" .. tostring(math.floor(_progress_info.processed / size * 100) .. "%"))
        params.progress(url, params.file, progress_info.processed, progress_info.sizes[1], progress_info.extras)
        if params.header_cb then
          params.header_cb(progress_info.extras)
          params.header_cb = nil
        end
      end)
    end
    task:on("completed", function()
      if params.checksum then
        local file_real_md5 = E.File.md5_fullpath(params.file)
        if params.checksum == file_real_md5 then
          cb({status = 200})
          if params.finish_cb then
            params.finish_cb()
          end
        else
          E.LOG.debug(TAG, "download fail, check md5 fail, file md5 is " .. tostring(file_real_md5) .. ", expect md5 is " .. tostring(params.checksum))
          cb({
            status = EC.EJOYSDK_ERROR_CODES.RES_DOWNLOAD_MD5_MISMATCH
          })
        end
      else
        cb({status = 200})
        if params.finish_cb then
          params.finish_cb()
        end
      end
      http_download_task_id_map[ejoysdk_task_id] = nil
      E.SPRawKeyStore.set("ejoysdk_http_download", "id_map", JSON.encode(http_download_task_id_map))
      current_task_queue_map[task.tid] = nil
      start_next_task()
    end)
    task:on("failed", function(_fail_progress_info)
      request.agent:show(task.tid):Then(function(fail_task_info)
        E.LOG.debug(TAG, "download fail, task_info >>>>")
        E.LOG.debug(TAG, lunate.deepcopy(fail_task_info))
        cb({
          status = fail_task_info.faults or 500
        })
        current_task_queue_map[task.tid] = nil
        request.agent:remove(http_download_task_id_map[ejoysdk_task_id])
        http_download_task_id_map[ejoysdk_task_id] = nil
        start_next_task()
      end):catch(function(err)
        cb({
          status = err.code
        })
        request.agent:remove(http_download_task_id_map[ejoysdk_task_id])
        http_download_task_id_map[ejoysdk_task_id] = nil
        start_next_task()
      end)
    end)
    task:on("remove", function()
      E.LOG.debug(TAG, "remove harmonyos task, task_id is " .. tostring(task.tid))
      current_task_queue_map[task.tid] = nil
    end)
  end
  
  local function create_download_task()
    if E.Utils.table_size(current_task_queue_map) >= download_task_queue_size then
      E.LOG.debug(TAG, "download_task_queue has full, should queue, ejoysdk_task_id is " .. tostring(ejoysdk_task_id))
      table.insert(task_cache_array, {
        type = type,
        url = url,
        params = params,
        cb = cb
      })
      return
    end
    
    local function inner_create_ohos_download_task()
      request.agent:create(context, config, function(err, task)
        if err then
          E.LOG.debug(TAG, "create request task fail, ejoysdk_task_id is " .. tostring(ejoysdk_task_id) .. "code is " .. tostring(err.code) .. ", msg is " .. tostring(err.message))
          if err.code == 21900004 then
            table.insert(task_cache_array, {
              type = type,
              url = url,
              params = params,
              cb = cb
            })
            if not next(current_task_queue_map) then
              E.LOG.debug(TAG, "current_task_queue_size is 0, try to clear ohos download task")
              clear_ohos_task(function(ret)
                if ret then
                  start_next_task()
                elseif not retry_task_cache[ejoysdk_task_id] then
                  retry_task_cache[ejoysdk_task_id] = true
                  E.LOG.debug(TAG, "clear ohos task fail, 60s retry")
                  E.Timer.once(60, function()
                    start_next_task()
                  end)
                else
                  cb({
                    status = err.code
                  })
                  retry_task_cache[ejoysdk_task_id] = nil
                end
              end)
            end
          else
            _ejoysdk.log("create_task_error, code is ")
            cb({
              status = err.code
            })
          end
        else
          current_task_queue_map[task.tid] = true
          E.LOG.debug(TAG, "Succeeded in creating a download task, task_id is " .. tostring(task.tid))
          http_download_task_id_map[ejoysdk_task_id] = task.tid
          E.SPRawKeyStore.set("ejoysdk_http_download", "id_map", JSON.encode(http_download_task_id_map))
          task:start()
          handle_download_callback(task)
        end
      end)
    end
    
    local no_error, error_msg = pcall(inner_create_ohos_download_task)
    if not no_error then
      E.LOG.debug(TAG, "create_ohos_download_task err msg is " .. tostring(error_msg))
      cb({
        status = EC.DOWNLOAD_ERROR_CODES.DOWNLOAD_TASK_CREATE_FAILED
      })
    end
  end
  
  local cache_task_id = http_download_task_id_map[ejoysdk_task_id]
  if cache_task_id then
    E.LOG.debug(TAG, "exist cache_task_id, try to reuse it")
    if not E.File.exists_fullpath(params.file) then
      E.LOG.debug(TAG, "exist cache_task_id, but not exist file, remove task, reset download")
      http_download_task_id_map[ejoysdk_task_id] = nil
      request.agent:remove(cache_task_id)
      create_download_task()
      return
    end
    request.agent:getTask(context, cache_task_id):Then(function(task)
      task:resume():Then(function()
        handle_download_callback(task)
      end):catch(function()
        http_download_task_id_map[ejoysdk_task_id] = nil
        request.agent:remove(cache_task_id)
        create_download_task()
      end)
    end):catch(function(err)
      E.LOG.debug(TAG, "reuse task fail, getTask fail, code is " .. tostring(err.code) .. ", message is " .. tostring(err.message))
      create_download_task()
    end)
  else
    create_download_task()
  end
end

function M.stop(task_id_arr, _params, cb)
  local jf = lunate.js_functions
  if not task_id_arr or next(task_id_arr) == nil then
    cb(false, {})
    return
  end
  local size = #task_id_arr
  local index = 0
  
  local function stop_item_cb()
    index = index + 1
    if index == size then
      cb(true)
    end
  end
  
  if not http_download_task_id_map then
    init_download_id_map()
  end
  for _, ejoysdk_task_id in ipairs(task_id_arr) do
    local task_id = http_download_task_id_map[ejoysdk_task_id]
    if task_id then
      local request = lunate.import("@ohos.request")
      local context = jf.get_context()
      request.agent:getTask(context, task_id):Then(function(task)
        task:pause():Then(function()
          E.LOG.debug(TAG, "stop task succ, task id is " .. tostring(ejoysdk_task_id))
        end):catch(function(pause_err)
          E.LOG.debug(TAG, "stop task fail, task id is " .. tostring(ejoysdk_task_id) .. ", code is " .. tostring(pause_err.code) .. ", msg is " .. tostring(pause_err.message))
        end)
        stop_item_cb()
      end):catch(function(err)
        stop_item_cb()
        E.LOG.debug(TAG, "stop task fail, task id is " .. tostring(ejoysdk_task_id) .. ", code is " .. tostring(err.code) .. ", msg is " .. tostring(err.message))
      end)
    else
      stop_item_cb()
      E.LOG.debug(TAG, "stop task fail, task id is " .. tostring(ejoysdk_task_id) .. ", task id not found")
    end
  end
end

return M
