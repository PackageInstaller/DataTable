local bs_101901 = require("GamePlay.SkillScripts.RoleSkill.101901_FernPassive")
local bs_101904 = class("bs_101904", bs_101901)
local base = bs_101901
bs_101904.config = {weaponLv = 1}
bs_101904.config = setmetatable(bs_101904.config, {
  __index = base.config
})

function bs_101904:ctor()
end

function bs_101904:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_101904:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_101904
