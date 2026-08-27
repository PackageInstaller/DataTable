local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_529 = class("bs_529", bs_1)
local base = bs_1
bs_529.config = {
  effectId_1 = 10567,
  effectId_2 = 10568,
  audioId1 = 319,
  audioId2 = 320
}
bs_529.config = setmetatable(bs_529.config, {
  __index = base.config
})

function bs_529:ctor()
end

function bs_529:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_529:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_529
