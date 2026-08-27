local bs_104201 = require("GamePlay.SkillScripts.RoleSkill.104201_HatsuchiriPassive")
local bs_104204 = class("bs_104204", bs_104201)
local base = bs_104201
bs_104204.config = {weaponLv = 1}
bs_104204.config = setmetatable(bs_104204.config, {
  __index = base.config
})

function bs_104204:ctor()
end

function bs_104204:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_104204:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_104204
