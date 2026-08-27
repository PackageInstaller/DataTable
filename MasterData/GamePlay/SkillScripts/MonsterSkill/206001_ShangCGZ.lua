local bs_200602 = require("GamePlay.SkillScripts.MonsterSkill.200602_CGZ_RefactorSY")
local bs_206001 = class("bs_206001", bs_200602)
local base = bs_200602
bs_206001.config = {}
bs_206001.config = setmetatable(bs_206001.config, {
  __index = base.config
})

function bs_206001:ctor()
end

function bs_206001:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_206001:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_206001
