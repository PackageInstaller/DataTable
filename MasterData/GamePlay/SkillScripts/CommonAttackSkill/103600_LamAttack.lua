local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_103600 = class("bs_103600", bs_1)
local base = bs_1
bs_103600.config = {
  GS_Id = 8000,
  effectId_trail = 10179,
  audioId1 = 111,
  time1 = 0,
  audioId2 = 112,
  time2 = 0,
  Imp = true
}
bs_103600.config = setmetatable(bs_103600.config, {
  __index = base.config
})

function bs_103600:ctor()
end

function bs_103600:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_103600:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_103600
