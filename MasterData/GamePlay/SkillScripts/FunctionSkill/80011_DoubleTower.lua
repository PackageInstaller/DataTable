local bs_80011 = class("bs_80011", LuaSkillBase)
local base = LuaSkillBase
bs_80011.config = {
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 10187,
    crit_formula = 0
  }
}

function bs_80011:ctor()
end

function bs_80011:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHealTrigger("bs_80011_1", 1, self.OnSetHeal, self.caster)
  self:AddAfterHurtTrigger("bs_80011_2", 1, self.OnAfterHurt, nil, nil, eBattleRoleBelong.player, nil, nil, nil, nil, eSkillTag.commonAttack)
end

function bs_80011:OnSetHeal(context)
  if context.sender == self.caster and self:IsReadyToTake() and not context.isTriggerSet and context.target.roleType == eBattleRoleType.character and context.target.belongNum == self.caster.belongNum and context.target.maxHp - context.target.hp < context.heal then
    self:OnSkillTake()
    local exHeal = (context.heal - context.target.maxHp + context.target.hp) * self.arglist[1] // 1000
    if exHeal <= 0 then
      exHeal = context.heal
    end
    local sheildValue = exHeal
    LuaSkillCtrl:AddRoleShield(context.target, eShieldType.Normal, sheildValue)
  end
end

function bs_80011:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if skill.isCommonAttack and not isMiss and not isTriggerSet then
    local sheidValue = LuaSkillCtrl:GetRoleAllShield(sender) * self.arglist[2] // 1000
    if 0 < sheidValue then
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {sheidValue}, true)
      skillResult:EndResult()
    end
  end
end

function bs_80011:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_80011
