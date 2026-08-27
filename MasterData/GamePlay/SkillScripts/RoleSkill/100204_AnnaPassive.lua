local bs_100201 = require("GamePlay.SkillScripts.RoleSkill.100201_AnnaPassive")
local bs_100204 = class("bs_100204", bs_100201)
local base = bs_100201
bs_100204.config = {weaponLv = 1, buffId_cockhourse2 = 100203}
bs_100204.config = setmetatable(bs_100204.config, {
  __index = base.config
})

function bs_100204:ctor()
end

function bs_100204:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_100204:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_100204
