local base = require("Game.ActivityFrame.ActivityBase")
local EventLadderGiftData = class("EventLadderGiftData", base)
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local CurActType = ActivityFrameEnum.eActivityType.LadderGift
local CheckerTypeId, CheckerGlobalConfig = table.unpack(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
local redDotType = {redDotLooked = 1}

function EventLadderGiftData:InitLadderGiftData(actId)
  self:SetActFrameDataByType(CurActType, actId)
  self._mainCfg = ConfigData.activity_laddergift[actId]
  if self:GetIsLadderGiftDataOver() then
    local activityCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame, true)
    activityCtrl:HideActivityByExtraLogic(CurActType, self:GetActId())
  end
end

function EventLadderGiftData:UpdateLadderGiftMsg(msg)
  self.startTime = msg.startTime
end

function EventLadderGiftData:GetLadderGiftDataCanPop()
  if not self._mainCfg.is_pop then
    return false
  end
  if not self.startTime then
    return false
  end
  if self.startTime + self._mainCfg.pop_time < PlayerDataCenter.timestamp then
    return false
  end
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  return saveUserData:GetLadderGiftCanPop(self:GetActId())
end

function EventLadderGiftData:SetLadderGiftDataCantPopToday()
  local cantShowTime = 0
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  saveUserData:SetLadderGiftCantShowTime(self:GetActId(), cantShowTime)
end

function EventLadderGiftData:GetLadderGiftMainCfg()
  return self._mainCfg
end

function EventLadderGiftData:GetLadderGiftSkinId()
  return self._mainCfg.skin_id
end

function EventLadderGiftData:GetGroupGiftCurrentStep()
  local payGiftCtrl = ControllerManager:GetController(ControllerTypeId.PayGift)
  for k, giftId in ipairs(self._mainCfg.group_id) do
    local giftInfo = payGiftCtrl:GetPayGiftDataById(giftId)
    if not giftInfo:IsSoldOut() then
      return k
    end
  end
  return #self._mainCfg.group_id + 1
end

function EventLadderGiftData:GetIsLadderGiftDataOver()
  local isAllSoldOut = self:GetGroupGiftCurrentStep() > #self._mainCfg.group_id
  if isAllSoldOut then
    return true
  end
  return false
end

return EventLadderGiftData
