local BASE_API = require("ejoysdk_lua.libs.base_api")
local vortex_api = BASE_API:New("vortex")
local M = {}
local API = {
  CENTER_LIST = "/client_api/campaign_center/center/list",
  PAGE_LIST = "/client_api/campaign_center/page/list"
}

function M.get_center_list(center_ids, cb)
  local body = {
    center_ids = center_ids or {}
  }
  local opt = {use_moment_token = true}
  vortex_api:post(API.CENTER_LIST, {}, body, opt, function(succ, ...)
    if succ then
      local data = (...)
      cb(true, (data.data or {}).list or {})
    else
      local code, msg = ...
      cb(false, code, msg)
    end
  end)
end

function M.get_page_list(center_id, lang, cb)
  local body = {center_id = center_id, lang = lang}
  local opt = {use_moment_token = true}
  vortex_api:post(API.PAGE_LIST, {}, body, opt, function(succ, ...)
    if succ then
      local data = (...)
      cb(true, (data.data or {}).list or {})
    else
      local code, msg = ...
      cb(false, code, msg)
    end
  end)
end

return M
