local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_107900 = class("bs_107900", bs_1)
local base = bs_1
bs_107900.config = {
  effectId_1 = 107915,
  effectId_2 = 107916,
  effectId_3 = 107901
}
bs_107900.config = setmetatable(bs_107900.config, {
  __index = base.config
})

function bs_107900:ctor()
end

function bs_107900:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_107900:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_107900
