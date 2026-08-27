local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_512 = class("bs_512", bs_1)
local base = bs_1
bs_512.config = {
  effectId_trail = 10218,
  audioId1 = 64,
  audioId2 = 64,
  Imp = fasle,
  audioId5 = 81
}
bs_512.config = setmetatable(bs_512.config, {
  __index = base.config
})

function bs_512:ctor()
end

function bs_512:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_512:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_512
