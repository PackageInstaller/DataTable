local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_211500 = class("bs_211500", bs_1)
local base = bs_1
bs_211500.config = {effectId_trail = 204300}
bs_211500.config = setmetatable(bs_211500.config, {
  __index = base.config
})

function bs_211500:ctor()
end

function bs_211500:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_211500:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_211500
