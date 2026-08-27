local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_207600 = class("bs_207600", bs_1)
local base = bs_1
bs_207600.config = {
  action2 = 1001,
  effectId_start1 = 207600,
  effectId_start2 = 207600
}
bs_207600.config = setmetatable(bs_207600.config, {
  __index = base.config
})

function bs_207600:ctor()
end

function bs_207600:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_207600:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_207600
