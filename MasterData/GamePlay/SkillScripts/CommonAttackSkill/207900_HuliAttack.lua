local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_207900 = class("bs_207900", bs_1)
local base = bs_1
bs_207900.config = {effectId_trail = 207900}
bs_207900.config = setmetatable(bs_207900.config, {
  __index = base.config
})

function bs_207900:ctor()
end

function bs_207900:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_207900:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_207900
