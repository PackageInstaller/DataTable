local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_2009800 = class(" bs_2009800", bs_1)
local base = bs_1
bs_2009800.config = {
  effectId_1 = 2009801,
  effectId_2 = 2009802,
  audioId1 = 2009801,
  time1 = 0,
  audioId2 = 2009802,
  time2 = 0,
  audioId3 = 2009803
}
bs_2009800.config = setmetatable(bs_2009800.config, {
  __index = base.config
})

function bs_2009800:ctor()
end

function bs_2009800:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_2009800:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_2009800
