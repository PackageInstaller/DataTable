local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_100700 = class("bs_100700", bs_1)
local base = bs_1
bs_100700.config = {effectId_1 = 100702, effectId_2 = 100709}
bs_100700.config = setmetatable(bs_100700.config, {
  __index = base.config
})

function bs_100700:ctor()
end

function bs_100700:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_100700:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_100700
