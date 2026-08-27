local bs_107101 = require("GamePlay.SkillScripts.RoleSkill.107101_PersicariaPassive")
local bs_107104 = class("bs_107104", bs_107101)
local base = bs_107101
bs_107104.config = {weaponLv = 1}
bs_107104.config = setmetatable(bs_107104.config, {
  __index = base.config
})

function bs_107104:ctor()
end

function bs_107104:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_107104:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_107104
