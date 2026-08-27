local career_108 = class("career_108", LuaSkillBase)
local base = LuaSkillBase
career_108.config = {}

function career_108:ctor()
end

function career_108:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "career_108_5", 1, self.OnAfterBattleStart)
end

function career_108:OnAfterBattleStart()
  if self.caster.career == 4 then
    self.caster.recordTable.transfCareer = 3
  end
end

function career_108:OnCasterDie()
  base.OnCasterDie(self)
end

return career_108
