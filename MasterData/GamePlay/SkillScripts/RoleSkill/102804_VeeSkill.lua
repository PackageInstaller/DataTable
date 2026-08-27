local bs_102802 = require("GamePlay.SkillScripts.RoleSkill.102802_VeeSkill")
local bs_102804 = class("bs_102804", bs_102802)
local base = bs_102802
bs_102804.config = {
  weaponLv = 1,
  buffId_zw1 = 102805,
  buffId_zw2 = 102806
}
bs_102804.config = setmetatable(bs_102804.config, {
  __index = base.config
})

function bs_102804:ctor()
end

function bs_102804:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_102804:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_102804
