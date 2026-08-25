local E = require("ejoysdk_lua.ejoysdk")
local E_UTILS = require("ejoysdk_lua.ejoysdk_utils")
local CONSTANCES = require("ejoysdk_lua.ejoysdk_constants")
local SITE = require("ejoysdk_lua.site.ejoysdk_site")
local SC = require("ejoysdk_lua.shortcut.ejoysdk_shortcut_webview")
local SNS = require("ejoysdk_lua.server_api.ejoysdk_sns")
local TAG = "site_heros"
local biz_type = SC.Type.Site
local M = {}

local function get_complete_bag_url(snapshot_id)
  if not snapshot_id or E_UTILS.STR.is_empty(snapshot_id) then
    E.LOG.d(TAG, "get complete bag url failed, snapshot_id is empty")
    return nil, CONSTANCES.SITE.HEROS.CODE_SNAPSHOT_ID_EMPTY, "snapshot_id is empty"
  end
  local site_params = SC.get_config_from_cc_h5res(biz_type)
  if site_params and site_params.url then
    do return string.format, "%s#/handbook?snapshot_id=%s", site_params.url end
    return string.format, "%s#/handbook?snapshot_id=%s", site_params.url, snapshot_id
  else
    E.LOG.d(TAG, "get complete bag url failed, could not find site config")
    return nil, CONSTANCES.SITE.CODE_SITE_CONFIG_NOT_EXIST, "could not find site config"
  end
end

local function get_target_url_with_snapshot_id(snapshot_id)
  if not snapshot_id or E_UTILS.STR.is_empty(snapshot_id) then
    E.LOG.d(TAG, "get target url failed, snapshot_id is empty")
    return
  end
  do return string.format, "/handbook?snapshot_id=%s" end
  return string.format, "/handbook?snapshot_id=%s", snapshot_id
end

function M.get_heros_sharing_content(player_ids, selectors, cb)
  local params = {}
  if player_ids and next(player_ids) then
    params.player_ids = player_ids
  end
  if selectors and next(selectors) then
    params.selectors = selectors
  end
  SNS.create_player_share_snapshot(params, function(succ, ...)
    if succ then
      local res_body = (...)
      local snapshot_id = res_body.data and res_body.data.snapshot_id
      local chat_data = res_body.chat_data
      local complete_bag_url, code, msg = get_complete_bag_url(snapshot_id)
      if complete_bag_url then
        cb(true, complete_bag_url, chat_data)
      else
        cb(false, code, msg)
      end
    else
      local code, msg = ...
      cb(false, code, msg)
    end
  end)
end

function M.open_heros_sharing_floater(snapshot_id, frame, on_callbacks)
  local width = frame.width
  local height = frame.height
  local params = {
    adjust_size = true,
    from_source_data = {
      target_url = get_target_url_with_snapshot_id(snapshot_id)
    }
  }
  if _ejoysdk.os() == "windows" then
    params.drag_padding = {
      left = 0,
      top = 0,
      right = width * 0.25,
      bottom = height * 0.9
    }
  end
  SITE.open_with_floater(params, frame, on_callbacks)
end

return M
