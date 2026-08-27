local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_210200 = class("bs_210200", bs_1)
local base = bs_1
bs_210200.config = {
  effectId_trail = 210200,
  action1 = 1001,
  action2 = 1001,
  effectId_action_2 = 210204,
  effectId_action_1 = 210204
}
bs_210200.config = setmetatable(bs_210200.config, {
  __index = base.config
})

function bs_210200:ctor()
end

function bs_210200:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_210200:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_210200
