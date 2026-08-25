local print = _ENV.print
local tconcat = table.concat
local tinsert = table.insert
local srep = string.rep
local type = _ENV.type
local pairs = _ENV.pairs
local tostring = _ENV.tostring
local next = _ENV.next

local function print_r(root)
  local cache = {
    [root] = "."
  }
  
  local function _dump(t, space, name)
    local temp = {}
    for k, v in pairs(t) do
      local key = tostring(k)
      if cache[v] then
        tinsert(temp, "+" .. key .. " {" .. cache[v] .. "}")
      elseif "table" == type(v) then
        local new_key = name .. "." .. key
        cache[v] = new_key
        tinsert(temp, "+" .. key .. _dump(v, space .. (next(t, k) and "|" or " ") .. srep(" ", #key), new_key))
      else
        tinsert(temp, "+" .. key .. " [" .. tostring(v) .. "]")
      end
    end
    do return tconcat, temp end
    return tconcat, temp, "\n" .. space, space, nil, nil, tostring(k), tinsert, temp, "+" .. key .. " [" .. tostring(v) .. "]", key, " [", tostring(v), "]", space .. (next(t, k) and "|" or " ") .. srep(" ", #key), new_key, srep(" ", #key), " ", #key
  end
  
  print(_dump(root, "", ""))
end

return print_r
