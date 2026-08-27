local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_104900 = class("bs_104900", bs_1)
local base = bs_1
bs_104900.config = {effectId_1 = 104901, effectId_2 = 104902}
bs_104900.config = setmetatable(bs_104900.config, {
  __index = base.config
})

function bs_104900:ctor()
end

function bs_104900:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_104900:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_104900
