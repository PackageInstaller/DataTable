local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_711 = class("bs_711", bs_1)
local base = bs_1
bs_711.config = {action1 = 1001, action2 = 1001}
bs_711.config = setmetatable(bs_711.config, {
  __index = base.config
})

function bs_711:ctor()
end

function bs_711:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_711:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_711
