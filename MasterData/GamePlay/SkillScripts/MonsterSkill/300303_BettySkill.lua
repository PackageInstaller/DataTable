local base = require("GamePlay.SkillScripts.RoleSkill.101302_BettySkill")
local bs_300303 = class("bs_300303", base)
bs_300303.config = {buffId_Wild = 10130102}
bs_300303.config = setmetatable(bs_300303.config, {
  __index = base.config
})

function bs_300303:ctor()
end

function bs_300303:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_300303:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_300303
