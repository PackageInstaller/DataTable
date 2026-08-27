local bs_104002 = class("bs_104002", LuaSkillBase)
local base = LuaSkillBase
bs_104002.config = {
  buffId_170 = 170,
  skill_time = 53,
  start_time = 22,
  actionId = 1002,
  action_speed = 1.5,
  effectId_big = 104002,
  effectId_small = 104001,
  buffId_1 = 104004,
  buffId_2 = 104005,
  buffId_09 = 104009,
  buffId_22 = 104012,
  selectId_player = 34,
  selectId_enemy = 33,
  Aoe_all = {
    effect_shape = 3,
    aoe_select_code = 4,
    aoe_range = 10
  },
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 3010,
    crit_formula = 0,
    crithur_ratio = 0,
    returndamage_formula = 0
  },
  buffId_skill = 104007,
  actionId_start = 104009,
  weaponLv = 0
}

function bs_104002:ctor()
end

function bs_104002:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable.skill_open = false
end

function bs_104002:PlaySkill(data)
  local skilltime = self.config.skill_time * 100 // (self.config.action_speed * 100)
  local starttime = self.config.start_time * 100 // (self.config.action_speed * 100)
  self:CallCasterWait(skilltime)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, starttime, attackTrigger)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_170, 1, self.arglist[1] + starttime, true)
end

function bs_104002:OnAttackTrigger()
  LuaSkillCtrl:StartShowSkillDurationTime(self, self.arglist[1])
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_09, 1, self.arglist[1])
  self.caster.recordTable.skill_open = true
  if self.openTimer ~= nil then
    self.openTimer:Stop()
    self.openTimer = nil
  end
  self.openTimer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], function()
    self.caster.recordTable.skill_open = false
    self:OnSkillDamageEnd()
  end)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_big, self, self.SkillEventFunc)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_skill, 1, 1)
end

function bs_104002:SkillEventFunc(effect, eventId, target)
  if eventId ~= eBattleEffectEvent.Create then
    return
  end
  if self.caster.recordTable.skill_open == true then
    local _Cskill = self.caster.recordTable.cs_Skill
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffectWithCSkill(_Cskill, target, self.config.Aoe_all)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {
      self.caster.recordTable["arglist[3]"]
    })
    skillResult:EndResult()
    LuaSkillCtrl:PlayAuSource(target, self.config.audioId_hit)
  end
end

function bs_104002:OnBreakSkill(role)
  if role == self.caster and self.isSkillUncompleted == true then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_170, 0, true)
  end
  base.OnBreakSkill(self, role)
end

function bs_104002:OnCasterDie()
  if self.openTimer ~= nil then
    self.openTimer:Stop()
    self.openTimer = nil
  end
  base.OnCasterDie(self)
end

return bs_104002
