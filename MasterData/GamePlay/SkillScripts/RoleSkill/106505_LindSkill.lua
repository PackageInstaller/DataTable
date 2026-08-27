local bs_106502 = require("GamePlay.SkillScripts.RoleSkill.106502_LindSkill")
local bs_106505 = class("bs_106505", bs_106502)
local base = bs_106502
bs_106505.config = {weaponLv = 2}
bs_106505.config = setmetatable(bs_106505.config, {
  __index = base.config
})

function bs_106505:ctor()
end

function bs_106505:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_106505:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_106505
