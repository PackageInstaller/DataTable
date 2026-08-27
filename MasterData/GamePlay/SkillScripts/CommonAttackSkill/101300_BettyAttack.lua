local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_101300 = class("bs_101300", bs_1)
local base = bs_1
bs_101300.config = {
  effectId_1 = 101301,
  effectId_2 = 101302,
  audioId1 = 101301,
  audioId2 = 101302,
  audioId3 = 101303
}
bs_101300.config = setmetatable(bs_101300.config, {
  __index = base.config
})

function bs_101300:ctor()
end

function bs_101300:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_101300:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_101300
