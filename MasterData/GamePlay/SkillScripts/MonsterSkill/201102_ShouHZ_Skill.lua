local bs_40028 = class("bs_40028", LuaSkillBase)
local base = LuaSkillBase
bs_40028.config = {
  effectId = 10217,
  buffId_1036 = 1036,
  audioId1 = 82,
  audioId2 = 83,
  healConfig = {baseheal_formula = 10101},
  start_time = 13,
  startAnimId = 1008,
  start_time2 = 15,
  startAnimId2 = 1007,
  skill_time = 31,
  loopAnimId1 = 1009,
  quitAnimId = 100
}

function bs_40028:ctor()
end

function bs_40028:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.BeforeBattleEnd, "bs_40028_3", 1, self.BeforeEndBattle)
  self.loopaudio = nil
  self.loop = nil
end

function bs_40028:PlaySkill(data)
  local time = 16 + self.arglist[1] + self.config.skill_time
  self:CallCasterWait(time)
  local callback = BindCallback(self, self.Oncallback)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_1036, 1, self.arglist[1] + self.config.start_time)
  LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId1)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.startAnimId, 1, self.config.start_time, callback)
end

function bs_40028:Oncallback()
  LuaSkillCtrl:StartShowSkillDurationTime(self, self.arglist[1])
  self.loop = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self, nil, nil, nil, true)
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.startAnimId2)
  local is_loop = self.arglist[1] // self.arglist[3] - 1
  local callback2 = BindCallback(self, self.Oncallback2)
  LuaSkillCtrl:StartTimer(nil, self.arglist[3], callback2, self, is_loop)
  LuaSkillCtrl:StartTimer(nil, self.arglist[1] - 1, function()
    if self.caster ~= nil and self.caster:GetBuffTier(self.config.buffId_1036) > 0 then
      LuaSkillCtrl:StartTimer(nil, self.config.start_time2, function()
        if self.loop ~= nil then
          self.loop:Die()
          self.loop = nil
        end
      end)
      LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_1036, 1)
      LuaSkillCtrl:CallRoleAction(self.caster, self.config.loopAnimId1)
      LuaSkillCtrl:StartTimer(nil, self.config.skill_time, function()
        LuaSkillCtrl:CallRoleAction(self.caster, self.config.quitAnimId)
        LuaSkillCtrl:StopAudioByBack(self.loopaudio)
      end)
    end
  end)
end

function bs_40028:Oncallback2()
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster)
  LuaSkillCtrl:HealResult(skillResult, self.config.healConfig)
  skillResult:EndResult()
end

function bs_40028:OnBreakSkill(role)
  base.OnBreakSkill(self, role)
  LuaSkillCtrl:StopShowSkillDurationTime(self)
  if role == self.caster then
    LuaSkillCtrl:DispelBuff(role, self.config.buffId_1036, 1)
    LuaSkillCtrl:CallRoleAction(self.caster, self.config.quitAnimId)
    self:CancleCasterWait()
    if self.loop ~= nil then
      self.loop:Die()
      self.loop = nil
    end
    if self.loopaudio ~= nil then
      LuaSkillCtrl:StopAudioByBack(self.loopaudio)
      self.loopaudio = nil
    end
  end
end

function bs_40028:BeforeEndBattle()
  if self.loopaudio ~= nil then
    LuaSkillCtrl:StopAudioByBack(self.loopaudio)
    self.loopaudio = nil
  end
end

function bs_40028:OnCasterDie()
  base.OnCasterDie(self)
  if self.loopaudio ~= nil then
    LuaSkillCtrl:StopAudioByBack(self.loopaudio)
    self.loopaudio = nil
  end
  LuaSkillCtrl:StopShowSkillDurationTime(self)
end

function bs_40028:LuaDispose()
  base.LuaDispose(self)
  self.loopaudio = nil
  self.loop = nil
end

return bs_40028
