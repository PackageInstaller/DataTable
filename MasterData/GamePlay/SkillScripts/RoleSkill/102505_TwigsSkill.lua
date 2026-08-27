local bs_102504 = require("GamePlay.SkillScripts.RoleSkill.102504_TwigsSkill")
local bs_102505 = class("bs_102505", bs_102504)
local base = bs_102504
bs_102505.config = {weaponLv = 2}
bs_102505.config = setmetatable(bs_102505.config, {
  __index = base.config
})

function bs_102505:ctor()
end

function bs_102505:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_102505:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_102505
