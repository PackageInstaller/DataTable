local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_521 = class("bs_521", bs_1)
local base = bs_1
bs_521.config = {}
bs_521.config = setmetatable(bs_521.config, {
  __index = base.config
})

function bs_521:ctor()
end

function bs_521:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_521:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_521
