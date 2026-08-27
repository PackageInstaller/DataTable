local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_108000 = class("bs_108000", bs_1)
local base = bs_1
bs_108000.config = {
  effectId_trail = 108001,
  effectId_action_1 = 108017,
  effectId_action_2 = 108018
}
bs_108000.config = setmetatable(bs_108000.config, {
  __index = base.config
})

function bs_108000:ctor()
end

function bs_108000:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_108000:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_108000
