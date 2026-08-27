local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_105400 = class("bs_105400", bs_1)
local base = bs_1
bs_105400.config = {effectId_1 = 105401, effectId_2 = 105402}
bs_105400.config = setmetatable(bs_105400.config, {
  __index = base.config
})

function bs_105400:ctor()
end

function bs_105400:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_105400:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_105400
