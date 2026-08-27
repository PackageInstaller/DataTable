local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_213400 = class("bs_213400", bs_1)
local base = bs_1
bs_213400.config = {effectId_trail = 213401}
bs_213400.config = setmetatable(bs_213400.config, {
  __index = base.config
})

function bs_213400:ctor()
end

function bs_213400:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_213400:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_213400
