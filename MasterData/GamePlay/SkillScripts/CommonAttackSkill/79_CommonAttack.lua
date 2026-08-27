local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_79 = class("bs_79", bs_1)
local base = bs_1
bs_79.config = {effectId_taril = 132}
bs_79.config = setmetatable(bs_79.config, {
  __index = base.config
})

function bs_79:ctor()
end

function bs_79:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_79:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_79
