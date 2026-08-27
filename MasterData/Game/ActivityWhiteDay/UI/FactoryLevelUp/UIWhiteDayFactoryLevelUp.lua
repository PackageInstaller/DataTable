local UIWhiteDayFactoryLevelUp = class("UIWhiteDayFactoryLevelUp", UIBaseWindow)
local base = UIBaseWindow
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
local UINWhiteDayInfoBtnUnlockItem = require("Game.ActivityWhiteDay.UI.UINWhiteDayInfoBtnUnlockItem")

function UIWhiteDayFactoryLevelUp:OnInit()
  self.rewardItemPool = UIItemPool.New(UINBaseItemWithCount, self.ui.uINBaseItemWithCount)
  self.ui.uINBaseItemWithCount:SetActive(false)
  self.unlockItemPool = UIItemPool.New(UINWhiteDayInfoBtnUnlockItem, self.ui.obj_unlockItem)
  self.ui.obj_unlockItem:SetActive(false)
  UIUtil.AddButtonListener(self.ui.btn_background, self, self.__OnClickClose)
end

function UIWhiteDayFactoryLevelUp:InitWDFactoryLevelUp(AWDData, beforeLevelUpLevel, closeCallback)
  self.AWDData = AWDData
  self.curLevel = AWDData:GetAWDFactoryLevel()
  self.beforeLevelUpLevel = beforeLevelUpLevel
  self.closeCallback = closeCallback
  if beforeLevelUpLevel >= self.curLevel then
    UIUtil.OnClickBackByUiTab(self)
  end
  self:__RefreshLevelUpUI()
end

function UIWhiteDayFactoryLevelUp:__RefreshLevelUpUI()
  local randomId, _ = self.AWDData:GetWDRandomPhotoItemIdAndNum()
  local exchangeId, _ = self.AWDData:GetWDExchangePhotoItemIdAndNum()
  local isLimit = self.AWDData:GetWhiteDayPhotoConvertItemIsAboveLimit()
  local unlockLevel = self.beforeLevelUpLevel + 1
  self.ui.tex_CurrentLevel.text = tostring(self.beforeLevelUpLevel)
  self.ui.tex_LvUp.text = tostring(unlockLevel)
  self.rewardItemPool:HideAll()
  self.unlockItemPool:HideAll()
  local ids, nums = self.AWDData:GetAWDFactoryLevelUpReward(self.beforeLevelUpLevel)
  for index, itemId in ipairs(ids) do
    local num = nums[index]
    local rewardItem = self.rewardItemPool:GetOne()
    local itemCfg = ConfigData.item[itemId]
    rewardItem:InitItemWithCount(itemCfg, num, nil, nil)
    if randomId == itemId or exchangeId == itemId then
      rewardItem:SetItemRecycyleTag(isLimit)
    end
  end
  local lineList = self.AWDData:GetAWDFactoryLevelUpUnlockLineList(unlockLevel) or table.emptytable
  for _, lineId in ipairs(lineList) do
    local unlockItem = self.unlockItemPool:GetOne()
    unlockItem:IntiInfoBtnUnlockItem(true, nil)
  end
  local orderDataList = self.AWDData:GetAWDFactoryLevelUpUnlockOrderDataList(unlockLevel) or table.emptytable
  for _, orderData in ipairs(orderDataList) do
    local unlockItem = self.unlockItemPool:GetOne()
    unlockItem:IntiInfoBtnUnlockItem(false, orderData)
  end
end

function UIWhiteDayFactoryLevelUp:BackAction()
  if self.beforeLevelUpLevel + 1 < self.curLevel then
    self.beforeLevelUpLevel = self.beforeLevelUpLevel + 1
    self:__RefreshLevelUpUI()
    return
  end
  if self.closeCallback ~= nil then
    self.closeCallback()
  end
  self:Hide()
end

function UIWhiteDayFactoryLevelUp:__OnClickClose()
  UIUtil.OnClickBackByUiTab(self)
end

function UIWhiteDayFactoryLevelUp:OnShow()
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.BackAction):PushTopStatusDataToBackStack()
  base.OnShow(self)
end

function UIWhiteDayFactoryLevelUp:OnDelete()
  base.OnDelete(self)
end

return UIWhiteDayFactoryLevelUp
