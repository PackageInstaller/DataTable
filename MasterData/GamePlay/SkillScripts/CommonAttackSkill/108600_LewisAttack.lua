local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_108600 = class("bs_108600", bs_1)
local base = bs_1
bs_108600.config = {
  effectId_1 = 108601,
  effectId_2 = 108602,
  effectId_3 = 108603
}
bs_108600.config = setmetatable(bs_108600.config, {
  __index = base.config
})

function bs_108600:ctor()
end

function bs_108600:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_108600:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_108600
