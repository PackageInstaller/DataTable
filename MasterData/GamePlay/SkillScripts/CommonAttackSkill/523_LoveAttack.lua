local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_523 = class("bs_523", bs_1)
local base = bs_1
bs_523.config = {
  effectId_action_1 = 10489,
  effectId_action_2 = 10490,
  effectId_trail = 10487
}
bs_523.config = setmetatable(bs_523.config, {
  __index = base.config
})

function bs_523:ctor()
end

function bs_523:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_523:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_523
