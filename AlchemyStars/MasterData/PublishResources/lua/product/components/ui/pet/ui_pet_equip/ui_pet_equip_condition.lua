_class("UIPetEquipCondition", UICustomWidget)
UIPetEquipCondition = UIPetEquipCondition

function UIPetEquipCondition:OnShow(uiParams)
  self:InitWidget()
end

function UIPetEquipCondition:InitWidget()
  self.imgEnoughGo = self:GetGameObject("imgEnough")
  self.imgNoneEnoughGo = self:GetGameObject("imgNoneEnough")
  self.txtCondition = self:GetUIComponent("UILocalizationText", "txtCondition")
  self.txtValue = self:GetUIComponent("UILocalizationText", "txtValue")
end

function UIPetEquipCondition:SetData(isEnough, conditionStr, valueStr)
  self.imgEnoughGo:SetActive(isEnough)
  self.imgNoneEnoughGo:SetActive(not isEnough)
  if isEnough then
    self.txtCondition:SetText("<color=#1fecd6>" .. conditionStr .. "</color>")
    self.txtValue:SetText("<color=#1fecd6>" .. valueStr .. "</color>")
  else
    self.txtCondition:SetText(conditionStr)
    self.txtValue:SetText(valueStr)
  end
end
