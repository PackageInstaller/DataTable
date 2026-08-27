local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_107100 = class("bs_107100", bs_1)
local base = bs_1
bs_107100.config = {
  effectId_trail = 107101,
  effectId_start1 = 107116,
  effectId_start2 = 107116
}
bs_107100.config = setmetatable(bs_107100.config, {
  __index = base.config
})

function bs_107100:ctor()
end

function bs_107100:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_107100:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_107100
