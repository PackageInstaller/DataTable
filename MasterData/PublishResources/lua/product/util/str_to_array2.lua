_class("StrToArray2", Singleton)
StrToArray2 = StrToArray2

function StrToArray2:Constructor()
  self._cache = {}
end

function StrToArray2:DefaultNumConvert(value)
  return tonumber(value)
end

function StrToArray2:GetArray(str, firstSplit, secondSplit, valueConvertFunc, cache)
  if not str then
    return {}
  end
  local array = self._cache[str]
  if array then
    return array
  end
  array = {}
  local tempArray = string.split(str, firstSplit)
  for k, v in pairs(tempArray) do
    local values = str.split(v, secondSplit)
    local ret = {}
    for k, v in pairs(values) do
      local value
      if valueConvertFunc then
        value = valueConvertFunc()
      else
        value = self:DefaultNumConvert(v)
      end
      table.insert(ret, value)
    end
    table.insert(array, ret)
  end
  if cache then
    self._cache[str] = array
  end
  return array
end

function StrToArray2:ClearCache()
  self._cache = {}
end
