local bs_7003 = class("bs_7003", LuaSkillBase)
local base = LuaSkillBase
bs_7003.config = {
  buffIdShield = 1148,
  effectId_hit = 10406,
  buffSilence = 1159
}

function bs_7003:ctor()
end

function bs_7003:InitSkill(isMidwaySkill)
  self:AddSetHurtTrigger("bs_7003_2", 1, self.OnSetHurt, nil, self.caster)
  local Value = self.caster.maxHp * self.arglist[1] // 1000
  LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.Beelneith, Value)
  self:AddTrigger(eSkillTriggerType.OnBreakShield, "bs_7003_22", 1, self.OnBreakShield)
end

function bs_7003:OnSetHurt(context)
  if context.target == self.caster and context.skill.dataId ~= 202003 and context.isTriggerSet ~= true and (LuaSkillCtrl:GetGridsDistance(context.sender.x, context.sender.y, self.caster.x, self.caster.y) > 1 or 1 < context.sender.attackRange or context.skill.dataId == 201903) then
    local hurt = context.hurt
    context.hurt = context.hurt * (1000 - self.arglist[2]) // 1000
    if self.caster.recordTable["20047_root2arg1"] ~= nil and 10 < hurt then
      LuaSkillCtrl:CallEffectWithArg(context.sender, self.config.effectId_hit, self, false, false, self.SkillEventFunc, context.sender, hurt)
    end
  end
end

function bs_7003:SkillEventFunc(sender, hurt, effect, eventId, target)
  if eventId == eBattleEffectEvent.Create then
    LuaSkillCtrl:RemoveLife(hurt * self.arglist[3] // 1000, self, sender, true, nil, true)
  end
end

function bs_7003:OnBreakShield(shieldType, sender, target)
  if target == self.caster and shieldType == eShieldType.Beelneith then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffSilence, 1, self.caster.recordTable.buffTime)
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffIdShield, 0)
  end
end

function bs_7003:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_7003
