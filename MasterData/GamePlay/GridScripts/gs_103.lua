local gs_103 = class("gs_103", LuaGridBase)
gs_103.config = {
  healDuration = 75,
  heal_config = {
    baseheal_formula = 501,
    heal_number = 0,
    correct_formula = 9990
  },
  effectId = 10286,
  effectGridId = 10827,
  effectHitId = 10845
}

function gs_103:ctor()
end

function gs_103:OnGridBattleStart(role)
  if role == nil then
    self:GridLoseEffect()
    return
  end
  local arriveCallBack = BindCallback(self, self.OnArriveAction, role)
  LuaSkillCtrl:StartTimer(nil, self.config.healDuration, arriveCallBack, nil, -1)
end

function gs_103:OnArriveAction(role)
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 52, 20, role)
  if targetlist.Count < 1 then
    return
  end
  local sl = role.skill_intensity * 50 // 100
  if role.career == 5 then
    sl = sl * 130 // 100
  end
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetlist[0].targetRole)
  LuaSkillCtrl:CallEffect(targetlist[0].targetRole, self.config.effectId, self)
  LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, {sl}, true, true)
  LuaSkillCtrl:CallEffect(role, self.config.effectGridId, self)
  LuaSkillCtrl:CallEffect(targetlist[0].targetRole, self.config.effectHitId, self)
  skillResult:EndResult()
end

function gs_103:OnGridEnterRole(role)
end

function gs_103:OnGridExitRole(role)
end

function gs_103:OnGridRoleDead(role)
end

return gs_103
