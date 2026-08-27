local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_104000 = class("bs_104000", bs_1)
local base = bs_1
bs_104000.config = {
  actionId_1 = 1022,
  actionId_end_1 = 1024,
  actionId_end_1_time = 27,
  actionId_2 = 1028,
  actionId_end_2 = 1030,
  actionId_end_2_time = 35,
  effectId_line = 104001,
  effectId_line_hit = 104002,
  Aoe_2 = {
    effect_shape = 3,
    aoe_select_code = 4,
    aoe_range = 2
  },
  Aoe_all = {
    effect_shape = 3,
    aoe_select_code = 4,
    aoe_range = 10
  },
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 3010,
    crit_formula = 0,
    returndamage_formula = 0
  },
  effectId_big = 104002,
  effectId_small = 104001,
  buffId_attack = 104006,
  buffId_skill = 104007,
  audioId1 = 104008,
  audioId2 = 104008,
  audioId_hit = 104002
}
bs_104000.config = setmetatable(bs_104000.config, {
  __index = base.config
})

function bs_104000:ctor()
end

function bs_104000:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable.cs_Skill = self.cskill
end

function bs_104000:OnAttackTrigger(target, data)
  if self.caster.recordTable.skill_open == true then
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_big, self, self.SkillEventFunc)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_skill, 1, 1)
  else
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_small, self, self.SkillEventFunc)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_attack, 1, 1)
  end
end

function bs_104000:SkillEventFunc(effect, eventId, target)
  if eventId ~= eBattleEffectEvent.Create then
    return
  end
  if self.caster.recordTable.skill_open == true then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target, self.config.Aoe_all)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {
      self.caster.recordTable["arglist[3]"]
    })
    skillResult:EndResult()
    LuaSkillCtrl:PlayAuSource(target.targetRole, self.config.audioId_hit)
  else
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target, self.config.Aoe_2)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {
      self.caster.recordTable["arglist[3]"]
    })
    skillResult:EndResult()
    LuaSkillCtrl:PlayAuSource(target.targetRole, self.config.audioId_hit)
  end
end

function bs_104000:OnBreakSkill(role)
  if role == self.caster then
    self.caster.recordTable.lastAttackRole = nil
  end
end

function bs_104000:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_104000
