local ActivityBase = require("Game.ActivityFrame.ActivityBase")
local ActivityBondData = class("ActivityBondData", ActivityBase)
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local CurActType = ActivityFrameEnum.eActivityType.Bond
local ActivityBondEnum = require("Game.ActivityBond.Data.ActivityBondEnum")
local ActivityBondDunGroupData = require("Game.ActivityBond.Data.ActivityBondDunGroupData")
local ActivityBondDunData = require("Game.ActivityBond.Data.ActivityBondDunData")

function ActivityBondData:InitActData(msg)
  self.actId = msg.actId
  self.totalScore = msg.totalScore
  self.rewardPickedScore = msg.RewardGot or 0
  self:SetActFrameDataByType(CurActType, self.actId)
  self.__fromActData = nil
  self.__battleReturnFunc = nil
  self.mainCfg = ConfigData.activity_bond_main[self.actId]
  self.dunDataGroupDataDic = {}
  self:InitDunData(msg.bondStageGroup)
  self:__RefreshlAllRedBuleDot()
end

function ActivityBondData:UpdateActData(msg)
  self.totalScore = msg.totalScore or 0
  self.rewardPickedScore = msg.RewardGot or self.rewardPickedScore
  if msg.bondStageGroup == nil then
    return
  end
  for groupId, dunGroupData in pairs(self.dunDataGroupDataDic) do
    local groupMsg = msg.bondStageGroup[groupId]
    if groupMsg ~= nil then
      dunGroupData:ActBond_RefreshByMsg(groupMsg)
    end
  end
  self:__RefreshlAllRedBuleDot()
end

function ActivityBondData:InitDunData(bondStageGroupMsg)
  for groupId, dunGropCfg in ipairs(ConfigData.activity_bond_dun_group[self.actId]) do
    local groupMsg = bondStageGroupMsg[groupId]
    local dunGroupData = ActivityBondDunGroupData.New(groupId, dunGropCfg)
    self.dunDataGroupDataDic[groupId] = dunGroupData
    for _, dunId in ipairs(dunGropCfg.dungeon_id) do
      local dunData = ActivityBondDunData.New(dunId, dunGroupData)
      dunGroupData:ActBond_AddDunData(dunData)
    end
    dunGroupData:ActBond_RefreshByMsg(groupMsg)
  end
end

function ActivityBondData:GetActBondSeasonRule()
  return LanguageUtil.GetLocaleText(self.mainCfg.season_rule)
end

function ActivityBondData:GetActBondSeasonBuffId()
  return self.mainCfg.season_buff_id
end

function ActivityBondData:GetActBondDunGroupList()
  return self.dunDataGroupDataDic
end

function ActivityBondData:GetActBondTipId()
  return self.mainCfg.rule_title, self.mainCfg.rule_id
end

function ActivityBondData:GetActBondTotalScore()
  return self.totalScore
end

function ActivityBondData:GetActBondPickedScore()
  return self.rewardPickedScore
end

function ActivityBondData:GetActBond_Bonds(typeEnum)
  local list = {}
  local cfgDic = ConfigData.activity_bond_bond[self.actId]
  for _, cfg in pairs(cfgDic) do
    if cfg.bond_type == typeEnum then
      table.insert(list, cfg)
    end
  end
  table.sort(list, function(a, b)
    return a.bond_id < b.bond_id
  end)
  return list
end

function ActivityBondData:GetFormationRuleCfg()
  local fmtRuleCfg
  local ruleId = self.mainCfg.formation_rule
  if 0 < ruleId then
    fmtRuleCfg = ConfigData.formation_rule[ruleId]
  end
  return fmtRuleCfg
end

function ActivityBondData:SetBondParentActData(fromActData, battleReturnFunc, enterBattleCallback)
  self.__fromActData = fromActData
  self.__battleReturnFunc = battleReturnFunc
  self.__enterBattleCallback = enterBattleCallback
end

function ActivityBondData:GetBondParentActData()
  return self.__fromActData, self.__battleReturnFunc, self.__enterBattleCallback
end

function ActivityBondData:GetBandHeroDic()
  local heroDic = {}
  local heroList = self.mainCfg.ban_hero
  for i, v in ipairs(heroList) do
    heroDic[v] = true
  end
  return heroDic
end

function ActivityBondData:RefreshRed_RewardPick()
  local redNode = self:GetActChildRedDot(ActivityBondEnum.reddotType.Reward)
  if redNode == nil then
    return
  end
  if not self:IsActivityRunning() and redNode:GetRedDotCount() ~= 0 then
    redNode:SetRedDotCount(0)
  end
  local actId = self:GetActId()
  local rewardCfgList = ConfigData.activity_bond_reward[actId]
  local totalScore = self:GetActBondTotalScore()
  local pickedScore = self:GetActBondPickedScore()
  local flag = false
  for _, cfg in ipairs(rewardCfgList) do
    local score = cfg.score
    if totalScore >= score and pickedScore < score then
      flag = true
      break
    end
  end
  local redCount = flag and 1 or 0
  if redNode:GetRedDotCount() ~= redCount then
    redNode:SetRedDotCount(redCount)
  end
end

function ActivityBondData:__RefreshlAllRedBuleDot()
  self:RefreshRed_RewardPick()
end

function ActivityBondData:ReSetActivityReddotRoot(reddotNode)
  local oldNode = self:GetActivityReddot()
  for _, nodeId in pairs(ActivityBondEnum.reddotType) do
    oldNode:RemoveChild(nodeId)
  end
  self.__reddotCumstomRootNode = reddotNode
  self:__RefreshlAllRedBuleDot()
end

function ActivityBondData:GetActivityReddot()
  if self.__reddotCumstomRootNode ~= nil then
    return self.__reddotCumstomRootNode
  end
  return ActivityBase.GetActivityReddot(self)
end

function ActivityBondData:GetActivityReddotNum()
  local isBlue = true
  local actRedDotNode = self:GetActivityReddot()
  if actRedDotNode == nil then
    error("can't get activity reddot node")
    return false, 0
  end
  local num = actRedDotNode:GetRedDotCount()
  for i, v in ipairs(ActivityBondEnum.reddotIsRedType) do
    local redChild = actRedDotNode:GetChild(v)
    if redChild ~= nil and 0 < redChild:GetRedDotCount() then
      isBlue = false
      break
    end
  end
  return isBlue, num
end

function ActivityBondData:OnDataRemoved()
  self:__RefreshlAllRedBuleDot()
end

return ActivityBondData
