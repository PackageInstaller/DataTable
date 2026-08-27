local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_101100 = class("bs_101100", bs_1)
local base = bs_1
bs_101100.config = {
  effectId_1 = 101109,
  effectId_2 = 101110,
  audioId1 = 101101,
  audioId2 = 101102,
  audioId3 = 101103
}
bs_101100.config = setmetatable(bs_101100.config, {
  __index = base.config
})

function bs_101100:ctor()
end

function bs_101100:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_101100:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_101100
