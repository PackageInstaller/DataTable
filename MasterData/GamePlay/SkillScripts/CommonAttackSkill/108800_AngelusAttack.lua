local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_108800 = class("bs_108800", bs_1)
local base = bs_1
bs_108800.config = {
  effectId_trail_1 = 108803,
  effectId_trail_2 = 108801,
  HurtConfigID = 10,
  HurtConfig = {
    hit_formula = 1,
    def_formula = 9996,
    basehurt_formula = 9988,
    minhurt_formula = 9994,
    crit_formula = 9992,
    crithur_ratio = 9995,
    correct_formula = 9989,
    lifesteal_formula = 1001,
    spell_lifesteal_formula = 1002,
    returndamage_formula = 1000,
    hurt_type = 1
  }
}
bs_108800.config = setmetatable(bs_108800.config, {
  __index = base.config
})

function bs_108800:ctor()
end

function bs_108800:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_108800:ExecuteEffectAttack(data, atkActionId, target, effectId1, effectId2)
  if self.caster.recordTable.atk2 == true then
    LuaSkillCtrl:CallEffectWithArg(target, self.config.effectId_trail_1, self, nil, false, self.SkillEventFunc, data)
  else
    LuaSkillCtrl:CallEffectWithArg(target, self.config.effectId_trail_2, self, nil, false, self.SkillEventFunc, data)
  end
end

function bs_108800:SkillEventFunc(configData, effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger and effect.dataId == self.config.effectId_trail_1 then
    if configData.audioId5 ~= nil then
      LuaSkillCtrl:PlayAuSource(target.targetRole, configData.audioId5)
    end
    if configData.Imp == true then
      LuaSkillCtrl:PlayAuHit(self, target)
    end
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig)
    skillResult:EndResult()
  end
  if eventId == eBattleEffectEvent.Trigger and effect.dataId == self.config.effectId_trail_2 then
    if configData.audioId5 ~= nil then
      LuaSkillCtrl:PlayAuSource(target.targetRole, configData.audioId5)
    end
    if configData.Imp == true then
      LuaSkillCtrl:PlayAuHit(self, target)
    end
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResult(self, skillResult, generalHurtConfig)
    skillResult:EndResult()
  end
end

function bs_108800:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_108800
