local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_106800 = class("bs_106800", bs_1)
local base = bs_1
bs_106800.config = {
  atkTriggerFrame3 = 9,
  action3 = 1021,
  effectId_trail = 106801,
  effectId3 = 106806,
  effectId4 = 106807,
  effectId5 = 106808,
  effectId6 = 106809,
  effectId7 = 106810,
  effectId_shoot = 106815,
  HurtConfigID1 = 10,
  HurtConfigID2 = 32,
  HurtConfigID3 = 31,
  HurtConfigID4 = 22,
  buffId_atkSpeed = 106801
}
bs_106800.config = setmetatable(bs_106800.config, {
  __index = base.config
})

function bs_106800:ctor()
end

function bs_106800:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.doDamgeHurtArgs = {}
end

function bs_106800:RealPlaySkill(target, data)
  self:CallSelectEffect()
  local atkSpeed = LuaSkillCtrl:CallFormulaNumber(9997, self.caster, self.caster)
  local atkSpeedRatio = 1
  local atkActionId = data.action1
  local atkTriggerFrame = 0
  if self.caster.recordTable.skill_mode == false then
    if 1 < self.attackNum then
      local prob = LuaSkillCtrl:CallRange(1, 2)
      if prob == 1 then
        if data.audioId2 ~= nil then
          LuaSkillCtrl:StartTimer(self, data.time2, function()
            LuaSkillCtrl:PlayAuSource(self.caster, data.audioId2)
          end)
        end
        atkSpeedRatio = self:CalcAtkActionSpeed(atkSpeed, 2) * self.config.baseActionSpd
        atkActionId = data.action2
        atkTriggerFrame = self:GetAtkTriggerFrame(2, atkSpeed)
        self.attackNum = 0
      else
        if data.audioId1 ~= nil then
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
      if data.audioId1 ~= nil then
        LuaSkillCtrl:StartTimer(self, data.time1, function()
          LuaSkillCtrl:PlayAuSource(self.caster, data.audioId1)
        end)
      end
      atkSpeedRatio = self:CalcAtkActionSpeed(atkSpeed, 1) * self.config.baseActionSpd
      atkTriggerFrame = self:GetAtkTriggerFrame(1, atkSpeed)
      atkActionId = data.action1
      self.attackNum = self.attackNum + 1
    end
  else
    atkTriggerFrame = self.config.atkTriggerFrame3
    atkActionId = self.config.action3
  end
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

function bs_106800:OnAttackTrigger(target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
  if self.caster.attackRange == 1 then
    if data.audioId3 ~= nil then
      LuaSkillCtrl:PlayAuSource(self.caster, data.audioId3)
    end
    if LuaSkillCtrl:IsAbleAttackTarget(self.caster, target, self.caster.attackRange, true) then
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      if data.Imp == true then
        LuaSkillCtrl:PlayAuHit(self, target)
      end
      LuaSkillCtrl:HurtResult(self, skillResult)
      skillResult:EndResult()
      if self.caster.recordTable.completeFirstComatk == nil then
        self.caster.recordTable.completeFirstComatk = true
      end
    else
      self:BreakSkill()
    end
  elseif LuaSkillCtrl:IsAbleAttackTarget(self.caster, target, self.caster.attackRange, true) then
    if data.effectId_action_1 ~= nil then
      if atkActionId == data.action1 then
        LuaSkillCtrl:CallEffect(self.caster, data.effectId_action_1, self)
      else
        LuaSkillCtrl:CallEffect(self.caster, data.effectId_action_2, self)
      end
    end
    if data.effectId_start3 ~= nil then
      if atkActionId == data.action1 then
        LuaSkillCtrl:CallEffect(target, data.effectId_start3, self, nil, nil, atkSpeedRatio)
      else
        LuaSkillCtrl:CallEffect(target, data.effectId_start4, self, nil, nil, atkSpeedRatio)
      end
    end
    local extraTarget = self:CheckAndGetExtraEffectTarget(target)
    self:ExecuteEffectAttack(data, atkActionId, target)
    if extraTarget ~= nil then
      self:ExecuteEffectAttack(data, atkActionId, extraTarget, data.effectId_split_shoot, data.effectId_split_shoot_ex)
    end
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
  if self.cskill.skillCfg.BreakNum ~= 0 then
    target:TryCallBreakNumChange(-self.cskill.skillCfg.BreakNum)
  end
end

function bs_106800:ExecuteEffectAttack(data, atkActionId, target, effectId1, effectId2)
  if self.caster.recordTable.skill_mode == false then
    if data.effectId_trail ~= nil then
      if data.audioId4 ~= nil then
        LuaSkillCtrl:PlayAuSource(self.caster, data.audioId4)
      end
      if data.effectId_trail_ex ~= nil then
        if atkActionId == data.action1 then
          effectId1 = effectId1 or data.effectId_trail
          LuaSkillCtrl:CallEffectWithArg(target, effectId1, self, nil, false, self.SkillEventFunc, data)
        else
          effectId2 = effectId2 or data.effectId_trail_ex
          LuaSkillCtrl:CallEffectWithArg(target, effectId2, self, nil, false, self.SkillEventFunc, data)
        end
      else
        effectId1 = effectId1 or data.effectId_trail
        LuaSkillCtrl:CallEffectWithArg(target, effectId1, self, nil, false, self.SkillEventFunc, data)
      end
    elseif data.effectId_hit_target ~= nil then
      LuaSkillCtrl:CallEffectWithArg(target, data.effectId_hit_target, self, nil, false, self.SkillEventFunc, data)
    end
  else
    LuaSkillCtrl:CallEffectWithArg(target, self.config.effectId3, self, nil, false, self.SkillEventFunc1, data)
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_shoot, self)
    LuaSkillCtrl:StartTimer(nil, 2, function()
      LuaSkillCtrl:CallEffectWithArg(target, self.config.effectId4, self, nil, false, self.SkillEventFunc1, data)
      LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_shoot, self)
    end, self, nil)
    LuaSkillCtrl:StartTimer(nil, 4, function()
      LuaSkillCtrl:CallEffectWithArg(target, self.config.effectId5, self, nil, false, self.SkillEventFunc1, data)
      LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_shoot, self)
    end, self, nil)
    LuaSkillCtrl:StartTimer(nil, 6, function()
      LuaSkillCtrl:CallEffectWithArg(target, self.config.effectId6, self, nil, false, self.SkillEventFunc1, data)
      LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_shoot, self)
    end, self, nil)
    LuaSkillCtrl:StartTimer(nil, 8, function()
      LuaSkillCtrl:CallEffectWithArg(target, self.config.effectId7, self, nil, false, self.SkillEventFunc1, data)
      LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_shoot, self)
    end, self, nil)
  end
end

function bs_106800:SkillEventFunc(configData, effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    if configData.audioId5 ~= nil then
      LuaSkillCtrl:PlayAuSource(target.targetRole, configData.audioId5)
    end
    if configData.Imp == true then
      LuaSkillCtrl:PlayAuHit(self, target)
    end
    self:DoDamage(target, 1000)
  end
end

function bs_106800:SkillEventFunc1(configData, effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local num = self.caster:GetBuffTier(self.config.buffId_atkSpeed)
    local damageRate = self.caster.recordTable.skill_damage + num * self.caster.recordTable.skill_damage_add
    self:DoDamage(target, damageRate)
  end
end

function bs_106800:DoDamage(target, damageRate)
  local hurtArgs = LuaSkillCtrl:CreatCacheTable(damageRate, self.doDamgeHurtArgs)
  local pow_damage = self:CalculateDamage_pow(target)
  local skill_intensity_damage = self:CalculateDamage_skill_intensity(target)
  if pow_damage >= skill_intensity_damage then
    if self.caster.pow >= self.caster.skill_intensity then
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID1, hurtArgs)
      skillResult:EndResult()
    else
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID2, hurtArgs)
      skillResult:EndResult()
    end
  elseif self.caster.pow >= self.caster.skill_intensity then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID3, hurtArgs)
    skillResult:EndResult()
  else
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID4, hurtArgs)
    skillResult:EndResult()
  end
end

function bs_106800:CalculateDamage_pow(target)
  local pow = math.max(self.caster.pow, self.caster.skill_intensity)
  local def = math.max(target.targetRole.def * (1 - self:GetBuffExtra(self.caster, 2) / 1000) - self.caster.sunder, -200)
  local atk = math.max(1, pow * math.max(0.1, 1000 / (def + 1000)) * 1)
  local Rate = math.max(0.1, 1 + (self:GetBuffExtra(self.caster, 8) - self:GetBuffExtra(target.targetRole, 10)))
  local damage = atk * Rate
  return damage
end

function bs_106800:CalculateDamage_skill_intensity(target)
  local pow = math.max(self.caster.pow, self.caster.skill_intensity)
  local magic_res = math.max(target.targetRole.magic_res * (1 - self:GetBuffExtra(self.caster, 2) / 1000) - self.caster.magic_pen, -200)
  local skill_intensity = math.max(1, pow * math.max(0.1, 1000 / (magic_res + 1000)) * 1)
  local Rate = math.max(0.1, 1 + (self:GetBuffExtra(self.caster, 9) - self:GetBuffExtra(target.targetRole, 11)))
  local damage = skill_intensity * Rate
  return damage
end

function bs_106800:GetBuffExtra(target, num)
  local buffMger = target:GetBuffComponent()
  if buffMger ~= nil then
    return buffMger:GetExtraPropertyValue(num)
  end
end

function bs_106800:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_106800
