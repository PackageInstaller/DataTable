local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_530 = class("bs_530", bs_1)
local base = bs_1
bs_530.config = {
  effectId_1 = 10573,
  effectId_2 = 10574,
  audioId1 = 322,
  audioId2 = 323
}
bs_530.config = setmetatable(bs_530.config, {
  __index = base.config
})

function bs_530:ctor()
end

function bs_530:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_530:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_530
