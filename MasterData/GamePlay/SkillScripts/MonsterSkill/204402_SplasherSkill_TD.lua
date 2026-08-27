local bs_204401 = require("GamePlay.SkillScripts.MonsterSkill.204401_SplasherSkill")
local bs_204402 = class("bs_204402", bs_204401)
local base = bs_204401
bs_204402.config = {selectId = 43}
bs_204402.config = setmetatable(bs_204402.config, {
  __index = base.config
})

function bs_204402:ctor()
end

function bs_204402:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_204402:CallEffectAndEmissions(target)
  LuaSkillCtrl:CallEffect(target, self.config.effectid_Hurt, self, self.SkillEventFunc)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectid_start, self)
end

function bs_204402:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    if target == nil or target.targetRole.hp <= 0 or target.targetRole:IsTowerLoadOff() then
      return
    end
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {
      self.arglist[1]
    }, false)
    LuaSkillCtrl:CallEffect(target, self.config.effectid_Sj, self)
    skillResult:EndResult()
  end
end

function bs_204402:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_204402
