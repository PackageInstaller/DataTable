local ActivityBase = require("Game.ActivityFrame.ActivityBase")
local ActDeliverySimulatorData = class("ActDeliverySimulatorData", ActivityBase)
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local ActDSEnum = require("Game.ActivityDeliverySimulator.ActMain.Data.ActDSEnum")
local ActCommonRewardBpData = require("Game.ActivityFrame.ActCommonRewardBp.ActCommonRewardBpData")
local CurActType = ActivityFrameEnum.eActivityType.DeliverySimulator

function ActDeliverySimulatorData:InitActData(msg)
  self:SetActFrameDataByType(CurActType, msg.actId)
  self:UpdateActFrameDataSingleMsg(msg)
  self._mainCfg = ConfigData.delivery_activity_main[msg.actId]
  self._sectorGroup = ConfigData.delivery_activity_sector_group[msg.actId]
  self.actCommonRewardBpData = ActCommonRewardBpData.New(self, self:GetActDSBpItem())
  self:UpdateActData(msg)
  self:RefreshLevelLookBlueDot()
  self.actCommonRewardBpData:SetAvgJumpFunc(function()
    local actCtrl = ControllerManager:GetController(ControllerTypeId.ActDeliverySimulator)
    if actCtrl == nil then
      return
    end
    actCtrl:JumpStorySector()
  end)
end

function ActDeliverySimulatorData:UpdateActData(msg)
  self.highestScoreDic = {}
  if msg.highestScore ~= nil then
    for id, score in pairs(msg.highestScore) do
      self:UpdateHighestScore(id, score)
    end
  end
end

function ActDeliverySimulatorData:UpdateHighestScore(sectorId, score)
  self.highestScoreDic[sectorId] = score
end

function ActDeliverySimulatorData:GetHighestScore(index)
  return self.highestScoreDic[index] or 0
end

function ActDeliverySimulatorData:GetDSSelectLevel()
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  local actId = self:GetActId()
  local level = saveUserData:GetActDSLevelSelect(actId)
  return level
end

function ActDeliverySimulatorData:SetDSSelectLevel(level)
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  local actId = self:GetActId()
  saveUserData:SetActDSLevelSelect(actId, level)
end

function ActDeliverySimulatorData:GetDSSelectLevelIsLooked(level)
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  local actId = self:GetActId()
  local looked = saveUserData:GetActDSLevelSelectIsLooked(actId, level)
  return looked
end

function ActDeliverySimulatorData:SetDSSelectLevelIsLooked(level)
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  local actId = self:GetActId()
  saveUserData:SetActDSLevelSelectLook(actId, level)
  self:RefreshLevelLookBlueDot()
end

function ActDeliverySimulatorData:RefreshLevelLookBlueDot()
  local redDot = self:GetActChildRedDot(ActDSEnum.reddotType.SelectLevelLook)
  if redDot == nil then
    return
  end
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  local isHaveDot = false
  local actId = self:GetActId()
  for id, cfg in pairs(self._sectorGroup) do
    local isUnlock = CheckCondition.CheckLua(cfg.pre_condition, cfg.pre_para1, cfg.pre_para2)
    local isLooked = saveUserData:GetActDSLevelSelectIsLooked(actId, id)
    if isUnlock and not isLooked then
      isHaveDot = true
      break
    end
  end
  local redDotNum = isHaveDot and 1 or 0
  redDot:SetRedDotCount(redDotNum)
end

function ActDeliverySimulatorData:GetIsHaveUIGameStartDot()
  local redDot = self:GetActChildRedDot(ActDSEnum.reddotType.SelectLevelLook)
  if redDot == nil then
    return false
  end
  return redDot:GetRedDotCount() > 0
end

function ActDeliverySimulatorData:GetIsHaveUIRewardBpRedDot()
  local redDot = self:GetActChildRedDot(ActDSEnum.reddotType.BpReward)
  if redDot == nil then
    return false
  end
  return redDot:GetRedDotCount() > 0
end

function ActDeliverySimulatorData:RefreshRedActDSRewardBp()
  local reddot = self:GetActChildRedDot(ActDSEnum.reddotType.BpReward)
  if reddot == nil then
    return
  end
  local flag = self.actCommonRewardBpData:HasCommonRewardExpCanReceive()
  local redCount = flag and 1 or 0
  if reddot:GetRedDotCount() ~= redCount then
    reddot:SetRedDotCount(redCount)
  end
end

function ActDeliverySimulatorData:GetMainCfg()
  return self._mainCfg
end

function ActDeliverySimulatorData:GetSectorGroupCfg()
  return self._sectorGroup
end

function ActDeliverySimulatorData:GetActDSBpItem()
  return self._mainCfg.bp_item
end

function ActDeliverySimulatorData:GetRewardBpData()
  return self.actCommonRewardBpData
end

function ActDeliverySimulatorData:GetRewardBpLevel()
  return self.actCommonRewardBpData:GetCommonRewardCurLv()
end

function ActDeliverySimulatorData:RefreshActivityCommonRewardBp(bpElem)
  if self.actCommonRewardBpData ~= nil then
    self.actCommonRewardBpData:UpdateCommonRewardBp(bpElem)
    self:RefreshRedActDSRewardBp()
  end
end

function ActDeliverySimulatorData:GetDSFriendRankData(index)
  local dataList = {}
  table.insert(dataList, {
    name = PlayerDataCenter.inforData.name,
    num = self:GetHighestScore(index)
  })
  local friendDataList = PlayerDataCenter.friendDataCenter:GetFreindList()
  for id, data in pairs(friendDataList) do
    local tempData = {}
    tempData.name = data.name
    tempData.num = 0
    if data.actDelivery.cur and data.actDelivery.cur.highestScore[index] then
      tempData.num = data.actDelivery.cur.highestScore[index]
    end
    table.insert(dataList, tempData)
  end
  table.sort(dataList, function(a, b)
    return a.num > b.num
  end)
  return dataList
end

function ActDeliverySimulatorData:GetActivityReddotNum()
  local isBlue = true
  local actRedDotNode = self:GetActivityReddot()
  if actRedDotNode == nil then
    error("can't get activity reddot node")
    return false, 0
  end
  local num = actRedDotNode:GetRedDotCount()
  for i, v in ipairs(ActDSEnum.reddotIsRedType) do
    local redChild = actRedDotNode:GetChild(v)
    if redChild ~= nil and 0 < redChild:GetRedDotCount() then
      isBlue = false
      break
    end
  end
  return isBlue, num
end

return ActDeliverySimulatorData
