local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_107600 = class("bs_107600", bs_1)
local base = bs_1
bs_107600.config = {effectId_trail = 107601}
bs_107600.config = setmetatable(bs_107600.config, {
  __index = base.config
})

function bs_107600:ctor()
end

function bs_107600:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_107600:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_107600
