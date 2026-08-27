local bs_103402 = require("GamePlay.SkillScripts.RoleSkill.103402_AbigailSkill")
local bs_103405 = class("bs_103405", bs_103402)
local base = bs_103402
bs_103405.config = {weaponLv = 2}
bs_103405.config = setmetatable(bs_103405.config, {
  __index = base.config
})

function bs_103405:ctor()
end

function bs_103405:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable.Crit = self.arglist[4]
  self.caster.recordTable.CritHurt = self.arglist[5]
  self.caster.recordTable.Time = self.arglist[6]
  self.caster.recordTable.CritMax = self.arglist[7]
end

function bs_103405:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_103405
