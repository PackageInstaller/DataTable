local bs_101001 = require("GamePlay.SkillScripts.RoleSkill.101001_EvelynPassive")
local bs_101004 = class("bs_101004", bs_101001)
local base = bs_101001
bs_101004.config = {weaponLv = 1}
bs_101004.config = setmetatable(bs_101004.config, {
  __index = base.config
})

function bs_101004:ctor()
end

function bs_101004:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_101004:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_101004
