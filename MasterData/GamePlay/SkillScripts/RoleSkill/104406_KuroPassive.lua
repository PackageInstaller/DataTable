local bs_104405 = require("GamePlay.SkillScripts.RoleSkill.104405_KuroPassive")
local bs_104406 = class("bs_104406", bs_104405)
local base = bs_104405
bs_104406.config = {weaponLv = 3}
bs_104406.config = setmetatable(bs_104406.config, {
  __index = base.config
})

function bs_104406:ctor()
end

function bs_104406:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable.weaponLv = 3
  self.caster.recordTable.dam_bullet = self.arglist[6]
end

return bs_104406
