local base = require("GamePlay.SkillScripts.RoleSkill.101301_BettyPassive")
local bs_300302 = class("bs_300302", base)
bs_300302.config = {}
bs_300302.config = setmetatable(bs_300302.config, {
  __index = base.config
})

function bs_300302:ctor()
end

function bs_300302:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_300302:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_300302
