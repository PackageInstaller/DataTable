local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_510 = class("bs_510", bs_1)
local base = bs_1
bs_510.config = {
  effectId_1 = 10214,
  effectId_2 = 10215,
  audioId1 = 65,
  time1 = 10,
  audioId2 = 66
}
bs_510.config = setmetatable(bs_510.config, {
  __index = base.config
})

function bs_510:ctor()
end

function bs_510:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_510:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_510
