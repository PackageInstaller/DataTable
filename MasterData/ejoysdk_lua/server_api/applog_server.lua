local E = require("ejoysdk_lua.ejoysdk")
local DS_API = require("ejoysdk_lua.protocol.cddp_protocol")
local M = {}

local function get_pkg_params()
  local pkg_info = E.get_pkg_info()
  local pkg_params = {
    gid = pkg_info.game_id,
    os = pkg_info.os,
    mc = pkg_info.channel_id,
    sc = pkg_info.ds_sub_channel_id or "",
    pkg = pkg_info.pkg_name,
    ptid = pkg_info.ptid,
    utdid = pkg_info.utdid
  }
  return pkg_params
end

function M.get_filtered_events_to_upload(_params, cb)
  local params = get_pkg_params()
  DS_API.post(DS_API.SERVICE.CDDP_QUERY_RULE, params, function(succ, ...)
    cb(succ, ...)
  end)
end

function M.get_event_upload_rule(event, _params, cb)
  _params = _params or {}
  local params = get_pkg_params() or {}
  params.event = event.name
  params.time = event.time
  local event_params = event.params or {}
  params.acid = not _params.acid and event_params.user_info and event_params.user_info.uid
  params.money = event_params.product_info and event_params.product_info.money
  params.currency = event_params.product_info and event_params.product_info.money_type
  DS_API.post(DS_API.SERVICE.CDDP_CALLBACK_CONTROL, params, function(succ, ...)
    cb(succ, ...)
  end)
end

return M
