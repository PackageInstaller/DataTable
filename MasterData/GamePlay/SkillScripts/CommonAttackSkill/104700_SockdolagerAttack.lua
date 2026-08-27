local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_104700 = class("bs_104700", bs_1)
local base = bs_1
bs_104700.config = {
  effectId_trail = 104701,
  effectId_action_1 = 104713,
  effectId_action_2 = 104713,
  effectId_action_3 = 104714,
  effectId_action_4 = 104714,
  effectId_trail_ex = 104711,
  HurtConfig = {
    hit_formula = 0,
    def_formula = 9996,
    basehurt_formula = 9993,
    minhurt_formula = 9994,
    crit_formula = 9992,
    crithur_ratio = 9995,
    correct_formula = 9989,
    lifesteal_formula = 1001,
    spell_lifesteal_formula = 1002,
    returndamage_formula = 1000,
    hurt_type = -1
  }
}
bs_104700.config = setmetatable(bs_104700.config, {
  __index = base.config
})

function bs_104700:ctor()
end

function bs_104700:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.Attack = 0
end

function bs_104700:ExecuteEffectAttack(data, atkActionId, target)
  if self.caster.recordTable.passiveisok == 1 then
    if data.audioId4 ~= nil then
      LuaSkillCtrl:PlayAuSource(self.caster, data.audioId4)
    end
    if data.effectId_trail_ex ~= nil then
      LuaSkillCtrl:CallEffectWithArg(target, data.effectId_trail_ex, self, nil, false, self.SkillEventFunc, data)
      self.caster.recordTable.passiveisok = 0
    end
  else
    if data.audioId4 ~= nil then
      LuaSkillCtrl:PlayAuSource(self.caster, data.audioId4)
    end
    LuaSkillCtrl:CallEffectWithArg(target, data.effectId_trail, self, nil, false, self.SkillEventFunc, data)
  end
end

function bs_104700:OnAttackTrigger(target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
  if self.caster.attackRange == 1 then
    if data.audioId3 ~= nil then
      LuaSkillCtrl:PlayAuSource(self.caster, data.audioId3)
    end
    if LuaSkillCtrl:IsAbleAttackTarget(self.caster, target, self.caster.attackRange) then
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
  elseif LuaSkillCtrl:IsAbleAttackTarget(self.caster, target, self.caster.attackRange) then
    if data.effectId_action_1 ~= nil then
      if self.caster.recordTable.passiveisok == 1 then
        if atkActionId == data.action1 then
          LuaSkillCtrl:CallEffect(self.caster, data.effectId_action_3, self)
        else
          LuaSkillCtrl:CallEffect(self.caster, data.effectId_action_4, self)
        end
      elseif atkActionId == data.action1 then
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
      self:ExecuteEffectAttack(data, atkActionId, extraTarget)
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

function bs_104700:SkillEventFunc(configData, effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    if configData.audioId5 ~= nil then
      LuaSkillCtrl:PlayAuSource(target.targetRole, configData.audioId5)
    end
    if configData.Imp == true then
      LuaSkillCtrl:PlayAuHit(self, target)
    end
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    if self.Attack >= self.caster.recordTable.arglist1 then
      LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig)
      skillResult:EndResult()
      self.Attack = 0
    else
      LuaSkillCtrl:HurtResult(self, skillResult, generalHurtConfig)
      skillResult:EndResult()
      self.Attack = self.Attack + 1
    end
  end
end

function bs_104700:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_104700
