local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_105700 = class("bs_105700", bs_1)
local base = bs_1
bs_105700.config = {effectId_trail = 105701}
bs_105700.config = setmetatable(bs_105700.config, {
  __index = base.config
})

function bs_105700:ctor()
end

function bs_105700:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_105700:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_105700
