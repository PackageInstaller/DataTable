local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_100100 = class("bs_100100", bs_1)
local base = bs_1
bs_100100.config = {effectId_trail = 100101}
bs_100100.config = setmetatable(bs_100100.config, {
  __index = base.config
})

function bs_100100:ctor()
end

function bs_100100:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_100100:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_100100
