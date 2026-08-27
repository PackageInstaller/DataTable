local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_107807 = class("bs_107807", bs_1)
local base = bs_1
bs_107807.config = {
  effectId_start1 = 107812,
  effectId_trail = 107813,
  effectId_start2 = 107812,
  action3 = 1021,
  effectId2 = 107810,
  effectId3 = 107813,
  effectId4 = 107816,
  rot_shoottimes = 4,
  select_Id = 42
}
bs_107807.config = setmetatable(bs_107807.config, {
  __index = base.config
})

function bs_107807:ctor()
end

function bs_107807:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnPlayChang, self.OnPlayChang)
end

function bs_107807:TryPlayByLua(moveSelectTarget, selectTargetCoord, selectRoles)
  LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.OnKurisuSummonerSkill, self, 0, eSkillTag.commonAttack)
  self.moveSelectTarget = moveSelectTarget
  local result = self:PlaySkill(nil, selectTargetCoord, selectRoles)
  self.caster.recordTable.lastSkill = self.dataID
  self.cskill:OnSkillTake()
  LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.OnKurisuSummonerSkill, self, 1, eSkillTag.commonAttack)
  return true
end

function bs_107807:OnAttackTrigger(target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
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
    self:ExecuteEffectAttack(target, nil, nil, shoottimes, sender)
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

function bs_107807:ExecuteEffectAttack(target, effectId1, effectId2, times, sender)
  if times == self.config.rot_shoottimes then
    effectId1 = self.config.effectId4
  else
    effectId1 = self.config.effectId3
  end
  local time_delay = 0
  if 0 < times then
    if times < self.config.rot_shoottimes then
      time_delay = 5
    end
    LuaSkillCtrl:StartTimer(self, time_delay, function()
      LuaSkillCtrl:CallEffectWithArgOverride(target, effectId1, self, sender, false, false, self.SkillEventFunc, target, sender, times)
    end)
  end
end

function bs_107807:SkillEventFunc(target, sender, times, effect, eventId)
  if eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.OnKurisuSummonerHurt, eSkillTag.commonAttack, target, effect, times)
    local target_next
    local targetList = LuaSkillCtrl:CallTargetSelect(self, self.config.select_Id, 10)
    if targetList.Count > 0 then
      for i = 0, targetList.Count - 1 do
        if targetList[i].targetRole ~= nil and targetList[i].targetRole ~= target then
          target_next = targetList[i].targetRole
          self:ExecuteEffectAttack(target_next, nil, nil, times - 1, target)
          break
        end
      end
    end
  end
end

return bs_107807
