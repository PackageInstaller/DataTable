local bs_101001 = require("GamePlay.SkillScripts.RoleSkill.101001_EvelynPassive")
local bs_101006 = class("bs_101006", bs_101001)
local base = bs_101001
bs_101006.config = {weaponLv = 3}
bs_101006.config = setmetatable(bs_101006.config, {
  __index = base.config
})

function bs_101006:ctor()
end

function bs_101006:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_101006:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_101006
