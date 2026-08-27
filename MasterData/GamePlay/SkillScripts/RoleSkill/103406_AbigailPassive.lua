local bs_103401 = require("GamePlay.SkillScripts.RoleSkill.103401_AbigailPassive")
local bs_103406 = class("bs_103406", bs_103401)
local base = bs_103401
bs_103406.config = {weaponLv = 3}
bs_103406.config = setmetatable(bs_103406.config, {
  __index = base.config
})

function bs_103406:ctor()
end

function bs_103406:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable.self_int = self.arglist[2]
  self.caster.recordTable.sender_int = self.arglist[3]
  self.caster.recordTable.skillTime = self.arglist[4]
end

function bs_103406:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_103406
