local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_108900 = class("bs_108900", bs_1)
local base = bs_1
bs_108900.config = {
  effectId_1 = 108901,
  effectId_2 = 108902,
  effectId_3 = 108903
}
bs_108900.config = setmetatable(bs_108900.config, {
  __index = base.config
})

function bs_108900:ctor()
end

function bs_108900:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_108900:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_108900
