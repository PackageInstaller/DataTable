local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_102500 = class("bs_102500", bs_1)
local base = bs_1
bs_102500.config = {
  effectId_trail = 102503,
  effectId_P = 102506,
  effectId_hit2 = 102505,
  effectId_hit3 = 102513,
  effectId_new = 102507,
  effectId_new2 = 102515,
  HurtConfig = {basehurt_formula = 3000},
  ex_hurttime = 3,
  buffId_170 = 170,
  buffId_tip = 102503,
  audioId1 = 248,
  audioId2 = 249,
  audioId5 = 250,
  audioId_three = 251,
  audioId_three_hit = 253,
  buffId_CH = 102501,
  spdPerFrame = 15
}
bs_102500.config = setmetatable(bs_102500.config, {
  __index = base.config
})

function bs_102500:ctor()
end

function bs_102500:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.three = false
  self.caster.recordTable.cs_Skill = self.cskill
end

function bs_102500:RealPlaySkill(target, data)
  if self.caster:GetBuffTier(self.config.buffId_170) > 0 then
    self.three = true
  else
    self.three = false
  end
  self:CallSelectEffect()
  local atkSpeed = LuaSkillCtrl:CallFormulaNumber(9997, self.caster, self.caster)
  local atkSpeedRatio = 1
  local atkActionId = data.action1
  local atkTriggerFrame = 0
  if 1 < self.attackNum then
    local prob = LuaSkillCtrl:CallRange(1, 2)
    if prob == 1 then
      if data.audioId2 ~= nil and self.three == false then
        LuaSkillCtrl:StartTimer(self, data.time2, function()
          LuaSkillCtrl:PlayAuSource(self.caster, data.audioId2)
        end)
      end
      atkSpeedRatio = self:CalcAtkActionSpeed(atkSpeed, 2) * self.config.baseActionSpd
      atkActionId = data.action2
      atkTriggerFrame = self:GetAtkTriggerFrame(2, atkSpeed)
      self.attackNum = 0
    else
      if data.audioId1 ~= nil and self.three == false then
        LuaSkillCtrl:StartTimer(self, data.time1, function()
          LuaSkillCtrl:PlayAuSource(self.caster, data.audioId1)
        end)
      end
      atkSpeedRatio = self:CalcAtkActionSpeed(atkSpeed, 1)
      atkActionId = data.action1
      atkTriggerFrame = self:GetAtkTriggerFrame(1, atkSpeed) * self.config.baseActionSpd
      self.attackNum = self.attackNum + 1
    end
  else
    if data.audioId1 ~= nil and self.three == false then
      LuaSkillCtrl:StartTimer(self, data.time1, function()
        LuaSkillCtrl:PlayAuSource(self.caster, data.audioId1)
      end)
    end
    atkSpeedRatio = self:CalcAtkActionSpeed(atkSpeed, 1) * self.config.baseActionSpd
    atkTriggerFrame = self:GetAtkTriggerFrame(1, atkSpeed)
    atkActionId = data.action1
    self.attackNum = self.attackNum + 1
  end
  self.caster.recordTable.lastAttackRole = target
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
  local waitTime = atkSpeed - 1 - (self.rotateWaited and 3 or 0)
  if 0 < waitTime then
    self:CallCasterWait(waitTime + 2)
  end
  if self.three == true then
  end
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, atkActionId, atkSpeedRatio, atkTriggerFrame, attackTrigger)
  if self.caster.attackRange == 1 then
    if data.effectId_1 ~= nil then
      if atkActionId == data.action1 then
        self.caster.recordTable["1_attack_effect"] = LuaSkillCtrl:CallEffect(target, data.effectId_1, self, nil, nil, atkSpeedRatio, true)
      else
        self.caster.recordTable["1_attack_effect"] = LuaSkillCtrl:CallEffect(target, data.effectId_2, self, nil, nil, atkSpeedRatio, true)
      end
    end
    if data.effectId_3 ~= nil then
      LuaSkillCtrl:StartTimer(self, atkTriggerFrame, function()
        LuaSkillCtrl:CallEffect(target, data.effectId_3, self, nil, nil, atkSpeedRatio)
      end)
    end
  end
  if data.effectId_start1 ~= nil then
    if atkActionId == data.action1 then
      LuaSkillCtrl:CallEffect(target, data.effectId_start1, self, nil, nil, atkSpeedRatio, true)
    else
      LuaSkillCtrl:CallEffect(target, data.effectId_start2, self, nil, nil, atkSpeedRatio, true)
    end
  end
end

function bs_102500:OnAttackTrigger(target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
  if self.three == true then
    local extraTarget = self:CheckAndGetExtraEffectTarget(target)
    self:CallColliderEmission(target)
    if extraTarget ~= nil then
      self:CallColliderEmission(extraTarget)
    end
    if self.isDoubleAttack then
      local attackTrigger = BindCallback(self, self.OnAttackTrigger, target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
      self:CheckAndExecuteSecondAttack(data, target, atkTriggerFrame, atkSpeedRatio, atkActionId, attackTrigger)
    else
      self:CancleCasterWait()
    end
  elseif self.caster.recordTable["102501_weaponLv"] >= 3 then
    local extraTarget = self:CheckAndGetExtraEffectTarget(target)
    LuaSkillCtrl:CallEffectWithArg(target, self.config.effectId_new2, self, false, false, self.CallColliderEmission2, target)
    if extraTarget ~= nil then
      LuaSkillCtrl:CallEffectWithArg(extraTarget, self.config.effectId_new2, self, false, false, self.CallColliderEmission2, extraTarget)
    end
    if self.isDoubleAttack then
      local attackTrigger = BindCallback(self, self.OnAttackTrigger, target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
      self:CheckAndExecuteSecondAttack(data, target, atkTriggerFrame, atkSpeedRatio, atkActionId, attackTrigger)
    else
      self:CancleCasterWait()
    end
  else
    base.OnAttackTrigger(self, target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
  end
end

function bs_102500:CallColliderEmission2(target, effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId_three)
    local collisionTrigger = BindCallback(self, self.OnCollision2, target)
    LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, target, 15, self.config.spdPerFrame, 10, collisionTrigger, nil, nil, nil, true, false)
  end
end

function bs_102500:CallColliderEmission(target)
  LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId_three)
  LuaSkillCtrl:CallEffect(target, self.config.effectId_P, self)
  local collisionTrigger = BindCallback(self, self.OnCollision, target)
  LuaSkillCtrl:CallCircledEmissionStraightlyWithThreeExtraChild(self, self.caster, target, 15, 5, 10, collisionTrigger, nil, nil, nil, 16, true, true)
  LuaSkillCtrl:CallEffect(target, self.config.effectId_new, self, nil, nil, 0.5)
end

function bs_102500:OnCollision(target, collider, index, entity)
  if self.caster == nil or self.caster.hp <= 0 or 0 < entity:GetBuffTier(self.config.buffId_tip) then
    return
  end
  if LuaSkillCtrl:IsFixedObstacle(entity) then
    return
  end
  local isInvinciable = LuaSkillCtrl:RoleContainsBuffFeature(entity, eBuffFeatureType.Invinciable)
  if isInvinciable then
    return
  end
  local arg1 = self.caster.recordTable.skill_arg
  LuaSkillCtrl:PlayAuSource(target, self.config.audioId_three_hit)
  if self.caster.recordTable["102502_weaponLv"] >= 1 then
    LuaSkillCtrl:CallEffect(entity, self.config.effectId_hit3, self)
  else
    LuaSkillCtrl:CallEffect(entity, self.config.effectId_hit2, self)
  end
  local _Cskill = self.caster.recordTable.cs_Skill
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, entity)
  if self.caster.recordTable["102502_weaponLv"] >= 1 then
    local num = entity:GetBuffTier(self.config.buffId_CH)
    if 5 <= num then
      num = 5
    end
    local arg2 = self.caster.recordTable.skill_arg2
    local hurtnum = arg1 * (1000 + num * arg2) / 1000
    hurtnum = math.floor(hurtnum)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig, {hurtnum})
  else
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig, {arg1})
  end
  skillResult:EndResult()
  LuaSkillCtrl:CallBuff(self, entity, self.config.buffId_tip, 1, 1)
end

function bs_102500:OnCollision2(target, collider, index, entity)
  if self.caster == nil or self.caster.hp <= 0 or 0 < entity:GetBuffTier(self.config.buffId_tip) then
    return
  end
  if LuaSkillCtrl:IsFixedObstacle(entity) then
    return
  end
  local isInvinciable = LuaSkillCtrl:RoleContainsBuffFeature(entity, eBuffFeatureType.Invinciable)
  if isInvinciable then
    return
  end
  local arg1 = self.caster.recordTable.skill_arg
  LuaSkillCtrl:PlayAuSource(target, self.config.audioId_three_hit)
  LuaSkillCtrl:CallEffect(entity, self.config.effectId_hit2, self)
  local _Cskill = self.caster.recordTable.cs_Skill
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, entity)
  LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig, {arg1})
  skillResult:EndResult()
  LuaSkillCtrl:CallBuff(self, entity, self.config.buffId_tip, 1, 1)
end

function bs_102500:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_102500
