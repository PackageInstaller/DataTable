local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_503 = class("bs_503", bs_1)
local base = bs_1
bs_503.config = {
  effectId_1 = 10093,
  effectId_2 = 10093,
  audioId1 = 21,
  audioId2 = 21
}
bs_503.config = setmetatable(bs_503.config, {
  __index = base.config
})

function bs_503:ctor()
end

function bs_503:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_503:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_503
