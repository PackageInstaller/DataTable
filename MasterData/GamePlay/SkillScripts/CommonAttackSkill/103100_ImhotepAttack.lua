local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_103100 = class("bs_103100", bs_1)
local base = bs_1
bs_103100.config = {
  effectId_trail = 103107,
  audioId1 = 271,
  audioId2 = 272,
  audioId5 = 341
}
bs_103100.config = setmetatable(bs_103100.config, {
  __index = base.config
})

function bs_103100:ctor()
end

function bs_103100:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_103100:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_103100
