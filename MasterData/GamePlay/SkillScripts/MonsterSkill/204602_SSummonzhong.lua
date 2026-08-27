local bs_201801 = require("GamePlay.SkillScripts.MonsterSkill.201801_ZYZ_RefactorSummon")
local bs_204602 = class("bs_204602", bs_201801)
local base = bs_201801
bs_204602.config = {
  middleMonsterId = {
    21,
    22,
    23
  },
  maxHpPer = 210,
  powPer = 750
}
bs_204602.config = setmetatable(bs_204602.config, {
  __index = base.config
})

function bs_204602:ctor()
end

function bs_204602:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_204602:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_204602
