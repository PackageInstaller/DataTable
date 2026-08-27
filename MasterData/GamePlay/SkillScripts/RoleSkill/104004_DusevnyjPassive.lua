local bs_104001 = require("GamePlay.SkillScripts.RoleSkill.104001_DusevnyjPassive")
local bs_104004 = class("bs_104004", bs_104001)
local base = bs_104001
bs_104004.config = {weaponLv = 1}
bs_104004.config = setmetatable(bs_104004.config, {
  __index = base.config
})

function bs_104004:ctor()
end

function bs_104004:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_104004:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_104004
