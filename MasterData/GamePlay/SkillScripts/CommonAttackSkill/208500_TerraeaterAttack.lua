local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_208500 = class("bs_208500", bs_1)
local base = bs_1
bs_208500.config = {effectId_start1 = 208503, effectId_start2 = 208504}
bs_208500.config = setmetatable(bs_208500.config, {
  __index = base.config
})

function bs_208500:ctor()
end

function bs_208500:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_208500:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_208500
