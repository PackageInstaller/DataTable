_class("UIN12BattleResultLeft", UICustomWidget)
UIN12BattleResultLeft = UIN12BattleResultLeft

function UIN12BattleResultLeft:OnShow(uiParams)
  self:_GetComponent()
end

function UIN12BattleResultLeft:_GetComponent()
  self._name = self:GetUIComponent("UILocalizationText", "Name")
end

function UIN12BattleResultLeft:SetData(str)
  self._name:SetText(StringTable.Get(str))
end
