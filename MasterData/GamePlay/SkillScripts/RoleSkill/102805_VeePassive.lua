local bs_102801 = require("GamePlay.SkillScripts.RoleSkill.102801_VeePassive")
local bs_102805 = class("bs_102805", bs_102801)
local base = bs_102801
bs_102805.config = {weaponLv = 2}
bs_102805.config = setmetatable(bs_102805.config, {
  __index = base.config
})

function bs_102805:ctor()
end

function bs_102805:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_102805:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_102805
