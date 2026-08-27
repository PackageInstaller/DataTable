local bs_2004031 = class("bs_2004031", LuaSkillBase)
local base = LuaSkillBase
bs_2004031.config = {
  hurt_config = {
    basehurt_formula = 10007,
    hit_formula = 10201,
    crit_formula = 0,
    correct_formula = 9989
  },
  aoe_config = {
    effect_shape = 3,
    aoe_select_code = 4,
    aoe_range = 1
  },
  effectId = 10101,
  hitEffectId = 10100,
  buffId_66 = 66,
  buffId_151 = 151,
  buffTier = 1,
  startAnimID = 1002,
  audioId1 = 53,
  skill_time = 50,
  start_time = 7,
  skill_speed = 1,
  strikeBackTime = 3,
  timeDuration = 15
}

function bs_2004031:ctor()
end

function bs_2004031:InitSkill(isMidwaySkill)
  self.totalTime = 1800
  self.timeValue = self.totalTime
  LuaSkillCtrl:SetGameScoreAcitve(2, true)
  LuaSkillCtrl:SetGameScoreValue(2, self.timeValue // 15)
  local arriveCallBack = BindCallback(self, self.OnArriveAction)
  LuaSkillCtrl:StartTimer(nil, self.config.timeDuration, arriveCallBack, self, -1)
  local timeCallBack = BindCallback(self, self.TimeUp)
  LuaSkillCtrl:StartTimer(nil, self.totalTime, timeCallBack)
  LuaSkillCtrl:RecordLimitTime(self.totalTime)
end

function bs_2004031:OnArriveAction()
  self.timeValue = self.timeValue - self.config.timeDuration
  local showTime = self.timeValue // 15
  LuaSkillCtrl:SetGameScoreValue(2, showTime)
end

function bs_2004031:TimeUp()
  LuaSkillCtrl:ForceEndBattle(false)
end

function bs_2004031:PlaySkill(data)
  LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId1)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, self.caster, data)
  self:CallCasterWait(self.config.skill_time)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self, nil, nil, nil, true)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.startAnimID, self.config.skill_speed, self.config.start_time, attackTrigger)
end

function bs_2004031:OnAttackTrigger(target, data)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target, self.config.aoe_config)
  LuaSkillCtrl:PlayAuHit(self, target)
  if target.hp > 0 then
    skillResult:BuffResult(self.config.buffId_151, self.config.buffTier, self.config.strikeBackTime)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config)
  end
  if 0 < skillResult.roleList.Count then
    for i = 0, skillResult.roleList.Count - 1 do
      local role = skillResult.roleList[i]
      LuaSkillCtrl:CallEffect(role, self.config.hitEffectId, self)
    end
  end
  skillResult:EndResult()
end

function bs_2004031:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_2004031
