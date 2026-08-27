local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_535 = class("bs_535", bs_1)
local base = bs_1
bs_535.config = {
  effectId_trail = 10769,
  effectId_action_1 = 10767,
  effectId_action_2 = 10767,
  effectId_start1 = 10768,
  effectId_start2 = 10768,
  audioId1 = 325,
  audioId2 = 203502
}
bs_535.config = setmetatable(bs_535.config, {
  __index = base.config
})

function bs_535:ctor()
end

function bs_535:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_535:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_535
