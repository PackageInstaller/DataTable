local DailyChallengeLevelAwardItem, Super = NewViewComponent("DailyChallengeLevelAwardItem")
local BALL_OFFSET = 0.12

function DailyChallengeLevelAwardItem:ctor(uiNode, view, itemData, level, claimFunc)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Pvp_Item_VictoryResource(uiNode)
  self.level = level
  self.itemData = itemData
  self.claimFunc = claimFunc
end

function DailyChallengeLevelAwardItem:RegisterNotifications()
end

function DailyChallengeLevelAwardItem:RegisterEvents()
end

function DailyChallengeLevelAwardItem:OnEnterComponent()
  self:_RefreshView()
end

function DailyChallengeLevelAwardItem:_RefreshView()
  self:SetTaskAward()
  self:SetProgress()
end

function DailyChallengeLevelAwardItem:SetTaskAward()
  local isReceive = CareerLevelModel.Instance:IsCareerLevelCanReceive(DailyChallengeDataUtils.careerLevelType, self.level)
  local isGot = CareerLevelModel.Instance:IsCareerLevelGoted(DailyChallengeDataUtils.careerLevelType, self.level)
  local itemData = {
    itemTid = self.itemData.itemTid or 0,
    itemCount = self.itemData.itemCount or 0,
    isGot = isGot,
    tipPosY = -600,
    showGetIcon = true
  }
  
  function itemData.clickFunc()
    if self.claimFunc and isReceive then
      self.claimFunc()
    end
    if not isReceive then
      ItemDataUtils.ShowItemDetailTips(self.binder, self.ui.uiNode, nil, self.itemData.itemTid)
    end
  end
  
  self:AddViewComponentOnce(self.ui.UI_Common_Item_WuPin_Type2.gameObject, CompPublicIconItemType2, itemData)
  self.ui.Effect_VX:SetActive(isReceive)
  self:SetText(self.ui.Text_Victory, LT.Textf("DailyChallengeLevel", self.level))
end

function DailyChallengeLevelAwardItem:SetProgress()
  self.ui.Image_Finish:SetActive(true)
  self.ui.Image_Finish_Next:SetActive(false)
  local lv, exp, upgradeExp = DungeonTaskDataModel.Instance:GetLevel()
  local expRate = exp / upgradeExp
  local fillAmount
  if lv >= DungeonTaskDataModel.Instance.maxLv and lv <= self.level then
    fillAmount = 0.5 * (1 + BALL_OFFSET)
  elseif lv < self.level - 1 then
    fillAmount = 0
  elseif lv > self.level then
    fillAmount = 1
  elseif lv == self.level - 1 then
    fillAmount = math.max(0, expRate - 0.5) * (1 - BALL_OFFSET)
  elseif lv == self.level then
    fillAmount = 0.5 * (1 + BALL_OFFSET) + math.min(0.5, expRate) * (1 - BALL_OFFSET)
  end
  self:SetImageFillAmount(self.ui.Image_Finish, fillAmount)
end

return DailyChallengeLevelAwardItem
