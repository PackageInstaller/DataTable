local bs_15067 = class("bs_15067", LuaSkillBase)
local base = LuaSkillBase
bs_15067.config = {buffId = 1258, configId1 = 26}

function bs_15067:ctor()
end

function bs_15067:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHealTrigger("bs_15067_1", 1, self.OnSetHeal, self.caster, nil, nil, self.caster.belongNum, nil, eBattleRoleType.character)
end

function bs_15067:OnSetHeal(context)
  if context.sender == self.caster and self:IsReadyToTake() and not context.isTriggerSet and context.target.roleType == eBattleRoleType.character and context.target.belongNum == self.caster.belongNum and context.target.maxHp - context.target.hp < context.heal then
    self:OnSkillTake()
    local exHeal = (context.heal - context.target.maxHp + context.target.hp) * self.arglist[1] // 1000
    if exHeal <= 0 then
      exHeal = context.heal
    end
    local damageValue = exHeal
    if 0 < damageValue then
      local targetlist2 = LuaSkillCtrl:CallTargetSelect(self, 7, 10)
      if 0 < targetlist2.Count then
        local target = targetlist2[0].targetRole
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
        LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.configId1, {damageValue}, true)
        skillResult:EndResult()
      end
    end
  end
end

function bs_15067:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15067
