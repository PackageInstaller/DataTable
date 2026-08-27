local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_108700 = class("bs_108700", bs_1)
local base = bs_1
bs_108700.config = {effectId_trail = 108701}
bs_108700.config = setmetatable(bs_108700.config, {
  __index = base.config
})

function bs_108700:ctor()
end

function bs_108700:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_108700:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_108700
