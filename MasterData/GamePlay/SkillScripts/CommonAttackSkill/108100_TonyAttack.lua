local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_108100 = class("bs_108100", bs_1)
local base = bs_1
bs_108100.config = {
  effectId_1 = 108101,
  effectId_2 = 108102,
  effectId_3 = 108103
}
bs_108100.config = setmetatable(bs_108100.config, {
  __index = base.config
})

function bs_108100:ctor()
end

function bs_108100:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_108100:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_108100
