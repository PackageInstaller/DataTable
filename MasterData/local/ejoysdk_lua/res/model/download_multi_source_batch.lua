local E = require("ejoysdk_lua.ejoysdk")
local RB = require("ejoysdk_lua.res.model.download_multi_source_base")
local DTM = require("ejoysdk_lua.res.model.ejoy_http_download_model")
local DT = require("ejoysdk_lua.res.model.http_download_task")
local HRU = require("ejoysdk_lua.res.ejoy_http_res_utils")
local EC = require("ejoysdk_lua.ejoysdk_constants")
local DST = require("ejoysdk_lua.res.model.http_download_stat")
local RTM = require("ejoysdk_lua.res.model.ejoy_res_type_model")
local M = RB:Inherit("EjoyHttpDownloadMultiRequestBatch")
local MODULE = "download_multi_source_batch"
local TAG = MODULE
local RETRY_TIME_DELAY = 1

local function char_to_hex(c)
  do return string.format, "%%%02X", string.byte(c) end
  return string.format, "%%%02X", string.byte(c)
end

local function hex_to_char(x)
  do return string.char, tonumber(x, 16) end
  return string.char, tonumber(x, 16)
end

local function url_encode(url)
  url = url:gsub("([^%w%-%.%_%~%!%*%'%(%)%;%/%?%:%@%&%=%$%,%#])", char_to_hex)
  return url
end

local function url_decode(url)
  url = url:gsub("%%(%x%x)", hex_to_char)
  return url
end

local function check_encode_url(url)
  local decode_url = url_decode(url)
  local is_url_encode = decode_url ~= url
  if not is_url_encode then
    url = url_encode(url)
  end
  url = url:gsub("%+", "%%20")
  return url
end

function M:log_debug(msg)
  E.LOG.debug(self._private_data.tag, msg)
end

function M:log_warn(msg)
  E.LOG.warn(self._private_data.tag, msg)
end

function M:constructor()
  local global_config = self._data.multi_model:get_global_config()
  local _max_retry_times = self._data.opts.max_retry_times or global_config.max_retry_times
  local _download_range_enable = self._data.opts.enable_download_range
  if nil == _download_range_enable then
    _download_range_enable = global_config.enable_download_range
  end
  self._private_data = {
    tag = TAG .. "#" .. self._data.multi_task_id,
    task_id_retry_times = {},
    last_download_error_code = nil,
    last_download_error_msg = nil,
    opts = {
      connectionTimeout = global_config.connect_timeout,
      dataRetrievalTimeout = global_config.read_timeout,
      use_independent_pool = true,
      max_retry_times = _max_retry_times,
      enable_download_range = _download_range_enable,
      network_strategy = self._data.network_strategy,
      multi_task_id = self._data.multi_task_id
    },
    unfinished_id_item_map = {},
    task_id_request_item_map = {},
    task_id_local_state_map = {},
    backup_urls = self._data.file_ext.backup_urls or {},
    current_backupurl_index = 0
  }
  self._private_data.backup_urls_count = #self._private_data.backup_urls
  self._private_data.current_retry_backurls_index = 0
  self._private_data.need_background_downloading = self:need_background_downloading()
end

function M:_callback_download_failed_for_file_item(file_item, code, msg, url)
  self._private_data.task_id_local_state_map[file_item.task_id] = DTM.DOWNLOAD_CHECK_STATE.DOWNLOADING_FILE_INCOMPLETE
  local state = code == EC.DOWNLOAD_ERROR_CODES.CANCELLED and DT.DOWNLOAD_STATE.STOPPED or DT.DOWNLOAD_STATE.FAILED
  local _file_path = file_item[RTM.FILE_ITEM_EXT_KEY.EXT][RTM.FILE_ITEM_EXT_KEY.EX_COMPLETE_PATH]
  local state_obj = {
    [DT.STATE_KEY.STATE_CHANGED] = true,
    [DT.STATE_KEY.FILE_PATH] = _file_path,
    [DT.STATE_KEY.TASK_ID] = file_item.task_id,
    [DT.STATE_KEY.SPEED] = 0,
    [DT.STATE_KEY.ERR_CODE] = code,
    [DT.STATE_KEY.ERR_MSG] = msg,
    [DT.STATE_KEY.ERR_URL] = self:_get_url_for_path(file_item.path),
    [DT.STATE_KEY.STATE] = state,
    url = url or self:_get_url_for_path(file_item.path)
  }
  self._private_data.last_download_error_code = code
  self._private_data.last_download_error_msg = msg
  if self._data.state_listener then
    self._data.state_listener(file_item, state, state_obj)
  end
end

function M:_callback_download_succ_for_file_item(file_item, event_time, url)
  self._private_data.task_id_local_state_map[file_item.task_id] = DTM.DOWNLOAD_CHECK_STATE.COMPLETE_FILE_VALID
  local dest_file_path = file_item[RTM.FILE_ITEM_EXT_KEY.EXT][RTM.FILE_ITEM_EXT_KEY.EX_COMPLETE_PATH]
  local state_obj = {
    [DT.STATE_KEY.STATE] = DT.DOWNLOAD_STATE.COMPLETE,
    [DT.STATE_KEY.STATE_CHANGED] = true,
    [DT.STATE_KEY.TASK_ID] = file_item.task_id,
    [DT.STATE_KEY.SPEED] = 0,
    [DT.STATE_KEY.FILE_PATH] = dest_file_path,
    [DT.STATE_KEY.SIZE] = file_item.size,
    [DT.STATE_KEY.RECV_BYTES] = file_item.size,
    [DT.STATE_KEY.ERR_CODE] = 0,
    [DT.STATE_KEY.ERR_MSG] = nil,
    [DT.STATE_KEY.PERCENT] = 100,
    url = url or self:_get_url_for_path(file_item.path),
    event_time = event_time
  }
  if self._data.state_listener then
    self._data.state_listener(file_item, DT.DOWNLOAD_STATE.COMPLETE, state_obj)
  end
end

function M:_on_single_download_cb(request_item, file_item, ret)
  ret.status = ret.status or EC.GLOBAL_GANGPLANK_ERROR_CODE.GLOBAL_HTTP_RESPONSE_STATUS_INVALID
  local err_msg = ret.message or ret.msg
  
  local function down_fail_handler(code, msg)
    if code == EC.DOWNLOAD_ERROR_CODES.CANCELLED then
      self:log_debug("down_fail_handler download cancelled received, already processed inner, skip")
      self:_callback_download_failed_for_file_item(file_item, code, msg)
      return
    end
    self:log_warn("download error " .. tostring(file_item.name) .. ", code:" .. tostring(code) .. ", msg:" .. tostring(msg))
    local need_remove_file = self._data.single_model:_is_download_response_fail_need_rm_file(code)
    if need_remove_file then
      self:log_debug("download_fail_handler, md5 check failed:" .. tostring(code) .. ", begin rm file:" .. tostring(request_item.file))
      HRU.os_remove(request_item.file)
    end
    local current_task_id_retry_times = self._private_data.task_id_retry_times[file_item.task_id] or 0
    current_task_id_retry_times = current_task_id_retry_times + 1
    local task_properties = self._data.multi_task:get_download_properties()
    local max_retry_time = task_properties.max_retry_times or self._private_data.opts.max_retry_times
    if current_task_id_retry_times > self._private_data.opts.max_retry_times then
      self:log_warn("down_fail_handler reach max retry times:" .. tostring(current_task_id_retry_times) .. ", max:" .. tostring(max_retry_time))
      self:_callback_download_failed_for_file_item(file_item, code, msg, request_item.retry_url)
    else
      self._private_data.task_id_retry_times[file_item.task_id] = current_task_id_retry_times
      local init_state = need_remove_file and DTM.DOWNLOAD_CHECK_STATE.NOT_DOWNLOAD or DTM.DOWNLOAD_CHECK_STATE.DOWNLOADING_FILE_INCOMPLETE
      self:_fill_request_item_with_state(request_item, file_item, init_state)
      E.Timer.once(RETRY_TIME_DELAY, function()
        self:log_debug("down_fail_handler retry for:" .. tostring(file_item.path) .. ", current_retry_times:" .. tostring(current_task_id_retry_times) .. ", taskId:" .. tostring(file_item.task_id) .. ", file_name:" .. tostring(file_item.name) .. ", max:" .. tostring(max_retry_time))
        self:retry_with_item(request_item, file_item)
      end)
    end
  end
  
  if self._data.single_model:_is_download_response_status_succ(ret.status) then
    if type(ret.total_size) == "number" and ret.total_size > 0 and file_item.size ~= ret.total_size then
      self:log_debug("update file size:" .. tostring(file_item.size) .. ", real size:" .. tostring(ret.total_size) .. ", " .. tostring(file_item.dest_path))
      file_item.size = ret.total_size
    end
    local http_ext_params = ret.http_ext_params or {}
    self:_callback_download_succ_for_file_item(file_item, http_ext_params.event_time, request_item.retry_url)
  else
    self:log_warn("receive download failed:" .. tostring(ret.status))
    down_fail_handler(ret.status, err_msg or "download failed")
  end
end

function M:_on_single_progress(_download_item, file_item, _url, _file, received, total, _headers, _event_time)
  local local_state = self._private_data.task_id_local_state_map[file_item.task_id]
  if local_state ~= DTM.DOWNLOAD_CHECK_STATE.COMPLETE_FILE_VALID then
    self._private_data.task_id_local_state_map[file_item.task_id] = DTM.DOWNLOAD_CHECK_STATE.DOWNLOADING_FILE_INCOMPLETE
  end
  if file_item.size <= 0 and type(total) == "number" and total >= 0 and total ~= file_item.size then
    file_item.size = total
  end
  local progress_info = {
    [DT.PROGRESS_INFO_KEY.SIZE] = file_item.size,
    [DT.PROGRESS_INFO_KEY.RECV_BYTES] = received,
    [DT.PROGRESS_INFO_KEY.TASK_ID] = file_item.task_id,
    event_time = _event_time
  }
  if self._data.progress_listener then
    self._data.progress_listener(file_item, progress_info)
  end
end

function M:_on_single_header_cb(download_item, _file_item, ...)
  local headers = (...)
  local url = self:_get_url_for_path(download_item.path)
  self._data.single_model:on_receive_download_response_header(download_item.taskId, url, headers, download_item.expect_size)
end

function M:_create_request_with_file_item(file_item, init_state, init_info, priority)
  local task_id = file_item.task_id
  self._private_data.unfinished_id_item_map[task_id] = file_item
  local temp_download_path = file_item[RTM.FILE_ITEM_EXT_KEY.EXT][RTM.FILE_ITEM_EXT_KEY.EX_TMP_PATH]
  local dest = file_item[RTM.FILE_ITEM_EXT_KEY.EXT][RTM.FILE_ITEM_EXT_KEY.EX_COMPLETE_PATH]
  local encode_path = check_encode_url(file_item.path)
  local request_item = {
    file = temp_download_path,
    dest = dest,
    checksum = file_item.md5,
    encode_path = encode_path,
    path = file_item.path,
    taskId = task_id,
    priority = priority,
    expect_size = file_item.size
  }
  self:_fill_request_item_with_state(request_item, file_item, init_state, init_info)
  return request_item
end

function M:_fill_request_item_with_state(request_item, file_item, init_state, init_info)
  local function remove_request_item_range_info(_req)
    if _req.headers then
      _req.headers.range = nil
    end
    _req.param_if_range = nil
  end
  
  local state_changed = false
  if init_state == DTM.DOWNLOAD_CHECK_STATE.DOWNLOADING_FILE_INCOMPLETE then
    local if_range_field
    local range_info = self._data.single_model:_get_file_range_info_by_id(request_item.taskId)
    if range_info then
      local etag = range_info[DT.RANGE_INFO_KEY.ETAG]
      local last_modified = range_info[DT.RANGE_INFO_KEY.LAST_MODIFIED]
      if_range_field = etag
      if not if_range_field or "" == if_range_field then
        if_range_field = last_modified
      end
    end
    request_item.param_if_range = if_range_field
    local file_local_info = init_info and init_info[DTM.TASK_INIT_PARAMS.LOCAL_INFO] or {}
    local file_local_size = file_local_info[DTM.TASK_INIT_PARAMS.LOCAL_TMP_SIZE] or 0
    if file_local_size <= 0 then
      local _is_exist, size = HRU.is_file_exists(request_item.file)
      if _is_exist and size and size > 0 then
        file_local_size = size
      end
      if file_local_size == file_item.size then
        local is_valid, _file_real_size = self._data.single_model:_on_download_complete_check_file_md5_and_size_valid(request_item.file, request_item.checksum, file_item.size)
        if is_valid then
          init_state = DTM.DOWNLOAD_CHECK_STATE.DOWNLOADING_FILE_VALID
          state_changed = true
        end
      end
      self:log_debug("file_local_size is nil for file:" .. tostring(request_item.file) .. ", read from file real size:" .. tostring(file_local_size) .. ", state_changed:" .. tostring(state_changed) .. ", state:" .. tostring(init_state))
    end
    self:log_debug("_fill_request_item_with_state DOWNLOADING_FILE_INCOMPLETE:" .. tostring(init_info and init_info[DTM.TASK_INIT_PARAMS.FILE_TEMP_PATH]) .. ", file_local_size:" .. tostring(file_local_size) .. ", if_range_field:" .. tostring(if_range_field))
    if file_local_size > 0 then
      request_item.headers = {
        range = "bytes=" .. tostring(file_local_size) .. "-"
      }
    end
  else
    remove_request_item_range_info(request_item)
  end
  return state_changed, init_state
end

function M:_get_local_file_state(task_id)
  local init_info, init_state
  local local_state = self._private_data.task_id_local_state_map[task_id]
  if not local_state then
    init_info = self._data.task_id_init_info_map[task_id]
    init_state = init_info[DTM.TASK_INIT_PARAMS.CHECKED_INIT_STATE]
    self._private_data.task_id_local_state_map[task_id] = init_state
  else
    init_state = local_state
  end
  return init_state, init_info
end

function M:_prepare_submit_list()
  self:log_debug("_prepare_submit_list invoked:" .. tostring(#self._data.unfinished_file_list))
  local before = E.system_clock()
  local submit_list = {}
  local submit_map = {}
  local to_rename_path_map = {}
  local to_rename_fileitem_map = {}
  local to_rename_count = 0
  local priority = self._data.file_ext and self._data.file_ext.priority or 0
  local unfinished_file_list = self._data.unfinished_file_list
  for _, file_item in ipairs(unfinished_file_list) do
    local _task_id = file_item.task_id
    local init_state, init_info = self:_get_local_file_state(_task_id)
    if init_state == DTM.DOWNLOAD_CHECK_STATE.DOWNLOADING_FILE_VALID then
      local dst_path = file_item[RTM.FILE_ITEM_EXT_KEY.EXT][RTM.FILE_ITEM_EXT_KEY.EX_COMPLETE_PATH]
      local downloading_path = file_item[RTM.FILE_ITEM_EXT_KEY.EXT][RTM.FILE_ITEM_EXT_KEY.EX_TMP_PATH]
      to_rename_path_map[downloading_path] = dst_path
      to_rename_fileitem_map[downloading_path] = file_item
      to_rename_count = to_rename_count + 1
    else
      local need_submit = true
      local request_item_cache = self._private_data.task_id_request_item_map[_task_id]
      if not request_item_cache then
        request_item_cache = self:_create_request_with_file_item(file_item, init_state, init_info, priority)
      else
        local state_changed, changed_state = self:_fill_request_item_with_state(request_item_cache, file_item, init_state)
        if state_changed and changed_state == DTM.DOWNLOAD_CHECK_STATE.DOWNLOADING_FILE_VALID then
          need_submit = false
          local dst_path = file_item[RTM.FILE_ITEM_EXT_KEY.EXT][RTM.FILE_ITEM_EXT_KEY.EX_COMPLETE_PATH]
          local downloading_path = file_item[RTM.FILE_ITEM_EXT_KEY.EXT][RTM.FILE_ITEM_EXT_KEY.EX_TMP_PATH]
          to_rename_path_map[downloading_path] = dst_path
          to_rename_fileitem_map[downloading_path] = file_item
          to_rename_count = to_rename_count + 1
          self:log_debug("_prepare_submit_list file download succ, directly rename it:" .. tostring(file_item.task_id) .. ", path:" .. tostring(dst_path))
        end
      end
      if need_submit then
        table.insert(submit_list, request_item_cache)
        submit_map[file_item.task_id] = request_item_cache
      end
    end
  end
  if next(to_rename_path_map) ~= nil then
    self:log_debug("_prepare_submit_list to_rename_path_map has values, cnt:" .. tostring(to_rename_count))
    
    local function callback_rename_succ_state_listener(rename_map)
      for _src, _ in pairs(rename_map) do
        local item = to_rename_fileitem_map[_src]
        local init_info = self._data.task_id_init_info_map[item.task_id]
        self:_callback_download_succ_for_file_item(item, item.size or init_info[DTM.TASK_INIT_PARAMS.LOCAL_TMP_SIZE] or 0)
      end
    end
    
    E.File.batch_rename(to_rename_path_map, function(rename_succ, ...)
      if rename_succ then
        self:log_debug("_prepare_submit_list to_rename_path_map rename succ, cnt:" .. tostring(to_rename_count))
        callback_rename_succ_state_listener(to_rename_path_map)
      else
        local rename_err_code, rename_err_msg, rename_fail_file_map = ...
        local to_rm_list = {}
        for fail_src_file, _ in pairs(rename_fail_file_map) do
          table.insert(to_rm_list, fail_src_file)
        end
        self:log_warn("_prepare_submit_list to_rename_path_map rename failed, code:" .. tostring(rename_err_code) .. ", msg:" .. tostring(rename_err_msg) .. ", size:" .. tostring(#to_rm_list))
        E.File.batch_remove(to_rm_list, function(succ, ...)
          self:log_warn("_prepare_submit_list batch_remove succ:" .. tostring(succ) .. ", cnt:" .. tostring(#to_rm_list))
          E.File.batch_rename(rename_fail_file_map, function(rename_succ2, ...)
            if rename_succ2 then
              self:log_debug("_prepare_submit_list batch_rename 2nd time succ, cnt:" .. tostring(#to_rm_list))
              callback_rename_succ_state_listener(to_rename_path_map)
            else
              local rename_err_code2, rename_err_msg2, rename_fail_file_map2 = ...
              self:log_warn("_prepare_submit_list batch_rename 2nd failed")
              for _rn_src, _ in pairs(rename_fail_file_map2) do
                local file_item = to_rename_fileitem_map[_rn_src]
                self:_callback_download_failed_for_file_item(file_item, rename_err_code2, rename_err_msg2)
              end
              local rename_succ_map = {}
              for _src, _dst in pairs(to_rename_path_map) do
                if not rename_fail_file_map2[_src] then
                  rename_succ_map[_src] = _dst
                end
              end
              callback_rename_succ_state_listener(rename_succ_map)
            end
          end, {is_fullpath = true})
        end, {is_fullpath = true})
      end
    end, {is_fullpath = true})
  end
  local after = E.system_clock()
  _ejoysdk.log("create list cnt:" .. tostring(#self._data.unfinished_file_list) .. ", cost:" .. tostring(after - before))
  self:log_debug("_prepare_submit_list submit cnt:" .. tostring(#submit_list))
  return submit_list, submit_map
end

function M:_get_item_by_task_id(task_id)
  local request_item = self._private_data.task_id_request_item_map[task_id]
  local file_item = self._private_data.unfinished_id_item_map[task_id]
  return request_item, file_item
end

function M:do_start()
  self._private_data.task_id_retry_times = {}
  self._private_data.last_download_error_code = nil
  self._private_data.last_download_error_msg = nil
  local before = E.system_clock()
  self:log_debug("start received")
  local submit_list, submit_map = self:_prepare_submit_list()
  self._private_data.task_id_request_item_map = submit_map
  self:log_debug("start submit_list cnt:" .. tostring(#submit_list))
  self:download_with_list(submit_list)
  local after = E.system_clock()
  _ejoysdk.log("start list cnt:" .. tostring(#submit_list) .. ", cost:" .. tostring(after - before))
end

function M:check_download_state(_task_id, file_item_info, init_info)
  do return self._check_download_state_with_file_item, self, file_item_info end
  return self._check_download_state_with_file_item, self, file_item_info, init_info
end

function M:retry_with_item(request_item, file_item)
  local url_base
  if self._private_data.backup_urls_count > 0 then
    if type(request_item.last_retry_backupurls_index) == "number" then
      if request_item.last_retry_backupurls_index == self._private_data.current_retry_backurls_index then
        self._private_data.current_retry_backurls_index = request_item.last_retry_backupurls_index % self._private_data.backup_urls_count + 1
      end
    elseif 0 == self._private_data.current_retry_backurls_index then
      self._private_data.current_retry_backurls_index = 1
    end
    request_item.last_retry_backupurls_index = self._private_data.current_retry_backurls_index
    url_base = self._private_data.backup_urls[self._private_data.current_retry_backurls_index]
  else
    url_base = self._data.file_ext.base_url
  end
  local url = E.HTTP.uri_join(url_base, request_item.encode_path)
  request_item.retry_url = url
  self:log_warn("retry_with_item task_id:" .. tostring(request_item.taskId) .. ", url:" .. tostring(url) .. ", urlIdx:" .. tostring(self._private_data.current_retry_backurls_index))
  local params = {}
  for k, v in pairs(request_item) do
    params[k] = v
  end
  for k, v in pairs(self._private_data.opts) do
    params[k] = v
  end
  
  function params.progress(...)
    self:_on_single_progress(request_item, file_item, ...)
  end
  
  function params.finish_cb()
  end
  
  function params.header_cb(...)
    self:_on_single_header_cb(request_item, file_item, ...)
  end
  
  self:http_get(url, params, function(_task_id, ret)
    self:log_debug("retry_with_item finish cb:" .. tostring(_task_id) .. ", ret:" .. tostring(type(ret) == "table" and ret.status or "unexpected type"))
    self:_on_single_download_cb(request_item, file_item, ret)
  end)
end

function M:download_with_list(submit_list)
  self:submit_download_list(submit_list, self._data.file_ext, self._private_data.opts, function(succ, ...)
    if not succ then
      local code, msg = ...
      if self._private_data.last_download_error_code == nil and code ~= EC.DOWNLOAD_ERROR_CODES.CANCELLED then
        self:log_warn("download_with_list failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
        self:on_global_error(code, msg)
      else
        self:log_debug("download_with_list interrupt, privious download error:" .. tostring(self._private_data.last_download_error_code) .. ", msg:" .. tostring(self._private_data.last_download_error_msg) .. ", cur code:" .. tostring(code))
      end
    else
      self:log_debug("download_with_list succ")
    end
  end, function(task_id, info)
    local request_item, file_item = self:_get_item_by_task_id(task_id)
    self:_on_single_download_cb(request_item, file_item, info)
  end, function(task_id, ...)
    local request_item, file_item = self:_get_item_by_task_id(task_id)
    self:_on_single_progress(request_item, file_item, ...)
  end, function(task_id, ...)
    local request_item, file_item = self:_get_item_by_task_id(task_id)
    self:_on_single_header_cb(request_item, file_item, ...)
  end)
end

function M:on_stop_all_download(cb)
  self:log_debug("on_stop_all_download received")
  local before1 = E.system_clock()
  local pending_stop_task_id_list = {}
  for task_id, local_state in pairs(self._private_data.task_id_local_state_map) do
    if not local_state or local_state ~= DTM.DOWNLOAD_CHECK_STATE.DOWNLOADING_FILE_VALID and local_state ~= DTM.DOWNLOAD_CHECK_STATE.COMPLETE_FILE_VALID then
      table.insert(pending_stop_task_id_list, task_id)
    end
  end
  local total_pending_stop_count = #pending_stop_task_id_list
  if 0 == total_pending_stop_count then
    self:log_debug("_do_stop_download_task pending stop count is 0, so directly cb true")
    if cb then
      cb(true)
    end
    return
  end
  self:log_warn("_do_stop_download_task, support batch stop and begin")
  self:http_stop(pending_stop_task_id_list, {}, function(_succ)
    local after1 = E.system_clock()
    self:log_debug("_do_stop_download_task multi,batch1 final cost:" .. tostring(after1 - before1) .. ", cnt:" .. tostring(total_pending_stop_count))
    local after2 = E.system_clock()
    local cost = after2 - before1
    self:log_debug("_do_stop_download_task multi,batch2 final cost:" .. tostring(cost) .. ", cnt:" .. tostring(total_pending_stop_count))
    DST.stat_action("ejoy_multi_http_download_stop", tostring(total_pending_stop_count), tostring(cost))
    if cb then
      cb(_succ)
    end
  end)
end

function M:on_download_all_removed()
  for task_id, _ in pairs(self._private_data.task_id_local_state_map) do
    self._private_data.task_id_local_state_map[task_id] = DTM.DOWNLOAD_CHECK_STATE.NOT_DOWNLOAD
  end
end

function M:need_present_notification_progress()
  return self._private_data.need_background_downloading
end

function M:need_lua_present_notification_progress()
  return false
end

return M
