local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_103300 = class("bs_103300", bs_1)
local base = bs_1
bs_103300.config = {
  effectId_trail = 103301,
  effectId_start1 = 103308,
  effectId_start2 = 103309,
  audioId1 = 103301,
  audioId2 = 103302,
  audioId5 = 103303
}
bs_103300.config = setmetatable(bs_103300.config, {
  __index = base.config
})

function bs_103300:ctor()
end

function bs_103300:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_103300:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_103300
