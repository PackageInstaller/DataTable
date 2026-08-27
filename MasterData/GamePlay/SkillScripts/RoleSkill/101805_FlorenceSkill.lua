local bs_101802 = require("GamePlay.SkillScripts.RoleSkill.101802_FlorenceSkill")
local bs_101805 = class("bs_101805", bs_101802)
local base = bs_101802
bs_101805.config = {weaponLv = 2}
bs_101805.config = setmetatable(bs_101805.config, {
  __index = base.config
})

function bs_101805:ctor()
end

function bs_101805:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_101805:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_101805
