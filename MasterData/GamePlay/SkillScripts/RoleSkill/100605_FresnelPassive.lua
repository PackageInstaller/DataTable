local bs_100601 = require("GamePlay.SkillScripts.RoleSkill.100601_FresnelPassive")
local bs_100605 = class("bs_100605", bs_100601)
local base = bs_100601
bs_100605.config = {weaponLv = 2}
bs_100605.config = setmetatable(bs_100605.config, {
  __index = base.config
})

function bs_100605:ctor()
end

function bs_100605:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_100605:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_100605
