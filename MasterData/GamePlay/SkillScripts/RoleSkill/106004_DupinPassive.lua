local bs_106001 = require("GamePlay.SkillScripts.RoleSkill.106001_DupinPassive")
local bs_106004 = class("bs_106004", bs_106001)
local base = bs_106001
bs_106004.config = {weaponLv = 1, buffCrt = 106006}
bs_106004.config = setmetatable(bs_106004.config, {
  __index = base.config
})

function bs_106004:ctor()
end

function bs_106004:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_106004:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_106004
