local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_105200 = class("bs_105200", bs_1)
local base = bs_1
bs_105200.config = {
  effectId_trail = 105203,
  audioId1 = 105201,
  time1 = 0,
  audioId2 = 105202,
  time2 = 0
}
bs_105200.config = setmetatable(bs_105200.config, {
  __index = base.config
})

function bs_105200:ctor()
end

function bs_105200:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_105200:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_105200
