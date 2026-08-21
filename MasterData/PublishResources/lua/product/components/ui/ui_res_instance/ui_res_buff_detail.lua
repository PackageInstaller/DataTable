_class("UIResBuffDetail", UICustomWidget)

function UIResBuffDetail:OnShow()
  self._name = self:GetUIComponent("UILocalizationText", "Name")
  self._des = self:GetUIComponent("UILocalizationText", "Des")
  self._maskGo = self:GetGameObject("Mask")
  self._bg = self:GetGameObject("bg")
  self._maskGo:SetActive(false)
end

function UIResBuffDetail:SetData(buffData, rootWorldPos, offset)
  self._maskGo:SetActive(true)
  self._bg.transform.position = rootWorldPos
  self._bg.transform.localPosition = self._bg.transform.localPosition + offset
  self._name.text = buffData.name
  self._des.text = buffData.des
end

function UIResBuffDetail:MaskOnClick(go)
  self._maskGo:SetActive(false)
end
