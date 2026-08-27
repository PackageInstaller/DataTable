local bs_207901 = class("bs_207901", LuaSkillBase)
local base = LuaSkillBase
bs_207901.config = {
  HurtConfig = 12,
  buffId_csbuff = 207901,
  buffId_ksbuff = 207902,
  effectId_line = 207906,
  effectId_trail = 207906,
  effectId_line2 = 207908,
  effectId_trail2 = 207908,
  selectId = 10001,
  selectRange = 10,
  selectId2 = 34,
  skill_time = 19,
  start_time = 12,
  actionId = 1002,
  act_speed = 1,
  time_hurt = 3,
  audioId = 207903
}

function bs_207901:ctor()
end

function bs_207901:InitSkill(isMidwaySkill)
  self.caster.recordTable.one = nil
  self.caster.recordTable.two = nil
end

function bs_207901:PlaySkill(data)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, self.config.selectId, self.config.selectRange)
  if targetList.Count == 0 then
    LuaSkillCtrl:SetResetCdByReturnConfigOnce(self)
    return
  end
  self:AbandonSkillCdAutoReset(true)
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self.caster:LookAtTarget(targetList[0].targetRole)
  self:CallCasterWait(self.config.skill_time)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, targetList[0].targetRole, data)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.act_speed, self.config.start_time, attackTrigger)
end

function bs_207901:OnAttackTrigger(target, data)
  self:RealPlaySkill(nil, target, 1)
  self:EndSkillAndCallNext()
end

function bs_207901:RealPlaySkill(sender, target, JNId)
  LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId)
  if sender == nil then
    LuaSkillCtrl:CallEffectWithArgOverride(target, self.config.effectId_trail, self, self.caster, false, false, self.SkillEventFunc, JNId)
  elseif JNId <= 1 then
    LuaSkillCtrl:StartTimer(nil, self.config.time_hurt, function()
      LuaSkillCtrl:CallEffectWithArgOverride(target, self.config.effectId_trail, self, sender, false, false, self.SkillEventFunc, JNId)
    end)
  else
    LuaSkillCtrl:StartTimer(nil, self.config.time_hurt, function()
      LuaSkillCtrl:CallEffectWithArgOverride(target, self.config.effectId_trail2, self, sender, false, false, self.SkillEventFunc, JNId)
    end)
  end
  if sender == nil and target == self.caster then
    return
  end
end

function bs_207901:SkillEventFunc(JNId, effect, eventId, target)
  if (effect.dataId == self.config.effectId_trail or effect.dataId == self.config.effectId_trail2) and eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:StartTimer(nil, self.config.time_hurt, BindCallback(self, self.CallBack, target.targetRole, JNId))
    local num = self.caster:GetBuffTier(self.config.buffId_csbuff)
    if JNId <= self.arglist[2] + num then
      local targetList = LuaSkillCtrl:CallTargetSelect(self, self.config.selectId2, self.config.selectRange, target.targetRole)
      if targetList.Count == 0 then
        return
      end
      if 2 <= targetList.Count then
        for i = 0, targetList.Count - 1 do
          if targetList[i].targetRole ~= nil and targetList[i].targetRole ~= target.targetRole and targetList[i].targetRole.roleDataId ~= self.caster.recordTable.one then
            self:RealPlaySkill(target.targetRole, targetList[i].targetRole, JNId + 1)
            if self.caster.recordTable.one ~= nil then
              self.caster.recordTable.two = self.caster.recordTable.one
            end
            self.caster.recordTable.one = target.targetRole.roleDataId
            break
          end
        end
      elseif targetList[0].targetRole ~= nil and targetList[0].targetRole ~= target.targetRole then
        self:RealPlaySkill(target.targetRole, targetList[0].targetRole, JNId + 1)
      end
    end
  end
end

function bs_207901:CallBack(targetRole, healId)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
  LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfig, {healId}, false, false)
  skillResult:EndResult()
end

function bs_207901:EndSkillAndCallNext()
  if self.caster == nil then
    return
  end
  self:CancleCasterWait()
  local skillMgr = self.caster:GetSkillComponent()
  if skillMgr == nil then
    return
  end
  skillMgr.lastSkill = self.cskill
  self:CallNextBossSkill()
end

function bs_207901:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_207901
