local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_208400 = class("bs_208400", bs_1)
local base = bs_1
bs_208400.config = {action2 = 1001, effectId_trail = 208401}
bs_208400.config = setmetatable(bs_208400.config, {
  __index = base.config
})

function bs_208400:ctor()
end

function bs_208400:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_208400:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_208400
