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

return M
