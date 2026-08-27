local bs_10262 = class("bs_10262", LuaSkillBase)
local base = LuaSkillBase
bs_10262.config = {buffId = 1177, buffTier = 1}

function bs_10262:ctor()
end

function bs_10262:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.HurtResultStart, "bs_10262_14", 1, self.OnHurtResultStart)
end

function bs_10262:OnHurtResultStart(skill, context)
  if context.target.hp * 1000 // context.target.maxHp <= self.arglist[1] then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier, nil, true)
  elseif context.target.hp * 1000 // context.target.maxHp > self.arglist[1] then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0)
  end
end

function bs_10262:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10262
