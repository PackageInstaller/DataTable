_class("UIPetChainSkillItem", UICustomWidget)
UIPetChainSkillItem = UIPetChainSkillItem

function UIPetChainSkillItem:OnShow()
  self._txtId = self:GetUIComponent("UILocalizationText", "txtId")
  self._imgSelect = self:GetUIComponent("Image", "imgSelect")
  self._imgSelect.gameObject:SetActive(false)
  self._skill = nil
end

function UIPetChainSkillItem:Flush(v)
  self._skill = v
  self._txtId.text = v.chainCount
end

function UIPetChainSkillItem:FlushSelect(id, len)
  self._imgSelect.gameObject:SetActive(1 < len and id == self._skill.id)
end
