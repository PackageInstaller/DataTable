local unpack = table.unpack or _ENV.unpack
local M = {}

function M.xpcall(f, msgh, arg1, ...)
  local ret = {
    pcall(f, arg1, ...)
  }
  if not ret[1] and msgh then
    msgh()
  end
  do return unpack end
  return unpack, ret, pcall(f, arg1, ...)
end

return M
