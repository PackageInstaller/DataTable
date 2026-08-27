local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_213200 = class("bs_213200", bs_1)
local base = bs_1
bs_213200.config = {}
bs_213200.config = setmetatable(bs_213200.config, {
  __index = base.config
})

function bs_213200:ctor()
end

function bs_213200:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_213200:RealPlaySkill(target, data)
end

function bs_213200:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_213200
