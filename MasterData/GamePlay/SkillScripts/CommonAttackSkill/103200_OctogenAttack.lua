local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_103200 = class("bs_103200", bs_1)
local base = bs_1
bs_103200.config = {
  effectId_trail = 103201,
  action1 = 1001,
  action2 = 1001,
  baseActionSpd = 1,
  skill_time = 46,
  start_time = 9,
  action_pass = 1004,
  effectId_ex = 103204,
  effectId_X = 103203,
  effectId_hit = 103207,
  HurtConfig = {
    hit_formula = 0,
    basehurt_formula = 10086,
    crit_formula = 0,
    crithur_ratio = 0
  },
  audioId1 = 103201,
  time1 = 0,
  audioId2 = 103202,
  time2 = 0,
  audioId5 = 103203,
  audioId_pass = 103204
}
bs_103200.config = setmetatable(bs_103200.config, {
  __index = base.config
})

function bs_103200:ctor()
end

function bs_103200:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_103200:RealPlaySkill(target, data)
  if self.caster.recordTable.passive == true then
    local atkSpeed = LuaSkillCtrl:CallFormulaNumber(9997, self.caster, self.caster)
    local atkSpeedRatio = 1
    local atkActionId = data.action_pass
    local atkTriggerFrame = 0
    atkSpeedRatio = self:CalcAtkActionSpeedForAirplane(atkSpeed, 2) * self.config.baseActionSpd
    atkActionId = data.action_pass
    atkTriggerFrame = self:GetAtkTriggerFrameForAirplane(2, atkSpeed)
    local attackTrigger2 = BindCallback(self, self.OnAttackTrigger2, target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
    self:CallCasterWait(atkSpeed + 2)
    self.caster.recordTable.lastAttackRole = target
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.action_pass, atkSpeedRatio, atkTriggerFrame, attackTrigger2)
    self.caster.recordTable.passive = false
  else
    base.RealPlaySkill(self, target, data)
  end
end

function bs_103200:CalcAtkActionSpeedForAirplane(atkInterval, atkId)
  local atkTotalFrames = self.config.skill_time
  if atkInterval < atkTotalFrames then
    return atkTotalFrames / atkInterval
  else
    return 1
  end
end

function bs_103200:GetAtkTriggerFrameForAirplane(atkId, atkInterval)
  local atkTotalFrames = self.config.skill_time
  local triggerFrameCfg = self.config.start_time
  if atkInterval < atkTotalFrames then
    return triggerFrameCfg * atkInterval // atkTotalFrames
  else
    return triggerFrameCfg
  end
end

function bs_103200:OnAttackTrigger2(target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
  LuaSkillCtrl:CallEffect(target, self.config.effectId_ex, self, self.SkillEventFunc2)
end

function bs_103200:SkillEventFunc2(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:PlayAuSource(target.targetRole, self.config.audioId_pass)
    LuaSkillCtrl:CallEffect(target.targetRole, self.config.effectId_hit, self)
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:PlayAuHit(self, target)
    LuaSkillCtrl:HurtResult(self, skillResult)
    skillResult:EndResult()
    local _Cskill = self.caster.recordTable.cs_Passive
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffectWithCSkill(_Cskill, target)
    LuaSkillCtrl:PlayAuHit(self, target)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig, {
      self.caster.recordTable.pass_arg
    })
    skillResult:EndResult()
    local grid_role = LuaSkillCtrl:GetGridWithRole(target.targetRole)
    local curGridTarget = LuaSkillCtrl:GetTargetWithGrid(grid_role.x, grid_role.y)
    local grid_X_list = LuaSkillCtrl:CallFindXLineGrid(grid_role, 1)
    if grid_X_list.Count > 0 then
      for i = 0, grid_X_list.Count - 1 do
        local target_grid = LuaSkillCtrl:GetTargetWithGrid(grid_X_list[i].x, grid_X_list[i].y)
        if target_grid ~= nil then
          local cusEffect = LuaSkillCtrl:CallEffect(curGridTarget, self.config.effectId_X, self)
          local collisionTrigger = BindCallback(self, self.OnCollision, target)
          self.skillEmission = LuaSkillCtrl:CallCircledEmissionStraightlyWithBornTarget(self, self.caster, target_grid, 15, 5, eColliderInfluenceType.Enemy, collisionTrigger, nil, nil, cusEffect, true, true, nil, nil, curGridTarget)
        end
      end
    end
  end
end

function bs_103200:OnCollision(target, collider, index, entity)
  if entity ~= target.targetRole then
    local _Cskill = self.caster.recordTable.cs_Passive
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffectWithCSkill(_Cskill, entity)
    LuaSkillCtrl:PlayAuHit(self, entity)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig, {
      self.caster.recordTable.pass_arg
    })
    skillResult:EndResult()
  end
end

function bs_103200:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_103200
