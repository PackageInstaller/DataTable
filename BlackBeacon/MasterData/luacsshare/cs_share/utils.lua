local M = {}

local function _pairs(mt)
  local lPairs = {}
  for k, v in pairs(mt) do
    lPairs[#lPairs + 1] = {k, v}
  end
  table.sort(lPairs, function(a, b)
    local ka, kb = a[1], b[1]
    local tka = type(ka)
    local tkb = type(kb)
    if tka == tkb then
      return ka < kb
    else
      return tka < tkb
    end
  end)
  local idx = 1
  return function()
    local pair = lPairs[idx]
    idx = idx + 1
    if nil ~= pair then
      return pair[1], pair[2]
    end
    return nil
  end
end

function M.table_to_str(mt, max_floor, cur_floor)
  if type(mt) ~= "table" then
    return tostring(mt)
  end
  cur_floor = cur_floor or 1
  max_floor = max_floor or 5
  if max_floor and cur_floor > max_floor then
    return tostring(mt)
  end
  local str
  if 1 == cur_floor then
    str = string.format("%s{\n", string.rep("--", max_floor))
  else
    str = "{\n"
  end
  for k, v in _pairs(mt) do
    if type(v) == "table" then
      v = M.table_to_str(v, max_floor, cur_floor + 1)
    else
      if type(v) == "string" then
        v = "'" .. v .. "'"
      end
      v = tostring(v) .. "\n"
    end
    str = str .. string.format("%s[%s] = %s", string.rep("--", cur_floor), k, v)
  end
  str = str .. string.format("%s}\n", string.rep("--", cur_floor - 1))
  return str
end

local offset32 = 2166136261
local prime32 = 16777619

function M.fnv_hash(str)
  local hash = offset32
  for i = 1, #str do
    hash = hash * prime32
    hash = hash ~ str:sub(i, i):byte()
  end
  return hash
end

return M
