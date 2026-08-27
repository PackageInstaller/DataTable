local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_103500 = class("bs_103500", bs_1)
local base = bs_1
bs_103500.config = {
  effectId_trail = 10793,
  effectId_trail_ex = 10806,
  effectId_start1 = 10192,
  effectId_start2 = 10193,
  audioId1 = 58,
  audioId2 = 59,
  time2 = 1
}
bs_103500.config = setmetatable(bs_103500.config, {
  __index = base.config
})

function bs_103500:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_103500:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_103500
