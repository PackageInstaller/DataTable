local RSA = require("ejoysdk_lua.res.model.src_adapters.res_source_adapter")
local E = require("ejoysdk_lua.ejoysdk")
local cloud_config = require("ejoysdk_lua.cloud_game.cloud_config")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local RTM = require("ejoysdk_lua.res.model.ejoy_res_type_model")
local ADAPTER_NAME = "AndroidCloudResSource"
local M = RSA:Inherit(ADAPTER_NAME)
local TAG = ADAPTER_NAME
M.FILE_LIST_CHECK_STATE = {
  UNDEFINED = "undefined",
  CHECKING = "checking",
  CHECK_FINISHED = "check_finished"
}
local _data = {
  res_update_info = {check_update_result = false, total_size = 0},
  res_tag_list = nil
}

function M:check_res_update(cb)
  if _data.res_update_info.check_update_result == true then
    E.LOG.debug(TAG, "get_update_info already check succ, now directly return")
    cb(true, _data.res_update_info)
    return
  end
  E.LOG.debug(TAG, "start parse odr res configs")
  if cloud_config.ODRConfig then
    local odr_config = cloud_config.ODRConfig
    local tags = {}
    local total_size = 0
    for _, tag_items in pairs(odr_config) do
      for _, tag in ipairs(tag_items) do
        table.insert(tags, tag[cloud_config.ODR_TAG_CONFIG_KEYS.NAME])
        total_size = total_size + tag[cloud_config.ODR_TAG_CONFIG_KEYS.SIZE]
      end
    end
    E.LOG.debug(TAG, "parse the odr config >>")
    E.LOG.debug(TAG, tags)
    E.LOG.debug(TAG, "total size >> " .. tostring(total_size))
    _data.res_tag_list = tags
    _data.res_update_info[RTM.UPDATE_INFO_KEY.TOTAL_SIZE] = total_size
    _data.res_update_info.check_update_result = true
    cb(true, _data.res_update_info)
  else
    _data.res_update_info.check_update_result = false
    cb(false, CONSTANTS.CLOUD_GAME_ERROR_CODES.CLOUD_CONFIG_DOWNLOAD_URL_INVALID, "_down_file_url_empty error")
  end
end

function M:check_update_file_list(cb)
  if _data.res_tag_list ~= nil and _data.res_update_info.check_update_result then
    E.LOG.debug(TAG, "check_update_file_list already exists, return succ")
    cb(true, _data.res_tag_list, _data.res_update_info)
    return
  end
  E.LOG.debug(TAG, "check_update_file_list begin")
  self:check_res_update(function(succ, ...)
    if succ then
      E.LOG.debug(TAG, "check_update_file_list get_update_info succ, now begin get file list")
      cb(true, _data.res_tag_list, _data.res_update_info)
    else
      cb(false, ...)
    end
  end)
end

function M:mark_update_res_invalid()
  _data.res_update_info.check_update_result = false
  _data.res_update_info.total_size = 0
  _data.res_tag_list = nil
end

return M
