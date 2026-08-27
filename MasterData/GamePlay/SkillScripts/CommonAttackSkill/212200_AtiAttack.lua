local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_212200 = class("bs_212200", bs_1)
local base = bs_1
bs_212200.config = {
  effectId_trail = 212201,
  effectId_trail_ex = 212203,
  effectId_action_1 = 212207,
  effectId_action_2 = 212208
}
bs_212200.config = setmetatable(bs_212200.config, {
  __index = base.config
})

function bs_212200:ctor()
end

function bs_212200:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_212200:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_212200
