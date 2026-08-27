local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_204300 = class("bs_204300", bs_1)
local base = bs_1
bs_204300.config = {effectId_trail = 204300}
bs_204300.config = setmetatable(bs_204300.config, {
  __index = base.config
})

function bs_204300:ctor()
end

function bs_204300:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_204300:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_204300
