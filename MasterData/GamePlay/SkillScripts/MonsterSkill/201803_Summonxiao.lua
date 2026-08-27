local bs_201801 = require("GamePlay.SkillScripts.MonsterSkill.201801_ZYZ_RefactorSummon")
local bs_201803 = class("bs_201803", bs_201801)
local base = bs_201801
bs_201803.config = {maxHpPer = 180, powPer = 700}
bs_201803.config = setmetatable(bs_201803.config, {
  __index = base.config
})

function bs_201803:ctor()
end

function bs_201803:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_201803:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_201803
