_class("UIPetLeftSkillItem", UICustomWidget)
UIPetLeftSkillItem = UIPetLeftSkillItem

function UIPetLeftSkillItem:Constructor()
  self._skillInfo = nil
  self._index = 1
end

function UIPetLeftSkillItem:OnShow(uiParams)
  self._skillIconRawImageLoader = self:GetUIComponent("RawImageLoader", "skillIcon")
  self._skillName = self:GetUIComponent("UILocalizationText", "skillName")
end

function UIPetLeftSkillItem:SetData(skillInfo)
  self._skillInfo = skillInfo
  self:SetText()
end

function UIPetLeftSkillItem:SetText()
  local cfg
  cfg = BattleSkillCfg(self._skillInfo.skillList[1])
  if cfg then
    local skillTypeStr = ""
    if cfg.Type == PetSkillType.SkillType_ChainSkill then
      skillTypeStr = "str_pet_config_left_skill_chain"
    elseif cfg.Type == PetSkillType.SkillType_Active then
      skillTypeStr = "str_pet_config_left_skill_major"
    elseif cfg.Type == PetSkillType.SkillType_Passive then
      skillTypeStr = "str_pet_config_equip_short"
    end
    self._skillName:SetText(StringTable.Get(skillTypeStr))
    self._skillIconRawImageLoader:LoadImage(cfg.GoldIcon)
  end
end
