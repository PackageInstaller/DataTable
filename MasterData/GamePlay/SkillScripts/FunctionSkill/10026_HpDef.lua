local bs_10015 = require("GamePlay.SkillScripts.FunctionSkill.10015_Anger")
local bs_10026 = class("bs_10026", bs_10015)
local base = bs_10015
bs_10026.config = {buffId = 75}
bs_10026.config = setmetatable(bs_10026.config, {
  __index = base.config
})

function bs_10026:ctor()
end

function bs_10026:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_10026:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10026
