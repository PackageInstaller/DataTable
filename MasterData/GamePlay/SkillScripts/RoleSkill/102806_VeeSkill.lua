local bs_102804 = require("GamePlay.SkillScripts.RoleSkill.102804_VeeSkill")
local bs_102806 = class("bs_102806", bs_102804)
local base = bs_102804
bs_102806.config = {weaponLv = 3}
bs_102806.config = setmetatable(bs_102806.config, {
  __index = base.config
})

function bs_102806:ctor()
end

function bs_102806:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_102806:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_102806
