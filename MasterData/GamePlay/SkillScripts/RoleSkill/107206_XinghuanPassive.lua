local bs_107201 = require("GamePlay.SkillScripts.RoleSkill.107201_XinghuanPassive")
local bs_107206 = class("bs_107206", bs_107201)
local base = bs_107201
bs_107206.config = {weaponLv = 3}
bs_107206.config = setmetatable(bs_107206.config, {
  __index = base.config
})

function bs_107206:ctor()
end

function bs_107206:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_107206:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_107206
