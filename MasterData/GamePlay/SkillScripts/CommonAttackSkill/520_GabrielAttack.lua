local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_520 = class("bs_520", bs_1)
local base = bs_1
bs_520.config = {
  effectId_trail = 10494,
  effectId_action_1 = 10493,
  effectId_action_2 = 10509,
  effectId_CD = 10821,
  Aoe = {
    effect_shape = 3,
    aoe_select_code = 5,
    aoe_range = 1
  },
  hurtconfig = {basehurt_formula = 10055, hit_formula = 10201},
  HurtConfigRoot = {basehurt_formula = 10055, hit_formula = 10201},
  rootAtkAnim = 1021,
  rootEffect1 = 10847,
  rootEffect2 = 10848,
  rootEffect3 = 10849,
  audioId1 = 337,
  audioId2 = 337
}
bs_520.config = setmetatable(bs_520.config, {
  __index = base.config
})

function bs_520:ctor()
end

function bs_520:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_520:RealPlaySkill(target, data)
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 60, 10)
  if targetlist.Count > 0 and self.caster.recordTable["20051_root4arg1"] == nil then
    local targetRole = targetlist[0].targetRole
    self.caster:LookAtTarget(targetRole)
    base.RealPlaySkill(self, targetRole, data)
  end
  if self.caster.recordTable["20051_root4arg1"] ~= nil then
    local atkActionId = data.rootAtkAnim
    local atkSpeedRatio = 1
    local atkTriggerFrame = 18
    self.caster:LookAtTarget(targetlist[0].targetRole)
    LuaSkillCtrl:CallEffect(targetlist[0].targetRole, data.rootEffect1, self, nil, nil, nil, true)
    local attackTrigger = BindCallback(self, self.OnAttackTrigger, targetlist[0].targetRole, data, atkSpeedRatio, atkActionId)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, atkActionId, atkSpeedRatio, atkTriggerFrame, attackTrigger)
    LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId1)
  end
end

function bs_520:OnAttackTrigger(target, data, atkSpeedRatio, atkActionId)
  self.caster.recordTable.lastAttackRole = target
  if self.caster.attackRange == 1 then
    if data.audioId3 ~= nil then
      LuaSkillCtrl:PlayAuSource(self.caster, data.audioId3)
    end
    if LuaSkillCtrl:IsAbleAttackTarget(self.caster, target, self.caster.attackRange, true) then
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      LuaSkillCtrl:PlayAuHit(self, target)
      LuaSkillCtrl:HurtResult(self, skillResult)
      skillResult:EndResult()
      if self.caster.recordTable.completeFirstComatk == nil then
        self.caster.recordTable.completeFirstComatk = true
      end
    else
      self:BreakSkill()
    end
  elseif self.caster.recordTable["20051_root4arg1"] ~= nil and LuaSkillCtrl:IsAbleAttackTarget(self.caster, target, self.caster.attackRange, true) then
    if data.audioId4 ~= nil then
      LuaSkillCtrl:PlayAuSource(self.caster, data.audioId4)
    end
    LuaSkillCtrl:CallEffectWithArg(target, data.rootEffect2, self, true, false, self.SkillEventFunc, data)
    if self.caster.recordTable.completeFirstComatk == nil then
      self.caster.recordTable.completeFirstComatk = true
    end
  elseif LuaSkillCtrl:IsAbleAttackTarget(self.caster, target, self.caster.attackRange, true) and self.caster.recordTable["20051_root4arg1"] == nil then
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
    if data.effectId_trail ~= nil then
      if data.audioId4 ~= nil then
        LuaSkillCtrl:PlayAuSource(self.caster, data.audioId4)
      end
      if data.effectId_trail_ex ~= nil then
        if atkActionId == data.action1 then
          LuaSkillCtrl:CallEffectWithArg(target, data.effectId_trail, self, true, false, self.SkillEventFunc, data)
        else
          LuaSkillCtrl:CallEffectWithArg(target, data.effectId_trail_ex, self, true, false, self.SkillEventFunc, data)
        end
      else
        LuaSkillCtrl:CallEffectWithArg(target, data.effectId_trail, self, true, false, self.SkillEventFunc, data)
      end
    end
    if self.caster.recordTable.completeFirstComatk == nil then
      self.caster.recordTable.completeFirstComatk = true
    end
  else
    self:BreakSkill()
  end
  self:CancleCasterWait()
end

function bs_520:SkillEventFunc(configData, effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    if configData.audioId5 ~= nil then
      LuaSkillCtrl:PlayAuSource(self.caster, configData.audioId5)
    end
    if self.caster.recordTable["20051_root4arg1"] ~= nil then
      local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
      LuaSkillCtrl:PlayAuHit(self.caster, target)
      LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfigRoot, {
        self.caster.recordTable["20051_root4arg1"]
      })
      skillResult:EndResult()
    else
      local hurt = BindCallback(self, self.Onhurt, effect, target)
      LuaSkillCtrl:StartTimer(self, 6, hurt, self)
    end
  end
end

function bs_520:Onhurt(effect, target)
  local arg = self.caster.recordTable["520_arg1"]
  local skillResult = LuaSkillCtrl:CallSkillResult(effect, target, self.config.Aoe)
  if skillResult.roleList.Count >= 2 then
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_CD, self)
    local skills = self.caster:GetBattleSkillList()
    if skills ~= nil then
      local skillCount = skills.Count
      if 0 < skillCount then
        for j = 0, skillCount - 1 do
          local curTotalCd = self.caster.recordTable["520_arg2"]
          LuaSkillCtrl:CallResetCDForSingleSkill(skills[j], curTotalCd)
        end
      end
    end
  end
  LuaSkillCtrl:PlayAuHit(self, target)
  LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurtconfig, {arg})
  skillResult:EndResult()
end

function bs_520:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_520
