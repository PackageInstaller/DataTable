local bs_104805 = require("GamePlay.SkillScripts.RoleSkill.104805_NoraPassive")
local bs_104806 = class("bs_104806", bs_104805)
local base = bs_104805
bs_104806.config = {weaponLv = 3}
bs_104806.config = setmetatable(bs_104806.config, {
  __index = base.config
})

function bs_104806:ctor()
end

function bs_104806:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

return bs_104806
