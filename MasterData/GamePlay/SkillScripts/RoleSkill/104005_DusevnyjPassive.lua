local bs_104001 = require("GamePlay.SkillScripts.RoleSkill.104001_DusevnyjPassive")
local bs_104005 = class("bs_104005", bs_104001)
local base = bs_104001
bs_104005.config = {weaponLv = 2}
bs_104005.config = setmetatable(bs_104005.config, {
  __index = base.config
})

function bs_104005:ctor()
end

function bs_104005:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_104005:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_104005
