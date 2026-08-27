local career_106 = class("career_106", LuaSkillBase)
local base = LuaSkillBase
career_106.config = {}

function career_106:ctor()
end

function career_106:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "career_106_5", 1, self.OnAfterBattleStart)
end

function career_106:OnAfterBattleStart()
  if self.caster.career == 2 then
    self.caster.recordTable.transfCareer = 4
  end
end

function career_106:OnCasterDie()
  base.OnCasterDie(self)
end

return career_106
