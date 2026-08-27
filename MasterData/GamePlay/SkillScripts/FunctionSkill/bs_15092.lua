local bs_15092 = class("bs_15092", LuaSkillBase)
local base = LuaSkillBase
bs_15092.config = {heal_resultId = 4}

function bs_15092:ctor()
end

function bs_15092:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_15092_3", 1, self.OnAfterHurt, self.caster, nil, nil, nil, nil, nil, nil, eSkillTag.commonAttack)
end

function bs_15092:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and LuaSkillCtrl:RoleContainsBuffFeature(target, eBuffFeatureType.Stun) and target.belongNum == eBattleRoleBelong.enemy and not isMiss and not isTriggerSet and self:IsReadyToTake() then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, sender)
    LuaSkillCtrl:HealResultWithConfig(self, skillResult, self.config.heal_resultId, {
      self.arglist[1]
    })
    skillResult:EndResult()
  end
  self:OnSkillTake()
end

function bs_15092:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15092
