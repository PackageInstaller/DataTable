local UIActivityFlipCardRewardPreview = class("UIActivityFlipCardRewardPreview", UIBaseWindow)
local base = UIBaseWindow
local UINActivityFlipCardRewardGroup = require("Game.ActivityFlipCard.UI.RewardPreview.UINActivityFlipCardRewardGroup")

function UIActivityFlipCardRewardPreview:OnInit()
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.__BackAction):PushTopStatusDataToBackStack()
  UIUtil.AddButtonListener(self.ui.btn_Bg, self, self.__OnClickClose)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.__OnClickClose)
  UIUtil.AddButtonListener(self.ui.btn_Left, self, self.__OnClickFlipLeft)
  UIUtil.AddButtonListener(self.ui.btn_Right, self, self.__OnClickFlipRight)
  self._rewardGroupPool = UIItemPool.New(UINActivityFlipCardRewardGroup, self.ui.obj_RewardGroup, false)
end

function UIActivityFlipCardRewardPreview:InitFlipRewardPreview(flipCardData, roundId)
  self._flipCardData = flipCardData
  self._currnetRoundId = roundId
  self:__SetFlipRewardPage(roundId)
end

function UIActivityFlipCardRewardPreview:__SetFlipRewardPage(roundId)
  self._showingRoundId = roundId
  local hasLeft = self._flipCardData:GetFlipCardRoundCfg(roundId - 1) ~= nil
  local hasRight = self._flipCardData:GetFlipCardRoundCfg(roundId + 1) ~= nil
  local hasFinal = self._flipCardData:GetRoundHasFinalReward(roundId)
  self.ui.btn_Left.interactable = hasLeft
  self.ui.btn_Right.interactable = hasRight
  local texIndex = hasFinal and 0 or 2
  if self._currnetRoundId == roundId then
    texIndex = texIndex + 1
  end
  self.ui.tex_RoundName:SetIndex(texIndex, tostring(roundId))
  self._rewardGroupPool:HideAll()
  if hasFinal then
    local finalRewardGroup = self._rewardGroupPool:GetOne()
    local rewardIds, rewardNums, rewardGroupNums = self._flipCardData:GetFlipFinalRewardByRound(roundId)
    finalRewardGroup:InitFlipRewardGroup(0, rewardIds, rewardNums, rewardGroupNums)
  end
  local commonewardGroup = self._rewardGroupPool:GetOne()
  local rewardIds, rewardNums, rewardGroupNums = self._flipCardData:GetFlipRewardsByRound(roundId, true)
  commonewardGroup:InitFlipRewardGroup(1, rewardIds, rewardNums, rewardGroupNums)
end

function UIActivityFlipCardRewardPreview:__OnClickFlipLeft()
  local hasLeft = self._flipCardData:GetFlipCardRoundCfg(self._showingRoundId - 1) ~= nil
  if not hasLeft then
    return
  end
  self:__SetFlipRewardPage(self._showingRoundId - 1)
end

function UIActivityFlipCardRewardPreview:__OnClickFlipRight()
  local hasRight = self._flipCardData:GetFlipCardRoundCfg(self._showingRoundId + 1) ~= nil
  if not hasRight then
    return
  end
  self:__SetFlipRewardPage(self._showingRoundId + 1)
end

function UIActivityFlipCardRewardPreview:__OnClickClose()
  UIUtil.OnClickBackByUiTab(self)
end

function UIActivityFlipCardRewardPreview:__BackAction()
  self:Delete()
end

return UIActivityFlipCardRewardPreview
