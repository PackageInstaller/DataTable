local bs_201812 = require("GamePlay.SkillScripts.MonsterSkill.201812_ZYZ_RefactorSummon")
local bs_201816 = class("bs_201816", bs_201812)
local base = bs_201812
bs_201816.config = {
  middleMonsterId = {
    9,
    10,
    19
  },
  maxHpPer = 250,
  powPer = 800
}
bs_201816.config = setmetatable(bs_201816.config, {
  __index = base.config
})

function bs_201816:ctor()
end

function bs_201816:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_201816:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_201816
