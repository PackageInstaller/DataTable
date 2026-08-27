local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_542 = class("bs_542", bs_1)
local base = bs_1
bs_542.config = {
  buffId_110 = 204203,
  buffId_111 = 204204,
  buffId_112 = 104008,
  effectId_trail = 204200,
  effectId_trail_ex = 204209,
  select_id = 9,
  select_range2 = 20,
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 3010,
    crit_formula = 0,
    crithur_ratio = 0,
    lifesteal_formula = 0,
    spell_lifesteal_formula = 0,
    returndamage_formula = 0
  }
}
bs_542.config = setmetatable(bs_542.config, {
  __index = base.config
})

function bs_542:ctor()
end

function bs_542:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.num_buff = 1
end

function bs_542:SkillEventFunc(configData, effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    if configData.audioId5 ~= nil then
      LuaSkillCtrl:PlayAuSource(target.targetRole, configData.audioId5)
    end
    if configData.Imp == true then
      LuaSkillCtrl:PlayAuHit(self, target)
    end
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResult(self, skillResult, generalHurtConfig)
    skillResult:EndResult()
    self:CallBuff(target.targetRole)
  end
end

function bs_542:CallBuff(target)
  local arg = self.caster.recordTable.arg
  if self.num_buff == 1 then
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId_110, 1, arg)
    self.num_buff = 2
    return
  end
  if self.num_buff == 2 then
    LuaSkillCtrl:CallBuffRepeated(self, target, self.config.buffId_111, 1, arg, false, false, self.OnBuffExecute)
    self.num_buff = 3
    return
  end
  if self.num_buff == 3 then
    LuaSkillCtrl:CallBuffRepeated(self, target, self.config.buffId_112, 1, arg, false, false, self.OnBuffExecute2)
    self.num_buff = 1
    return
  end
end

function bs_542:OnBuffExecute(buff, targetRole)
  if self.caster == nil or self.caster.hp <= 0 then
    return
  end
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
  LuaSkillCtrl:PlayAuHit(self, targetRole)
  local skillValue = 100 * buff.tier
  LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {skillValue}, true)
  skillResult:EndResult()
end

function bs_542:OnBuffExecute2(buff, targetRole)
  if self.caster == nil or self.caster.hp <= 0 then
    return
  end
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
  LuaSkillCtrl:PlayAuHit(self, targetRole)
  local skillValue2 = 100 * buff.tier
  LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {skillValue2}, true)
  skillResult:EndResult()
end

function bs_542:OnCasterDie()
  base.OnCasterDie(self)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, self.config.select_id, self.config.select_range2)
  if targetList.Count > 0 then
    for i = 0, targetList.Count - 1 do
      local buffrole = targetList[i].targetRole
      if 0 < buffrole.hp then
        LuaSkillCtrl:DispelBuff(buffrole, self.config.buffId_110, 1, true)
        LuaSkillCtrl:DispelBuff(buffrole, self.config.buffId_111, 1, true)
        LuaSkillCtrl:DispelBuff(buffrole, self.config.buffId_112, 1, true)
      end
    end
  end
end

return bs_542
