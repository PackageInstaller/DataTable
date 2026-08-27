local bs_1016 = class("bs_1016", LuaSkillBase)
local base = LuaSkillBase
bs_1016.config = {
  heal_config = {baseheal_formula = 3022}
}

function bs_1016:ctor()
end

function bs_1016:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetDeadHurtTrigger("bs_1016", 99, self.OnSetDeadHurt, nil, self.caster)
end

function bs_1016:OnSetDeadHurt(context)
  if context.target == self.caster and context.target:GetBuffTier(self.config.nanaka_buffId) <= 0 then
    local target
    local targets = LuaSkillCtrl:CallTargetSelect(self, 2, 10)
    for i = targets.Count - 1, 0, -1 do
      local role = targets[i].targetRole
      if LuaSkillCtrl:IsObstacle(role) then
        targets:RemoveAt(i)
      end
    end
    if 0 < targets.Count then
      for i = 0, targets.Count - 1 do
        local role = targets[i].targetRole
        if role ~= nil and 0 < role.hp then
          local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
          LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, {
            self.arglist[1]
          }, true)
          skillResult:EndResult()
        end
      end
    end
  end
end

function bs_1016:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_1016
