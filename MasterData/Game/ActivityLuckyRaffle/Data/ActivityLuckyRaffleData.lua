local base = require("Game.ActivityFrame.ActivityBase")
local ActivityLuckyRaffleData = class("ActivityLuckyRaffleData", base)
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local CurActType = ActivityFrameEnum.eActivityType.LuckyRaffle
local CommonRewardData = require("Game.CommonUI.CommonRewardData")
local redDotType = {redDotAddress = 1, redDotStarNum = 2}

function ActivityLuckyRaffleData:InitActivityLuckyRaffleDataByMsg(msg)
  local actId = msg.actId
  self:SetActFrameDataByType(CurActType, actId)
  self._mainCfg = ConfigData.activity_lucky_raffle_main[actId]
  self._infoCfg = ConfigData.activity_lucky_raffle[actId]
  self:SetLuckyRaffleVoteNumByPoolId(msg.vote)
  self:__UpdateLuckyRaffle()
end

function ActivityLuckyRaffleData:__UpdateLuckyRaffle()
  self:RefreshLuckyRaffleRedDotAddress()
  self:RefreshLuckyRaffleRedDotStarNum()
end

function ActivityLuckyRaffleData:RefreshLuckyRaffleRedDotAddress()
  local actRed = self:GetActivityReddot()
  if actRed == nil then
    return
  end
  local addressRed = actRed:AddChild(redDotType.redDotAddress)
  local isLooked = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):GetLuckyRaffleAddressLooked(self:GetActId())
  addressRed:SetRedDotCount(isLooked and 0 or 1)
end

function ActivityLuckyRaffleData:RefreshLuckyRaffleRedDotStarNum()
  local actRed = self:GetActivityReddot()
  if actRed == nil then
    return
  end
  local isHave = false
  local starNumRed = actRed:AddChild(redDotType.redDotStarNum)
  local actId = self:GetActId()
  for id, v in pairs(ConfigData.activity_lucky_raffle.starItemDic[actId]) do
    if PlayerDataCenter:GetItemCount(id) > 0 then
      isHave = true
      break
    end
  end
  starNumRed:SetRedDotCount(isHave and 1 or 0)
end

function ActivityLuckyRaffleData:SetLuckyRaffleAddressLooked()
  PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):SetLuckyRaffleAddressLooked(self:GetActId())
  self:RefreshLuckyRaffleRedDotAddress()
end

function ActivityLuckyRaffleData:SetLuckyRaffleVoteNumByPoolId(vote)
  self.voteDic = {}
  for i, v in pairs(vote) do
    self.voteDic[v.k] = v.v
  end
end

function ActivityLuckyRaffleData:GetLuckyRaffleMainCfg()
  return self._mainCfg
end

function ActivityLuckyRaffleData:GetLuckyRaffleInfoCfg()
  return self._infoCfg
end

function ActivityLuckyRaffleData:GetLuckyRaffleVoteDic()
  return self.voteDic
end

function ActivityLuckyRaffleData:GetLuckyRaffleVoteNumByPoolId(poolId)
  return self.voteDic[poolId] or 0
end

function ActivityLuckyRaffleData:GetLuckyRaffleAddressRedDot()
  local actRed = self:GetActivityReddot()
  if actRed == nil then
    return false
  end
  local starNumRed = actRed:AddChild(redDotType.redDotAddress)
  return starNumRed:GetRedDotCount() > 0
end

return ActivityLuckyRaffleData
