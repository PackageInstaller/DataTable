local bs_103102 = require("GamePlay.SkillScripts.RoleSkill.103102_ImhotepSkill")
local bs_103106 = class("bs_103106", bs_103102)
local base = bs_103102
bs_103106.config = {weaponLv = 3}
bs_103106.config = setmetatable(bs_103106.config, {
  __index = base.config
})

function bs_103106:ctor()
end

function bs_103106:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_103106:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_103106
