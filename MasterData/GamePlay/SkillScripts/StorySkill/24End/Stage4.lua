local StorySkillBase = require("GamePlay.SkillScripts.StorySkill.StorySkillBase")
local sc_2 = class("sc_2", StorySkillBase)
local base = StorySkillBase
sc_2.config = {}
sc_2.config = setmetatable(sc_2.config, {
  __index = base.config
})

function sc_2:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function sc_2:OnAfterBattleStart()
  base.OnAfterBattleStart(self)
end

function sc_2:OnCasterDie()
  base.OnCasterDie(self)
end

return sc_2
