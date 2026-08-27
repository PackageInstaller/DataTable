local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_211600 = class("bs_211600", bs_1)
local base = bs_1
bs_211600.config = {action2 = 1001, effectId_trail = 208401}
bs_211600.config = setmetatable(bs_211600.config, {
  __index = base.config
})

function bs_211600:ctor()
end

function bs_211600:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_211600:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_211600
