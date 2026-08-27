local bs_100801 = require("GamePlay.SkillScripts.RoleSkill.100801_GinPassive")
local bs_100805 = class("bs_100805", bs_100801)
local base = bs_100801
bs_100805.config = {weaponLv = 2}
bs_100805.config = setmetatable(bs_100805.config, {
  __index = base.config
})

function bs_100805:ctor()
end

function bs_100805:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable.exHeal = self.arglist[7]
  self.caster.recordTable.exHeal_rate = self.arglist[6]
  self.caster.recordTable.weapon = true
  self.caster.recordTable.weapon2 = true
end

function bs_100805:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_100805
