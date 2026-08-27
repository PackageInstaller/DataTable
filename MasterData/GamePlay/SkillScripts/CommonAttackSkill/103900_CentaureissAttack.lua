local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_103900 = class("bs_103900", bs_1)
local base = bs_1
bs_103900.config = {
  effectId_1 = 10462,
  effectId_2 = 10463,
  baseActionSpd = 1.36,
  audioId1 = 295,
  audioId2 = 296,
  audioId3 = 345
}
bs_103900.config = setmetatable(bs_103900.config, {
  __index = base.config
})

function bs_103900:ctor()
end

function bs_103900:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_103900:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_103900
