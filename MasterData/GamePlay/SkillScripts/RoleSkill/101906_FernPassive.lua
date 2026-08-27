local bs_101901 = require("GamePlay.SkillScripts.RoleSkill.101901_FernPassive")
local bs_101906 = class("bs_101906", bs_101901)
local base = bs_101901
bs_101906.config = {weaponLv = 3}
bs_101906.config = setmetatable(bs_101906.config, {
  __index = base.config
})

function bs_101906:ctor()
end

function bs_101906:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_101906:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_101906
