local bs_201811 = require("GamePlay.SkillScripts.MonsterSkill.201811_ZYZ_RefactorSummon")
local bs_201814 = class("bs_201814", bs_201811)
local base = bs_201811
bs_201814.config = {
  middleMonsterId = {
    7,
    9,
    10
  },
  maxHpPer = 210,
  powPer = 750
}
bs_201814.config = setmetatable(bs_201814.config, {
  __index = base.config
})

function bs_201814:ctor()
end

function bs_201814:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_201814:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_201814
