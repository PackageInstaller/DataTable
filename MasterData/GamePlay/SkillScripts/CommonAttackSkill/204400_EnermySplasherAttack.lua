local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_204400 = class("bs_204400", bs_1)
local base = bs_1
bs_204400.config = {effectId_trail = 204402}
bs_204400.config = setmetatable(bs_204400.config, {
  __index = base.config
})

function bs_204400:ctor()
end

function bs_204400:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_204400:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_204400
