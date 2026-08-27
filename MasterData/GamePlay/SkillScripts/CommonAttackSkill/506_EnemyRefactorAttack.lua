local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_506 = class("bs_506", bs_1)
local base = bs_1
bs_506.config = {
  effectId_trail = 10107,
  audioId1 = 23,
  audioId2 = 23
}
bs_506.config = setmetatable(bs_506.config, {
  __index = base.config
})

function bs_506:ctor()
end

function bs_506:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_506:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_506
