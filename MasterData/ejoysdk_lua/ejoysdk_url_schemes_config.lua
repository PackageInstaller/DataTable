local E = require("ejoysdk_lua.ejoysdk")
local CC = require("ejoysdk_lua.ejoysdk_config_center")
local M = {}
local WHITE_QUERIED_URL_SCHEMES = {
  "weixin",
  "xhsdiscover",
  "sinaweibo",
  "snssdk1128",
  "bilibili",
  "tel",
  "fb",
  "twitter",
  "line",
  "instagram",
  "whatsapp",
  "youtube",
  "market"
}
local has_inited = false
local queried_url_schemes = {}

local function merge_schemes(schemes, white_schemes)
  local all_schemes = schemes or {}
  if schemes and next(schemes) ~= nil then
    for _, w_scheme in ipairs(white_schemes) do
      local find_scheme = false
      for _, p_scheme in ipairs(all_schemes) do
        if w_scheme == p_scheme then
          find_scheme = true
          break
        end
      end
      if not find_scheme then
        table.insert(all_schemes, w_scheme)
      end
    end
  else
    for _, w_scheme in ipairs(white_schemes) do
      table.insert(all_schemes, w_scheme)
    end
  end
  return all_schemes
end

function M.init_schemes()
  if has_inited then
    return
  end
  has_inited = true
  local cc_config = CC.get_global_config(CC.NAMESPACE.EJOYSDK_BIZ)
  local url_schemes = cc_config and cc_config.config and cc_config.config.url_schemes
  queried_url_schemes = merge_schemes(url_schemes, WHITE_QUERIED_URL_SCHEMES)
end

function M.can_open_url(url)
  if not url then
    return false
  end
  if E.Sysinfo.os() ~= "android" and not E.Sysinfo.can_open_url(url) then
    return false
  end
  if E.Utils.start_with(url, "http") then
    return true
  end
  M.init_schemes()
  local protocol = (E.Utils.split_string(url, "://") or {})[1]
  for i = 1, #queried_url_schemes do
    local url_scheme = queried_url_schemes[i]
    if protocol == url_scheme then
      return true
    end
  end
  return false
end

return M
