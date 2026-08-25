local M = {}

function M.SetValueByPath(data, path, value)
  local pathList = string.split(path, ".")
  local pathLen = #pathList
  for i, _path in pairs(pathList) do
    if string.isdigit(_path) then
      _path = tonumber(_path)
    end
    if i < pathLen then
      data = data[_path]
    else
      data[_path] = value
    end
  end
end

function M.GetCompAndMethod(methodName)
  local methodList = string.split(methodName, ".")
  local len = #methodList
  assert(len <= 2 and len > 0, "GetCompAndMethod Error " .. methodName)
  if 1 == len then
    return nil, methodList[1]
  end
  return methodList[1], methodList[2]
end

function M.IsSameTable(tplA, tplB)
  for k, v in pairs(tplA) do
    if v ~= tplB[k] then
      return false
    end
  end
  for k, v in pairs(tplB) do
    if v ~= tplA[k] then
      return false
    end
  end
  return true
end

function M.IsChineseChar(unicode)
  return unicode >= 19968 and unicode <= 40869
end

function M.ChineseOnly(str)
  for _, c in utf8.codes(str) do
    if not M.IsChineseChar(c) then
      return false
    end
  end
  return true
end

function M.Utf8Len(str)
  do return utf8.len end
  return utf8.len, str
end

function M.LimitUtf8String(str, max)
  local count = 1
  for p, _ in utf8.codes(str) do
    if nil ~= max and max > 0 and max < count then
      return string.sub(str, 1, p - 1)
    end
    count = count + 1
  end
  return str
end

function M.RandomWeightList(list)
  local totalWeight = 0
  local weightList = {}
  for _, data in ipairs(list) do
    totalWeight = data.Weight + totalWeight
    table.insert(weightList, totalWeight)
  end
  local rand = math.random(1, totalWeight)
  local matchIndex
  for i, weight in ipairs(weightList) do
    matchIndex = i
    if weight > rand then
      break
    end
  end
  return list[matchIndex]
end

function M.GetTableValue(tab, key, defalutVal)
  assert(type(tab) == "table", "tab not type=[table]")
  if tab[key] then
    return tab[key]
  end
  tab[key] = defalutVal or {}
  return tab[key]
end

function M.SplitArray(list, splitLen)
  splitLen = splitLen or 2
  local ret = {}
  if not list or type(list) ~= "table" then
    return {}
  end
  for k, v in ipairs(list) do
    local key = math.ceil(k / splitLen)
    if not ret[key] then
      ret[key] = {}
    end
    table.insert(ret[key], v)
  end
  return ret
end

return M
