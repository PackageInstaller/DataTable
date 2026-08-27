local bs_106101 = require("GamePlay.SkillScripts.RoleSkill.106101_UndinePassive")
local bs_106104 = class("bs_106104", bs_106101)
local base = bs_106101
bs_106104.config = {weaponLv = 1}
bs_106104.config = setmetatable(bs_106104.config, {
  __index = base.config
})

function bs_106104:ctor()
end

function bs_106104:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_106104:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_106104
