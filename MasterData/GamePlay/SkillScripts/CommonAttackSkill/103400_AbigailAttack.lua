local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_103400 = class("bs_103400", bs_1)
local base = bs_1
bs_103400.config = {
  effectId_trail = 10798,
  effectId_start1 = 10453,
  effectId_start2 = 10453,
  action1 = 1021,
  action2 = 1021,
  audioId1 = 276,
  audioId2 = 276,
  audioId5 = 277
}
bs_103400.config = setmetatable(bs_103400.config, {
  __index = base.config
})

function bs_103400:ctor()
end

function bs_103400:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_103400:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_103400
