local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_207603 = class("bs_207603", bs_1)
local base = bs_1
bs_207603.config = {
  action2 = 1001,
  effectId_start1 = 207602,
  effectId_start2 = 207602
}
bs_207603.config = setmetatable(bs_207603.config, {
  __index = base.config
})

function bs_207603:ctor()
end

function bs_207603:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_207603:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_207603
