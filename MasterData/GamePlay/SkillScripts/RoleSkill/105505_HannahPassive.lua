local bs_105501 = require("GamePlay.SkillScripts.RoleSkill.105501_HannahPassive")
local bs_105505 = class("bs_105505", bs_105501)
local base = bs_105501
bs_105505.config = {buffId_attackSpeed = 105509, weaponLv = 2}
bs_105505.config = setmetatable(bs_105505.config, {
  __index = base.config
})

function bs_105505:ctor()
end

function bs_105505:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

return bs_105505
