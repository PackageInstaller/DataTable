local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_103000 = class("bs_103000", bs_1)
local base = bs_1
bs_103000.config = {
  effectId_trail = 103001,
  effectId_trail_ex = 103003,
  audioId1 = 103001,
  audioId2 = 103002,
  audioId5 = 103003
}
bs_103000.config = setmetatable(bs_103000.config, {
  __index = base.config
})

function bs_103000:ctor()
end

function bs_103000:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_103000:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_103000
