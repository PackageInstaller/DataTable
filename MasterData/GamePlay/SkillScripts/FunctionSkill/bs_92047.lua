local bs_92047 = class("bs_92047", LuaSkillBase)
local base = LuaSkillBase
bs_92047.config = {
  effectId = 10987,
  heal_config = {
    baseheal_formula = 10087,
    correct_formula = 9990,
    heal_number = 0
  }
}

function bs_92047:ctor()
end

function bs_92047:InitSkill(isMidwaySkill)
  self:AddAfterHurtTrigger("bs_92047_10", 1, self.OnAfterHurt, nil, nil, nil, nil, nil, nil, nil)
  self.heal_config = {}
end

function bs_92047:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target.belongNum == self.caster.belongNum and self:IsReadyToTake() and not isTriggerSet then
    self:PlayChipEffect()
    self:OnSkillTake()
    local hurtheal = hurt * self.arglist[1] // 1000
    local targetList = LuaSkillCtrl:FindAllRolesWithinRange(target, 1, false)
    LuaSkillCtrl:CallEffect(target, self.config.effectId, self)
    for i = 0, targetList.Count - 1 do
      local role = targetList[i]
      if role.belongNum == self.caster.belongNum then
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
        LuaSkillCtrl:HealResultWithConfig(self, skillResult, 6, {hurtheal}, true, true)
      end
    end
  end
end

function bs_92047:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_92047
