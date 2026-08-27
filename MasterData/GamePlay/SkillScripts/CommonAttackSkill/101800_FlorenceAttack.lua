local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_101800 = class("bs_101800", bs_1)
local base = bs_1
bs_101800.config = {
  effectId_trail = 101801,
  audioId1 = 101801,
  audioId2 = 101802
}
bs_101800.config = setmetatable(bs_101800.config, {
  __index = base.config
})

function bs_101800:ctor()
end

function bs_101800:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_101800:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_101800
