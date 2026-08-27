local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_207800 = class("bs_207800", bs_1)
local base = bs_1
bs_207800.config = {}
bs_207800.config = setmetatable(bs_207800.config, {
  __index = base.config
})

function bs_207800:ctor()
end

function bs_207800:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_207800:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_207800
