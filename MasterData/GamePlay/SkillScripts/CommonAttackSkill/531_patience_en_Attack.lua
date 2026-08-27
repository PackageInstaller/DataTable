local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_531 = class("bs_531", bs_1)
local base = bs_1
bs_531.config = {
  effectId_1 = 10589,
  effectId_2 = 10589,
  audioId1 = 21,
  audioId2 = 21
}
bs_531.config = setmetatable(bs_531.config, {
  __index = base.config
})

function bs_531:ctor()
end

function bs_531:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_531:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_531
