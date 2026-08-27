local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_602 = class("bs_602", bs_1)
local base = bs_1
bs_602.config = {effectId_1 = 60201, effectId_2 = 60202}
bs_602.config = setmetatable(bs_602.config, {
  __index = base.config
})

function bs_602:ctor()
end

function bs_602:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_602:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_602
