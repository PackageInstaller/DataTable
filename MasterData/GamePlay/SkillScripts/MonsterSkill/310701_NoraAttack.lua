local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_310701 = class("bs_310701", bs_1)
local base = bs_1
bs_310701.config = {
  effectId_trail = 10480102,
  action1 = 1021,
  action2 = 1044,
  audioId1 = 104301,
  audioId2 = 104303
}
bs_310701.config = setmetatable(bs_310701.config, {
  __index = base.config
})

function bs_310701:ctor()
end

function bs_310701:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_310701:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_310701
