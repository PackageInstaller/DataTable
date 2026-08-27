local bs_21014 = class("bs_21014", LuaSkillBase)
local base = LuaSkillBase
bs_21014.config = {buffId = 110023}

function bs_21014:ctor()
end

function bs_21014:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_21014_1", 1, self.OnAfterBattleStart)
end

function bs_21014:OnAfterBattleStart()
  if self.caster.intensity >= 2 and not LuaSkillCtrl:IsObstacle(self.caster) then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1)
  end
end

function bs_21014:OnSetHurt(context)
  if context.target == self.caster and context.sender.intensity >= 2 then
    LuaSkillCtrl:CallBuff(self, context.sender, self.config.buffId, 1, nil, true)
  end
end

function bs_21014:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target == self.caster then
    LuaSkillCtrl:DispelBuff(sender, self.config.buffId, 0)
  end
end

function bs_21014:OnHurtResultStart(skill, context)
  if context.sender == self.caster and context.target.intensity >= 2 then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
  end
end

function bs_21014:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_21014
