local UINEventSignIn = require("Game.DailySignIn.UI.UINEventSignIn")
local UINEventSignInWithPeriodicCard = class("UINEventSignInWithPeriodicCard", UINEventSignIn)
local base = UINEventSignIn
local EPeriodicCardType = require("Game.DailySignIn.DailySignInEnum").EPeriodicCardType
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")

function UINEventSignInWithPeriodicCard:OnInit()
  base.OnInit(self)
  UIUtil.AddButtonListener(self.ui.btn_monthAwardGroup, self, self.OnClickBuyMonthCard)
  UIUtil.AddButtonListener(self.ui.btn_weekAwardGroup, self, self.OnClickBuyMonthCard)
end

function UINEventSignInWithPeriodicCard:__SelectRewardItem(SigninRewardItem)
  self.selectedItemDateNum = SigninRewardItem.dateNum
  self.ui.obj_Select.transform:SetParent(SigninRewardItem.transform, false)
  self.ui.obj_Select:SetActive(true)
  self.ui.obj_sign:SetActive(SigninRewardItem.isPicked)
  local itemIds, itemNums = PlayerDataCenter.dailySignInData:GetSingInRewardByDayNum(SigninRewardItem.dateNum)
  local MC_itemIds, MC_itemNums = PlayerDataCenter.dailySignInData:GetMonthCardRewardBm(EPeriodicCardType.MonthCard)
  local WC_itemIds, WC_itemNums = PlayerDataCenter.dailySignInData:GetMonthCardRewardBm(EPeriodicCardType.WeekCard)
  for _, item in pairs(self.ItemWithCountList) do
    item.gameObject:SetActive(false)
  end
  local count = 0
  if itemIds ~= nil then
    for index, id in ipairs(itemIds) do
      if self.ItemWithCountList[index] == nil then
        local rewardItem = UINBaseItemWithReceived.New()
        local go = self.ui.obj_rewardItem:Instantiate()
        rewardItem:Init(go)
        self.ItemWithCountList[index] = rewardItem
      end
      local itemCfg = ConfigData.item[id]
      local num = itemNums[index]
      self.ItemWithCountList[index].transform:SetParent(self.ui.obj_normalAwardGroup.transform, false)
      self.ItemWithCountList[index]:InitItemWithCount(itemCfg, num)
      self.ItemWithCountList[index].gameObject:SetActive(true)
    end
    count = #itemIds
  end
  if MC_itemIds ~= nil then
    self.ui.obj_monthAwardGroup:SetActive(true)
    for index, id in ipairs(MC_itemIds) do
      local listIndex = index + count + EPeriodicCardType.MonthCard - 1
      if self.ItemWithCountList[listIndex] == nil then
        local rewardItem = UINBaseItemWithReceived.New()
        local go = self.ui.obj_MonthRewardItem
        rewardItem:Init(go)
        self.ItemWithCountList[listIndex] = rewardItem
      end
      local itemCfg = ConfigData.item[id]
      local num = MC_itemNums[index]
      self.ItemWithCountList[listIndex]:InitItemWithCount(itemCfg, num)
      self.ItemWithCountList[listIndex].gameObject:SetActive(true)
      break
    end
  else
    self.ui.obj_monthAwardGroup:SetActive(false)
  end
  if WC_itemIds ~= nil then
    self.ui.obj_weekAwardGroup:SetActive(true)
    for index, id in ipairs(WC_itemIds) do
      local listIndex = index + count + EPeriodicCardType.WeekCard - 1
      if self.ItemWithCountList[listIndex] == nil then
        local rewardItem = UINBaseItemWithReceived.New()
        local go = self.ui.obj_WeekRewardItem
        rewardItem:Init(go)
        self.ItemWithCountList[listIndex] = rewardItem
      end
      local itemCfg = ConfigData.item[id]
      local num = WC_itemNums[index]
      self.ItemWithCountList[listIndex]:InitItemWithCount(itemCfg, num)
      self.ItemWithCountList[listIndex].gameObject:SetActive(true)
      break
    end
  else
    self.ui.obj_weekAwardGroup:SetActive(false)
  end
end

function UINEventSignInWithPeriodicCard:ShowMonthCardLeftNum()
  local showMonthTip = self:RefreshMonthCardUI(EPeriodicCardType.MonthCard, self.ui.tex_monthJump, self.ui.tex_monthLastTime)
  local showWeekTip = self:RefreshMonthCardUI(EPeriodicCardType.WeekCard, self.ui.tex_weekJump, self.ui.tex_weekLastTime)
  self.ui.TimeNode:SetActive(showMonthTip or showWeekTip)
end

function UINEventSignInWithPeriodicCard:RefreshMonthCardUI(cardType, uiTexJump, uiTexLastTime)
  local leftday = PlayerDataCenter.dailySignInData:GetMonthCardLeftCount(cardType)
  local needTips = false
  if 0 < leftday then
    uiTexJump:SetIndex(1)
    uiTexLastTime:SetIndex(0, tostring(leftday))
    if leftday <= PlayerDataCenter.dailySignInData:GetMonthCardData(cardType):GetMonthCardTipsDay() then
      needTips = true
    end
  else
    uiTexJump:SetIndex(0)
    uiTexLastTime:SetIndex(1)
  end
  return needTips
end

return UINEventSignInWithPeriodicCard
