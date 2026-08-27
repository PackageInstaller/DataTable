local bs_103102 = require("GamePlay.SkillScripts.RoleSkill.103102_ImhotepSkill")
local bs_103104 = class("bs_103104", bs_103102)
local base = bs_103102
bs_103104.config = {weaponLv = 1}
bs_103104.config = setmetatable(bs_103104.config, {
  __index = base.config
})

function bs_103104:ctor()
end

function bs_103104:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_103104:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_103104
