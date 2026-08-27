local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_101200 = class("bs_101200", bs_1)
local base = bs_1
bs_101200.config = {
  effectId_trail = 101202,
  effectId_action_1 = 101201,
  effectId_action_2 = 101201,
  audioId1 = 101201,
  audioId2 = 101202,
  audioId5 = 101203
}
bs_101200.config = setmetatable(bs_101200.config, {
  __index = base.config
})

function bs_101200:ctor()
end

function bs_101200:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_101200:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_101200
