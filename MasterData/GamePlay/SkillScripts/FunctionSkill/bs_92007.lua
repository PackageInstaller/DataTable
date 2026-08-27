local bs_92007 = class("bs_92007", LuaSkillBase)
local base = LuaSkillBase
bs_92007.config = {buffId = 2012}

function bs_92007:ctor()
end

function bs_92007:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddHurtResultStartTrigger("bs_92007_1", 1, self.OnHurtResultStart, nil, self.caster)
end

function bs_92007:OnHurtResultStart(skill, context)
  local shieldValue = LuaSkillCtrl:GetRoleAllShield(self.caster)
  if shieldValue > self.caster.maxHp * self.arglist[2] // 1000 then
    shieldValue = self.caster.maxHp * self.arglist[2] // 1000
  end
  local buffTier = self.arglist[1] * shieldValue // (self.caster.maxHp * self.arglist[2] // 1000)
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, buffTier, nil, true)
end

function bs_92007:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_92007
