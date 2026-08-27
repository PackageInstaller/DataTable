local bs_104102 = require("GamePlay.SkillScripts.RoleSkill.104102_DeLaceySkill")
local bs_104106 = class("bs_104106", bs_104102)
local base = bs_104102
bs_104106.config = {weaponLv = 3}
bs_104106.config = setmetatable(bs_104106.config, {
  __index = base.config
})

function bs_104106:ctor()
end

function bs_104106:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_104106:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_104106
