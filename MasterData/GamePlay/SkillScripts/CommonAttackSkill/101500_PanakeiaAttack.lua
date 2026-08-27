local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_101500 = class("bs_101500", bs_1)
local base = bs_1
bs_101500.config = {
  effectId_trail = 101502,
  effectId_trail_ex = 101501,
  effecId_action_1 = 101503,
  effecId_action_2 = 101504,
  audioId1 = 101501,
  audioId2 = 101503
}
bs_101500.config = setmetatable(bs_101500.config, {
  __index = base.config
})

function bs_101500:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_101500:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_101500
