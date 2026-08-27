local bs_107102 = require("GamePlay.SkillScripts.RoleSkill.107102_PersicariaSkill")
local bs_107105 = class("bs_107105", bs_107102)
local base = bs_107102
bs_107105.config = {weaponLv = 2}
bs_107105.config = setmetatable(bs_107105.config, {
  __index = base.config
})

function bs_107105:ctor()
end

function bs_107105:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_107105:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_107105
