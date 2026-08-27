local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_505 = class("bs_505", bs_1)
local base = bs_1
bs_505.config = {
  effectId_1 = 10102,
  effectId_2 = 10102,
  action2 = 1001,
  audioId1 = 19,
  audioId2 = 19
}
bs_505.config = setmetatable(bs_505.config, {
  __index = base.config
})

function bs_505:ctor()
end

function bs_505:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_505:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_505
