local E = require("ejoysdk_lua.ejoysdk")
local Class = require("ejoysdk_lua.ejoysdk_class")
local SC = require("ejoysdk_lua.res.startup.startup_res_config")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local UIM = require("ejoysdk_lua.res.update_info_manager")
local ER = require("ejoysdk_lua.res.ejoysdk_res")
local ER_UTILS = require("ejoysdk_lua.res.ejoysdk_res_utils")
local HOTFIX_LIST = require("ejoysdk_lua.res.hotfix.ejoy_hotfix_list_mgr")
local RES_FILE_LIST = require("ejoysdk_lua.res.model.res_src.ejoy_local_file_list")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local UTIL = require("ejoysdk_lua.ejoysdk_utils")
local RTM = require("ejoysdk_lua.res.model.ejoy_res_type_model")
local GMR = require("ejoysdk_lua.res.group_res_manager")
local M = Class:Inherit("EJOYSDK_QZ_HOTFIX")
M.QZ_HOTFIX_HISTORY = "ejoy_qz_res_hotfix_history.json"
local TAG = "QZ_RES_HOTFIX"
local _instance = {}

function M.static_get_hotfix_mgr(namespace, res_key)
  local key_name = namespace .. "/" .. res_key
  local instance = _instance[key_name]
  if not instance then
    instance = M:New(namespace, res_key)
    if instance._data.init == true then
      _instance[key_name] = instance
    end
  end
  return instance
end

local function _try_get_list(self, cb)
  if type(self._data.update_info) == "table" and self._data.update_info[RTM.UPDATE_INFO_KEY.ORIGIN] and next(self._data.update_info[RTM.UPDATE_INFO_KEY.ORIGIN]) then
    local _origin_info = self._data.update_info[RTM.UPDATE_INFO_KEY.ORIGIN]
    local index_info = {
      base_url = self._data.update_info[RTM.RES_CONFIG_KEY.KEY_BASE_URL] .. "/" .. self._data.update_info[RTM.RES_CONFIG_KEY.KEY_RES_TYPE],
      file_list = {
        [HOTFIX_LIST.QZ_HOTFIX_ORIGIN_RES_MAPPING] = {
          name = _origin_info[RTM.RES_CONFIG_KEY.KEY_RAW_MAPPING_FILE],
          md5 = _origin_info[RTM.RES_CONFIG_KEY.KEY_RAW_MAPPING_FILE_MD5]
        },
        [HOTFIX_LIST.QZ_HOTFIX_RES_INDEX_MAPPING] = {
          name = _origin_info[RTM.RES_CONFIG_KEY.KEY_RAW_MAPPING_INDEX_FILE],
          md5 = _origin_info[RTM.RES_CONFIG_KEY.KEY_RAW_MAPPING_INDEX_FILE_MD5]
        }
      }
    }
    local ERS = require("ejoysdk_lua.res.model.src_adapters.ejoy_res_source")
    local _ns = self.namespace
    local _rk = self.res_key
    local _list_dest_path = ERS.static_get_index_file_cache_path(_ns, _rk, UIM.get_using_version(_ns, _rk), nil, {
      [RTM.RES_UPDATES_OPTIONS.RES_SAVE_STORAGE_TYPE] = self._data.save_storage_type
    })
    E.LOG.d(TAG, "list_dest_path:" .. _list_dest_path)
    HOTFIX_LIST.static_get_qz_hotfix_list(_list_dest_path):get_file_list(index_info, cb)
  else
    cb(false, CONSTANTS.RESOURCE_UPDATE_ERROR_CODES.RES_EJOY_HOTFIX_FILE_ERROR, "index_info invalid")
  end
end

local function _get_hotfix_file_list(self)
  if not UTIL.is_text_empty(self._data.apply_dest_path) and not self._data.hotfix_file_list then
    self._data.hotfix_file_list = RES_FILE_LIST.static_get_file_list(self._data.apply_dest_path, false, M.QZ_HOTFIX_HISTORY)
  end
  return self._data.hotfix_file_list
end

function M:_init(namespace, res_key)
  self.namespace = namespace
  self.res_key = GMR.get_real_res_key(res_key)
  self.ori_res_key = res_key
  E.LOG.d(TAG, string.format("origin_res_key:%s,real_res_key:%s", self.ori_res_key, self.res_key))
  self._data = {
    init = false,
    apply_dest_path = nil,
    hotfix_file_list = nil,
    update_info = nil,
    save_storage_type = RTM.STORAGE_TYPE.INTERNAL_APP_PRIVATE
  }
  local startup_res_update_infos = SC.get_startup_update_infos()
  UIM.add_update_infos(startup_res_update_infos)
  self._data.update_info = UIM.get_res_update_info(namespace, self.res_key)
  if not self._data.update_info or not next(self._data.update_info) then
    E.LOG.w(TAG, "update_info is nil")
    return
  end
  E.LOG.d(TAG, {
    update_info = self._data.update_info
  })
  local EF = require("ejoysdk_lua.res.ejoysdk_res_facade_v2")
  local startup_res_info = EF.get_startup_res_info()
  local res_save_base_path = startup_res_info.res_save_base_path
  local res_save_storage_type = startup_res_info.res_save_storage_type
  if UTIL.is_text_empty(res_save_storage_type) or UTIL.is_text_empty(res_save_base_path) then
    E.LOG.d(TAG, "no startup info")
    return
  end
  local game_res_real_save_storage_type = ER_UTILS.try_get_storage_type(res_save_storage_type, res_save_base_path)
  self._data.save_storage_type = game_res_real_save_storage_type
  self._data.apply_dest_path = res_save_base_path
  E.LOG.d(TAG, "save_res_path:" .. res_save_base_path)
  E.LOG.d(TAG, "save_storage_type:" .. game_res_real_save_storage_type)
  ET.subscribe(ET.gangplank.LOGIN, function()
    _try_get_list(self)
  end)
  self._data.init = true
end

function M:hotfix_res(res_list, cb, _listeners)
  if UTIL.is_text_empty(self._data.apply_dest_path) or not _get_hotfix_file_list(self) then
    cb(false, CONSTANTS.RESOURCE_UPDATE_ERROR_CODES.RES_EJOY_HOTFIX_PARAMS_INVALID, "params invalid")
    return
  end
  cb = cb or function()
  end
  _try_get_list(self, function(succ, ...)
    if true == succ then
      local _res_map = (...)
      local _dependencies_res_list = {}
      for _, _origin_res in ipairs(res_list) do
        local _qz_resources = _res_map[_origin_res]
        if not _qz_resources then
          cb(false, CONSTANTS.RESOURCE_UPDATE_ERROR_CODES.RES_EJOY_HOTFIX_FILE_NOT_FOUND, "res not found:" .. _origin_res)
          return
        end
        for _, _qz_resource in ipairs(_qz_resources) do
          UTIL.insert_array(_dependencies_res_list, _qz_resource)
        end
      end
      
      local function _complete_cb(_download_succ, ...)
        E.LOG.d(TAG, "hotfix download succ")
        if _download_succ then
          local _, ext_obj = ...
          local ejoy_temp_dest_abs_dir = ext_obj.ejoy_temp_dest_abs_dir
          local download_files_info = ext_obj.download_info or {}
          E.LOG.d(TAG, {download_file_list = download_files_info})
          local _move_map = {}
          local _move_info_map = {}
          E.LOG.d(TAG, {_dependencies_res_list = _dependencies_res_list})
          for _, _item in ipairs(download_files_info.file_list) do
            local source_path = E.Path.join(ejoy_temp_dest_abs_dir, _item.key)
            local target_path = E.Path.join(self._data.apply_dest_path, _item.key)
            _move_map[source_path] = target_path
            _move_info_map[target_path] = _item
            self._data.hotfix_file_list:add_file(_item.key, _item.md5, _item.size)
          end
          ER_UTILS.batch_move_res_file(self._data.apply_dest_path, _move_map, _move_info_map, function(moving_succ, ...)
            if moving_succ then
              self._data.hotfix_file_list:save()
              cb(true, _dependencies_res_list, download_files_info.group_list or {})
            else
              cb(false, ...)
            end
          end)
        else
          local _code, _msg = ...
          cb(false, _code, _msg)
        end
      end
      
      local _state
      local _progress_info = {}
      
      local function _state_listener(state, _state_ob)
        _state = state
      end
      
      local function _progress_listener(hotfix_progress_info)
        _progress_info = hotfix_progress_info
      end
      
      E.LOG.d(TAG, {dependencies_res_list = _dependencies_res_list})
      local local_res_group_state = RTM.static_get_local_res_state(self.namespace, self.res_key) or {}
      local using_res_info = local_res_group_state[RTM.NAMESPACE_RES_CONFIG_KEY.TYPE_USING_RES_INFO] or {}
      E.LOG.d(TAG, {using_res_info = using_res_info})
      ER.check_namespace_res_update_with_update_info(self.namespace, self.res_key, self._data.update_info, using_res_info, {}, {
        [RTM.RES_UPDATES_OPTIONS.RES_SAVE_BASE_PATH] = self._data.apply_dest_path,
        [RTM.RES_UPDATES_OPTIONS.RES_SAVE_STORAGE_TYPE] = self._data.save_storage_type
      }, function(_check_succ, ...)
        if _check_succ then
          ER.download_res_files(self.namespace, self.res_key, using_res_info.version, _dependencies_res_list, {
            storage_type = self._data.save_storage_type
          }, _complete_cb, _state_listener, _progress_listener)
        else
          cb(false, ...)
        end
      end)
    else
      cb(false, ...)
    end
  end)
end

function M:hotfix_res_update(origin_file_list, down_origin_file_info, down_patch_file_info, full_match_file_info)
  if not _get_hotfix_file_list(self) then
    return
  end
  local addition_origin_file_list = {}
  if self._data.hotfix_file_list:get_size() > 0 then
    E.LOG.d(TAG, "hotfix_res_update")
    down_origin_file_info = down_origin_file_info or {}
    down_origin_file_info.file_list = down_origin_file_info.file_list or {}
    down_patch_file_info = down_patch_file_info or {}
    down_patch_file_info.file_list = down_patch_file_info.file_list or {}
    local _fix_file_list = self._data.hotfix_file_list:get_file_list()
    E.LOG.d(TAG, {fix_file_list = _fix_file_list})
    for _, _from in ipairs({full_match_file_info, down_patch_file_info}) do
      if UTIL.tablelength(_fix_file_list) > 0 and _from and _from.file_list and next(_from.file_list) then
        for _, _item in ipairs(_from.file_list) do
          E.LOG.d(TAG, {from_item = _item})
          if UTIL.tablelength(_fix_file_list) <= 0 then
            break
          end
          local _fix_file_info = _fix_file_list[_item.to]
          if _fix_file_info then
            E.LOG.d(TAG, {fix_file_info = _fix_file_info})
            _fix_file_list[_item.to] = nil
            self._data.hotfix_file_list:remove_record(_item.to)
          end
        end
      end
    end
    local is_group = GMR.is_group(self.ori_res_key)
    if UTIL.tablelength(_fix_file_list) > 0 and origin_file_list and next(origin_file_list) then
      for _, _item in ipairs(origin_file_list) do
        if UTIL.tablelength(_fix_file_list) <= 0 then
          break
        end
        local _fix_file_info = _fix_file_list[_item.to]
        if _fix_file_info then
          E.LOG.d(TAG, {fix_file_info2 = _fix_file_info})
          local _match_update = is_group or _item.group == "default"
          if _fix_file_info.md5 ~= _item.md5 and not _match_update then
            table.insert(addition_origin_file_list, _item)
          end
          _fix_file_list[_item.to] = nil
          if _match_update then
            E.LOG.d(TAG, "remove from history:" .. _item.to)
            self._data.hotfix_file_list:remove_record(_item.to)
          end
        end
      end
    end
    if not is_group then
      for _file_name, _item in pairs(_fix_file_list) do
        E.LOG.d(TAG, "remove from resp:" .. _file_name)
        self._data.hotfix_file_list:remove_record(_file_name)
      end
    end
    self._data.hotfix_file_list:save()
  end
  return addition_origin_file_list, down_origin_file_info, down_patch_file_info, full_match_file_info
end

function M:has_history()
  if not _get_hotfix_file_list(self) then
    return false
  end
  local _has_history = self._data.hotfix_file_list:get_size() > 0
  E.LOG.d(TAG, "has fix list:" .. tostring(_has_history))
  return _has_history
end

function M.repair(namespace, res_key)
  if GMR.is_group(res_key) then
    return
  end
  E.LOG.d(TAG, "hotfix repair")
  local _hotfix_mgr = M.static_get_hotfix_mgr(namespace, res_key)
  local _hotfix_file = _get_hotfix_file_list(_hotfix_mgr)
  if _hotfix_file then
    _hotfix_file:delete()
  end
end

return M
