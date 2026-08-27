local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_109200 = class("bs_109200", bs_1)
local base = bs_1
bs_109200.config = {
  effectId_trail = 109201,
  HurtConfig = {
    hit_formula = 9991,
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
bs_109200.config = setmetatable(bs_109200.config, {
  __index = base.config
})

function bs_109200:ctor()
end

function bs_109200:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_109200:SkillEventFunc(configData, effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    if configData.audioId5 ~= nil then
      LuaSkillCtrl:PlayAuSource(target.targetRole, configData.audioId5)
    end
    if configData.Imp == true then
      LuaSkillCtrl:PlayAuHit(self, target)
    end
    if self.caster.recordTable.atk == true then
      local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
      LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig)
      skillResult:EndResult()
    else
      local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
      LuaSkillCtrl:HurtResult(self, skillResult, generalHurtConfig)
      skillResult:EndResult()
    end
  end
end

function bs_109200:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_109200
