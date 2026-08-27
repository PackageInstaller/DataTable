local bs_20265 = class("bs_20265", LuaSkillBase)
local base = LuaSkillBase
bs_20265.config = {}

function bs_20265:ctor()
end

function bs_20265:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_20265_1", 2, self.OnAfterBattleStart)
  self.effect = nil
end

function bs_20265:OnAfterBattleStart()
end

function bs_20265:EventTrigger(EventName)
  if EventName == "" then
  end
  if EventName == "" then
  end
end

function bs_20265:Event1()
end

function bs_20265:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20265
