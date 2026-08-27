local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_107200 = class("bs_107200", bs_1)
local base = bs_1
bs_107200.config = {
  effectId_trail = 107201,
  effectId_trail_bot = 107203,
  rot_shoottimes = 3,
  select_Id = 42,
  hurt_id_1 = 40,
  hurt_id_2 = 15,
  effectId_trail_bot_jump = 107212
}
bs_107200.config = setmetatable(bs_107200.config, {
  __index = base.config
})

function bs_107200:ctor()
end

function bs_107200:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_107200:OnAttackTrigger(target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
  if LuaSkillCtrl:IsAbleAttackTarget(self.caster, target, self.caster.attackRange, true) then
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
    local shoottimes = self.config.rot_shoottimes
    local sender = self.caster
    if self.caster.recordTable.changebody == false then
      self:ExecuteEffectAttack(data, atkActionId, target)
    else
      self:ExecuteEffectAttack2(target, nil, nil, shoottimes, sender)
    end
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

function bs_107200:ExecuteEffectAttack2(target, effectId1, effectId2, times, sender)
  if times == self.config.rot_shoottimes then
    effectId1 = self.config.effectId_trail_bot
  else
    effectId1 = self.config.effectId_trail_bot_jump
  end
  local time_delay = 0
  if 0 < times then
    if times < self.config.rot_shoottimes then
      time_delay = 5
    end
    LuaSkillCtrl:StartTimer(nil, time_delay, function()
      LuaSkillCtrl:CallEffectWithArgOverride(target, effectId1, self, sender, false, false, self.SkillEventFunc2, target, sender, times)
    end)
  end
end

function bs_107200:SkillEventFunc2(target, sender, times, effect, eventId)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.hurt_id_1, {
      self.caster.recordTable.dam_bot_attack
    }, false)
    skillResult:EndResult()
    local EnemyList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
    local target_next
    local targetList = LuaSkillCtrl:CallTargetSelect(self, self.config.select_Id, 10)
    if targetList.Count > 0 then
      for i = 0, targetList.Count - 1 do
        if targetList[i].targetRole ~= nil and targetList[i].targetRole ~= target then
          target_next = targetList[i].targetRole
          self:ExecuteEffectAttack2(target_next, nil, nil, times - 1, target)
          break
        end
      end
    end
  end
end

function bs_107200:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_107200
