local bs_100801 = require("GamePlay.SkillScripts.RoleSkill.100801_GinPassive")
local bs_100804 = class("bs_100804", bs_100801)
local base = bs_100801
bs_100804.config = {weaponLv = 1}
bs_100804.config = setmetatable(bs_100804.config, {
  __index = base.config
})

function bs_100804:ctor()
end

function bs_100804:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable.weapon = true
end

function bs_100804:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_100804
