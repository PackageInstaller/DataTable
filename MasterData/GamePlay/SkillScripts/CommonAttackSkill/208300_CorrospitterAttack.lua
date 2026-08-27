local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_208300 = class("bs_208300", bs_1)
local base = bs_1
bs_208300.config = {effectId_trail = 208302}
bs_208300.config = setmetatable(bs_208300.config, {
  __index = base.config
})

function bs_208300:ctor()
end

function bs_208300:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_208300:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_208300
