local bs_107101 = require("GamePlay.SkillScripts.RoleSkill.107101_PersicariaPassive")
local bs_107106 = class("bs_107106", bs_107101)
local base = bs_107101
bs_107106.config = {weaponLv = 3}
bs_107106.config = setmetatable(bs_107106.config, {
  __index = base.config
})

function bs_107106:ctor()
end

function bs_107106:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_107106:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_107106
