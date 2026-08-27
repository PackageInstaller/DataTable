local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_212300 = class("bs_212300", bs_1)
local base = bs_1
bs_212300.config = {
  action1 = 1001,
  action2 = 1001,
  action3 = 1004,
  effectId_AOE1 = 212301,
  effectId_AOE2 = 212302,
  Aoe_1 = {
    effect_shape = 3,
    aoe_select_code = 4,
    aoe_range = 1
  },
  Aoe_2 = {
    effect_shape = 3,
    aoe_select_code = 4,
    aoe_range = 2
  },
  HurtConfig_aoe = {basehurt_formula = 300},
  buffID_hurt = 212301,
  effectId_3 = 212304,
  buffID_rage = 212302,
  HurtConfigID = 10,
  audioId1 = 212301,
  time1 = 0,
  audioId2 = 212301,
  time2 = 0,
  audioId3_ex = 212303
}
bs_212300.config = setmetatable(bs_212300.config, {
  __index = base.config
})

function bs_212300:ctor()
end

function bs_212300:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_212300:RealPlaySkill(target, data)
  if self.caster:GetBuffTier(self.config.buffID_rage) == 0 then
    base.RealPlaySkill(self, target, data)
    self.isDoubleAttack = false
    return
  else
    self.isDoubleAttack = true
  end
  self:CallSelectEffect()
  local atkSpeed = LuaSkillCtrl:CallFormulaNumber(9997, self.caster, self.caster)
  local atkSpeedRatio = 1
  local atkActionId = data.action3
  local atkTriggerFrame = 0
  if data.audioId3_ex ~= nil then
    LuaSkillCtrl:StartTimer(self, data.time1, function()
      LuaSkillCtrl:PlayAuSource(self.caster, data.audioId3_ex)
    end)
  end
  atkSpeedRatio = self:CalcAtkActionSpeed2(atkSpeed, 3)
  atkActionId = data.action3
  atkTriggerFrame = self:GetAtkTriggerFrame2(3, atkSpeed) * self.config.baseActionSpd
  self.caster.recordTable.lastAttackRole = target
  if LuaSkillCtrl.IsInTDBattle and self.caster.belongNum == 2 then
    self.caster.recordTable.lastAttackRole = nil
  end
  local attackTrigger2 = BindCallback(self, self.OnAttackTrigger2, target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
  local waitTime = atkSpeed - 1 - (self.rotateWaited and 3 or 0)
  if 0 < waitTime then
    self:CallCasterWait(waitTime + 2)
  end
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, atkActionId, atkSpeedRatio, atkTriggerFrame, attackTrigger2)
  LuaSkillCtrl:PlayAuSource(self.caster, data.audioId3_ex)
end

function bs_212300:OnAttackTrigger(target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
  if data.audioId3 ~= nil then
    LuaSkillCtrl:PlayAuSource(self.caster, data.audioId3)
  end
  if LuaSkillCtrl:IsAbleAttackTarget(self.caster, target, self.caster.attackRange, true) then
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 0)
    if 0 < targetList.Count then
      for i = targetList.Count - 1, 0, -1 do
        local target = targetList[i]
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
        LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID, {
          self.caster.recordTable.AOEDamage
        })
        skillResult:EndResult()
        if data.Imp == true then
          LuaSkillCtrl:PlayAuHit(self, target)
        end
      end
      LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_AOE1, self, nil, nil, atkSpeedRatio)
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

function bs_212300:OnAttackTrigger2(target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
  if data.audioId3 ~= nil then
    LuaSkillCtrl:PlayAuSource(self.caster, data.audioId3)
  end
  if LuaSkillCtrl:IsAbleAttackTarget(self.caster, target, self.caster.attackRange, true) then
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 1)
    if targetList.Count > 0 then
      for i = targetList.Count - 1, 0, -1 do
        local target = targetList[i]
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
        LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID, {
          self.caster.recordTable.AOEDamage
        })
        skillResult:EndResult()
        if data.Imp == true then
          LuaSkillCtrl:PlayAuHit(self, target)
        end
      end
      LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_AOE2, self, nil, nil, atkSpeedRatio)
    end
    if self.caster.recordTable.completeFirstComatk == nil then
      self.caster.recordTable.completeFirstComatk = true
    end
  else
    self:BreakSkill()
  end
  if self.isDoubleAttack then
    local attackTrigger = BindCallback(self, self.OnAttackTrigger2, target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
    self:CheckAndExecuteSecondAttack(data, target, atkTriggerFrame, atkSpeedRatio, atkActionId, attackTrigger)
  else
    self:CancleCasterWait()
  end
  if self.cskill.skillCfg.BreakNum ~= 0 then
    target:TryCallBreakNumChange(-self.cskill.skillCfg.BreakNum)
  end
end

function bs_212300:CalcAtkActionSpeed2(atkInterval, atkId)
  local atkTotalFrames = self:GetTotalAtkActionFrames2(atkId)
  if atkInterval < atkTotalFrames then
    return atkTotalFrames / atkInterval
  else
    return 1
  end
end

function bs_212300:GetTotalAtkActionFrames2(atkId)
  local srcId = self.caster.resSrcId
  if srcId == 0 then
    return 0
  end
  if atkId == 3 then
    return 35
  else
    return 0
  end
end

function bs_212300:GetAtkTriggerFrame2(atkId, atkInterval)
  local srcId = self.caster.resSrcId
  if srcId == 0 then
    return 0
  end
  local atkTotalFrames = self:GetTotalAtkActionFrames2(atkId)
  local triggerFrameCfg = 0
  if atkId == 3 then
    triggerFrameCfg = 13
  end
  if atkInterval < atkTotalFrames then
    return triggerFrameCfg * atkInterval // atkTotalFrames
  else
    return triggerFrameCfg
  end
end

function bs_212300:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_212300
