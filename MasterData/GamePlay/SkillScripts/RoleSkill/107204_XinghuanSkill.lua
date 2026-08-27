local bs_107202 = require("GamePlay.SkillScripts.RoleSkill.107202_XinghuanSkill")
local bs_107204 = class("bs_107204", bs_107202)
local base = bs_107202
bs_107204.config = {weaponLv = 1}
bs_107204.config = setmetatable(bs_107204.config, {
  __index = base.config
})

function bs_107204:ctor()
end

function bs_107204:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_107204:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_107204
