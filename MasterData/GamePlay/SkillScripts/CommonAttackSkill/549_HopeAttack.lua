local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_522 = class("bs_522", bs_1)
local base = bs_1
bs_522.config = {
  effectId_1 = 1042501,
  effectId_2 = 1042601,
  audioId1 = 302,
  audioId3 = 303
}
bs_522.config = setmetatable(bs_522.config, {
  __index = base.config
})

function bs_522:ctor()
end

function bs_522:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_522:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_522
