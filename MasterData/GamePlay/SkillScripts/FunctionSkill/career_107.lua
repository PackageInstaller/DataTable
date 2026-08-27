local career_107 = class("career_107", LuaSkillBase)
local base = LuaSkillBase
career_107.config = {}

function career_107:ctor()
end

function career_107:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "career_107_5", 1, self.OnAfterBattleStart)
end

function career_107:OnAfterBattleStart()
  if self.caster.career == 3 then
    self.caster.recordTable.transfCareer = 1
  end
end

function career_107:OnCasterDie()
  base.OnCasterDie(self)
end

return career_107
