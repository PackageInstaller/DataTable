local bs_100902 = require("GamePlay.SkillScripts.RoleSkill.100902_MaiSkill")
local bs_100905 = class("bs_100905", bs_100902)
local base = bs_100902
bs_100905.config = {weaponLv = 2}
bs_100905.config = setmetatable(bs_100905.config, {
  __index = base.config
})

function bs_100905:ctor()
end

function bs_100905:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_100905:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_100905
