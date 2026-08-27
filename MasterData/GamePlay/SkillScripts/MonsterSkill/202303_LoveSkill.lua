local bs_202303 = class("bs_202303", LuaSkillBase)
local base = LuaSkillBase
bs_202303.config = {
  antion1 = 1008,
  antion2 = 1007,
  antion3 = 1009,
  effectHithurt = 10491,
  effectHitheal = 10491,
  effectId = 10492,
  buffId_196 = 196,
  HurtConfig = {
    hit_formula = 0,
    basehurt_formula = 10077,
    crit_formula = 0
  },
  HealConfig = {baseheal_formula = 10083},
  skill_time = 80,
  start_time = 24,
  skill_range = 2,
  select_enemy_id = 24,
  select_hero_id = 42,
  skill_interval = 6,
  hurt_delay = 5,
  heal_delay = 3,
  over_time = 48,
  audio_loop = 358,
  audioId1 = 309,
  audioId2 = 310
}

function bs_202303:ctor()
end

function bs_202303:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_202303:PlaySkill(data)
  self:CallCasterWait(self.config.skill_time)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.antion1, 1, self.config.start_time, attackTrigger)
  self.loop = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self, nil, nil, nil, true)
  self.loopaudio = LuaSkillCtrl:PlayAuSource(self.caster, self.config.audio_loop)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_196, 1, self.config.skill_time + 5)
end

function bs_202303:OnAttackTrigger()
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.antion2)
  local hurt = BindCallback(self, self.Onhurt)
  local heal = BindCallback(self, self.Onheal)
  local Over = BindCallback(self, self.OnOver)
  LuaSkillCtrl:StartTimer(self, self.config.skill_interval, hurt, self, self.arglist[1] - 1, self.config.hurt_delay)
  LuaSkillCtrl:StartTimer(self, self.config.skill_interval, heal, self, self.arglist[1] - 1, self.config.heal_delay)
  LuaSkillCtrl:StartTimer(self, 48, Over, self)
end

function bs_202303:Onhurt()
  local range = self.config.skill_range - self.caster.attackRange
  local target_hurt = LuaSkillCtrl:CallTargetSelect(self, self.config.select_hero_id, range)
  if target_hurt.Count > 0 then
    LuaSkillCtrl:CallEffect(target_hurt[0].targetRole, self.config.effectHithurt, self)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target_hurt[0].targetRole)
    LuaSkillCtrl:PlayAuSource(target_hurt[0].targetRole, self.config.audioId2)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig)
    skillResult:EndResult()
  end
end

function bs_202303:Onheal()
  local range = self.config.skill_range - self.caster.attackRange
  local target_heal = LuaSkillCtrl:CallTargetSelect(self, self.config.select_enemy_id, range)
  local _healtarget
  if target_heal.Count > 0 then
    local _target = target_heal[0].targetRole
    _healtarget = _target
    if _target.roleDataId == 15 and target_heal[1].targetRole ~= nil then
      _healtarget = target_heal[1].targetRole
    end
    if _target.roleDataId == 15 and target_heal[1].targetRole == nil then
      _healtarget = self.caster
    end
  end
  if _healtarget == nil then
    _healtarget = self.caster
  end
  LuaSkillCtrl:CallEffect(_healtarget, self.config.effectHitheal, self)
  LuaSkillCtrl:PlayAuSource(_healtarget, self.config.audioId1)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, _healtarget)
  LuaSkillCtrl:HealResult(skillResult, self.config.HealConfig)
  skillResult:EndResult()
end

function bs_202303:OnOver()
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.antion3)
  if self.loop ~= nil then
    self.loop:Die()
    self.loop = nil
  end
  if self.loopaudio ~= nil then
    LuaSkillCtrl:StopAudioByBack(self.loopaudio)
    self.loopaudio = nil
  end
  LuaSkillCtrl:StartTimer(self, 5, function()
    self:CancleCasterWait()
  end)
end

function bs_202303:OnBreakSkill(role)
  base.OnBreakSkill(self, role)
end

function bs_202303:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_202303:LuaDispose()
  base.LuaDispose(self)
  self.loop = nil
  self.loopaudio = nil
end

return bs_202303
