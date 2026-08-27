local UINBaseSkillItem = class("UINBaseSkillItem", UIBaseNode)
local base = UIBaseNode
local HeroSkillUpgradeEnum = require("Game.Hero.NewUI.UpgradeSkill.HeroSkillUpgradeEnum")

function UINBaseSkillItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINBaseSkillItem:InitBaseSkillItem(skillData, resloader)
  self.resloader = resloader
  self:RefreshBaseSkillItem(skillData)
end

function UINBaseSkillItem:RefreshBaseSkillItem(skillData)
  self.skillData = skillData
  self:__RefreshIsUnlock()
end

function UINBaseSkillItem:GetSkillData()
  return self.skillData
end

function UINBaseSkillItem:GetSkillUnlockState()
  return self.unlock
end

function UINBaseSkillItem:__RefreshIsUnlock()
  if self.skillData == nil then
    return
  end
  self.unlock = self.skillData:GetIsUnlock()
  self:__SetUnlockUI(self.unlock)
end

function UINBaseSkillItem:__SetUnlockUI(active)
  self.ui.lock:SetActive(not active)
  self.ui.unlock:SetActive(active)
  self.ui.img_icon.sprite = CRH:GetSprite(self.skillData:GetIcon(), CommonAtlasType.SkillIcon)
  local skillTag = self.skillData:GetSkillTag()
  self.ui.img_type:SetIndex(skillTag)
  self.ui.img_typeLine:SetIndex(skillTag)
  self.ui.img_type.image.color = eBattleSkillTypeColor[self.skillData:GetBattleSkillTypeColor()]
  if self.ui.Img_SpecWeaponLine ~= nil then
    local skillSourceType = self.skillData:GetSkillAdaptationSource()
    local isShowSpecWeaponLine = skillSourceType == HeroSkillUpgradeEnum.SkillAdaptation.SpecWeapon or skillSourceType == HeroSkillUpgradeEnum.SkillAdaptation.Entropization
    self.ui.Img_SpecWeaponLine.gameObject:SetActive(isShowSpecWeaponLine)
    if isShowSpecWeaponLine and self.ui.Img_SpecWeaponLine.color ~= nil then
      self.ui.Img_SpecWeaponLine.color = HeroSkillUpgradeEnum.SkillColor[skillSourceType]
    end
  end
end

function UINBaseSkillItem:SetBanSkillActive(active)
  self.ui.obj_ban:SetActive(active)
end

function UINBaseSkillItem:OnDelete()
  base.OnDelete(self)
end

return UINBaseSkillItem
