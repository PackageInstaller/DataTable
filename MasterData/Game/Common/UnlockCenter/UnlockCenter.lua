local UnlockCenter = {}
local CheckerTypeId, _ = table.unpack(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
UnlockCenter.eUnlockLogic = {CompleteStage = 1}
local unlockLogicId2CheckerTypeId = {
  [UnlockCenter.eUnlockLogic.CompleteStage] = CheckerTypeId.CompleteStage
}

function UnlockCenter:InitUnlockCenter()
  self.unlockLogicDic = {}
end

function UnlockCenter:AddUnlockElemEvent(callback, logic, para1)
  if callback == nil or logic == nil or para1 == nil then
    error(string.format("param error, callback:%s, logic:%s, para1:%s", callback, logic, para1))
    return
  end
  if logic == 0 then
    return
  end
  local unlockLogic = self.unlockLogicDic[logic] or {}
  if self.unlockLogicDic[logic] == nil then
    self.unlockLogicDic[logic] = unlockLogic
  end
  local eventDic = unlockLogic[para1] or {}
  if unlockLogic[para1] == nil then
    unlockLogic[para1] = eventDic
  end
  if eventDic[callback] ~= nil then
    error("Aready cotains callback : " .. tostring(callback))
    return
  end
  eventDic[callback] = true
end

function UnlockCenter:TriggerUnlockEvent(logic, para1)
  if self.unlockLogicDic[logic] == nil or self.unlockLogicDic[logic][para1] == nil then
    return
  end
  local eventDic = self.unlockLogicDic[logic][para1]
  for callback, v in pairs(eventDic) do
    callback(logic, para1)
  end
  self.unlockLogicDic[logic][para1] = nil
end

function UnlockCenter:UnlockCheck(logic, para1)
  local pre_condition = unlockLogicId2CheckerTypeId[logic]
  if pre_condition == nil then
    error("Unsupported logic, id = " .. tostring(logic))
    return false
  end
  return CheckCondition.CheckLua({pre_condition}, {para1})
end

function UnlockCenter:GetUnlockElemDes(logic, para1)
  local pre_condition = unlockLogicId2CheckerTypeId[logic]
  if pre_condition == nil then
    error("Unsupported logic, id = " .. tostring(logic))
    return false
  end
  local lockStr = CheckCondition.GetUnlockInfoLua({pre_condition}, {para1})
  return lockStr
end

return UnlockCenter
