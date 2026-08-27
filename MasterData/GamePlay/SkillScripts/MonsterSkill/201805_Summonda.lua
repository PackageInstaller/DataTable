local bs_201801 = require("GamePlay.SkillScripts.MonsterSkill.201801_ZYZ_RefactorSummon")
local bs_201805 = class("bs_201805", bs_201801)
local base = bs_201801
bs_201805.config = {
  middleMonsterId = {
    9,
    10,
    19
  },
  maxHpPer = 250,
  powPer = 800
}
bs_201805.config = setmetatable(bs_201805.config, {
  __index = base.config
})

function bs_201805:ctor()
end

function bs_201805:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_201805:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_201805
