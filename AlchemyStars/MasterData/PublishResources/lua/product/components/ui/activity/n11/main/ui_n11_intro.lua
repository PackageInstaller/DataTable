_class("UIN11Intro", UIController)
UIN11Intro = UIN11Intro

function UIN11Intro:OnShow(uiParams)
  self.atc = self:GetGameObject():GetComponent(typeof(ATransitionComponent))
  self.atc.enabled = true
  self.atc:PlayEnterAnimation(true)
end

function UIN11Intro:OnHide()
end

function UIN11Intro:btnCloseOnClick(go)
  self:CloseDialog()
end
