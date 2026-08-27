local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_107700 = class("bs_107700", bs_1)
local base = bs_1
bs_107700.config = {effectId_trail = 107701}
bs_107700.config = setmetatable(bs_107700.config, {
  __index = base.config
})

function bs_107700:ctor()
end

function bs_107700:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_107700:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_107700
