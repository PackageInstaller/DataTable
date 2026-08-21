_class("UIN14FishingGameCatchedFish", UICustomWidget)
UIN14FishingGameCatchedFish = UIN14FishingGameCatchedFish

function UIN14FishingGameCatchedFish:OnShow()
  self._spine = self:GetUIComponent("SpineLoader", "Spine")
  self.view.gameObject:SetActive(false)
end

function UIN14FishingGameCatchedFish:SetData(animName)
  self._spine:SetAnimation(0, animName, true)
  self.view.gameObject:SetActive(true)
  self._currentShowAnim = animName
  self._currentFishId = animName
end

function UIN14FishingGameCatchedFish:CheckShowName(animName)
  return animName == self._currentShowAnim
end

function UIN14FishingGameCatchedFish:CheckIsRight(rightId)
  if rightId == self._currentFishId then
    self.view.transform:SetAsLastSibling()
  end
end

function UIN14FishingGameCatchedFish:ShowFish()
  self.view.gameObject:SetActive(true)
end

function UIN14FishingGameCatchedFish:Hide()
  self.view.gameObject:SetActive(false)
end
