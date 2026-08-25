local download_utils = require("ejoysdk_lua.cloud_game.download_utils")
local M = {}
local json = require("ejoysdk_lua.ejoysdk_json")
local cloud_config = require("ejoysdk_lua.cloud_game.cloud_config")
local E = require("ejoysdk_lua.ejoysdk")
local EM = require("ejoysdk_lua.ejoysdk_module")
local CA = require("ejoysdk_lua.cloud_game.cloud_adapter")
local TAG = EM.MODULE.CLOUD_GAME .. "asset_down_def"
local CONFIG_KEY_PEEL_RESOURCE_LIST = "peel_resource_list"
local CONFIG_KEY_PEEL_RESOURCE_DEST = "peel_resource_dest"
local download_url
local is_updated_free_url = false
local FILE_LIST_CONF = download_utils.RES_FILE_LIST
local game_res_peel_dest_map
local remote_res_url_sp = E.SPKeyStore:New("com.ejoy.cloud_config", "remote_url")
local progress_change_listener

function M._get_file_list()
  local cfg, content = M._get_file_content(FILE_LIST_CONF)
  if not cfg then
    return
  end
  local files = {}
  local total_size = 0
  for _, item in pairs(cfg) do
    files[item.file] = item
    total_size = total_size + item.size
  end
  E.LOG.debug(TAG, "_get_file_list, total_size:" .. tostring(total_size))
  M._remove_invalid_file(files, content)
  return files, total_size
end

function M._get_file_content(file)
  local file_path = download_utils.download_folder .. file
  do return download_utils.get_file_content end
  return download_utils.get_file_content, file_path
end

function M.get_current_download_url()
  return download_url
end

function M.update_free_download_url(url)
  is_updated_free_url = true
  download_url = url
end

function M._get_url(ok_cb, _fail_cb)
  local url_conf = download_utils.URL_CONF
  if download_utils.is_file_exist(url_conf) then
    local cfg = M._get_file_content(url_conf)
    if cfg and cfg[1] then
      E.LOG.debug(TAG, "[cloud game] get url_conf " .. tostring(cfg[1]))
      ok_cb(cloud_config.fix_url(cfg[1]))
      return
    else
      E.LOG.debug(TAG, "[cloud game] url_conf file invalid, remove files:" .. tostring(cfg[1]))
      download_utils.backup_clear_game_res_config_files()
    end
  end
  local remote_url_sp = E.SPKeyStore:New("com.ejoy.cloud_config", "remote_url")
  local old_remote_url = remote_url_sp:get()
  E.LOG.debug(TAG, "[cloud game] old remote url =" .. tostring(old_remote_url))
end

function M._remove_invalid_file(new_files, _content)
  local old_list_cfg_name = download_utils.get_backup_file_name(FILE_LIST_CONF)
  local old_cfg = M._get_file_content(old_list_cfg_name)
  local compat_file_prefix = ""
  if not old_cfg then
    E.LOG.debug(TAG, "doesnt have filelist bak file:" .. tostring(old_list_cfg_name))
    local assets_state_info = download_utils.current_assets_down_state()
    local state = assets_state_info[download_utils.STATE_KEY.STATE]
    if state == download_utils.CLOUD_RES_STATE.UPDATING then
      E.LOG.debug(TAG, "not has file list bak file, and is updating state")
      old_list_cfg_name = "_cloud_game_files.json"
      old_cfg = M._get_file_content(old_list_cfg_name)
      compat_file_prefix = "assets/pkg/"
    end
  else
    E.LOG.debug(TAG, "has bak file")
  end
  if old_cfg then
    for _, item in pairs(old_cfg) do
      local f_name = compat_file_prefix .. item.file
      local new_item = new_files[f_name]
      if new_item and new_item.md5 ~= item.md5 then
        local relative_file_name = M._fix_download_filename(item.file)
        local file_path = download_utils.download_folder .. relative_file_name
        os.remove(file_path)
        E.LOG.debug(TAG, "[cloud game] _remove_invalid_file =" .. tostring(file_path))
      end
    end
    E.LOG.debug(TAG, "check bak files and new files finished, now remove bak files:" .. tostring(old_list_cfg_name))
    os.remove(download_utils.download_folder .. old_list_cfg_name)
  end
end

local function on_download_progress_changed(cur_down_size, total_size)
  E.LOG.debug(TAG, "request_file: on_download_progress_changed:" .. tostring(cur_down_size) .. ", total_size:" .. tostring(total_size))
  if nil ~= progress_change_listener then
    progress_change_listener(cur_down_size, total_size)
  end
end

local function set_download_url(url)
  url = tostring(url)
  E.LOG.debug(TAG, "set download url-1 >> " .. url)
  url = cloud_config.fix_url(url)
  E.LOG.debug(TAG, "set download url-2 >> " .. tostring(url))
  if is_updated_free_url then
    E.LOG.debug(TAG, "is updated free url is true, free download url >> " .. tostring(download_url) .. ", and url >> " .. tostring(url))
    local free_url_obj = E.HTTP.parse(download_url)
    local url_obj = E.HTTP.parse(url)
    download_url = url_obj.scheme .. "://" .. free_url_obj.host .. url_obj.path
    E.LOG.debug(TAG, "after exchange free host, free download url >> " .. tostring(download_url))
  else
    download_url = url
  end
  remote_res_url_sp:set(url)
end

function M._down_file_list_cfg(url, ok_cb, fail_cb)
  E.LOG.debug(TAG, "[cloud game] set url =" .. tostring(url))
  local full_url = download_url .. FILE_LIST_CONF
  download_utils.down_file(full_url, FILE_LIST_CONF, ok_cb, fail_cb)
end

function M.init()
  download_utils.init(cloud_config.SaveAssetDir)
end

local function parse_file_list_cfg(ok_cb, fail_cb)
  local files_need_down, total_size = M._get_file_list()
  if files_need_down and next(files_need_down) ~= nil then
    ok_cb(files_need_down, total_size)
  else
    fail_cb("_down_file_list_cfg error")
  end
end

function M.get_file_list(ok_cb, fail_cb)
  local function inner_ok_cb()
    parse_file_list_cfg(ok_cb, function()
      E.LOG.debug(TAG, "_cloud_game_files parse failed, callback failed and remove cfg files")
      
      download_utils.remove_game_res_config_files()
      fail_cb("cfg file invalid")
    end)
  end
  
  local res_cfg_files = download_utils.check_game_res_config_files()
  if res_cfg_files.res_file_list then
    E.LOG.debug(TAG, "file list config already exists , now begin parse")
    local remote_res_url = res_cfg_files.remote_res_url
    set_download_url(remote_res_url)
    inner_ok_cb()
  else
    E.LOG.debug(TAG, "file list config NOT exists , now begin download file list config")
    set_download_url(cloud_config.REMOTE_URLS)
    M._down_file_list_cfg(cloud_config.REMOTE_URLS, inner_ok_cb, fail_cb)
  end
end

function M._get_game_res_peel_dest_map()
  if game_res_peel_dest_map then
    return game_res_peel_dest_map
  end
  local unisdk_config_path = "unisdk/ejoy_pack_config.json"
  local config_content = _ejoysdk.lread(unisdk_config_path)
  local ok, cfg = pcall(json.decode, config_content)
  local peel_dest_map
  if ok then
    cfg = cfg or {}
    peel_dest_map = cfg[CONFIG_KEY_PEEL_RESOURCE_DEST] or {}
    if next(peel_dest_map) == nil then
      local peel_list_dirs = cfg[CONFIG_KEY_PEEL_RESOURCE_LIST] or {}
      for _, dir in ipairs(peel_list_dirs) do
        peel_dest_map[dir] = ""
      end
      E.LOG.debug(TAG, "peel_resource_dest does not exists, now use peel_resource_list instead, this shall cause replace use root directory, list size:" .. tostring(#peel_list_dirs))
    end
  else
    E.LOG.error(TAG, "_get_game_res_peel_dest_map failed, unisdk_config_path read failed:" .. tostring(unisdk_config_path))
    peel_dest_map = {}
  end
  local formated_dest_map = {}
  for peel_dir_name, peel_dir_dest in pairs(peel_dest_map) do
    if peel_dir_name and "" ~= peel_dir_name then
      local peel_dir_key = string.gsub(peel_dir_name, "^[/]*(.-)[/]*$", "%1")
      local replace_key = peel_dir_dest
      if "." == replace_key or "/" == replace_key or "\\" == replace_key then
        replace_key = ""
      else
        replace_key = string.gsub(replace_key, "^[/]+", "")
      end
      formated_dest_map[peel_dir_key] = replace_key
    else
      E.LOG.warn(TAG, "_get_game_res_peel_dest_map skip empty key:" .. tostring(peel_dir_name))
    end
  end
  game_res_peel_dest_map = formated_dest_map
  return formated_dest_map
end

function M._fix_download_filename(file_list_item_name)
  local res_peel_dest_map = M._get_game_res_peel_dest_map()
  local file_name = file_list_item_name
  for peel_dir_key, peel_dir_dest_key in pairs(res_peel_dest_map) do
    file_list_item_name = string.gsub(file_list_item_name, "^[/\\]+", "")
    local peel_dir_prefix_pattern = "^" .. tostring(peel_dir_key)
    local start_i, _end_i, _sub_str = string.find(file_list_item_name, peel_dir_prefix_pattern)
    if nil ~= start_i then
      local dir_without_peelname = string.gsub(file_list_item_name, peel_dir_key, peel_dir_dest_key, 1)
      file_name = dir_without_peelname
      break
    end
  end
  return file_name
end

function M.get_downloading_size(items, cb)
  local downloading_size = 0
  local time_begin = os.time()
  local file_map_list = {}
  local file_path_map = {}
  local total_count = 0
  local count_in_one_map = 0
  local max_transfer_count = 7000
  for f, item in pairs(items) do
    local download_file_name = M._fix_download_filename(item.file)
    local file_path_info = {
      path = download_utils.download_folder .. download_file_name,
      size = item.size
    }
    file_path_map[f] = file_path_info
    if count_in_one_map > max_transfer_count then
      E.LOG.debug(TAG, "enclose a map:" .. tostring(count_in_one_map))
      table.insert(file_map_list, file_path_map)
      count_in_one_map = 0
      file_path_map = {}
    end
    count_in_one_map = count_in_one_map + 1
    total_count = total_count + 1
  end
  table.insert(file_map_list, file_path_map)
  local map_size = #file_map_list
  E.LOG.debug(TAG, "get_downloading_size, total count:" .. tostring(total_count) .. ", map count:" .. tostring(map_size))
  local native_result_count = 0
  for i = 1, map_size do
    local map_item = file_map_list[i]
    E.LOG.debug(TAG, "check_game_file_valid call begin")
    local CJSON = require("ejoysdk_lua.ejoysdk_cjson")
    local map_item_str = CJSON.encode(map_item)
    local params = {data = map_item_str}
    CA.check_game_file_valid(params, function(file_result_param)
      local result_data_str = file_result_param.data
      local file_result_map = CJSON.decode(result_data_str)
      local map_item_count = 0
      for fk, ritem in pairs(file_result_map) do
        map_item_count = map_item_count + 1
        if ritem.result == true then
          local fp_info = map_item[fk]
          downloading_size = downloading_size + fp_info.size
          items[fk] = nil
        end
      end
      E.LOG.debug(TAG, "check_game_file_valid result:" .. tostring(map_item_count))
      native_result_count = native_result_count + 1
      if native_result_count == map_size then
        E.LOG.debug(TAG, "[cloud game] get_downloading_size time =" .. tostring(os.time() - time_begin) .. ", downloading_size:" .. tostring(downloading_size))
        cb(downloading_size)
      end
    end)
  end
end

function M.download_assets(need_down_files, total_size, cur_down_size, ok_cb, fail_cb)
  local _index
  local finish_job_cnt = 0
  local downloading_job_cnt = 0
  local is_finish = false
  local is_fail = false
  local cache_fail_code, cache_fail_msg
  local http_job_cnt = cloud_config.HttpJobCnt
  
  local function get_next()
    if is_finish then
      return nil
    end
    local file, item = next(need_down_files, _index)
    _index = file
    if not file then
      is_finish = true
    end
    return file, item
  end
  
  on_download_progress_changed(cur_down_size, total_size)
  
  local function check_if_fail_cb()
    E.LOG.debug(TAG, "check if fail cb, is fail >> " .. tostring(is_fail) .. ", and current downloading job cnt >> " .. tostring(downloading_job_cnt))
    if is_fail and downloading_job_cnt <= 0 then
      fail_cb(cache_fail_code, cache_fail_msg)
    end
  end
  
  local begin_down_file
  
  function begin_down_file(file, item)
    if is_fail then
      check_if_fail_cb()
      return
    end
    if file then
      local function on_progress(_)
      end
      
      local file_name = M._fix_download_filename(file)
      if download_utils.check_file_valid(download_utils.download_folder .. file_name, item.size) then
        begin_down_file(get_next())
        return
      end
      local full_url = download_url .. file
      downloading_job_cnt = downloading_job_cnt + 1
      E.LOG.debug(TAG, "start download file >> " .. tostring(file) .. ", and current downloading job >>" .. tostring(downloading_job_cnt))
      download_utils.down_file(full_url, file_name, function()
        downloading_job_cnt = downloading_job_cnt - 1
        E.LOG.debug(TAG, "download succ,  file >> " .. tostring(file) .. ", and current downloading job >>" .. tostring(downloading_job_cnt))
        cur_down_size = cur_down_size + item.size
        on_download_progress_changed(cur_down_size, total_size)
        begin_down_file(get_next())
      end, function(code, msg)
        downloading_job_cnt = downloading_job_cnt - 1
        E.LOG.debug(TAG, "download fail,  file >> " .. tostring(file) .. ", and current downloading job >>" .. tostring(downloading_job_cnt))
        cache_fail_code = code
        cache_fail_msg = msg
        is_fail = true
        check_if_fail_cb()
      end, item.size, item.md5, on_progress)
    else
      finish_job_cnt = finish_job_cnt + 1
      E.LOG.debug(TAG, "[cloud game] down job finish=" .. tostring(finish_job_cnt) .. " total=" .. tostring(http_job_cnt))
      if finish_job_cnt == http_job_cnt then
        ok_cb()
      end
    end
  end
  
  E.LOG.debug(TAG, string.format("[cloud game] being down asset http_job_cnt=%s", tostring(http_job_cnt)))
  for _ = 1, http_job_cnt do
    begin_down_file(get_next())
  end
end

function M.register_download_progress_changed(listener)
  progress_change_listener = listener
end

return M
