local UINDunLevelNormalNode = class("UINLevelNormalNode", UIBaseNode)
local base = UIBaseNode
local DungeonLevelEnum = require("Game.DungeonCenter.DungeonLevelEnum")
local UINLevelDetailRewardItem = require("Game.Sector.SectorLevelDetail.Nodes.UINLevelDetailRewardItem")
local CS_LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder

function UINDunLevelNormalNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_ShowRank, self, self._OnClickShowRank)
  self.rewardItemPool = UIItemPool.New(UINLevelDetailRewardItem, self.ui.itemWithCount)
  self.ui.itemWithCount:SetActive(false)
end

function UINDunLevelNormalNode:BindDunLevelResloader(resloader)
  self.__resloader = resloader
end

function UINDunLevelNormalNode:InitDungeonInfoNode(dLevelDetail)
  self.__dLevelDetail = dLevelDetail
  local dunLevelData = dLevelDetail:GetDungeonLevelData()
  self.ui.tex_LevelName:SetIndex(0, dunLevelData:GetDungeonLevelName())
  self.ui.tex_LevelInfo.text = dunLevelData:GetDungeonInfoDesc()
  self:RefreshDLevelReward()
  self:RefreshDLevelWave()
  self:_UpdRanking()
end

function UINDunLevelNormalNode:RefreshDLevelReward()
  local dunLevelData = self.__dLevelDetail:GetDungeonLevelData()
  local dungeonType = dunLevelData:GetDungeonLevelType()
  if dungeonType == DungeonLevelEnum.DunLevelType.SectorIIChallenge or dungeonType == DungeonLevelEnum.DunLevelType.ADC or dungeonType == DungeonLevelEnum.DunLevelType.ActBlackHole or dungeonType == DungeonLevelEnum.DunLevelType.HeroGrowChallenge then
    self.ui.obj_reward:SetActive(false)
    return
  end
  self.ui.obj_reward:SetActive(true)
  self.ui.normalList.gameObject:SetActive(true)
  self.ui.maybeList.gameObject:SetActive(false)
  self.rewardItemPool:HideAll()
  local rewardCount = 0
  local dunLevelData = self.__dLevelDetail:GetDungeonLevelData()
  local isPicked = false
  if dungeonType == DungeonLevelEnum.DunLevelType.Tower or dungeonType == DungeonLevelEnum.DunLevelType.SixHeroTower then
    local levelNum = dunLevelData:GetDunTowerLevelNum()
    local towerId = dunLevelData:GetDungeonTowerType()
    isPicked = levelNum <= PlayerDataCenter.dungeonTowerSData:GetTowerCompleteLevel(towerId)
  else
    isPicked = 0 < PlayerDataCenter:GetTotalBattleTimes(dunLevelData:GetDungeonLevelStageId())
  end
  local dunLevelType = dunLevelData:GetDungeonLevelType()
  if dunLevelType == DungeonLevelEnum.DunLevelType.Tower or dunLevelType == DungeonLevelEnum.DunLevelType.Carnival or dungeonType == DungeonLevelEnum.DunLevelType.Spring or dungeonType == DungeonLevelEnum.DunLevelType.CommonHard or dungeonType == DungeonLevelEnum.DunLevelType.Bond or dungeonType == DungeonLevelEnum.DunLevelType.SixHeroTower then
    local first_reward_ids, first_reward_nums = dunLevelData:GetDungeonFirstReward()
    self.ui.txtInfo_firsRewardList:SetIndex(0)
    for index, rewardId in ipairs(first_reward_ids) do
      local rewardNum = first_reward_nums[index]
      rewardCount = self:__CreateDetailRewardItem(rewardCount, self.ui.normalList, rewardId, rewardNum, isPicked, false)
    end
  elseif dunLevelType == DungeonLevelEnum.DunLevelType.SectorII or dunLevelType == DungeonLevelEnum.DunLevelType.SectorIII then
    local dropDic = dunLevelData:GetCommonActDropData()
    self.ui.txtInfo_firsRewardList:SetIndex(3)
    for itemId, numTable in pairs(dropDic) do
      local num
      if numTable.max == nil then
        num = numTable.min
      elseif numTable.max >= 1000 then
        num = tostring(numTable.min) .. "+"
      else
        num = tostring(numTable.min) .. "-" .. tostring(numTable.max)
      end
      rewardCount = self:__CreateDetailRewardItem(rewardCount, self.ui.normalList, itemId, num, false, false)
    end
  elseif dunLevelType == DungeonLevelEnum.DunLevelType.HeroGrow or dungeonType == DungeonLevelEnum.DunLevelType.Repeat or dungeonType == DungeonLevelEnum.DunLevelType.Season or dungeonType == DungeonLevelEnum.DunLevelType.SeasonI or dungeonType == DungeonLevelEnum.DunLevelType.HeroGrowV3Repeat then
    self.ui.maybeList.gameObject:SetActive(true)
    local first_reward_ids, first_reward_nums = dunLevelData:GetDungeonFirstReward()
    self.ui.txtInfo_firsRewardList:SetIndex(0)
    for index, rewardId in ipairs(first_reward_ids) do
      local rewardNum = first_reward_nums[index]
      rewardCount = self:__CreateDetailRewardItem(rewardCount, self.ui.normalList, rewardId, rewardNum, isPicked, false)
    end
    local dropDic = dunLevelData:GetCommonActDropData()
    for itemId, numTable in pairs(dropDic) do
      local num
      if numTable.max == nil then
        num = numTable.min
      elseif numTable.max >= 1000 then
        num = tostring(numTable.min) .. "+"
      else
        num = tostring(numTable.min) .. "-" .. tostring(numTable.max)
      end
      rewardCount = self:__CreateDetailRewardItem(rewardCount, self.ui.maybeList, itemId, num, false, false)
    end
    CS_LayoutRebuilder.ForceRebuildLayoutImmediate(self.ui.obj_reward.transform)
  end
end

function UINDunLevelNormalNode:RefreshDLevelWave()
  local dunLevelData = self.__dLevelDetail:GetDungeonLevelData()
  local dunLevelType = dunLevelData:GetDungeonLevelType()
  if dunLevelType == DungeonLevelEnum.DunLevelType.Tower then
    self.ui.obj_levelName:SetActive(false)
  elseif dunLevelType == DungeonLevelEnum.DunLevelType.SectorII or dunLevelType == DungeonLevelEnum.DunLevelType.SectorIII then
    self.ui.obj_levelName:SetActive(true)
    self.ui.tex_Layer:SetIndex(1, tostring(dunLevelData:GetWaveNum()))
  elseif dunLevelType == DungeonLevelEnum.DunLevelType.SectorIIChallenge then
    self.ui.obj_levelName:SetActive(true)
    self.ui.tex_Layer:SetIndex(2, tostring(dunLevelData:GetSctIIChallengeDgLvNum()))
  else
    self.ui.obj_levelName:SetActive(false)
  end
end

function UINDunLevelNormalNode:__CreateDetailRewardItem(oriCount, parentTr, itemId, itemNum, isPick, showTag)
  local rewardItem = self.rewardItemPool:GetOne()
  rewardItem.transform:SetParent(parentTr)
  local itemCfg = ConfigData.item[itemId]
  rewardItem:InitItemWithCount(itemCfg, itemNum, self.__ShowRewardDetail, isPick, showTag)
  return (oriCount or 0) + 1
end

function UINDunLevelNormalNode:_UpdRanking()
  local dunLevelData = self.__dLevelDetail:GetDungeonLevelData()
  local dunLevelType = dunLevelData:GetDungeonLevelType()
  self.ui.ranking:SetActive(false)
  self.ui.btn_ShowRank.gameObject:SetActive(true)
  self.ui.obj_dmgNode:SetActive(false)
  if not dunLevelData:GetIsShowDunRank() then
    return
  end
  if dunLevelType == DungeonLevelEnum.DunLevelType.SectorIIChallenge then
    self.ui.ranking:SetActive(true)
    local maxScore = dunLevelData:GetSctIIChallengeDgMaxScore()
    self.ui.tex_MaxRankScoure.text = tostring(maxScore)
    self.ui.btn_ShowRank.gameObject:SetActive(false)
  elseif dunLevelType == DungeonLevelEnum.DunLevelType.ADC then
    local isOnlyShowScore = dunLevelData:GetIsOnlyShowScore()
    if isOnlyShowScore then
      self.ui.btn_ShowRank.gameObject:SetActive(false)
    end
    self.ui.ranking:SetActive(true)
    local maxScore = dunLevelData:GetDungeonADCScore()
    self.ui.tex_MaxRankScoure.text = tostring(maxScore)
    local isInfinite = dunLevelData:GetIsInfinite()
    self.ui.obj_dmgNode:SetActive(isInfinite)
    if isInfinite then
      local maxDmg = dunLevelData:GetDungeonADCMaxDamage()
      self.ui.tex_MaxDmgNum.text = tostring(maxDmg)
    end
  elseif dunLevelType == DungeonLevelEnum.DunLevelType.HeroGrowChallenge then
    self.ui.btn_ShowRank.gameObject:SetActive(false)
    self.ui.ranking:SetActive(true)
    local maxScore = dunLevelData:GetHeroGrowMaxScore()
    self.ui.tex_MaxRankScoure.text = tostring(maxScore)
    self.ui.obj_dmgNode:SetActive(true)
    local maxDmg = dunLevelData:GetHeroGrowMaxDamage()
    self.ui.tex_MaxDmgNum.text = tostring(maxDmg)
  end
end

function UINDunLevelNormalNode:_OnClickShowRank()
  local rankId
  local dunLevelData = self.__dLevelDetail:GetDungeonLevelData()
  local dunLevelType = dunLevelData:GetDungeonLevelType()
  if dunLevelType == DungeonLevelEnum.DunLevelType.SectorIIChallenge then
    rankId = dunLevelData:GetSctIIChallengeDgRankId()
  elseif dunLevelType == DungeonLevelEnum.DunLevelType.ADC then
    rankId = dunLevelData:GetDungeonADCRankId()
  end
  if rankId == nil then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonRank, function(rankWindow)
    if rankWindow == nil then
      return
    end
    rankWindow:InitCommonRank(rankId)
  end)
end

return UINDunLevelNormalNode
