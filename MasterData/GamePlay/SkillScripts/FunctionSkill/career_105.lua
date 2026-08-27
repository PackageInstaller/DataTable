local career_105 = class("career_105", LuaSkillBase)
local base = LuaSkillBase
career_105.config = {}

function career_105:ctor()
end

function career_105:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "career_105_5", 1, self.OnAfterBattleStart)
end

function career_105:OnAfterBattleStart()
  if self.caster.career == 1 then
    self.caster.recordTable.transfCareer = 2
  end
end

function career_105:OnCasterDie()
  base.OnCasterDie(self)
end

return career_105
