local AllEffectorData = class("AllEffectorData")
local EffectorResourceData = require("Game.Effector.Data.EffectorResourceData")
local EffectorUtil = require("Game.Effector.EffectorUtil")
local AutoResourceGeneratorData = require("Game.Effector.Data.AutoResourceGeneratorData")

function AllEffectorData:ctor()
  self.effectorResDataDic = {}
  self.AutoResourceGeneratorDic = {}
  self.OldItemDNumDic = {}
  self.m_OnARGItemChnage = BindCallback(self, self.OnARGItemChnage)
end

function AllEffectorData:UpdateResourceData(rg)
  local resData = self.effectorResDataDic[rg.uid]
  if resData == nil then
    resData = EffectorResourceData.New()
    resData:InitEffectorRes(rg)
    self.effectorResDataDic[rg.uid] = resData
  else
    resData:UpdateEffectorRes(rg)
  end
  local functionId = resData.functionId
  if functionId == proto_csmsg_SystemFunctionID.SystemFunctionID_Building then
    self:UpdateBuildingResourceData(resData)
  end
end

function AllEffectorData:UpdateBuildingResourceData(resData, remove)
  local buildingId = resData.logicId
  local buildingData = PlayerDataCenter.AllBuildingData.built[buildingId]
  if buildingData == nil then
    error("Can't find buildingData, id = " .. tostring(buildingId))
    return
  end
  local resDatas = buildingData.resDatas
  if resDatas == nil then
    resDatas = {}
    buildingData.resDatas = resDatas
  end
  if remove then
    resDatas[resData.itemId] = nil
  else
    resDatas[resData.itemId] = resData
  end
end

function AllEffectorData:DeleteResourceData(uid)
  local resData = self.effectorResDataDic[uid]
  self.effectorResDataDic[uid] = nil
  local functionId = resData.functionId
  if functionId == proto_csmsg_SystemFunctionID.SystemFunctionID_Building then
    self:UpdateBuildingResourceData(resData, true)
  end
end

function AllEffectorData:IsAutoGenerateResource(itemId)
  local itemCfg = ConfigData.item[itemId]
  if itemCfg == nil then
    return false
  end
  return itemCfg.type == eItemType.AutoGenerateResource and self.AutoResourceGeneratorDic[itemId] ~= nil
end

function AllEffectorData:UpdateAutoResourceGenerator(ARGBase)
  local ArgData = self.AutoResourceGeneratorDic[ARGBase.itemId]
  if ArgData == nil then
    ArgData = AutoResourceGeneratorData.New()
    ArgData:UpdateItem(ARGBase)
    self.AutoResourceGeneratorDic[ARGBase.itemId] = ArgData
  else
    ArgData:UpdateItem(ARGBase)
  end
end

function AllEffectorData:OnUpdateItemCeil()
  for itemId, data in pairs(self.AutoResourceGeneratorDic) do
    data:UpdateItemCeil()
  end
end

function AllEffectorData:OnUpdateItemGenerateSpeed()
  for itemId, data in pairs(self.AutoResourceGeneratorDic) do
    data:UpdateItemSpeed()
  end
end

function AllEffectorData:GetCurrentARGNum(itemId)
  if self.AutoResourceGeneratorDic[itemId] == nil then
    error("auto gen item don't have id=" .. tostring(itemId))
    return 0, 0
  end
  return self.AutoResourceGeneratorDic[itemId]:GetCurrentNum()
end

function AllEffectorData:GetCurrentARGCeiling(itemId)
  if self.AutoResourceGeneratorDic[itemId] == nil then
    error("auto gen item don't have id=" .. tostring(itemId))
    return 0
  end
  return self.AutoResourceGeneratorDic[itemId]:GetARGCeiling()
end

function AllEffectorData:GetCurrentARGSpeed(itemId, isBase)
  if self.AutoResourceGeneratorDic[itemId] == nil then
    error("auto gen item don't have id=" .. tostring(itemId))
    return 0
  end
  return self.AutoResourceGeneratorDic[itemId]:GetARGGenSpeedPerSecond(isBase)
end

function AllEffectorData:SetAccRacte(itemId, accRate)
  if self.AutoResourceGeneratorDic[itemId] == nil then
    error("auto gen item don't have id=" .. tostring(itemId))
    return
  end
  self.AutoResourceGeneratorDic[itemId]:SetAccRate(accRate)
end

function AllEffectorData:StartTimer4ARGNum()
  local minTime = math.maxinteger
  for itemId, data in pairs(self.AutoResourceGeneratorDic) do
    local num, remainSecond = data:GetCurrentNum()
    self.OldItemDNumDic[itemId] = num
    if remainSecond ~= 0 then
      minTime = math.min(minTime, remainSecond)
    end
  end
  TimerManager:StopTimer(self.ARGNumTimerId)
  if minTime == math.maxinteger then
    return
  end
  if minTime < 1 then
    minTime = 1
  end
  self.ARGNumTimerId = TimerManager:StartTimer(minTime, self.m_OnARGItemChnage, nil, true, false, false)
end

function AllEffectorData:OnARGItemChnage()
  self.ARGNumTimerId = nil
  local changedItemNumDic = {}
  for itemId, data in pairs(self.AutoResourceGeneratorDic) do
    local num, remainSecond = data:GetCurrentNum()
    if num ~= self.OldItemDNumDic[itemId] then
      changedItemNumDic[itemId] = num
    end
  end
  MsgCenter:Broadcast(eMsgEventId.UpdateARGItem, changedItemNumDic)
  self:StartTimer4ARGNum()
end

return AllEffectorData
