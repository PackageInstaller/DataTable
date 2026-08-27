local base = require("GamePlay.SkillScripts.RoleSkill.100202_AnnaSkill")
local bs_300103 = class("bs_300103", base)
bs_300103.config = {
  action1 = 1044,
  skill_time = 37,
  start_time = 17
}
bs_300103.config = setmetatable(bs_300103.config, {
  __index = base.config
})

function bs_300103:ctor()
end

function bs_300103:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_300103:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_300103
