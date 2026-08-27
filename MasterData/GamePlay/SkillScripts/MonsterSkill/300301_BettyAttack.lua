local base = require("GamePlay.SkillScripts.CommonAttackSkill.101300_BettyAttack")
local bs_300301 = class("bs_300301", base)
bs_300301.config = {action1 = 1004, action2 = 1004}
bs_300301.config = setmetatable(bs_300301.config, {
  __index = base.config
})

function bs_300301:ctor()
end

function bs_300301:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_300301:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_300301
