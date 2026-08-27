local base = require("Game.ActivityFrame.ActivityBase")
local EventAngelaGiftData = class("EventAngelaGiftData", base)
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local CurActType = ActivityFrameEnum.eActivityType.EventAngelaGift
local CheckerTypeId, CheckerGlobalConfig = table.unpack(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
local redDotType = {redDotLooked = 1}

function EventAngelaGiftData:InitAngelaGiftData(actId)
  self:SetActFrameDataByType(CurActType, actId)
  self._mainCfg = ConfigData.activity_angela_main[actId]
  local payGiftCtrl = ControllerManager:GetController(ControllerTypeId.PayGift)
  local groupGiftInfos = {}
  for _, giftId in ipairs(self._mainCfg.group_id) do
    local giftInfo = payGiftCtrl:GetPayGiftDataById(giftId)
    if giftInfo == nil then
      error("find angelaGiftInfo Fail! giftId = " .. tostring(giftId))
    end
    table.insert(groupGiftInfos, giftInfo)
  end
  self.groupGiftInfos = groupGiftInfos
  if self:GetIsAngelaGiftDataOver() then
    local activityCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame, true)
    activityCtrl:HideActivityByExtraLogic(CurActType, self:GetActId())
  end
  self:__UpdateAngelaGift()
end

function EventAngelaGiftData:__UpdateAngelaGift()
  self:RefreshAngelaGiftLooked()
end

function EventAngelaGiftData:RefreshAngelaGiftLooked()
  local actRed = self:GetActivityReddot()
  if actRed == nil then
    return
  end
  local newQARed = actRed:AddChild(redDotType.redDotLooked)
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  if not saveUserData:GetAngelaGiftLooked(self:GetActId()) then
    newQARed:SetRedDotCount(1)
    return
  end
  newQARed:SetRedDotCount(0)
end

function EventAngelaGiftData:SetAngelaGiftDataLooked()
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  saveUserData:SetAngelaGiftLooked(self:GetActId())
  self:__UpdateAngelaGift()
end

function EventAngelaGiftData:GetAngelaGiftDataCanPop()
  local isInTime = CheckCondition.CheckLua(self._mainCfg.pre_condition2, self._mainCfg.pre_para3, self._mainCfg.pre_para4)
  if not isInTime then
    for iCheckLuaIndex, vConditionId in ipairs(self._mainCfg.pre_condition2) do
      local para3 = self._mainCfg.pre_para3[iCheckLuaIndex]
      local para4 = self._mainCfg.pre_para4[iCheckLuaIndex]
      if vConditionId == CheckerTypeId.SectorStagePassTm and para3 ~= nil and para4 ~= nil then
        local giftStartTime = self._mainCfg.gift_start_time
        local passed = PlayerDataCenter.sectorStage:CheckStagePassTmInRange(para3, 0)
        if passed and PlayerDataCenter.timestamp < giftStartTime + para4 then
          break
        end
        return false
      end
    end
  end
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  return saveUserData:GetAngelaGiftCanPop(self:GetActId())
end

function EventAngelaGiftData:SetAngelaGiftDataCantPopToday()
  local cantShowTime = 0
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  saveUserData:SetAngelaGiftCantShowTime(self:GetActId(), cantShowTime)
  self:__UpdateAngelaGift()
end

function EventAngelaGiftData:GetAngelaGiftMainCfg()
  return self._mainCfg
end

function EventAngelaGiftData:GetGroupGiftCurrentStep()
  for step, giftInfo in ipairs(self.groupGiftInfos) do
    if not giftInfo:IsSoldOut() then
      return step
    end
  end
  return #self.groupGiftInfos + 1
end

function EventAngelaGiftData:GetIsAngelaGiftDataOver()
  local isAllSoldOut = self:GetGroupGiftCurrentStep() > #self.groupGiftInfos
  if isAllSoldOut then
    return true
  end
  return false
end

return EventAngelaGiftData
