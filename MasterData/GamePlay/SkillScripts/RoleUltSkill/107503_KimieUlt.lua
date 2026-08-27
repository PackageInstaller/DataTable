local bs_107503 = class("bs_107503", LuaSkillBase)
local base = LuaSkillBase
bs_107503.config = {
  effectId_line = 107512,
  actionId_start = 1005,
  actionId_end = 1006,
  skillSelectId = 9,
  exRoleNum = 2,
  loopTime = 2,
  buffId_Super = 3003,
  hurtConfig = {
    hit_formula = 0,
    basehurt_formula = 3010,
    crit_formula = 0
  },
  shieldFormula = 3021,
  angryId = 107507,
  delay = 10,
  buffId_angry_1 = 107508,
  buffId_angry_2 = 107509,
  buffId_angry_3 = 107510,
  buff_anti_ultskill = 105205,
  audioIdStart = 107507,
  audioIdMovie = 107508
}

function bs_107503:ctor()
end

function bs_107503:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.audio = nil
end

function bs_107503:PlaySkill(data, selectTargetCoord, selectRoles, selectRolesType)
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:CallCasterWait(45)
  LuaSkillCtrl:CallBattleCamShake()
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_end)
  self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute), selectRolesType)
end

function bs_107503:CallSelectExecute(role)
  if role ~= nil then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buff_anti_ultskill, 1, 45, true)
    if not LuaSkillCtrl.IsInVerify then
      self.audio = AudioManager:PlayAudioById(107509)
    end
    LuaSkillCtrl:StartTimer(self, 45, function()
      if self.audio ~= nil and not LuaSkillCtrl.IsInVerify then
        AudioManager:StopAudioByBack(self.audio)
        self.audio = nil
      end
    end, nil)
    LuaSkillCtrl:StartTimer(self, self.config.delay, function()
      if role.isDead == false then
        self:FireEffect(self.config.exRoleNum, role)
      else
        self:FireEffect(self.config.exRoleNum + 1, nil)
      end
    end, self, self.config.loopTime)
  end
end

function bs_107503:FireEffect(loopTime, roleLess)
  LuaSkillCtrl:StartTimer(self, 3, function()
    if roleLess == nil then
      local role = LuaSkillCtrl:CallTargetSelect(self, self.config.skillSelectId, 10)
      if role.Count > 0 then
        local roleNew = role[0].targetRole
        for i = 1, role.Count - 1 do
          if role[i].targetRole.belongNum ~= 0 and roleNew:GetBuffTier(self.config.angryId) > role[i].targetRole:GetBuffTier(self.config.angryId) then
            roleNew = role[i].targetRole
          end
        end
        roleLess = roleNew
      end
    end
    if roleLess ~= nil then
      LuaSkillCtrl:CallEffectWithArg(roleLess, self.config.effectId_line, self, nil, false, self.SkillEventFunc)
      LuaSkillCtrl:CallBuff(self, roleLess, self.config.angryId, 1, self.arglist[5], true)
      roleLess = nil
    end
  end, nil, loopTime)
end

function bs_107503:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger and self.caster ~= nil and self.caster.hp > 0 then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurtConfig, {
      self.arglist[1]
    })
    skillResult:EndResult()
    local buffTier = target.targetRole:GetBuffTier(self.config.angryId)
    if 4 < buffTier then
      LuaSkillCtrl:CallBuff(self, target.targetRole, self.config.buffId_angry_3, 1, self.arglist[5], true)
    elseif 2 < buffTier and buffTier < 5 then
      LuaSkillCtrl:CallBuff(self, target.targetRole, self.config.buffId_angry_2, 1, self.arglist[5], true)
    else
      LuaSkillCtrl:CallBuff(self, target.targetRole, self.config.buffId_angry_1, 1, self.arglist[5], true)
    end
  end
end

function bs_107503:PlayUltEffect(data, selectTargetCoord, selectRoles)
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_Super, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_107503:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, 8, self.PlayUltMovie, self)
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_start)
end

function bs_107503:OnSkipUltView()
  base.OnSkipUltView(self)
end

function bs_107503:OnMovieFadeOut()
  base.OnMovieFadeOut(self)
end

function bs_107503:OnCasterDie()
  base.OnCasterDie(self)
  if self.audio ~= nil then
    AudioManager:StopAudioByBack(self.audio)
    self.audio = nil
  end
end

function bs_107503:LuaDispose()
  base.LuaDispose(self)
  self.audio = nil
end

return bs_107503
