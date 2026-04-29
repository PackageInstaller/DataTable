_class("UILuckLandResCalcuPopUp", UIController)
UILuckLandResCalcuPopUp = UILuckLandResCalcuPopUp

function UILuckLandResCalcuPopUp:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UILuckLandResCalcuPopUp:OnShow(uiParams)
  self.speed = uiParams[1]
  self:InitWidget()
  self:AttachEvent(GameEventType.LuckLandResColl, self._ResColl)
end

function UILuckLandResCalcuPopUp:InitWidget()
  self._anim = self:GetUIComponent("Animator", "_anim")
  self.resText = self:GetUIComponent("UILocalizationText", "ResText")
  self.resText:SetText("0")
  self._anim:Play("uieff_UILuckLandResCalcuPopUp_in", 1)
  self._anim.speed = self.speed
end

function UILuckLandResCalcuPopUp:_ResColl(value)
  self.resText:SetText("" .. value)
end

function UILuckLandResCalcuPopUp:OnClose()
  self:DetachEvent(GameEventType.LuckLandResColl)
end

function UILuckLandResCalcuPopUp:BgOnClick(go)
end
