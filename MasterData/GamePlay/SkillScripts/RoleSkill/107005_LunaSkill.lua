local bs_107004 = require("GamePlay.SkillScripts.RoleSkill.107004_LunaSkill")
local bs_107005 = class("bs_107005", bs_107004)
local base = bs_107004
bs_107005.config = {weaponLv = 2}
bs_107005.config = setmetatable(bs_107005.config, {
  __index = base.config
})

function bs_107005:ctor()
end

function bs_107005:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable.damgeplus_Ex = self.arglist[7]
end

function bs_107005:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_107005
