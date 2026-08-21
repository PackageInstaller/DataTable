_class("UIN22Intro", UIController)
UIN22Intro = UIN22Intro

function UIN22Intro:OnShow(uiParams)
  self.atc = self:GetGameObject():GetComponent(typeof(ATransitionComponent))
  self.atc.enabled = true
  self.atc:PlayEnterAnimation(true)
end

function UIN22Intro:OnHide()
end

function UIN22Intro:BtnCloseOnClick(go)
  self:CloseDialog()
end
