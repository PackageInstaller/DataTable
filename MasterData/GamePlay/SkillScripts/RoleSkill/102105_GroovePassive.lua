local bs_102101 = require("GamePlay.SkillScripts.RoleSkill.102101_GroovePassive")
local bs_102105 = class("bs_102105", bs_102101)
local base = bs_102101
bs_102105.config = {weaponLv = 2}
bs_102105.config = setmetatable(bs_102105.config, {
  __index = base.config
})

function bs_102105:ctor()
end

function bs_102105:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_102105:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_102105
