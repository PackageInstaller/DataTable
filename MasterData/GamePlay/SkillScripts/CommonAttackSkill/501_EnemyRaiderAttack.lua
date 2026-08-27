local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_501 = class("bs_501", bs_1)
local base = bs_1
bs_501.config = {
  effectId_1 = 10081,
  effectId_2 = 10082,
  audioId1 = 22,
  audioId2 = 200102,
  Imp = true
}
bs_501.config = setmetatable(bs_501.config, {
  __index = base.config
})

function bs_501:ctor()
end

function bs_501:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_501:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_501
