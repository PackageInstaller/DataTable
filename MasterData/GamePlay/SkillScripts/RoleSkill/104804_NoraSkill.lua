local bs_104802 = require("GamePlay.SkillScripts.RoleSkill.104802_NoraSkill")
local bs_104804 = class("bs_104804", bs_104802)
local base = bs_104802
bs_104804.config = {weaponLv = 1}
bs_104804.config = setmetatable(bs_104804.config, {
  __index = base.config
})

function bs_104804:ctor()
end

function bs_104804:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_104804:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_104804
