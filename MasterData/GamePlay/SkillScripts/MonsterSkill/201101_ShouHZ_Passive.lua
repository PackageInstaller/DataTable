local bs_40027 = class("bs_40027", LuaSkillBase)
local base = LuaSkillBase
bs_40027.config = {buffId_1035 = 1035}

function bs_40027:ctor()
end

function bs_40027:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_40027_3", 10, self.OnAfterHurt, nil, self.caster)
  self:AddAfterHealTrigger("bs_40027_4", 10, self.OnAfterHeal, nil, self.caster)
end

function bs_40027:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target == self.caster and target.hp < target.maxHp * self.arglist[1] // 1000 and target:GetBuffTier(self.config.buffId_1035) == 0 then
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId_1035, 1, nil, true)
  end
end

function bs_40027:OnAfterHeal(sender, target, skill, heal)
  if target == self.caster and target.hp > target.maxHp * self.arglist[1] // 1000 and target:GetBuffTier(self.config.buffId_1035) == 1 then
    LuaSkillCtrl:DispelBuff(target, self.config.buffId_1035, 1, true)
  end
end

function bs_40027:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_40027
