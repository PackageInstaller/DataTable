local bs_104101 = require("GamePlay.SkillScripts.RoleSkill.104101_DeLaceyPassive")
local bs_104104 = class("bs_104104", bs_104101)
local base = bs_104101
bs_104104.config = {weaponLv = 1}
bs_104104.config = setmetatable(bs_104104.config, {
  __index = base.config
})

function bs_104104:ctor()
end

function bs_104104:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_104104:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_104104
