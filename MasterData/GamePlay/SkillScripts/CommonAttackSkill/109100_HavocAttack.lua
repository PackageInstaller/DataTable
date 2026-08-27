local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_109100 = class("bs_109100", bs_1)
local base = bs_1
bs_109100.config = {
  effectId_1 = 109101,
  effectId_2 = 109102,
  effectId_3 = 109103
}
bs_109100.config = setmetatable(bs_109100.config, {
  __index = base.config
})

function bs_109100:ctor()
end

function bs_109100:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_109100:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_109100
