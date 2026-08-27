local gs_108 = class("gs_108", LuaGridBase)
gs_108.config = {
  damageDuration = 75,
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 502,
    crit_formula = 0
  },
  effectId = 10335,
  effectGridId = 10823,
  effectHitId = 10844,
  effectAtkId = 10254
}

function gs_108:ctor()
end

function gs_108:OnGridBattleStart(role)
  if role == nil then
    self:GridLoseEffect()
    return
  end
  local arriveCallBack = BindCallback(self, self.OnArriveAction, role)
  LuaSkillCtrl:StartTimer(nil, self.config.damageDuration, arriveCallBack, nil, -1)
end

function gs_108:OnArriveAction(role)
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 7, 20, role)
  if targetlist.Count < 1 then
    return
  end
  local sl = role.skill_intensity * 50 // 100
  if role.career == 4 then
    sl = sl * 130 // 100
  end
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetlist[0].targetRole)
  LuaSkillCtrl:CallEffect(targetlist[0].targetRole, self.config.effectId, self)
  LuaSkillCtrl:CallEffect(role, self.config.effectGridId, self)
  LuaSkillCtrl:CallEffect(targetlist[0].targetRole, self.config.effectHitId, self)
  LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {sl}, true, false)
  skillResult:EndResult()
end

function gs_108:OnGridEnterRole(role)
end

function gs_108:OnGridExitRole(role)
end

function gs_108:OnGridRoleDead(role)
end

return gs_108
