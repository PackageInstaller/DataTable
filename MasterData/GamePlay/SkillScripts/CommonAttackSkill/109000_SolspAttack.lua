local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_109000 = class("bs_109000", bs_1)
local base = bs_1
bs_109000.config = {effectId_1 = 109001, effectId_2 = 109002}
bs_109000.config = setmetatable(bs_109000.config, {
  __index = base.config
})

function bs_109000:ctor()
end

function bs_109000:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_109000:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_109000
