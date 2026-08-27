local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_704 = class("bs_704", bs_1)
local base = bs_1
bs_704.config = {
  buffId_110 = 204203,
  buffId_111 = 204204,
  buffId_112 = 104008,
  effectId_trail = 204200,
  effectId_trail_ex = 204209,
  effectId_sign = 210201,
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
bs_704.config = setmetatable(bs_704.config, {
  __index = base.config
})

function bs_704:ctor()
end

function bs_704:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_704", 1, self.OnAfterBattleStart)
  self.num_buff = 1
end

function bs_704:OnAfterBattleStart()
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_sign, self)
end

function bs_704:SkillEventFunc(configData, effect, eventId, target)
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

function bs_704:CallBuff(target)
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

function bs_704:OnBuffExecute(buff, targetRole)
  if self.caster == nil or self.caster.hp <= 0 then
    return
  end
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
  LuaSkillCtrl:PlayAuHit(self, targetRole)
  local skillValue = 100 * buff.tier
  LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {skillValue}, true)
  skillResult:EndResult()
end

function bs_704:OnBuffExecute2(buff, targetRole)
  if self.caster == nil or self.caster.hp <= 0 then
    return
  end
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
  LuaSkillCtrl:PlayAuHit(self, targetRole)
  local skillValue2 = 100 * buff.tier
  LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {skillValue2}, true)
  skillResult:EndResult()
end

function bs_704:OnCasterDie()
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

return bs_704
