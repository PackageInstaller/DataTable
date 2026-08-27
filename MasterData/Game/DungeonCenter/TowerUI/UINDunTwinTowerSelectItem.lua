local UINDunTwinTowerSelectItem = class("UINDunTwinTowerSelectItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")

function UINDunTwinTowerSelectItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_State, self, self.OnTwinTowerItemClick)
  self.rewardPool = UIItemPool.New(UINBaseItemWithCount, self.ui.uINBaseItem)
  self.ui.uINBaseItem:SetActive(false)
end

function UINDunTwinTowerSelectItem:InitTwinTowerSelectItem(towerTypeData, selectId, myRank, clickEvent)
  self.__towerTypeData = towerTypeData
  self.__clickEvent = clickEvent
  self.ui.tex_TowerName.text = self.__towerTypeData:GetDungeonTowerName()
  self.ui.tex_Details.text = self.__towerTypeData:GetDungeonTowerDesc()
  local totalLevel = self.__towerTypeData:GetTowerTotalLevel()
  local towerId = self.__towerTypeData:GetDungeonTowerTypeId()
  local completeLevel = PlayerDataCenter.dungeonTowerSData:GetTowerCompleteLevel(self.__towerTypeData:GetDungeonTowerTypeId())
  self.ui.tex_Progress:SetIndex(0, tostring(completeLevel), tostring(totalLevel))
  self.ui.sl_Progress.value = completeLevel / totalLevel
  if 0 < selectId then
    local isSelected = selectId == towerId
    self.ui.obj_challenge:SetActive(isSelected)
    self.ui.btn_State.gameObject:SetActive(not isSelected)
    self.ui.tex_State:SetIndex(0)
  else
    self.ui.btn_State.gameObject:SetActive(true)
    self.ui.tex_State:SetIndex(1)
  end
  local allComplete = totalLevel <= completeLevel
  self.ui.obj_received:SetActive(allComplete)
  self.ui.obj_reward:SetActive(not allComplete)
  if not allComplete then
    self.rewardPool:HideAll()
    local reward_ids, reward_nums = self.__towerTypeData:GetTowerRewardInfo()
    for index, itemId in pairs(reward_ids) do
      local itemCount = reward_nums[index]
      local itmeCfg = ConfigData.item[itemId]
      local item = self.rewardPool:GetOne()
      item:InitItemWithCount(itmeCfg, nil)
    end
  end
  self:_InitRankSelfInfo(myRank)
end

function UINDunTwinTowerSelectItem:_InitRankSelfInfo(myRank)
  local isComplete, totalFrame = PlayerDataCenter.dungeonTowerSData:GetTowerTotalRacingFrame(self.__towerTypeData:GetDungeonTowerTypeId())
  self.ui.obj_time:SetActive(isComplete)
  if isComplete then
    self.ui.tex_TotalTime:SetIndex(0, BattleUtil.FrameToTimeString(totalFrame, true))
  end
  if totalFrame >= BattleUtil.CheatFrame then
    self.ui.obj_RankPer:SetActive(false)
    return
  end
  local rankCfg = ConfigData.common_ranklist[self.__towerTypeData:GetTowerRankId()]
  if myRank == nil or rankCfg == nil then
    self.ui.obj_RankPer:SetActive(false)
    return
  end
  if myRank.inRank then
    self.ui.obj_RankPer:SetActive(true)
    self.ui.tex_RankPer:SetIndex(1, tostring(myRank.rankParam))
  elseif myRank.rankParam <= rankCfg.percent_show then
    self.ui.obj_RankPer:SetActive(true)
    self.ui.tex_RankPer:SetIndex(0, GetPreciseDecimalStr(myRank.rankParam / 100, 1))
  else
    self.ui.obj_RankPer:SetActive(false)
  end
end

function UINDunTwinTowerSelectItem:__PlayThemeTween(time)
  self.ui.cg_ThemeAlpha:DOFade(0, 0.3):From():SetDelay(time * 0.15)
end

function UINDunTwinTowerSelectItem:SetTwinTowerItemReddot(active)
  self.ui.redDot_Twin:SetActive(active)
end

function UINDunTwinTowerSelectItem:SetTwinTowerItemBluedot(active)
  self.ui.blueDot_Twin:SetActive(active)
end

function UINDunTwinTowerSelectItem:OnTwinTowerItemClick()
  if self.__clickEvent ~= nil then
    self.__clickEvent(self.__towerTypeData)
  end
end

function UINDunTwinTowerSelectItem:OnDelete()
  self.ui.cg_ThemeAlpha:DOKill()
  base.OnDelete(self)
end

return UINDunTwinTowerSelectItem
