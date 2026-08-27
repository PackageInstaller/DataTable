local bs_6008 = class("bs_6008", LuaSkillBase)
local base = LuaSkillBase
bs_6008.config = {
  buffId1 = 128,
  buffId2 = 129,
  buffId3 = 197,
  heal_config = {baseheal_formula = 501}
}

function bs_6008:ctor()
end

function bs_6008:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterHurt, "bs_6008_3", 1, self.OnAfterHurt)
  self.caster.recordTable.pre_hp = 0
  self.caster.recordTable.pre_pow = 0
  self.caster.recordTable.pre_skill = 0
end

function bs_6008:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target.hp <= 0 and 0 < hurt and sender == self.caster and target.belongNum == 2 then
    local add_hp = self.arglist[1] * target.maxHp // 100
    local add_pow = self.arglist[2] * target.pow // 100
    local add_skill_intensity = self.arglist[2] * target.skill_intensity // 100
    local pre_hp = self.caster.recordTable.pre_hp
    local pre_pow = self.caster.recordTable.pre_pow
    local pre_skill = self.caster.recordTable.pre_skill
    if add_hp > pre_hp then
      self.caster:AddRoleProperty(eHeroAttr.maxHp, add_hp - pre_hp, eHeroAttrType.Extra)
      self.caster.recordTable.pre_hp = add_hp
    end
    if add_pow > pre_pow then
      self.caster:AddRoleProperty(eHeroAttr.pow, add_pow - pre_pow, eHeroAttrType.Extra)
      self.caster.recordTable.pre_pow = add_pow
    end
    if add_skill_intensity > pre_skill then
      self.caster:AddRoleProperty(eHeroAttr.skill_intensity, add_skill_intensity - pre_skill, eHeroAttrType.Extra)
      self.caster.recordTable.pre_skill = add_skill_intensity
    end
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster)
    LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, {add_hp})
    skillResult:EndResult()
  end
end

function bs_6008:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_6008
