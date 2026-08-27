local base = require("GamePlay.SkillScripts.RoleSkill.102301_BoneePassive")
local bs_300402 = class("bs_300402", base)
bs_300402.config = {}
bs_300402.config = setmetatable(bs_300402.config, {
  __index = base.config
})

function bs_300402:ctor()
end

function bs_300402:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_300402:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_300402
