local bs_10028 = class("bs_10028", LuaSkillBase)
local base = LuaSkillBase
bs_10028.config = {buffId = 76, effectId = 1002}

function bs_10028:ctor()
end

function bs_10028:InitSkill(isMidwaySkill)
  self:AddSetHurtTrigger("bs_10028_2", 1, self.OnSetHurt, nil, self.caster)
  self:AddAfterHurtTrigger("bs_10028_3", 1, self.OnAfterHurt, nil, self.caster)
  self.hurtBack = 0
end

function bs_10028:OnSetHurt(context)
  if context.target == self.caster and self.caster:GetBuffTier(self.config.buffId) > 0 then
    self.hurtBack = context.hurt * self.arglist[2] // 1000
  end
end

function bs_10028:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target == self.caster and self.caster:GetBuffTier(self.config.buffId) > 0 and 0 < self.hurtBack then
    self:PlayChipEffect()
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
    if targetList.Count < 1 then
      return
    end
    for i = 0, targetList.Count - 1 do
      local targetRole = targetList[i].targetRole
      LuaSkillCtrl:CallEffect(targetRole, self.config.effectId, self)
      LuaSkillCtrl:RemoveLife(self.hurtBack, self, targetRole)
    end
    self.hurtBack = 0
  end
end

function bs_10028:PlaySkill()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, self.arglist[1])
end

function bs_10028:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10028
