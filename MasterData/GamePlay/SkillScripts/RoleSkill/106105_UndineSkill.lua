local bs_106102 = require("GamePlay.SkillScripts.RoleSkill.106102_UndineSkill")
local bs_106105 = class("bs_106105", bs_106102)
local base = bs_106102
bs_106105.config = {weaponLv = 2}
bs_106105.config = setmetatable(bs_106105.config, {
  __index = base.config
})

function bs_106105:ctor()
end

function bs_106105:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_106105:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_106105
