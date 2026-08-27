local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_209200 = class("bs_209200", bs_1)
local base = bs_1
bs_209200.config = {effectId_trail = 209201}
bs_209200.config = setmetatable(bs_209200.config, {
  __index = base.config
})

function bs_209200:ctor()
end

function bs_209200:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_209200:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_209200
