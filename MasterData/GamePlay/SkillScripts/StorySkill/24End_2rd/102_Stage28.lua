local StorySkillBase = require("GamePlay.SkillScripts.StorySkill.StorySkillBase")
local sc_102 = class("sc_102", StorySkillBase)
local base = StorySkillBase
sc_102.config = {}
sc_102.config = setmetatable(sc_102.config, {
  __index = base.config
})

function sc_102:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function sc_102:OnAfterBattleStart()
  base.OnAfterBattleStart(self)
  if self:isBattleRoom(1302821) then
    self:flow1()
  end
end

function sc_102:flow1()
end

function sc_102:OnCasterDie()
  base.OnCasterDie(self)
end

return sc_102
