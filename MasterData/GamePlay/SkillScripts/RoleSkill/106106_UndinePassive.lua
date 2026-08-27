local bs_106104 = require("GamePlay.SkillScripts.RoleSkill.106104_UndinePassive")
local bs_106106 = class("bs_106106", bs_106104)
local base = bs_106104
bs_106106.config = {weaponLv = 3}
bs_106106.config = setmetatable(bs_106106.config, {
  __index = base.config
})

function bs_106106:ctor()
end

function bs_106106:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_106106:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_106106
