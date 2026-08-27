local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_102700 = class("bs_102700", bs_1)
local base = bs_1
bs_102700.config = {
  effectId_1 = 10378,
  effectId_2 = 10379,
  audioId1 = 260,
  audioId2 = 261,
  audioId3 = 343
}
bs_102700.config = setmetatable(bs_102700.config, {
  __index = base.config
})

function bs_102700:ctor()
end

function bs_102700:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_102700:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_102700
