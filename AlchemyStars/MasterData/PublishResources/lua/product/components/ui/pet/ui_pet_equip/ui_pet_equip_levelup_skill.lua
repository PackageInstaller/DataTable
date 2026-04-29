_class("UIPetEquipLevelupSkill", UICustomWidget)
UIPetEquipLevelupSkill = UIPetEquipLevelupSkill

function UIPetEquipLevelupSkill:OnShow(uiParams)
  self:InitWidget()
end

function UIPetEquipLevelupSkill:InitWidget()
  self.skillName = self:GetUIComponent("UILocalizationText", "skillName")
  self._skillDesc = self:GetUIComponent("UILocalizedTMP", "skillDesc")
  
  function self._skillDesc.onHrefClick(hrefName)
    GameGlobal.UIStateManager():ShowDialog("UISkillHrefInfo", hrefName)
  end
  
  self.skillIcon = self:GetUIComponent("RawImageLoader", "skillIcon")
end

function UIPetEquipLevelupSkill:SetData(skillIcon, skillDesc)
  self.skillIcon:LoadImage(skillIcon)
  self._skillDesc:SetText(skillDesc)
end
