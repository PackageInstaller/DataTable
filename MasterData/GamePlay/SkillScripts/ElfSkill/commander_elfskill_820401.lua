local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_820401 = class("bs_820401", bs_1)
local base = bs_1
bs_820401.config = {
  effectId_trail = 106111,
  effectId_trailHit = 106112,
  action1 = 1001,
  action2 = 1001
}
bs_820401.config = setmetatable(bs_820401.config, {
  __index = base.config
})

function bs_820401:ctor()
end

function bs_820401:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_820401:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_820401
