local bs_107201 = require("GamePlay.SkillScripts.RoleSkill.107201_XinghuanPassive")
local bs_107205 = class("bs_107205", bs_107201)
local base = bs_107201
bs_107205.config = {weaponLv = 2}
bs_107205.config = setmetatable(bs_107205.config, {
  __index = base.config
})

function bs_107205:ctor()
end

function bs_107205:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_107205:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_107205
