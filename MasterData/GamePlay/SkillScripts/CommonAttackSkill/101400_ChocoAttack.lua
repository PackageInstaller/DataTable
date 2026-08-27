local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_101400 = class("bs_101400", bs_1)
local base = bs_1
bs_101400.config = {
  effectId_trail = 101401,
  effectId_trail_ex = 101402,
  effectId_start1 = 101408,
  effectId_start2 = 101409,
  audioId1 = 101401,
  audioId2 = 101402
}
bs_101400.config = setmetatable(bs_101400.config, {
  __index = base.config
})

function bs_101400:ctor()
end

function bs_101400:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_101400:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_101400
