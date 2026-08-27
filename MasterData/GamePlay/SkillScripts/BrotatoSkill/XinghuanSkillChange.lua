local XinghuanSkillChange = {}
XinghuanSkillChange.config = {}

function XinghuanSkillChange:OnAttackTrigger2(target, ex_damage)
  LuaSkillCtrl:StartShowSkillDurationTime(self, self.loopTime2)
  self.atk = LuaSkillCtrl:StartTimer(self, 3, function()
    local targets = LuaSkillCtrl:CallTargetSelect(self, 42, 10)
    for i = 0, targets.Count - 1 do
      local role = targets[i].targetRole
      if not LuaSkillCtrl:IsObstacle(role) then
        target = role
        break
      end
    end
    if target == nil then
      LuaSkillCtrl:CallBreakAllSkill(self.caster)
    end
    LuaSkillCtrl:CallEffectWithArgOverride(target, self.config.effect_trail_2, self, self.caster, nil, nil, self.SkillEventFunc_2, ex_damage)
  end, nil, self.arglist[4] - 1, 3)
end

return XinghuanSkillChange
