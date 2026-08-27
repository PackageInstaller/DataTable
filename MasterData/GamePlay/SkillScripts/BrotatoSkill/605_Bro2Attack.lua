local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_605 = class("bs_605", bs_1)
local base = bs_1
bs_605.config = {
  effectId_skill = 60403,
  effectId_w = 60402,
  Hurt_config = {
    hit_formula = 0,
    basehurt_formula = 502,
    crit_formula = 0,
    returndamage_formula = 0
  },
  buffIdBro = 60401,
  Time = 5,
  radius = 10,
  spd = 1
}
bs_605.config = setmetatable(bs_605.config, {
  __index = base.config
})

function bs_605:ctor()
end

function bs_605:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_605:RealPlaySkill(target, data)
  LuaSkillCtrl:CallBuff(self, self.caster, 170, 1, self.config.Time)
  self:CallCasterWait(self.config.Time)
  self.caster:LookAtTarget(target)
end

function bs_605:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_605
