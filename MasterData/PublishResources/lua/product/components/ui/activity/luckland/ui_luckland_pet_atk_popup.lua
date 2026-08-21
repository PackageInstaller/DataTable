_class("UILuckLandPetAtkPopUp", UIController)
UILuckLandPetAtkPopUp = UILuckLandPetAtkPopUp

function UILuckLandPetAtkPopUp:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UILuckLandPetAtkPopUp:OnShow(uiParams)
  self.speed = uiParams[1]
  self:InitWidget()
  self:AttachEvent(GameEventType.LuckLandResColl, self._ResColl)
end

function UILuckLandPetAtkPopUp:InitWidget()
  self._anim = self:GetUIComponent("Animator", "_anim")
  self.resText = self:GetUIComponent("UILocalizationText", "ResText")
  self.resText:SetText("0")
  self._anim:Play("uieff_UILuckLandResCalcuPopUp_in", 1)
  self._anim.speed = self.speed
end

function UILuckLandPetAtkPopUp:_ResColl(value)
  self.resText:SetText("" .. value)
end

function UILuckLandPetAtkPopUp:OnClose()
  self:DetachEvent(GameEventType.LuckLandResColl)
end

function UILuckLandPetAtkPopUp:BgOnClick(go)
end
