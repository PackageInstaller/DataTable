local bs_104101 = require("GamePlay.SkillScripts.RoleSkill.104101_DeLaceyPassive")
local bs_104105 = class("bs_104105", bs_104101)
local base = bs_104101
bs_104105.config = {weaponLv = 2}
bs_104105.config = setmetatable(bs_104105.config, {
  __index = base.config
})

function bs_104105:ctor()
end

function bs_104105:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_104105:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_104105
