local base = require("GamePlay.SkillScripts.RoleSkill.103802_SakuyaSkill")
local bs_300203 = class("bs_300203", base)
bs_300203.config = {skill_time = 37, start_time = 17}
bs_300203.config = setmetatable(bs_300203.config, {
  __index = base.config
})

function bs_300203:ctor()
end

function bs_300203:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_300203:PlaySkill(data)
  base.PlaySkill(self, data)
end

function bs_300203:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_300203
