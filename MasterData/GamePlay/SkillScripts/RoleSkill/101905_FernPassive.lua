local bs_101901 = require("GamePlay.SkillScripts.RoleSkill.101901_FernPassive")
local bs_101905 = class("bs_101905", bs_101901)
local base = bs_101901
bs_101905.config = {weaponLv = 2}
bs_101905.config = setmetatable(bs_101905.config, {
  __index = base.config
})

function bs_101905:ctor()
end

function bs_101905:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_101905:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_101905
