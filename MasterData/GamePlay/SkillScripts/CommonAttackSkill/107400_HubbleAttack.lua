local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_107400 = class("bs_107400", bs_1)
local base = bs_1
bs_107400.config = {effectId_trail = 107401}
bs_107400.config = setmetatable(bs_107400.config, {
  __index = base.config
})

function bs_107400:ctor()
end

function bs_107400:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_107400:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_107400
