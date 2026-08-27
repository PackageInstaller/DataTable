local bs_208602 = class("bs_208602", LuaSkillBase)
local base = LuaSkillBase
bs_208602.config = {
  buffId_192 = 208602,
  effectId_skill = 208604,
  effectId_end = 208601,
  effectId_hit = 208602,
  radius = 50,
  spd = 15,
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 3010,
    crit_formula = 0,
    returndamage_formula = 0
  }
}

function bs_208602:ctor()
end

function bs_208602:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable["208601_hurt"] = self.arglist[1]
end

function bs_208602:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_208602
