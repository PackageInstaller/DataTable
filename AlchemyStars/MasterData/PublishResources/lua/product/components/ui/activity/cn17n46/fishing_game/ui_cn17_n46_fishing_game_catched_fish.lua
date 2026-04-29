_class("UICN17N46FishingGameCatchedFish", UICustomWidget)
UICN17N46FishingGameCatchedFish = UICN17N46FishingGameCatchedFish

function UICN17N46FishingGameCatchedFish:OnShow()
  self._spine = self:GetUIComponent("SpineLoader", "Spine")
  self.view.gameObject:SetActive(false)
end

function UICN17N46FishingGameCatchedFish:SetData(animName)
  self._spine:SetAnimation(0, animName, true)
  self.view.gameObject:SetActive(true)
  self._currentShowAnim = animName
  self._currentFishId = animName
end

function UICN17N46FishingGameCatchedFish:CheckShowName(animName)
  return animName == self._currentShowAnim
end

function UICN17N46FishingGameCatchedFish:CheckIsRight(rightId)
  if rightId == self._currentFishId then
    self.view.transform:SetAsLastSibling()
  end
end

function UICN17N46FishingGameCatchedFish:ShowFish()
  self.view.gameObject:SetActive(true)
end

function UICN17N46FishingGameCatchedFish:Hide()
  self.view.gameObject:SetActive(false)
end
