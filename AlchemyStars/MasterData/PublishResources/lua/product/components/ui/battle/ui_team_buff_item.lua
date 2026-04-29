_class("UITeamBuffItem", UICustomWidget)
UITeamBuffItem = UITeamBuffItem

function UITeamBuffItem:Constructor()
end

function UITeamBuffItem:OnShow(uiParams)
  self._buffIconLoader = self:GetUIComponent("RawImageLoader", "TeamBuffStateIcon")
  self._buffIconGo = self:GetGameObject("TeamBuffStateIcon")
  self._teamBuffRoundText = self:GetUIComponent("UILocalizationText", "TeamBuffRoundText")
  self._txtDesc = self:GetUIComponent("UILocalizationText", "txtDesc")
end

function UITeamBuffItem:OnHide()
end

function UITeamBuffItem:Dispose()
end

function UITeamBuffItem:SetData(BuffViewInstance)
  self._buffViewInstance = BuffViewInstance
  local buffEffectType = self._buffViewInstance:GetBuffEffectType()
  local iconRes = self._buffViewInstance:GetBuffIcon()
  if not iconRes then
    self._buffIconGo:SetActive(false)
  else
    self._buffIconGo:SetActive(true)
    self._buffIconLoader:LoadImage(self._buffViewInstance:GetBuffIcon())
  end
  self._teamBuffRoundText.text = self._buffViewInstance:GetRoundCountOrLayerText()
  self._txtDesc.text = StringTable.Get(self._buffViewInstance:GetBuffDesc(), self._buffViewInstance:GetShowBuffDescParams())
end
