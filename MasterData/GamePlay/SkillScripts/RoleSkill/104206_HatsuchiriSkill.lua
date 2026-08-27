local bs_104202 = require("GamePlay.SkillScripts.RoleSkill.104202_HatsuchiriSkill")
local bs_104206 = class("bs_104206", bs_104202)
local base = bs_104202
bs_104206.config = {weaponLv = 3}
bs_104206.config = setmetatable(bs_104206.config, {
  __index = base.config
})

function bs_104206:ctor()
end

function bs_104206:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_104206:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_104206
