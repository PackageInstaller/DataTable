local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_104800 = class("bs_104800", bs_1)
local base = bs_1
bs_104800.config = {
  effectId_trail = 104801,
  action1 = 1001,
  action2 = 1004,
  audioId1 = 104301,
  audioId2 = 104303
}
bs_104800.config = setmetatable(bs_104800.config, {
  __index = base.config
})

function bs_104800:ctor()
end

function bs_104800:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_104800:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_104800
