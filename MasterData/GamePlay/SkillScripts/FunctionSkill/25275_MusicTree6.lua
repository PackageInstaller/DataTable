local bs_25274 = class("bs_25274", LuaSkillBase)
local base = LuaSkillBase
bs_25274.config = {buffId = 2134}

function bs_25274:ctor()
end

function bs_25274:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.HurtResultStart, "bs_25274_3", 1, self.OnHurtResultStart)
  self:AddSetHurtTrigger("bs_25274_2", 1, self.OnSetHurt, self.caster)
end

function bs_25274:OnHurtResultStart(skill, context)
  if context.sender == self.caster and context.target.hp * 1000 // context.target.maxHp >= self.arglist[1] then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
  end
end

function bs_25274:OnSetHurt(context)
  if context.sender == self.caster then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0)
  end
end

function bs_25274:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_25274
