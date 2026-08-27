local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_102000 = class("bs_102000", bs_1)
local base = bs_1
bs_102000.config = {
  effectId_1 = 102001,
  effectId_2 = 102002,
  audioId1 = 102001,
  audioId2 = 102002
}
bs_102000.config = setmetatable(bs_102000.config, {
  __index = base.config
})

function bs_102000:ctor()
end

function bs_102000:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_102000:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_102000
