local bs_80002 = class("bs_80002", LuaSkillBase)
local base = LuaSkillBase
bs_80002.config = {
  heal_config = {baseheal_formula = 10089},
  effectId = 1048,
  hurt_config = {basehurt_formula = 10087}
}

function bs_80002:ctor()
end

function bs_80002:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_80002_3", 1, self.OnAfterHurt)
  self.hurtTime = 0
end

function bs_80002:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target == self.caster and not isMiss and not isTriggerSet and skill.isCommonAttack then
    self.hurtTime = self.hurtTime + 1
    if self.hurtTime >= self.arglist[2] then
      self.hurtTime = 0
      local shieldValue = self.caster.skill_intensity * self.arglist[1] // 1000
      LuaSkillCtrl:AddRoleShield(target, eShieldType.Normal, shieldValue)
    end
  end
end

function bs_80002:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_80002
