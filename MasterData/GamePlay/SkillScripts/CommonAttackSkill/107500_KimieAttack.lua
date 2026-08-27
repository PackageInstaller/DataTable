local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_107500 = class("bs_107500", bs_1)
local base = bs_1
bs_107500.config = {
  effectId_trail = 107501,
  effectId_start1 = 107503,
  effectId_start2 = 107504
}
bs_107500.config = setmetatable(bs_107500.config, {
  __index = base.config
})

function bs_107500:ctor()
end

function bs_107500:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_107500:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_107500
