_class("UIPetEquipRefineSkill", UICustomWidget)
UIPetEquipRefineSkill = UIPetEquipRefineSkill

function UIPetEquipRefineSkill:OnShow(uiParams)
  self:InitWidget()
end

function UIPetEquipRefineSkill:InitWidget()
  self.skillName = self:GetUIComponent("UILocalizationText", "skillName")
  self._skillDesc = self:GetUIComponent("UILocalizedTMP", "skillDesc")
  
  function self._skillDesc.onHrefClick(hrefName)
    GameGlobal.UIStateManager():ShowDialog("UISkillHrefInfo", hrefName)
  end
  
  self.skillIcon = self:GetUIComponent("RawImageLoader", "skillIcon")
end

function UIPetEquipRefineSkill:SetData(petTemplateId, petLv)
  local cfg = UIPetEquipHelper.GetRefineCfg(petTemplateId, petLv)
  if not cfg then
    return
  end
  local skillType = cfg.SkillType
  local skillTypeStrKey
  if skillType == PetSkillType.SkillType_ChainSkill then
    skillTypeStrKey = "str_pet_equip_skilltype_refine_2"
  elseif skillType == PetSkillType.SkillType_Active then
    skillTypeStrKey = "str_pet_equip_skilltype_refine_3"
  elseif skillType == PetSkillType.SkillType_Passive then
    skillTypeStrKey = "str_pet_equip_skilltype_refine_4"
  end
  self.skillIcon:LoadImage(cfg.SkillIcon)
  self._skillDesc:SetText(StringTable.Get(cfg.Desc))
  if skillTypeStrKey then
    local str = StringTable.Get(skillTypeStrKey, StringTable.Get(cfg.SkillName))
    self.skillName:SetText(str)
  else
    self.skillName:SetText(StringTable.Get(cfg.SkillName))
  end
end
