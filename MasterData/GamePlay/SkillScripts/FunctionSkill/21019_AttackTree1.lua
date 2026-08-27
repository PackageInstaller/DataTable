local bs_21019 = class("bs_21019", LuaSkillBase)
local base = LuaSkillBase
bs_21019.config = {buffId = 110037}

function bs_21019:ctor()
end

function bs_21019:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.HurtResultStart, "bs_21019_3", 1, self.OnHurtResultStart)
  self:AddSetHurtTrigger("bs_21019_2", 1, self.OnSetHurt, self.caster)
end

function bs_21019:OnHurtResultStart(skill, context)
  if context.sender == self.caster and context.target.hp * 1000 // context.target.maxHp >= self.arglist[1] then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
  end
end

function bs_21019:OnSetHurt(context)
  if context.sender == self.caster then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0)
  end
end

function bs_21019:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_21019
