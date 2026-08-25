local E = require("ejoysdk_lua.ejoysdk")
local CC = require("ejoysdk_lua.ejoysdk_config_center")
local M = {}
local WHITE_HOST_ARR = {
  ".aligames.com",
  ".lingxigames.com",
  ".ejoy.com",
  ".alibaba.net"
}

function M.white_hosts()
  return WHITE_HOST_ARR
end

function M.merge_hosts(hosts)
  local all_hosts = hosts or {}
  if hosts and next(hosts) ~= nil then
    for _, w_host in ipairs(WHITE_HOST_ARR) do
      local find_host = false
      for _, p_host in ipairs(all_hosts) do
        if w_host == p_host then
          find_host = true
          break
        end
      end
      if not find_host then
        table.insert(all_hosts, w_host)
      end
    end
  else
    for _, w_host in ipairs(WHITE_HOST_ARR) do
      table.insert(all_hosts, w_host)
    end
  end
  return all_hosts
end

function M.add_injection_host(new_host)
  local find_host = false
  for _, host in ipairs(WHITE_HOST_ARR) do
    if host == new_host then
      find_host = true
      break
    end
  end
  if not find_host then
    table.insert(WHITE_HOST_ARR, new_host)
  end
end

function M.add_injection_hosts(hosts)
  for _, new_host in ipairs(hosts) do
    M.add_injection_host(new_host)
  end
end

function M.remove_inject_host(remove_host)
  local find_host = false
  local find_host_idx = 0
  for idx, host in ipairs(WHITE_HOST_ARR) do
    if host == remove_host then
      find_host = true
      find_host_idx = idx
      break
    end
  end
  if find_host then
    table.remove(WHITE_HOST_ARR, find_host_idx)
  end
end

function M.global_white_error_domains()
  local cc_config = CC.get_global_config(CC.NAMESPACE.EJOYSDK_BIZ)
  return cc_config and cc_config.config and cc_config.config.error_domains_white_list or {}
end

function M.is_in_global_white_domains(url)
  local url_split = E.Utils.split_string(url, "://") or {}
  local url_protocol = url_split[1]
  local url_suffix = url_split[2]
  local white_error_domains = M.global_white_error_domains() or {}
  for i = 1, #white_error_domains do
    local white_error_domain = white_error_domains[i]
    if string.sub(url, 1, #white_error_domain) == white_error_domain then
      return true
    end
    local white_split = E.Utils.split_string(white_error_domain, "://") or {}
    local white_protocol = white_split[1]
    local white_suffix = white_split[2]
    if url_protocol and url_suffix and white_protocol and white_suffix and E.Utils.start_with(url_protocol, "http") and E.Utils.start_with(white_protocol, "http") and string.sub(url_suffix, 1, #white_suffix) == white_suffix then
      return true
    end
  end
  return false
end

return M
