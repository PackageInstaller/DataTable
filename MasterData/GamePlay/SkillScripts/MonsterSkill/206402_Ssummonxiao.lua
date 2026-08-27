local bs_206403 = require("GamePlay.SkillScripts.MonsterSkill.206403_SSummonzhong")
local bs_206402 = class("bs_206402", bs_206403)
local base = bs_206403
bs_206402.config = {
  middleMonsterId = {
    20,
    21,
    22
  },
  maxHpPer = 180,
  powPer = 700
}
bs_206402.config = setmetatable(bs_206402.config, {
  __index = base.config
})

function bs_206402:ctor()
end

function bs_206402:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_206402:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_206402
