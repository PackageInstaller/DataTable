local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_100900 = class("bs_100900", bs_1)
local base = bs_1
bs_100900.config = {
  effectId_trail = 100901,
  audioId1 = 100903,
  audioId2 = 100904,
  audioId4 = 100905
}
bs_100900.config = setmetatable(bs_100900.config, {
  __index = base.config
})

function bs_100900:ctor()
end

function bs_100900:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_100900:SkillEventFunc(configData, effect, eventId, target)
  base.SkillEventFunc(self, configData, effect, eventId, target)
end

function bs_100900:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_100900
