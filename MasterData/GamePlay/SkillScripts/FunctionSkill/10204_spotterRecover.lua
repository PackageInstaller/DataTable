local bs_10204 = class("bs_10204", LuaSkillBase)
local base = LuaSkillBase
bs_10204.config = {
  heal_config = {baseheal_formula = 10037}
}

function bs_10204:ctor()
end

function bs_10204:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHealTrigger("bs_10204_5", 1, self.OnSetHeal, nil, self.caster)
end

function bs_10204:OnSetHeal(context)
  if context.target == self.caster and context.skill.dataId ~= self.cskill.dataId then
    local sheildNum = context.heal * self.arglist[1] // 1000
    if sheildNum <= 0 then
      return
    end
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 2, 10)
    if 1 > targetList.Count then
      return
    end
    for i = 0, targetList.Count - 1 do
      local targetRole = targetList[i].targetRole
      LuaSkillCtrl:AddRoleShield(targetRole, eShieldType.Normal, sheildNum)
    end
    self:PlayChipEffect()
  end
end

function bs_10204:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10204
