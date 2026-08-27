local base = require("GamePlay.SkillScripts.CommonAttackSkill.102300_BoneeAttack")
local bs_300401 = class("bs_300401", base)
bs_300401.config = {}
bs_300401.config = setmetatable(bs_300401.config, {
  __index = base.config
})

function bs_300401:ctor()
end

function bs_300401:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_300401:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_300401
