local base = require("GamePlay.SkillScripts.RoleSkill.102302_BoneeSkill")
local bs_300403 = class("bs_300403", base)
bs_300403.config = {
  buffId_Defup = 10230102,
  skill_time = 37,
  start_time = 17
}
bs_300403.config = setmetatable(bs_300403.config, {
  __index = base.config
})

function bs_300403:ctor()
end

function bs_300403:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_300403:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_300403
