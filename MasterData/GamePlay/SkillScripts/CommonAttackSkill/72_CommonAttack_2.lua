local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_72 = class("bs_72", bs_1)
local base = bs_1
bs_72.config = {effectId_trail = 131}
bs_72.config = setmetatable(bs_72.config, {
  __index = base.config
})

function bs_72:ctor()
end

function bs_72:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_72:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_72
