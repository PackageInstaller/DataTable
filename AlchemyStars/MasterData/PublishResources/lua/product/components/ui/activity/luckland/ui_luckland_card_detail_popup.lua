_class("UILuckLandCardDetailPopUp", UIController)
UILuckLandCardDetailPopUp = UILuckLandCardDetailPopUp

function UILuckLandCardDetailPopUp:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UILuckLandCardDetailPopUp:OnShow(uiParams)
  self:InitWidget()
  self.cardData = uiParams[1]
  self:RefreshCardDetail()
end

function UILuckLandCardDetailPopUp:InitWidget()
  self._animObj = self:GetGameObject("_anim")
  self.characterNameText = self:GetUIComponent("UILocalizationText", "CharacterNameText")
  self.skillTipsText = self:GetUIComponent("UILocalizationText", "SkillTipsText")
  self._anim = self:GetUIComponent("Animation", "_anim")
end

function UILuckLandCardDetailPopUp:RefreshCardDetail()
  self.CardAreaList = UIWidgetHelper.SpawnObjects(self, "Card", "UILuckLandSingleCard", 1)
  for i = 1, #self.CardAreaList do
    local item = self.CardAreaList[i]
    item:SetData(self.cardData)
  end
  self.characterNameText:SetText(StringTable.Get(self.cardData:Cfg().CardName))
  self.skillTipsText:SetText(StringTable.Get(self.cardData:Cfg().CardTips))
  local cardStarCount = self.cardData:Cfg().CardStar
  self.CardAreaList = UIWidgetHelper.SpawnObjects(self, "Star", "UILuckLandStarItem", cardStarCount)
end

function UILuckLandCardDetailPopUp:BgOnClick(go)
  self._anim:Play("uieff_UILuckLandCardDetailPopUp_out")
  GameGlobal.Timer():AddEvent(300, function()
    self:CloseDialog()
  end)
end
