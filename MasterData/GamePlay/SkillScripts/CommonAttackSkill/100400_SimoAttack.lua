local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_100400 = class("bs_100400", bs_1)
local base = bs_1
bs_100400.config = {effectId_trail = 100401}
bs_100400.config = setmetatable(bs_100400.config, {
  __index = base.config
})

function bs_100400:ctor()
end

function bs_100400:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_100400:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_100400
