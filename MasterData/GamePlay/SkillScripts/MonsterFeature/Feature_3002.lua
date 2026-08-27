local bs_3002 = class("bs_3002", LuaSkillBase)
local base = LuaSkillBase
bs_3002.config = {}

function bs_3002:ctor()
end

function bs_3002:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.StoryEvent, "StoryEnd")
end

function bs_3002:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_3002
