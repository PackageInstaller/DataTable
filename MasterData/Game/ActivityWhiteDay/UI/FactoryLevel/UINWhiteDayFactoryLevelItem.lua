local UINWhiteDayFactoryLevelItem = class("UINWhiteDayFactoryLevelItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")
local UINWhiteDayInfoBtnUnlockItem = require("Game.ActivityWhiteDay.UI.UINWhiteDayInfoBtnUnlockItem")

function UINWhiteDayFactoryLevelItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.rewardItemPool = UIItemPool.New(UINBaseItemWithReceived, self.ui.uINBaseItemWithReceived)
  self.ui.uINBaseItemWithReceived:SetActive(false)
  self.unlockItemPool = UIItemPool.New(UINWhiteDayInfoBtnUnlockItem, self.ui.obj_unlockItem)
  self.ui.obj_unlockItem:SetActive(false)
end

function UINWhiteDayFactoryLevelItem:InitWDFactoryLevelItem(AWDData, preLevelCfg, levelCfg, curLevel, curExp)
  self.AWDData = AWDData
  self.preLevelCfg = preLevelCfg
  self.levelCfg = levelCfg
  local level = levelCfg.level
  local isNextLevel = level == curLevel + 1
  local isComplete = curLevel >= level
  local levelUpExp = 0
  if self.preLevelCfg ~= nil then
    levelUpExp = self.preLevelCfg.level_up_exp
  end
  self.ui.obj_IsComplete:SetActive(isComplete)
  self.ui.obj_IsNextLevel:SetActive(isNextLevel)
  self.ui.tex_Lv.text = tostring(self.levelCfg.level)
  self.ui.tex_ProgressBar.gameObject:SetActive(not isComplete)
  self.ui.tex_Complete:SetActive(isComplete)
  self.ui.slider.gameObject:SetActive(not isComplete)
  if isComplete then
  elseif isNextLevel then
    self.ui.tex_ProgressBar:SetIndex(0, tostring(curExp), tostring(levelUpExp))
    self.ui.slider.value = curExp / levelUpExp
  else
    self.ui.tex_ProgressBar:SetIndex(0, "0", tostring(levelUpExp))
    self.ui.slider.value = 0
  end
  self:__GenRewardItems(self.levelCfg.level, isComplete)
end

function UINWhiteDayFactoryLevelItem:__GenRewardItems(curLevel, isComplete)
  local randomId, _ = self.AWDData:GetWDRandomPhotoItemIdAndNum()
  local exchangeId, _ = self.AWDData:GetWDExchangePhotoItemIdAndNum()
  local isLimit = self.AWDData:GetWhiteDayPhotoConvertItemIsAboveLimit()
  self.rewardItemPool:HideAll()
  for index, itemId in ipairs(self.levelCfg.level_reward_ids) do
    local num = self.levelCfg.level_reward_nums[index]
    local rewardItem = self.rewardItemPool:GetOne()
    local itemCfg = ConfigData.item[itemId]
    rewardItem:InitItemWithCount(itemCfg, num, nil, isComplete)
    if not isComplete and (randomId == itemId or exchangeId == itemId) then
      rewardItem:SetItemRecycyleTag(isLimit)
    end
  end
  self.unlockItemPool:HideAll()
  local lineList = self.AWDData:GetAWDFactoryLevelUpUnlockLineList(curLevel) or table.emptytable
  for _, lineId in ipairs(lineList) do
    local unlockItem = self.unlockItemPool:GetOne()
    unlockItem:IntiInfoBtnUnlockItem(true, nil)
  end
  local orderDataList = self.AWDData:GetAWDFactoryLevelUpUnlockOrderDataList(curLevel) or table.emptytable
  for _, orderData in ipairs(orderDataList) do
    local unlockItem = self.unlockItemPool:GetOne()
    unlockItem:IntiInfoBtnUnlockItem(false, orderData)
  end
end

function UINWhiteDayFactoryLevelItem:OnDelete()
  base.OnDelete(self)
end

return UINWhiteDayFactoryLevelItem
