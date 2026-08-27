local bs_201811 = require("GamePlay.SkillScripts.MonsterSkill.201811_ZYZ_RefactorSummon")
local bs_201815 = class("bs_201815", bs_201811)
local base = bs_201811
bs_201815.config = {
  middleMonsterId = {
    9,
    10,
    19
  },
  maxHpPer = 250,
  powPer = 800
}
bs_201815.config = setmetatable(bs_201815.config, {
  __index = base.config
})

function bs_201815:ctor()
end

function bs_201815:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_201815:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_201815
