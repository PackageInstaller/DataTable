local bs_102905 = require("GamePlay.SkillScripts.RoleSkill.102905_WillowPassive")
local bs_102906 = class("bs_102906", bs_102905)
local base = bs_102905
bs_102906.config = {weaponLv = 3}
bs_102906.config = setmetatable(bs_102906.config, {
  __index = base.config
})

function bs_102906:ctor()
end

function bs_102906:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_102906:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_102906
