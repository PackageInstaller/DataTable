local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_108500 = class("bs_108500", bs_1)
local base = bs_1
bs_108500.config = {effectId_trail = 108501}
bs_108500.config = setmetatable(bs_108500.config, {
  __index = base.config
})

function bs_108500:ctor()
end

function bs_108500:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_108500:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_108500
