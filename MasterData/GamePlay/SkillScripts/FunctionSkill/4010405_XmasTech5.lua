local bs_4010405 = class("bs_4010405", LuaSkillBase)
local base = LuaSkillBase
bs_4010405.config = {}

function bs_4010405:ctor()
end

function bs_4010405:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_4010405_1", 1, self.OnAfterHurt, nil, self.caster)
  self.HpPercent = 1
end

function bs_4010405:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, isRealDmg, isTriggerSet)
  if target == self.caster and target.hp > 0 and target.hp * 1000 // target.maxHp < self.arglist[1] and self.HpPercent == 1 then
    self.HpPercent = 0
    local value = self.caster.maxHp * self.arglist[2] // 1000
    LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.Normal, value)
  end
end

function bs_4010405:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4010405
