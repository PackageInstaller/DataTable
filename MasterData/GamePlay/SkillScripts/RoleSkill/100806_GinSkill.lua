local bs_100802 = require("GamePlay.SkillScripts.RoleSkill.100802_GinSkill")
local bs_100806 = class("bs_100806", bs_100802)
local base = bs_100802
bs_100806.config = {weaponLv = 3}
bs_100806.config = setmetatable(bs_100806.config, {
  __index = base.config
})

function bs_100806:ctor()
end

function bs_100806:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_100806:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_100806
