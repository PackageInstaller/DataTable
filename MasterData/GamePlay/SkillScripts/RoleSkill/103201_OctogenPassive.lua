local bs_103201 = class("bs_103201", LuaSkillBase)
local base = LuaSkillBase
bs_103201.config = {}

function bs_103201:ctor()
end

function bs_103201:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_103201_13", 1, self.OnAfterPlaySkill)
  self.Bj = 0
  self.caster.recordTable.pass_arg = self.arglist[2]
  self.caster.recordTable.cs_Passive = self.cskill
end

function bs_103201:OnAfterPlaySkill(skill, role)
  if role == self.caster and skill.isCommonAttack then
    self.Bj = self.Bj + 1
    if self.Bj == self.arglist[1] - 1 then
      self.caster.recordTable.passive = true
      self.Bj = -1
    end
  end
end

function bs_103201:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_103201
