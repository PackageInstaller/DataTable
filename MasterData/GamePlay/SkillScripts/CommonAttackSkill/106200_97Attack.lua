local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_106200 = class("bs_106200", bs_1)
local base = bs_1
bs_106200.config = {
  effectId_start1 = 106201,
  effectId_start2 = 106202,
  action1 = 1001,
  action2 = 1004
}
bs_106200.config = setmetatable(bs_106200.config, {
  __index = base.config
})

function bs_106200:ctor()
end

function bs_106200:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_106200:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_106200
