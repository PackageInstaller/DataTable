local base = require("GamePlay.SkillScripts.CommonAttackSkill.100200_AnnaAttack")
local bs_300101 = class("bs_300101", base)
bs_300101.config = {action1 = 1021, action2 = 1044}
bs_300101.config = setmetatable(bs_300101.config, {
  __index = base.config
})

function bs_300101:ctor()
end

function bs_300101:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_300101:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_300101
