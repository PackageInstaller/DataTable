local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_209400 = class("bs_209400", bs_1)
local base = bs_1
bs_209400.config = {effectId_trail = 209401}
bs_209400.config = setmetatable(bs_209400.config, {
  __index = base.config
})

function bs_209400:ctor()
end

function bs_209400:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_209400:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_209400
