local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_210600 = class("bs_210600", bs_1)
local base = bs_1
bs_210600.config = {effectId_1 = 210601, effectId_2 = 210602}
bs_210600.config = setmetatable(bs_210600.config, {
  __index = base.config
})

function bs_210600:ctor()
end

function bs_210600:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_210600:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_210600
