local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_101600 = class("bs_101600", bs_1)
local base = bs_1
bs_101600.config = {
  effectId_trail = 101601,
  audioId1 = 57,
  audioId2 = 57
}
bs_101600.config = setmetatable(bs_101600.config, {
  __index = base.config
})

function bs_101600:ctor()
end

function bs_101600:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_101600:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_101600
