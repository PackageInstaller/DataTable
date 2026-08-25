local SystemUtils = System.NewClass("SystemUtils")

function SystemUtils.LuaTableToString(obj)
  local outStr
  local outStrList = {}
  local objDic = {}
  local dSpaceStr = "    "
  
  local function Serialize(o, spaceStr)
    spaceStr = spaceStr or ""
    if type(o) == "string" then
      table.insert(outStrList, "\"" .. tostring(o) .. "\"")
    elseif type(o) == "table" then
      if objDic[o] then
        table.insert(outStrList, "Repetition of the table")
      else
        objDic[o] = true
        table.insert(outStrList, "{\n")
        for k, v in pairs(o) do
          if type(k) == "number" then
            table.insert(outStrList, spaceStr .. dSpaceStr .. "[" .. k .. "] = ")
          else
            table.insert(outStrList, spaceStr .. dSpaceStr .. "[" .. "\"" .. tostring(k) .. "\"" .. "] = ")
          end
          Serialize(v, spaceStr .. dSpaceStr)
          table.insert(outStrList, ",\n")
        end
        table.insert(outStrList, spaceStr .. "}")
      end
    else
      table.insert(outStrList, tostring(o))
    end
  end
  
  Serialize(obj)
  outStr = table.concat(outStrList)
  return outStr
end

function SystemUtils.split(input, delimiter)
  input = tostring(input)
  delimiter = tostring(delimiter)
  if "" == delimiter then
    return false
  end
  local pos, arr = 0, {}
  for st, sp in function()
    do return string.find, input, delimiter, pos end
    return string.find, input, delimiter, pos, true
  end, nil, nil, nil do
    table.insert(arr, string.sub(input, pos, st - 1))
    pos = sp + 1
  end
  table.insert(arr, string.sub(input, pos))
  return arr
end

function SystemUtils.Len(tbl)
  local count = 0
  for _, _ in pairs(tbl) do
    count = count + 1
  end
  return count
end

function SystemUtils.Contain(tbl, value)
  local ret = false
  for _, v in ipairs(tbl) do
    if v == value then
      ret = true
    end
  end
  return ret
end

function SystemUtils.Orm2Raw(value, depth)
  if nil == depth then
    depth = 1
  end
  if 0 == depth then
    return value
  end
  local t = type(value)
  if "table" ~= t then
    return value
  end
  depth = depth - 1
  local raw = {}
  for k, v in pairs(value) do
    raw[k] = SystemUtils.Orm2Raw(v, depth)
  end
  return raw
end

return SystemUtils
