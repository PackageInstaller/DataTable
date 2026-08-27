local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_502 = class("bs_502", bs_1)
local base = bs_1
bs_502.config = {effectId_trail = 10088, audioId4 = 28}
bs_502.config = setmetatable(bs_502.config, {
  __index = base.config
})

function bs_502:ctor()
end

function bs_502:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_502:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_502
