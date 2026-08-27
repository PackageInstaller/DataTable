local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_107000 = class("bs_107000", bs_1)
local base = bs_1
bs_107000.config = {
  effectId_trail = 107001,
  effectId_start1 = 107013,
  effectId_start2 = 107014
}
bs_107000.config = setmetatable(bs_107000.config, {
  __index = base.config
})

function bs_107000:ctor()
end

function bs_107000:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_107000:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_107000
