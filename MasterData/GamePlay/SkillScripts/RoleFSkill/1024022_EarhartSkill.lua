local bs_1024022 = class("bs_1024022", LuaSkillBase)
local base = LuaSkillBase
bs_1024022.config = {
  buffId_236 = 236,
  buffId_196 = 196,
  buffId_170 = 170,
  skill_time = 20,
  effectId_DDL = 10744,
  Aoe = {
    effect_shape = 3,
    aoe_select_code = 5,
    aoe_range = 1
  },
  HurtConfig = {
    hit_formula = 0,
    basehurt_formula = 3010,
    crit_formula = 0
  },
  start_time = 20,
  actionId = 1002,
  actionId_end = 1009,
  action_speed = 1,
  end_time = 32,
  audioId1 = 246,
  audio_loop = 247
}

function bs_1024022:ctor()
end

function bs_1024022:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.BeforeBattleEnd, "bs_1024022_1", 1, self.BeforeEndBattle)
  self.DD = 0
  self.caster.recordTable.skill_arg1 = self.arglist[1]
  self.caster.recordTable.cskill = self.cskill
end

function bs_1024022:PlaySkill(data)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger)
  self:CallCasterWait(self.config.skill_time)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.start_time, attackTrigger)
  LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId1)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_170, 1, self.config.start_time + self.arglist[2], true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_196, 1, self.config.start_time + self.arglist[2], true)
  self.action = true
end

function bs_1024022:OnAttackTrigger()
  self.action = false
  LuaSkillCtrl:StartShowSkillDurationTime(self, self.arglist[2])
  local over = BindCallback(self, self.Onover)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_236, 1, self.arglist[2], true)
  self.loopAudio = LuaSkillCtrl:PlayAuSource(self.caster, self.config.audio_loop)
  local last_target = self.caster.recordTable.lastAttackRole
  local target
  if last_target ~= nil and last_target.hp > 0 and last_target.belongNum ~= eBattleRoleBelong.neutral and last_target:IsUnSelect(self.caster) ~= true then
    target = last_target
  else
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 1001, 0)
    if 0 < targetList.Count then
      target = targetList[0].targetRole
    end
  end
  if target ~= nil then
    LuaSkillCtrl:CallEffect(target, self.config.effectId_DDL, self, self.SkillEventFunc)
  end
  self.onOverTimer = LuaSkillCtrl:StartTimer(nil, self.arglist[2], over)
end

function bs_1024022:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target.targetRole, self.config.Aoe)
    LuaSkillCtrl:PlayAuHit(self, target)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig, {
      self.arglist[3]
    })
    skillResult:EndResult()
  end
end

function bs_1024022:Onover()
  if self.loopAudio ~= nil then
    LuaSkillCtrl:StopAudioByBack(self.loopAudio)
    self.loopAudio = nil
  end
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_196, 1, true)
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_170, 1, true)
  self:CallCasterWait(self.config.end_time)
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_end)
end

function bs_1024022:OnBreakSkill(role)
  if role == self.caster and self.action == true then
    self.action = false
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_196, 1, true)
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_170, 1, true)
    self:CancleCasterWait()
  end
  if self.loopAudio ~= nil then
    LuaSkillCtrl:StopAudioByBack(self.loopAudio)
    self.loopAudio = nil
  end
  base.OnBreakSkill(self, role)
end

function bs_1024022:BeforeEndBattle()
  if self.loopAudio ~= nil then
    LuaSkillCtrl:StopAudioByBack(self.loopAudio)
    self.loopAudio = nil
  end
end

function bs_1024022:OnCasterDie()
  if self.loopAudio ~= nil then
    LuaSkillCtrl:StopAudioByBack(self.loopAudio)
    self.loopAudio = nil
  end
  if self.onOverTimer ~= nil then
    self.onOverTimer:Stop()
    self.onOverTimer = nil
  end
  base.OnCasterDie(self)
end

return bs_1024022
