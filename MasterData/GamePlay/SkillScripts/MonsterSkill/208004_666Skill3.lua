local bs_208004 = class("bs_208004", LuaSkillBase)
local base = LuaSkillBase
bs_208004.config = {
  effectId_hit = 208014,
  effectId_role = 208013,
  actionId_start_time = 15,
  actionId_end_time = 45,
  actionId_start = 1028,
  actionId_loop = 1029,
  actionId_end = 1030,
  action_speed = 1,
  buffId_lockCd = 170,
  buffId = 208005,
  hurtResultId = 44,
  selectId = 10001
}

function bs_208004:ctor()
end

function bs_208004:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_208004_1", 1, self.OnAfterHurt, nil, self.caster)
  self.playskill = false
end

function bs_208004:PlaySkill(data)
  self.hurtRecord = 0
  self.playskill = true
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, data)
  local time = self.config.actionId_start_time + self.config.actionId_end_time + self.arglist[1]
  self:CallCasterWait(time)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId_start, self.config.action_speed, self.config.actionId_start_time, attackTrigger)
  LuaSkillCtrl:StartTimer(nil, self.config.actionId_start_time, function()
    LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_loop, self.config.action_speed)
  end, nil)
  LuaSkillCtrl:StartTimer(nil, self.config.actionId_start_time + self.arglist[1], function()
    LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_end, self.config.action_speed)
  end, nil)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_lockCd, 1, time, true)
  self:AbandonSkillCdAutoReset(true)
end

function bs_208004:OnAttackTrigger(data)
  self.effectAtk = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_role, self, nil, nil, nil, true)
  LuaSkillCtrl:StartShowSkillDurationTime(self, self.arglist[1] + 3)
  local num = self.arglist[1] // 5 - 1
  LuaSkillCtrl:StartTimer(self, 5, function()
    local range = 2 - self.caster.attackRange
    local targetList = LuaSkillCtrl:CallTargetSelect(self, self.config.selectId, range)
    if targetList.Count > 0 then
      for i = 0, targetList.Count - 1 do
        local role = targetList[i].targetRole
        if role.belongNum ~= self.caster.belongNum and LuaSkillCtrl:IsAbleAttackTarget(self.caster, role, 2) then
          local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
          LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.hurtResultId, {
            self.arglist[2]
          })
          skillResult:EndResult()
          LuaSkillCtrl:CallEffect(role, self.config.effectId_hit, self)
        end
      end
    end
  end, self, num, 4)
  local callnextskill = BindCallback(self, self.EndSkillAndCallNext)
  LuaSkillCtrl:StartTimer(nil, self.arglist[1], callnextskill)
end

function bs_208004:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if self.playskill == true and target == self.caster and 0 < hurt then
    self.hurtRecord = self.hurtRecord + hurt
    local upper = self.caster.maxHp * self.arglist[3] // 1000
    if upper <= self.hurtRecord then
      self.hurtRecord = 0
      self.playskill = false
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, self.arglist[4])
      self:EndSkillAndCallNext()
    end
  end
end

function bs_208004:EndSkillAndCallNext()
  if self.effectAtk ~= nil then
    self.effectAtk:Die()
    self.effectAtk = nil
  end
  LuaSkillCtrl:DispelBuff(self.caster, 170, 0)
  if self.caster == nil then
    return
  end
  self.hurtRecord = 0
  self.playskill = false
  self:CancleCasterWait()
  local skillMgr = self.caster:GetSkillComponent()
  if skillMgr == nil then
    return
  end
  skillMgr.lastSkill = self.cskill
  self:CallNextBossSkill()
  LuaSkillCtrl:StopShowSkillDurationTime(self)
end

function bs_208004:OnCasterDie()
  LuaSkillCtrl:StopShowSkillDurationTime(self)
  base.OnCasterDie(self)
end

function bs_208004:LuaDispose()
  self.effectAtk = nil
  base.LuaDispose(self)
end

return bs_208004
