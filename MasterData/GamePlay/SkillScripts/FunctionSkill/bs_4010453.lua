local bs_4010453 = class("bs_4010453", LuaSkillBase)
local base = LuaSkillBase
bs_4010453.config = {buffId = 1097}

function bs_4010453:ctor()
end

function bs_4010453:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.HurtResultStart, "bs_4010453_14", 1, self.OnHurtResultStart)
  self:AddSelfTrigger(eSkillTriggerType.HurtResultEnd, "bs_4010453_15", 1, self.OnHurtResultEnd)
end

function bs_4010453:OnHurtResultStart(skill, context)
  if context.sender == self.caster and context.target.intensity >= 2 then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
  end
end

function bs_4010453:OnHurtResultEnd(skill, targetRole, hurtValue)
  if targetRole == self.caster then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0, true)
  end
end

function bs_4010453:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4010453
