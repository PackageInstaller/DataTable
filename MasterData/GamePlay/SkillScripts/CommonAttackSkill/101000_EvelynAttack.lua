local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_101000 = class("bs_101000", bs_1)
local base = bs_1
bs_101000.config = {
  effectId_3 = 101001,
  audioId1 = 101001,
  audioId2 = 101002,
  time1 = 6
}
bs_101000.config = setmetatable(bs_101000.config, {
  __index = base.config
})

function bs_101000:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_101000:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_101000
