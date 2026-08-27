local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_208200 = class("bs_208200", bs_1)
local base = bs_1
bs_208200.config = {
  action1 = 1001,
  action2 = 1004,
  effectId_start1 = 208201,
  effectId_start2 = 208202
}
bs_208200.config = setmetatable(bs_208200.config, {
  __index = base.config
})

function bs_208200:ctor()
end

function bs_208200:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_208200:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_208200
