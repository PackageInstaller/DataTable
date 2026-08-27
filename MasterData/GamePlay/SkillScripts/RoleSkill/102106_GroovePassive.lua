local bs_102101 = require("GamePlay.SkillScripts.RoleSkill.102101_GroovePassive")
local bs_102106 = class("bs_102106", bs_102101)
local base = bs_102101
bs_102106.config = {weaponLv = 3}
bs_102106.config = setmetatable(bs_102106.config, {
  __index = base.config
})

function bs_102106:ctor()
end

function bs_102106:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_102106:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_102106
