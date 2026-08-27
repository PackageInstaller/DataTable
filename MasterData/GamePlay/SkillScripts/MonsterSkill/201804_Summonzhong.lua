local bs_201801 = require("GamePlay.SkillScripts.MonsterSkill.201801_ZYZ_RefactorSummon")
local bs_201804 = class("bs_201804", bs_201801)
local base = bs_201801
bs_201804.config = {
  middleMonsterId = {
    7,
    9,
    10
  },
  maxHpPer = 210,
  powPer = 750
}
bs_201804.config = setmetatable(bs_201804.config, {
  __index = base.config
})

function bs_201804:ctor()
end

function bs_201804:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_201804:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_201804
