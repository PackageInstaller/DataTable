local bs_100403 = class("bs_100403", LuaSkillBase)
local base = LuaSkillBase
bs_100403.config = {
  effectId_start = 100405,
  effectId_end = 100406,
  buffId_Hiding_Simo = 100402,
  buffId_Dizz = 3006,
  heal_config = {baseheal_formula = 3022},
  start_time = 5,
  skill_time = 15,
  selectId = 6,
  selectrange = 10,
  actionId_start = 1005,
  movieEndRoleActionId = 1006,
  buffId_Super = 3003,
  audioIdStart = 100404,
  audioIdMovie = 100405,
  audioIdEnd = 100406
}

function bs_100403:ctor()
end

function bs_100403:InitSkill(isMidwaySkill)
  self.durTime = self.arglist[2]
  self.realTime = 0
  self.delay = 15
end

function bs_100403:PlaySkill(data)
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:CallCasterWait(self.config.skill_time)
  LuaSkillCtrl:StartTimer(self, self.config.start_time, function()
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_start, self)
    local targetList = LuaSkillCtrl:CallTargetSelect(self, self.config.selectId, self.config.selectrange)
    if targetList ~= nil and targetList.Count > 0 then
      for i = 0, targetList.Count - 1 do
        LuaSkillCtrl:CallEffect(targetList[i].targetRole, self.config.effectId_end, self, self.SkillEventFunc)
      end
    end
    local targetList1 = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
    if targetList1 ~= nil and targetList1.Count > 0 then
      for i = 0, targetList1.Count - 1 do
        LuaSkillCtrl:CallBuff(self, targetList1[i].targetRole, self.config.buffId_Dizz, 1, 1, true)
      end
    end
  end)
  LuaSkillCtrl:CallBattleCamShake()
end

function bs_100403:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:CallBuffRepeated(self, target.targetRole, self.config.buffId_Hiding_Simo, 1, self.arglist[2], nil, false, self.OnBuffExecute)
  end
end

function bs_100403:OnBuffExecute(buff, targetRole)
  if targetRole == nil or targetRole.hp <= 0 then
    return
  end
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
  LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, {
    self.arglist[1]
  }, true)
  skillResult:EndResult()
end

function bs_100403:PlayUltEffect()
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_100403:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_start)
end

function bs_100403:OnSkipUltView()
  base.OnSkipUltView(self)
end

function bs_100403:OnMovieFadeOut()
  base.OnMovieFadeOut(self)
end

function bs_100403:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_100403
