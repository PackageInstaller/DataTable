local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_105900 = class("bs_105900", bs_1)
local base = bs_1
bs_105900.config = {effectId_1 = 105901, effectId_2 = 105902}
bs_105900.config = setmetatable(bs_105900.config, {
  __index = base.config
})

function bs_105900:ctor()
end

function bs_105900:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_105900:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_105900
