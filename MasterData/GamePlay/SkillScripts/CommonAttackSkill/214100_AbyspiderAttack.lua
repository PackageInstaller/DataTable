local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_214000 = class("bs_214000", bs_1)
local base = bs_1
bs_214000.config = {
  action1 = 1001,
  action2 = 1004,
  effectId_1 = 214101,
  effectId_2 = 214113,
  effectId_3 = 214102
}
bs_214000.config = setmetatable(bs_214000.config, {
  __index = base.config
})

function bs_214000:ctor()
end

function bs_214000:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_214000:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_214000
