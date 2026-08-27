local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_206600 = class("bs_206600", bs_1)
local base = bs_1
bs_206600.config = {
  effectId_1 = 2066001,
  effectId_2 = 2066001,
  action1 = 1001,
  action2 = 1001,
  audioId1 = 444
}
bs_206600.config = setmetatable(bs_206600.config, {
  __index = base.config
})

function bs_206600:ctor()
end

function bs_206600:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_206600:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_206600
