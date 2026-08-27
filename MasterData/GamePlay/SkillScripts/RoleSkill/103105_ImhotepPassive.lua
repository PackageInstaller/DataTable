local bs_103101 = require("GamePlay.SkillScripts.RoleSkill.103101_ImhotepPassive")
local bs_103105 = class("bs_103105", bs_103101)
local base = bs_103101
bs_103105.config = {weaponLv = 2}
bs_103105.config = setmetatable(bs_103105.config, {
  __index = base.config
})

function bs_103105:ctor()
end

function bs_103105:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_103105:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_103105
