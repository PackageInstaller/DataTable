local bs_105801 = require("GamePlay.SkillScripts.RoleSkill.105801_ClukayPassive")
local bs_105804 = class("bs_105804", bs_105801)
local base = bs_105801
bs_105804.config = {weaponLv = 1}
bs_105804.config = setmetatable(bs_105804.config, {
  __index = base.config
})

function bs_105804:ctor()
end

function bs_105804:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_105804:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_105804
