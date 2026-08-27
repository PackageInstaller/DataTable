local bs_15341 = class("bs_15341", LuaSkillBase)
local base = LuaSkillBase
bs_15341.config = {
  buffId_miniFire = 110150,
  effectId = 12092,
  aoe_config = {
    effect_shape = 3,
    aoe_select_code = 5,
    aoe_range = 1
  },
  newBuffId_miniFire = 110152
}

function bs_15341:ctor()
end

function bs_15341:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_15341_3", 1, self.OnAfterHurt, self.caster, nil, nil, nil, nil, nil, nil, eSkillTag.commonAttack, false)
end

function bs_15341:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and not isMiss and skill.isCommonAttack and not isTriggerSet and hurtType ~= eHurtType.RealDmg and LuaSkillCtrl:CallRange(1, 1000) <= self.arglist[1] and (target:GetBuffTier(self.config.buffId_miniFire) > 0 or 0 < target:GetBuffTier(self.config.newBuffId_miniFire)) then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target, self.config.aoe_config)
    local damage = 0
    if self.caster.recordTable.miniFireBuff == nil then
      damage = self.arglist[2] * target:GetBuffTier(self.config.buffId_miniFire)
    else
      damage = self.arglist[2] * target:GetBuffTier(self.config.newBuffId_miniFire)
    end
    if 0 < skillResult.roleList.Count then
      for i = 0, skillResult.roleList.Count - 1 do
        local targetRole = skillResult.roleList[i]
        local skillResult1 = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
        LuaSkillCtrl:HurtResultWithConfig(self, skillResult1, 38, {damage}, true)
        skillResult1:EndResult()
      end
    end
    skillResult:EndResult()
    LuaSkillCtrl:CallEffect(target, self.config.effectId, self)
  end
end

function bs_15341:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15341
