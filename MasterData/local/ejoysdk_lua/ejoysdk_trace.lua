local E = require("ejoysdk_lua.ejoysdk")
local HTTP = E.HTTP
local JSON = require("ejoysdk_lua.ejoysdk_json")
local EM = require("ejoysdk_lua.ejoysdk_module")
local M = {}
local TAG = EM.MODULE.EJOYSDK_BASE_MODULE .. "trace"
local product = E.CONFIG.get_config("product"):lower()

function M.create(crashid, type, data, cb)
  local params_data = {crashid = crashid, type = type}
  for key, value in pairs(data) do
    params_data[key] = value
  end
  local params = {
    data = JSON.encode(params_data)
  }
  local url_base = E.CONFIG.get_config("trace")
  local trace_url = url_base .. "/dl/" .. product .. "/create"
  E.LOG.debug(TAG, "create trace_url:" .. trace_url)
  HTTP.post(trace_url, {
    acceptable = HTTP.CT_JSON
  }, HTTP.CT_URLENCODED, params, function(resp)
    if cb then
      if resp.status and resp.status == 200 or resp.status == 201 then
        cb(true)
      else
        local body = resp.body or {}
        cb(false, resp.status or -1, body.message or "")
      end
    end
  end)
end

function M.sdk_create(msg, type, data)
  local trace_key = _ejoysdk_crypt.hashkey(msg)
  local trace_id = _ejoysdk_crypt.hexencode(trace_key)
  local stat = require("ejoysdk_lua.ejoysdk_stat")
  local gdp = require("ejoysdk_lua.gangplank_data_provider")
  data = data or {}
  data.msg = debug.traceback(msg)
  data.env_info = stat.env_info()
  data.player_info = gdp.PLAYER_INFO.get()
  M.create(trace_id, type, data)
end

return M
