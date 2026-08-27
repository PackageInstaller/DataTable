local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_524 = class("bs_524", bs_1)
local base = bs_1
bs_524.config = {
  effectId_1 = 10435,
  effectId_2 = 10436,
  audioId1 = 311,
  audioId2 = 312
}
bs_524.config = setmetatable(bs_524.config, {
  __index = base.config
})

function bs_524:ctor()
end

function bs_524:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_524:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_524
