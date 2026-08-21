_class("UIN12ChallengeTaskRewardItem", UICustomWidget)
UIN12ChallengeTaskRewardItem = UIN12ChallengeTaskRewardItem

function UIN12ChallengeTaskRewardItem:OnShow(uiParams)
  self:_GetComponent()
end

function UIN12ChallengeTaskRewardItem:_GetComponent()
  self._count = self:GetUIComponent("UILocalizationText", "Count")
end

function UIN12ChallengeTaskRewardItem:SetData(count)
  self._count:SetText(count)
end
