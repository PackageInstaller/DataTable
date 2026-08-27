local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_507 = class("bs_507", bs_1)
local base = bs_1
bs_507.config = {
  effectId_1 = 10114,
  effectId_2 = 10115,
  audioId1 = 27,
  audioId2 = 27,
  Imp = true
}
bs_507.config = setmetatable(bs_507.config, {
  __index = base.config
})

function bs_507:ctor()
end

function bs_507:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_507:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_507
