local bs_201801 = require("GamePlay.SkillScripts.MonsterSkill.201801_ZYZ_RefactorSummon")
local bs_204603 = class("bs_204603", bs_201801)
local base = bs_201801
bs_204603.config = {
  middleMonsterId = {
    20,
    22,
    23
  },
  maxHpPer = 250,
  powPer = 800
}
bs_204603.config = setmetatable(bs_204603.config, {
  __index = base.config
})

function bs_204603:ctor()
end

function bs_204603:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_204603:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_204603
