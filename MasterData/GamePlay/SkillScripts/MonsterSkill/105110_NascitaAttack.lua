local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_105110 = class("bs_105110", bs_1)
local base = bs_1
bs_105110.config = {effectId_1 = 105101, effectId_2 = 105102}
bs_105110.config = setmetatable(bs_105110.config, {
  __index = base.config
})

function bs_105110:ctor()
end

function bs_105110:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_105110:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_105110
