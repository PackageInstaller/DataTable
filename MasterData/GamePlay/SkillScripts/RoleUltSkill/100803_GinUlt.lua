local bs_100803 = class("bs_100803", LuaSkillBase)
local base = LuaSkillBase
bs_100803.config = {
  effectId_start = 100804,
  effectId_line = 100805,
  buffId_100802 = 100802,
  buffId_Super = 3003,
  audioIdStart = 100805,
  audioIdMovie = 100806,
  audioIdEnd = 100807,
  movieEndRoleActionId = 1006,
  aoe_config = {
    effect_shape = 1,
    aoe_select_code = 3,
    aoe_range = 10
  },
  heal_config = {
    baseheal_formula = 100801,
    heal_number = 0,
    crit_formula = 0,
    crithur_ratio = 0,
    correct_formula = 9990
  },
  heal_configF = {
    baseheal_formula = 100802,
    heal_number = 0,
    crit_formula = 0,
    crithur_ratio = 0,
    correct_formula = 9990
  }
}

function bs_100803:ctor()
end

function bs_100803:InitSkill(isMidwaySkill)
  self.hurt_config = {}
  self.buff_during_time = self.arglist[2]
end

function bs_100803:PlaySkill(data)
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:CallCasterWait(20)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_start, self, self.SkillEventFunc, nil, 0.5)
  LuaSkillCtrl:CallBattleCamShake()
end

function bs_100803:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target, self.config.aoe_config)
    if skillResult.roleList.Count >= 2 then
      for i = 0, skillResult.roleList.Count - 1 do
        if i == skillResult.roleList.Count - 1 then
          LuaSkillCtrl:CallEffect(skillResult.roleList[i], self.config.effectId_line, self, nil, skillResult.roleList[0])
        else
          LuaSkillCtrl:CallEffect(skillResult.roleList[i + 1], self.config.effectId_line, self, nil, skillResult.roleList[i])
        end
      end
    end
    local healCfg
    if self:IsConsumeSkill() then
      healCfg = self.config.heal_configF
    else
      healCfg = self.config.heal_config
    end
    skillResult:HealResult(healCfg)
    skillResult:EndResult()
  end
end

function bs_100803:PlayUltEffect()
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_Super, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_100803:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie, self)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005)
end

function bs_100803:OnSkipUltView()
  base.OnSkipUltView(self)
end

function bs_100803:OnMovieFadeOut()
  base.OnMovieFadeOut(self)
end

function bs_100803:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_100803
