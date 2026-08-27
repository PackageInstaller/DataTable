local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_104100 = class("bs_104100", bs_1)
local base = bs_1
bs_104100.config = {
  effectId_trail = 104101,
  effectId_action_1 = 104103,
  effectId_action_2 = 104103
}
bs_104100.config = setmetatable(bs_104100.config, {
  __index = base.config
})

function bs_104100:ctor()
end

function bs_104100:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_104100:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_104100
