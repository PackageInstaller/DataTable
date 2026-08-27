local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_310601 = class("bs_310601", bs_1)
local base = bs_1
bs_310601.config = {
  action1 = 1004,
  action2 = 1004,
  effectId_1 = 10490102,
  effectId_2 = 10490202
}
bs_310601.config = setmetatable(bs_310601.config, {
  __index = base.config
})

function bs_310601:ctor()
end

function bs_310601:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_310601:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_310601
