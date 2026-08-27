local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_106500 = class("bs_106500", bs_1)
local base = bs_1
bs_106500.config = {
  effectId_1 = nil,
  effectId_2 = nil,
  effectId_3 = 106501,
  effectId_hit_ex = 106502,
  buffId_2 = 106503,
  action3 = 1020,
  hurtConfigId = 10,
  buffId_fly = 106509,
  radius = 100,
  arcAngleRange = 60,
  audioId1 = 106501,
  time1 = 0,
  audioId2 = 106502,
  time2 = 0,
  audioId_pa = 106504
}
bs_106500.config = setmetatable(bs_106500.config, {
  __index = base.config
})

function bs_106500:ctor()
end

function bs_106500:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_106500:RealPlaySkill(target, data)
  if self.caster:GetBuffTier(self.config.buffId_2) == 0 then
    base.RealPlaySkill(self, target, data)
    return
  end
  self:CallSelectEffect()
  local atkSpeed = LuaSkillCtrl:CallFormulaNumber(9997, self.caster, self.caster)
  local atkSpeedRatio = 1
  local atkActionId = data.action3
  local atkTriggerFrame = 0
  if data.audioId3 ~= nil then
    LuaSkillCtrl:StartTimer(self, data.time1, function()
      LuaSkillCtrl:PlayAuSource(self.caster, data.audioId1_ex)
    end)
  end
  atkSpeedRatio = self:CalcAtkActionSpeed2(atkSpeed, 3)
  atkActionId = data.action3
  atkTriggerFrame = self:GetAtkTriggerFrame2(3, atkSpeed) * self.config.baseActionSpd
  self.caster.recordTable.lastAttackRole = target
  if LuaSkillCtrl.IsInTDBattle and self.caster.belongNum == 2 then
    self.caster.recordTable.lastAttackRole = nil
  end
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
  local waitTime = atkSpeed - 1 - (self.rotateWaited and 3 or 0)
  if 0 < waitTime then
    self:CallCasterWait(waitTime + 2)
  end
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, atkActionId, atkSpeedRatio, atkTriggerFrame, attackTrigger)
  if self.caster.attackRange == 1 and data.effectId_4 ~= nil and atkActionId == data.action3 then
    self.caster.recordTable["1_attack_effect"] = LuaSkillCtrl:CallEffect(target, data.effectId_4, self, nil, nil, atkSpeedRatio, true)
  end
  LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId_pa)
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_2, 1)
end

function bs_106500:OnAttackTrigger(target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
  if atkActionId == data.action1 or atkActionId == data.action2 then
    if LuaSkillCtrl:IsAbleAttackTarget(self.caster, target, self.caster.attackRange, true) then
      local hurt = 1000
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.hurtConfigId, {hurt})
      skillResult:EndResult()
      local onCtrl = LuaSkillCtrl:RoleContainsCtrlBuff(target)
      if onCtrl == true then
        LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.OnLindHurt, 0, target)
      end
      if self.caster.recordTable.completeFirstComatk == nil then
        self.caster.recordTable.completeFirstComatk = true
      end
    else
      self:BreakSkill()
    end
  elseif LuaSkillCtrl:IsAbleAttackTarget(self.caster, target, self.caster.attackRange, true) then
    local selectTarget = LuaSkillCtrl:GetTargetWithGrid(target.x, target.y)
    local targetPos = target.lsObject.localPosition
    local forwardDir = CS.TrueSync.TSVector3.Subtract(targetPos, self.caster.lsObject.localPosition)
    LuaSkillCtrl:CallEffect(target, self.config.effectId_hit_ex, self)
    local ColliderEnter = BindCallback(self, self.OnColliderEnter, forwardDir, targetPos)
    local fireCollider = LuaSkillCtrl:CallGetCircleSkillCollider(self, self.config.radius, eColliderInfluenceType.Enemy, ColliderEnter)
    fireCollider.lsObject = CS.LSUnityObject()
    fireCollider:SetColiderObjPosForce(targetPos)
    LuaSkillCtrl:StartTimer(nil, 1, function()
      LuaSkillCtrl:ClearColliderOrEmission(fireCollider)
    end)
    if self.caster.recordTable.completeFirstComatk == nil then
      self.caster.recordTable.completeFirstComatk = true
    end
  else
    self:BreakSkill()
  end
  if self.isDoubleAttack then
    local attackTrigger = BindCallback(self, self.OnAttackTrigger, target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
    self:CheckAndExecuteSecondAttack(data, target, atkTriggerFrame, atkSpeedRatio, atkActionId, attackTrigger)
  else
    self:CancleCasterWait()
  end
end

function bs_106500:OnColliderEnter(forwardDir, selectTargetPos, collider, index, entity)
  local angle = 0
  if not entity.lsObject.localPosition:Equals(selectTargetPos) then
    local tsVec2 = CS.TrueSync.TSVector2
    local curDir = CS.TrueSync.TSVector3.Subtract(entity.lsObject.localPosition, selectTargetPos)
    local curDir2d = tsVec2(curDir.x, curDir.z).normalized
    local forwardDir2D = tsVec2(forwardDir.x, forwardDir.z)
    angle = LuaSkillCtrl:CallTSVec2Angle(curDir2d, forwardDir2D)
  end
  if 180 < angle then
    angle = 360 - angle
  end
  if angle > self.config.arcAngleRange then
    return
  end
  if self.caster == nil or 0 >= self.caster.hp then
    return
  end
  if 0 < entity.intensity and entity.belongNum == eBattleRoleBelong.enemy then
    LuaSkillCtrl:CallBuff(self, entity, self.config.buffId_fly, 1, 10)
  end
  local onCtrl = LuaSkillCtrl:RoleContainsCtrlBuff(entity)
  if onCtrl == true then
    LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.OnLindHurt, 1, entity)
  end
end

function bs_106500:CalcAtkActionSpeed2(atkInterval, atkId)
  local atkTotalFrames = self:GetTotalAtkActionFrames2(atkId)
  if atkInterval < atkTotalFrames then
    return atkTotalFrames / atkInterval
  else
    return 1
  end
end

function bs_106500:GetTotalAtkActionFrames2(atkId)
  local srcId = self.caster.resSrcId
  if srcId == 0 then
    return 0
  end
  if atkId == 3 then
    return 30
  else
    return 0
  end
end

function bs_106500:GetAtkTriggerFrame2(atkId, atkInterval)
  local srcId = self.caster.resSrcId
  if srcId == 0 then
    return 0
  end
  local atkTotalFrames = self:GetTotalAtkActionFrames2(atkId)
  local triggerFrameCfg = 0
  if atkId == 3 then
    triggerFrameCfg = 9
  end
  if atkInterval < atkTotalFrames then
    return triggerFrameCfg * atkInterval // atkTotalFrames
  else
    return triggerFrameCfg
  end
end

function bs_106500:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_106500
