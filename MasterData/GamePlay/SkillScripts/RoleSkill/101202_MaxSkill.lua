local bs_101202 = class("bs_101202", LuaSkillBase)
local base = LuaSkillBase
bs_101202.config = {
  effectId_loop = 101207,
  effectId_line = 101208,
  effectId_weapon = 101210,
  effectId_start = 101206,
  effectId_swim = 101215,
  buffId_66 = 3006,
  actionId = 1002,
  action_speed = 1,
  skill_time = 25,
  start_time = 20,
  HurtConfig = {
    hit_formula = 0,
    basehurt_formula = 3010,
    crit_formula = 0,
    crithur_ratio = 0,
    returndamage_formula = 0
  }
}

function bs_101202:ctor()
end

function bs_101202:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_101202:PlaySkill(data)
  local grid = LuaSkillCtrl:CallFindGridMostRolesArounded(2)
  if grid == nil then
    LuaSkillCtrl:SetResetCdByReturnConfigOnce(self)
    return
  end
  local target = LuaSkillCtrl:GetTargetWithGrid(grid.x, grid.y)
  local targetlist = LuaSkillCtrl:FindRolesAroundGrid(grid, 2)
  if targetlist ~= nil and targetlist.Count == 1 and targetlist[0] then
    target = LuaSkillCtrl:GetTargetWithGrid(targetlist[0].x, targetlist[0].y)
  end
  if LuaSkillCtrl:GetCasterSkinId(self.caster) == 301204 then
    LuaSkillCtrl:CallEffect(target, self.config.effectId_swim, self)
  end
  self:CallCasterWait(self.config.skill_time)
  local triggerCallBack = BindCallback(self, self.OnActionCallBack, target, grid)
  self.caster:LookAtTarget(target)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.start_time, triggerCallBack)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_weapon, self)
  LuaSkillCtrl:StartTimer(self, 7, function()
    LuaSkillCtrl:CallEffect(target, self.config.effectId_start, self)
  end)
end

function bs_101202:OnActionCallBack(target, grid)
  local effectBall = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_loop, self)
  local ballSkillData = {
    effectBall = effectBall,
    lastTime = self.arglist[4],
    roleMarks = {},
    arivedRoles = {}
  }
  local target2 = LuaSkillCtrl:GetTargetWithGrid(grid.x, grid.y)
  local collisionTrigger = BindCallback(self, self.OnCollision, ballSkillData)
  local EmissionArrive = BindCallback(self, self.OnEmissionArrive)
  local RemoveArrive = BindCallback(self, self.OnRemoveArrive, ballSkillData)
  local skillEmission = LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, target2, 80, 1, eColliderInfluenceType.Enemy, collisionTrigger, nil, RemoveArrive, effectBall, true, false, EmissionArrive)
  if skillEmission == nil then
    return
  end
  self:RealPlaySkill(ballSkillData, skillEmission)
end

function bs_101202:RealPlaySkill(ballSkillData, skillEmission)
  local intervalTime = self.arglist[1]
  local timer
  timer = LuaSkillCtrl:StartTimer(nil, intervalTime, function()
    if skillEmission.collider == nil then
      self:KillEffectBall(ballSkillData.effectBall)
      timer:Stop()
      return
    end
    ballSkillData.lastTime = ballSkillData.lastTime - intervalTime
    if ballSkillData.lastTime < 0 then
      timer:Stop()
      self:PlaySkillEnd(ballSkillData, skillEmission)
      return
    end
    for i = 1, #ballSkillData.arivedRoles do
      local role = ballSkillData.arivedRoles[i]
      if 0 < role.hp then
        LuaSkillCtrl:CallEffectWithEmission(skillEmission, self.config.effectId_line, self, nil, role, nil, false)
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
        LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig, {
          self.arglist[2]
        })
        skillResult:EndResult()
        if LuaSkillCtrl:CallRange(1, 1000) <= self.arglist[5] then
          LuaSkillCtrl:CallBuff(self, role, self.config.buffId_66, 1, self.arglist[6])
        end
      end
    end
  end, nil, -1)
end

function bs_101202:PlaySkillEnd(ballSkillData, skillEmission)
  self:KillEffectBall(ballSkillData.effectBall)
  skillEmission:EndAndDisposeEmission()
  self:OnSkillDamageEnd()
end

function bs_101202:KillEffectBall(effectBall)
  if effectBall ~= nil then
    effectBall:Die()
    effectBall = nil
  end
end

function bs_101202:OnCollision(ballSkillData, collider, index, entity)
  if ballSkillData.roleMarks[entity] == nil then
    table.insert(ballSkillData.arivedRoles, entity)
    ballSkillData.roleMarks[entity] = true
  end
end

function bs_101202:OnRemoveArrive(ballSkillData, collider, entity)
  if ballSkillData.roleMarks[entity] then
    ballSkillData.roleMarks[entity] = nil
    table.removebyvalue(ballSkillData.arivedRoles, entity)
  end
end

function bs_101202:OnEmissionArrive(skillEmission)
  local target_new = LuaSkillCtrl:CallTargetSelect(self, 19, 10)
  if target_new.Count > 0 then
    local target_real = target_new[0].targetRole
    local EmissionArrive = BindCallback(self, self.OnEmissionArrive)
    LuaSkillCtrl:CallRestartEmit(self, skillEmission, 1, target_real, true, false, EmissionArrive)
  end
end

function bs_101202:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_101202
