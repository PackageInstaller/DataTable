local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_2100001 = class("bs_2100001", bs_1)
local base = bs_1
bs_2100001.config = {effectId_trail = 210001}
bs_2100001.config = setmetatable(bs_2100001.config, {
  __index = base.config
})

function bs_2100001:ctor()
end

function bs_2100001:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_2100001:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_2100001
