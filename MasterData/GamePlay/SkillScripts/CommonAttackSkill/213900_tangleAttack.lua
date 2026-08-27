local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_213900 = class("bs_213900", bs_1)
local base = bs_1
bs_213900.config = {
  action2 = 1001,
  effectId_trail = 213901,
  effectId_start1 = 213907
}
bs_213900.config = setmetatable(bs_213900.config, {
  __index = base.config
})

function bs_213900:ctor()
end

function bs_213900:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_213900:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_213900
