local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_508 = class(" bs_508", bs_1)
local base = bs_1
bs_508.config = {
  effectId_1 = 10121,
  effectId_2 = 10122,
  audioId1 = 26,
  audioId2 = 26
}
bs_508.config = setmetatable(bs_508.config, {
  __index = base.config
})

function bs_508:ctor()
end

function bs_508:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_508:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_508
