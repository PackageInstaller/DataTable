local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_208100 = class("bs_208100", bs_1)
local base = bs_1
bs_208100.config = {effectId_start1 = 105011, effectId_start2 = 105011}
bs_208100.config = setmetatable(bs_208100.config, {
  __index = base.config
})

function bs_208100:ctor()
end

function bs_208100:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_208100:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_208100
