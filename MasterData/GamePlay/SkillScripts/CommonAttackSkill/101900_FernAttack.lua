local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_101900 = class("bs_101900", bs_1)
local base = bs_1
bs_101900.config = {
  effectId_1 = 10680,
  effectId_2 = 10681,
  audioId1 = 216,
  audioId2 = 217,
  audioId3 = 218
}
bs_101900.config = setmetatable(bs_101900.config, {
  __index = base.config
})

function bs_101900:ctor()
end

function bs_101900:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_101900:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_101900
