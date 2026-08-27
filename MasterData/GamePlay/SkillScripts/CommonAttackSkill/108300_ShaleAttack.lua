local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_108200 = class("bs_108200", bs_1)
local base = bs_1
bs_108200.config = {
  effectId_1 = 108301,
  effectId_2 = 108302,
  effectId_3 = 108303
}
bs_108200.config = setmetatable(bs_108200.config, {
  __index = base.config
})

function bs_108200:ctor()
end

function bs_108200:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_108200:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_108200
