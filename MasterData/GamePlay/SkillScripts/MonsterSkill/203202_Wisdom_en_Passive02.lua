local bs_202602 = require("GamePlay.SkillScripts.MonsterSkill.202602_WisdomPassive02")
local bs_203202 = class("bs_203202", bs_202602)
local base = bs_202602
bs_203202.config = {}
bs_203202.config = setmetatable(bs_203202.config, {
  __index = base.config
})

function bs_203202:ctor()
end

function bs_203202:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_203202:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_203202
