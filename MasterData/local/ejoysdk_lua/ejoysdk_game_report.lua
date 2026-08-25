local E = require("ejoysdk_lua.ejoysdk")
local holo = require("ejoysdk_lua.ejoysdk_holo")
local EM = require("ejoysdk_lua.ejoysdk_module")
local TAG = EM.MODULE.EJOYSDK_BASE_MODULE .. "game_report"
local M = {}

local function require_params()
  local player_token = holo.get_player_token()
  return {
    acceptable = E.HTTP.CT_JSON,
    headers = {
      ["moment-Token"] = player_token
    }
  }
end

function M.post_game_report_content(report_content_tab, cb)
  local url = holo.holo_url("submit_record")
  _ejoysdk.log(TAG .. "request url: " .. url)
  local params = report_content_tab
  local stat = require("ejoysdk_lua.ejoysdk_stat")
  local channel = stat.env_info().chInfo.ch
  local sub_channel = stat.env_info().chInfo.subCh
  local ext = {}
  ext.channel_id = channel
  ext.sub_channel_id = sub_channel
  ext.report_role_id = params.report_role_id
  ext.report_role_name = params.report_role_name
  ext.sy = E.Sysinfo.os()
  params.report_role_id = nil
  params.report_role_name = nil
  params.extend = ext
  params.type = report_content_tab.type or 8
  params.feedback_type = 0
  if not cb or type(cb) ~= "function" then
    function cb(...)
    end
  end
  E.log(params)
  E.HTTP.post(url, require_params(), E.HTTP.CT_JSON, params, function(resp)
    _ejoysdk.log(TAG .. " request resp >>")
    E.log(resp)
    if resp.status == 200 then
      if 0 == resp.body.code then
        cb(true)
      else
        cb(false, resp.body.code, resp.body.message)
      end
    else
      cb(false, resp.status, "")
    end
  end)
end

return M
