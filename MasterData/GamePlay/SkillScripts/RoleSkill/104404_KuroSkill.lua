local bs_104402 = require("GamePlay.SkillScripts.RoleSkill.104402_KuroSkill")
local bs_104404 = class("bs_104404", bs_104402)
local base = bs_104402
bs_104404.config = {weaponLv = 1}
bs_104404.config = setmetatable(bs_104404.config, {
  __index = base.config
})

function bs_104404:ctor()
end

function bs_104404:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_104404:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_104404
