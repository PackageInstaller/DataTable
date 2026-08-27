local CheckCondition = {}
local CheckerTypeId, CheckerGlobalConfig = table.unpack(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
local paramGoup = {}

local function CheckLuaBaseFunc(callback, lockRenturn, ...)
  local paramNum = select("#", ...)
  if paramNum == 0 then
    print("[CheckCondition] not args")
    return false
  end
  local para1 = select(1, ...)
  local length = #para1
  for i = 2, paramNum do
    local para = select(i, ...)
    local len = #para
    if 0 < len and len ~= length then
      print("[CheckCondition] args length is different")
      return false
    end
  end
  for i = 1, length do
    local index = 1
    for j = 1, paramNum do
      local para = select(j, ...)
      if 0 < #para then
        paramGoup[index] = para[i]
        index = index + 1
      end
    end
    for i = index, #paramGoup do
      paramGoup[i] = nil
    end
    local checker = CheckerGlobalConfig[paramGoup[1]]
    if checker == nil then
      error("Checker is nil  id:" .. tostring(paramGoup[1]))
      return false
    end
    if not checker.Checker.LengthCheck(paramGoup) then
      return false
    end
    local unlock = checker.Checker.ParamsCheck(paramGoup)
    if not unlock and lockRenturn then
      return false
    end
    if callback ~= nil then
      callback(unlock, checker, paramGoup)
    end
  end
  return true
end

function CheckCondition.CheckLua(...)
  return CheckLuaBaseFunc(nil, true, ...)
end

function CheckCondition.GetUnlockInfoLua(...)
  local unlockStr = ""
  
  local function GenStrFunc(unlock, checker, paramGoup)
    if string.IsNullOrEmpty(unlockStr) then
      unlockStr = unlockStr .. checker.Checker.GetUnlockInfo(paramGoup)
    else
      unlockStr = unlockStr .. "\n" .. checker.Checker.GetUnlockInfo(paramGoup)
    end
  end
  
  local ok = CheckLuaBaseFunc(GenStrFunc, false, ...)
  if ok then
    return unlockStr
  else
    return ""
  end
end

function CheckCondition.GetUnlockAndInfoList(...)
  local preConditionList = {}
  
  local function genListFunc(unlock, checker, paramGoup)
    local lockReason = checker.Checker.GetUnlockInfo(paramGoup)
    table.insert(preConditionList, {unlock = unlock, lockReason = lockReason})
  end
  
  local ok = CheckLuaBaseFunc(genListFunc, false, ...)
  if ok then
    return preConditionList
  else
    return table.emptytable
  end
end

function CheckCondition.GetUnlockInfoLuaByMany(...)
  local unlockStr = ""
  local tempUnlock = ""
  local length = select("#", ...) / 3
  local unLock
  
  local function GenStrFunc(unlock, checker, paramGoup)
    if string.IsNullOrEmpty(tempUnlock) then
      tempUnlock = tempUnlock .. checker.Checker.GetUnlockInfo(paramGoup)
    else
      tempUnlock = tempUnlock .. "\n" .. checker.Checker.GetUnlockInfo(paramGoup)
    end
    if unlock then
      unLock = unlock
    end
  end
  
  for i = 1, length do
    if #select(3 * (i - 1) + 1, ...) ~= 0 then
      local arg1, arg2, arg3 = select(3 * (i - 1) + 1, ...)
      local ok = CheckLuaBaseFunc(GenStrFunc, false, arg1, arg2, arg3)
      if ok then
        if string.IsNullOrEmpty(unlockStr) then
          unlockStr = tempUnlock
        else
          unlockStr = string.format(ConfigData:GetTipContent(8710), unlockStr, tempUnlock)
        end
        tempUnlock = ""
      end
    end
  end
  return unlockStr, unLock
end

function CheckCondition.GetUnlockAndInfoListByMany(...)
  local preConditionList = {}
  local str, unlock = CheckCondition.GetUnlockInfoLuaByMany(...)
  table.insert(preConditionList, {unlock = unlock, lockReason = str})
  return preConditionList
end

function CheckCondition.GetUnlockInfoLuaByManyList(manyList)
  local unlockStr = ""
  local tempUnlock = ""
  local unLock
  
  local function GenStrFunc(unlock, checker, paramGoup)
    if string.IsNullOrEmpty(tempUnlock) then
      tempUnlock = tempUnlock .. checker.Checker.GetUnlockInfo(paramGoup)
    else
      tempUnlock = tempUnlock .. "\n" .. checker.Checker.GetUnlockInfo(paramGoup)
    end
    if unlock then
      unLock = unlock
    end
  end
  
  for i, v in ipairs(manyList) do
    local arg1, arg2, arg3 = v[1], v[2], v[3]
    local ok = CheckLuaBaseFunc(GenStrFunc, false, arg1, arg2, arg3)
    if ok then
      if string.IsNullOrEmpty(unlockStr) then
        unlockStr = tempUnlock
      else
        unlockStr = string.format(ConfigData:GetTipContent(8710), unlockStr, tempUnlock)
      end
      tempUnlock = ""
    end
  end
  return unlockStr, unLock
end

return CheckCondition
