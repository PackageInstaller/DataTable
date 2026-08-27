local gs_104 = class("gs_104", LuaGridBase)
gs_104.config = {
  buffDuration = 75,
  hurt_config = {
    hit_formula = 0,
    def_formula = 0,
    basehurt_formula = 502,
    crit_formula = 0,
    hurt_type = eHurtType.RealDmg
  },
  effectGridId = 10828,
  effectId = 10790
}

function gs_104:ctor()
end

function gs_104:OnGridBattleStart(role)
  if role == nil then
    self:GridLoseEffect()
    return
  end
  local arriveCallBack = BindCallback(self, self.OnArriveAction, role)
  LuaSkillCtrl:StartTimer(nil, self.config.buffDuration, arriveCallBack, self, -1, self.config.buffDuration)
end

function gs_104:OnArriveAction(role)
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 5, 20)
  if targetlist.Count < 1 then
    return
  end
  local sl = role.skill_intensity * 1
  if role.career == 2 then
    sl = sl * 130 // 100
  end
  for i = 1, targetlist.Count - 1 do
    if targetlist[i].targetRole.y == role.y and targetlist[i].targetRole.belongNum ~= 1 and targetlist[i].targetRole.intensity ~= 0 then
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetlist[i].targetRole)
      LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {sl}, true, true)
      skillResult:EndResult()
    end
  end
  local gridTarget = LuaSkillCtrl:GetTargetWithGrid(0, role.y)
  if gridTarget ~= nil then
    LuaSkillCtrl:CallEffect(gridTarget, self.config.effectId, self)
  end
  LuaSkillCtrl:CallEffect(role, self.config.effectGridId, self)
end

function gs_104:OnGridEnterRole(role)
end

function gs_104:OnGridExitRole(role)
end

function gs_104:OnGridRoleDead(role)
end

return gs_104
