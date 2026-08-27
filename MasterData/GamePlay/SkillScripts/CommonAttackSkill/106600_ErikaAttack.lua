local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_106600 = class("bs_106600", bs_1)
local base = bs_1
bs_106600.config = {
  action3 = 1021,
  effectId_trail_pa = 106606,
  effectId_trail_pa_skin_newyear = 106619,
  effectId_trail = 106601,
  effectId_trail_ex = 106602,
  effectId_action_1 = 106603,
  effectId_action_2 = 106604,
  effectId_action_passive = 106615,
  effectId_action_passive_skin_newyear = 106620,
  audioId1 = 106601,
  time1 = 0,
  audioId2 = 106602,
  time2 = 0,
  audioId3_ex = 106604,
  effectId_trail_skin_show = 10660302,
  effectId_trail_ex_skin_show = 10660402,
  effectId_trail_skin_real = 10660102,
  effectId_trail_ex_skin_real = 10660202
}
bs_106600.config = setmetatable(bs_106600.config, {
  __index = base.config
})

function bs_106600:ctor()
end

function bs_106600:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.skinid = LuaSkillCtrl:GetCasterSkinId(self.caster)
end

function bs_106600:RealPlaySkill(target, data)
  local range = self.caster.recordTable.arglist1
  if range < LuaSkillCtrl:CallRange(1, 1000) then
    base.RealPlaySkill(self, target, data)
    return
  end
  self:CallSelectEffect()
  local atkSpeed = LuaSkillCtrl:CallFormulaNumber(9997, self.caster, self.caster)
  local atkSpeedRatio = 1
  local atkActionId = data.action3
  local atkTriggerFrame = 0
  if data.audioId1_ex ~= nil then
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
  local attackTrigger2 = BindCallback(self, self.OnAttackTrigger2, target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
  local waitTime = atkSpeed - 1 - (self.rotateWaited and 3 or 0)
  if 0 < waitTime then
    self:CallCasterWait(waitTime + 2)
  end
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, atkActionId, atkSpeedRatio, atkTriggerFrame, attackTrigger2)
  LuaSkillCtrl:PlayAuSource(self.caster, data.audioId3_ex)
end

function bs_106600:ExecuteEffectAttack(data, atkActionId, target, effectId1, effectId2)
  if data.audioId4 ~= nil then
    LuaSkillCtrl:PlayAuSource(self.caster, data.audioId4)
  end
  if atkActionId == data.action1 then
    if self.skinid ~= 306603 then
      effectId1 = self.config.effectId_trail
    else
      effectId1 = self.config.effectId_trail_skin_real
      LuaSkillCtrl:CallEffectWithArg(target, self.config.effectId_trail_skin_show, self, nil, false, self.SkillEventFuncShow, data)
    end
    LuaSkillCtrl:CallEffectWithArg(target, effectId1, self, nil, false, self.SkillEventFunc, data)
  else
    if self.skinid ~= 306603 then
      effectId2 = self.config.effectId_trail_ex
    else
      effectId2 = self.config.effectId_trail_ex_skin_real
      LuaSkillCtrl:CallEffectWithArg(target, self.config.effectId_trail_ex_skin_show, self, nil, false, self.SkillEventFuncShow, data)
    end
    LuaSkillCtrl:CallEffectWithArg(target, effectId2, self, nil, false, self.SkillEventFunc, data)
  end
end

function bs_106600:SkillEventFunc(configData, effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    if configData.audioId5 ~= nil and self.skinid ~= 306603 then
      LuaSkillCtrl:PlayAuSource(target.targetRole, configData.audioId5)
    end
    if configData.Imp == true and self.skinid ~= 306603 then
      LuaSkillCtrl:PlayAuHit(self, target)
    end
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResult(self, skillResult, generalHurtConfig)
    skillResult:EndResult()
  end
end

function bs_106600:SkillEventFuncShow(configData, effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    if configData.audioId5 ~= nil then
      LuaSkillCtrl:PlayAuSource(target.targetRole, configData.audioId5)
    end
    if configData.Imp == true then
      LuaSkillCtrl:PlayAuHit(self, target)
    end
  end
end

function bs_106600:OnAttackTrigger2(target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
  if LuaSkillCtrl:IsAbleAttackTarget(self.caster, target, self.caster.attackRange, true) then
    local extraTarget = self:CheckAndGetExtraEffectTarget(target)
    self:ExecuteEffectAttack2(data, atkActionId, target)
    if extraTarget ~= nil then
      self:ExecuteEffectAttack2(data, atkActionId, extraTarget, data.effectId_split_shoot, data.effectId_split_shoot_ex)
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
end

function bs_106600:ExecuteEffectAttack2(data, atkActionId, target, effectId1, effectId2)
  if self.skinid == 306604 then
    LuaSkillCtrl:CallEffect(target, self.config.effectId_action_passive_skin_newyear, self)
    LuaSkillCtrl:CallEffectWithArg(target, self.config.effectId_trail_pa_skin_newyear, self, nil, false, self.SkillEventFunc2, data)
  else
    LuaSkillCtrl:CallEffect(target, self.config.effectId_action_passive, self)
    LuaSkillCtrl:CallEffectWithArg(target, self.config.effectId_trail_pa, self, nil, false, self.SkillEventFunc2, data)
  end
end

function bs_106600:SkillEventFunc2(configData, effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.OnErikaAttackEx, target)
  end
end

function bs_106600:CalcAtkActionSpeed2(atkInterval, atkId)
  local atkTotalFrames = self:GetTotalAtkActionFrames2(atkId)
  if atkInterval < atkTotalFrames then
    return atkTotalFrames / atkInterval
  else
    return 1
  end
end

function bs_106600:GetTotalAtkActionFrames2(atkId)
  local srcId = self.caster.resSrcId
  if srcId == 0 then
    return 0
  end
  if atkId == 3 then
    return 38
  else
    return 0
  end
end

function bs_106600:GetAtkTriggerFrame2(atkId, atkInterval)
  local srcId = self.caster.resSrcId
  if srcId == 0 then
    return 0
  end
  local atkTotalFrames = self:GetTotalAtkActionFrames2(atkId)
  local triggerFrameCfg = 0
  if atkId == 3 then
    triggerFrameCfg = 11
  end
  if atkInterval < atkTotalFrames then
    return triggerFrameCfg * atkInterval // atkTotalFrames
  else
    return triggerFrameCfg
  end
end

function bs_106600:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_106600
