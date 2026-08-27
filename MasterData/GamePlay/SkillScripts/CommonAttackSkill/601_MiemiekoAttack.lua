local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_601 = class("bs_601", bs_1)
local base = bs_1
bs_601.config = {action1 = 1106, action2 = 1106}
bs_601.config = setmetatable(bs_601.config, {
  __index = base.config
})

function bs_601:ctor()
end

function bs_601:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_601:PlaySkill(passdata)
end

function bs_601:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_601
