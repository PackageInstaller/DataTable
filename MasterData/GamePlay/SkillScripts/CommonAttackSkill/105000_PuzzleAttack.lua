local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_105000 = class("bs_105000", bs_1)
local base = bs_1
bs_105000.config = {
  effectId_start1 = 105001,
  effectId_start2 = 105002,
  effectId_trail = 105014
}
bs_105000.config = setmetatable(bs_105000.config, {
  __index = base.config
})

function bs_105000:ctor()
end

function bs_105000:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_105000:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_105000
