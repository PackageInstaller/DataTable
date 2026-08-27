local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_212100 = class("bs_212100", bs_1)
local base = bs_1
bs_212100.config = {effectId_1 = 212117, effectId_2 = 212118}
bs_212100.config = setmetatable(bs_212100.config, {
  __index = base.config
})

function bs_212100:ctor()
end

function bs_212100:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_212100:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_212100
