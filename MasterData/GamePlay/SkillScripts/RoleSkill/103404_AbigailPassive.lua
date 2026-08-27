local bs_103401 = require("GamePlay.SkillScripts.RoleSkill.103401_AbigailPassive")
local bs_103404 = class("bs_103404", bs_103401)
local base = bs_103401
bs_103404.config = {weaponLv = 1}
bs_103404.config = setmetatable(bs_103404.config, {
  __index = base.config
})

function bs_103404:ctor()
end

function bs_103404:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable.self_int = self.arglist[2]
  self.caster.recordTable.sender_int = self.arglist[3]
end

function bs_103404:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_103404
