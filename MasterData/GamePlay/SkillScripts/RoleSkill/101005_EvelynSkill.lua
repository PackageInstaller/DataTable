local bs_101002 = require("GamePlay.SkillScripts.RoleSkill.101002_EvelynSkill")
local bs_101005 = class("bs_101005", bs_101002)
local base = bs_101002
bs_101005.config = {weaponLv = 2}
bs_101005.config = setmetatable(bs_101005.config, {
  __index = base.config
})

function bs_101005:ctor()
end

function bs_101005:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_101005:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_101005
