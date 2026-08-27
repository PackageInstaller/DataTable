local bs_20013 = class("bs_20013", LuaSkillBase)
local base = LuaSkillBase
bs_20013.config = {buffId = 1111}

function bs_20013:ctor()
end

function bs_20013:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.HurtResultStart, "bs_20013_14", 1, self.OnHurtResultStart)
  self:AddTrigger(eSkillTriggerType.HurtResultEnd, "bs_20013_15", 1, self.OnHurtResultEnd)
end

function bs_20013:OnHurtResultStart(skill, context)
  if context.target.hp * 1000 // context.target.maxHp < self.arglist[1] and context.target.intensity > 0 then
    LuaSkillCtrl:CallBuff(self, context.target, self.config.buffId, 1, nil, true)
  end
end

function bs_20013:OnHurtResultEnd(skill, targetRole, hurtValue)
  LuaSkillCtrl:DispelBuff(targetRole, self.config.buffId, 0, true)
end

function bs_20013:OnCast4rDie()
  base.OnCasterDie(self)
end

return bs_20013
