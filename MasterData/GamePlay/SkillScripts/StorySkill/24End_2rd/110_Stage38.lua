local StorySkillBase = require("GamePlay.SkillScripts.StorySkill.StorySkillBase")
local sc_110 = class("sc_110", StorySkillBase)
local base = StorySkillBase
sc_110.config = {}
sc_110.config = setmetatable(sc_110.config, {
  __index = base.config
})

function sc_110:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function sc_110:OnAfterBattleStart()
  base.OnAfterBattleStart(self)
end

function sc_110:OnCasterDie()
  base.OnCasterDie(self)
end

return sc_110
