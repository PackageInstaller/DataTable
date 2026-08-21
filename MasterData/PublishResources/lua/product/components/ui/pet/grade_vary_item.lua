_class("GradeVaryItem", UICustomWidget)

function GradeVaryItem:Constructor()
  self._consumItemInfo = nil
  self._itemIndex = nil
end

function GradeVaryItem:OnShow()
  self._stateIcon = self:GetUIComponent("Image", "stateIcon")
  self._varyName = self:GetUIComponent("UILocalizationText", "varyName")
  self._uiPetGradeDetail = self:GetAsset("UIPetGrade.spriteatlas", LoadType.SpriteAtlas)
end

function GradeVaryItem:OnHide()
  self:Release()
end

function GradeVaryItem:Release()
  self._consumItemInfo = nil
  self._stateIcon = nil
  self._varyName = nil
  self._uiPetGradeDetail = nil
end

function GradeVaryItem:SetData(varyInfo)
  local tag = varyInfo.type
  local skillName = ""
  if tag == "active" then
    skillName = "str_pet_config_skill_major"
  elseif tag == "extra" then
    skillName = "str_pet_config_skill_major"
  elseif tag == "passive" then
    skillName = "str_pet_config_common_equip_des"
  elseif tag == "chain" then
    skillName = "str_pet_config_common_chain_des"
  elseif tag == "work" then
    skillName = "str_pet_config_common_work_des"
  end
  local spriteName = ""
  if varyInfo.changeType == PetSkillChangeState.NewGain then
    spriteName = "spirit_suo1_icon"
  elseif varyInfo.changeType == PetSkillChangeState.Improved then
    spriteName = "spirit_jiantou1_icon"
  end
  self._stateIcon.sprite = self._uiPetGradeDetail:GetSprite(spriteName)
  self._varyName:SetText(StringTable.Get(skillName))
end
