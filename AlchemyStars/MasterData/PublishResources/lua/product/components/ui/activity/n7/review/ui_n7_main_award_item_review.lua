_class("UIN7MainAwardItemReview", UICustomWidget)
UIN7MainAwardItemReview = UIN7MainAwardItemReview

function UIN7MainAwardItemReview:OnShow()
  self.anim = self:GetUIComponent("Animation", "UIN7MainAwardItemReview")
  self.notReach = self:GetGameObject("notReach")
  self.reach = self:GetGameObject("reach")
  self.next = self:GetGameObject("next")
end

function UIN7MainAwardItemReview:OnHide()
end

function UIN7MainAwardItemReview:Flush(isReach, isNext, checkGot)
  self.next:SetActive(false)
  self.notReach:SetActive(false)
  self.reach:SetActive(false)
  if isNext then
    self.next:SetActive(true)
  elseif isReach and not checkGot then
    self.reach:SetActive(true)
  else
    self.notReach:SetActive(true)
  end
end

function UIN7MainAwardItemReview:PlayAnim()
  self.anim:Play("uieff_N7_MainReview1")
end
