local bs_1015022 = class("bs_1015022", LuaSkillBase)
local base = LuaSkillBase
bs_1015022.config = {
  effectId_green = 101513,
  effectId_zong = 101502,
  effectId_role = 101512,
  actionId = 1002,
  action_speed = 1,
  skill_time = 72,
  start_time = 6,
  buffId_lockCd = 3008,
  buffId_Ult = 101501,
  audioId_hit = 101502,
  select_teammate = 14,
  select_teammate_range = 10,
  select_enermy = 19,
  select_enermy_range = 10,
  HurtConfig = {
    hit_formula = 0,
    basehurt_formula = 3010,
    crit_formula = 0
  },
  HealConfig = {baseheal_formula = 3021}
}

function bs_1015022:ctor()
end

function bs_1015022:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_1015022:PlaySkill(data)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, data)
  self:CallCasterWait(self.config.skill_time)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.start_time, attackTrigger)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_lockCd, 1, self.config.skill_time, true)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_role, self, nil, nil, nil, true)
end

function bs_1015022:OnAttackTrigger(data)
  LuaSkillCtrl:StartShowSkillDurationTime(self, self.config.skill_time - self.config.start_time)
  local num = self.arglist[1] - 1
  if self.caster:GetBuffTier(self.config.buffId_Ult) > 0 then
    num = num + self.caster.recordTable.Ult_skill_up
  end
  local time = 40 // num
  LuaSkillCtrl:StartTimer(self, time, function()
    local target_fr = LuaSkillCtrl:CallTargetSelect(self, self.config.select_teammate, self.config.select_teammate_range)
    if target_fr.Count > 0 then
      LuaSkillCtrl:CallEffect(target_fr[0].targetRole, self.config.effectId_green, self, self.SkillEventFunc)
    end
    local target_en_role
    local target_en = LuaSkillCtrl:CallTargetSelect(self, self.config.select_enermy, self.config.select_enermy_range)
    if target_en.Count > 0 and target_en[0].targetRole.intensity ~= 0 and target_en[0].targetRole.roleType ~= eBattleRoleType.realSummoner then
      target_en_role = target_en[0].targetRole
    else
      local target_en_ex = LuaSkillCtrl:CallTargetSelect(self, self.config.select_enermy, self.config.select_enermy_range)
      if target_en_ex.Count > 0 and target_en_ex[0].targetRole.intensity ~= 0 then
        target_en_role = target_en_ex[0].targetRole
      end
    end
    if target_en_role ~= nil and 0 < target_en_role.hp then
      LuaSkillCtrl:CallEffect(target_en_role, self.config.effectId_zong, self, self.SkillEventFunc)
    end
  end, self, num, time - 1)
end

function bs_1015022:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger and effect.dataId == self.config.effectId_zong then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId_hit)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig, {
      self.arglist[3]
    })
    skillResult:EndResult()
  end
  if eventId == eBattleEffectEvent.Trigger and effect.dataId == self.config.effectId_green then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HealResult(skillResult, self.config.HealConfig, {
      self.arglist[2]
    })
    skillResult:EndResult()
  end
end

function bs_1015022:OnBreakSkill(role)
  if role == self.caster then
    LuaSkillCtrl:StopShowSkillDurationTime(self)
    self:CancleCasterWait()
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_lockCd, 0, true)
  end
  base.OnBreakSkill(self, role)
end

function bs_1015022:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_1015022
