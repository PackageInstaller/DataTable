local bs_201811 = require("GamePlay.SkillScripts.MonsterSkill.201801_ZYZ_RefactorSummon")
local bs_201813 = class("bs_201813", bs_201811)
local base = bs_201811
bs_201813.config = {maxHpPer = 180, powPer = 700}
bs_201813.config = setmetatable(bs_201813.config, {
  __index = base.config
})

function bs_201813:ctor()
end

function bs_201813:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_201813:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_201813
