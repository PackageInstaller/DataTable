local bs_1026022 = class("bs_1026022", LuaSkillBase)
local base = LuaSkillBase
bs_1026022.config = {
  effectId_start = 10721,
  effectId2 = 10724,
  effectId = 100802,
  HurtConfig = {
    hit_formula = 0,
    basehurt_formula = 10077,
    crit_formula = 0
  },
  skill_time = 27,
  start_time = 10,
  actionId = 1002,
  action_speed = 1,
  buffId_232 = 23201,
  buffId_170 = 170,
  selectId = 47,
  effectId_heal = 100802,
  effectId_end = 102604,
  heal_config = {baseheal_formula = 3021},
  audioId1 = 257,
  audioId2 = 259
}

function bs_1026022:ctor()
end

function bs_1026022:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_1026022:PlaySkill(data)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger)
  self:CallCasterWait(self.config.skill_time)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.start_time, attackTrigger)
  LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId1)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_start, self)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_170, 1, self.arglist[1] + self.config.start_time, true)
end

function bs_1026022:OnAttackTrigger()
  LuaSkillCtrl:StartShowSkillDurationTime(self, self.arglist[1])
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_232, 1, self.arglist[1])
  local skill_heal = BindCallback(self, self.Onskillheal)
  local time = self.arglist[1] // 15 - 1
  LuaSkillCtrl:StartTimer(nil, 15, skill_heal, self, time, 13)
  local overHeal = BindCallback(self, self.onOverHeal)
  LuaSkillCtrl:StartTimer(nil, self.arglist[1], overHeal)
end

function bs_1026022:Onskillheal()
  local range = 3 - self.caster.attackRange
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, self.config.selectId, range)
  if targetlist.Count > 0 then
    for i = 0, targetlist.Count - 1 do
      local role = targetlist[i].targetRole
      if 0 < role.hp then
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
        LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, {
          self.arglist[2]
        })
        skillResult:EndResult()
      end
    end
  end
end

function bs_1026022:onOverHeal()
  LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId2)
  local range = 3 - self.caster.attackRange
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_end, self)
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, self.config.selectId, range)
  if targetlist.Count > 0 then
    for i = 0, targetlist.Count - 1 do
      local role = targetlist[i].targetRole
      if 0 < role.hp then
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
        LuaSkillCtrl:CallEffect(role, self.config.effectId_heal, self)
        LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, {
          self.arglist[3]
        })
        skillResult:EndResult()
      end
    end
  end
end

function bs_1026022:OnBreakSkill(role)
  if role == self.caster and self.isSkillUncompleted == true then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_170, 0, true)
  end
  base.OnBreakSkill(self, role)
end

function bs_1026022:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_1026022
