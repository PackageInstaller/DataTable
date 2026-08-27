local bs_105804 = require("GamePlay.SkillScripts.RoleSkill.105804_ClukayPassive")
local bs_105806 = class("bs_105806", bs_105804)
local base = bs_105804
bs_105806.config = {weaponLv = 3}
bs_105806.config = setmetatable(bs_105806.config, {
  __index = base.config
})

function bs_105806:ctor()
end

function bs_105806:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

return bs_105806
