local LoadFuncUtils = {}

function LoadFuncUtils.GetFunc(str)
  return DT.FuncTable[str] or function()
    return tonumber(str) or 0
  end
end

if ApplicationUtils.is_editor_mode() then
  function LoadFuncUtils.GetFunc(str)
    local num = tonumber(str)
    
    if num then
      return function()
        return num
      end
    end
    if not DT.FuncTable[str] and "nil" ~= str then
      Alert.ShowStr("FuncTable.lua 找不到:" .. str)
    end
    return function(fenv)
      local func = load(string.format("return %s", str), nil, nil, fenv)
      do return end
      return func, nil, nil, fenv
    end
  end
end
return LoadFuncUtils
