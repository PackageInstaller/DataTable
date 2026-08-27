local base = require("GamePlay.SkillScripts.RoleFSkill.FakeCommonPassive")
local bs_1032012 = class("bs_1032012", base)
bs_1032012.config = {}

function bs_1032012:ctor()
end

function bs_1032012:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_1032012_13", 1, self.OnAfterPlaySkill)
  self.Bj = 0
  self.caster.recordTable.pass_arg = self.arglist[2]
  self.caster.recordTable.cs_Passive = self.cskill
end

function bs_1032012:OnAfterPlaySkill(skill, role)
  if role == self.caster and skill.isCommonAttack then
    self.Bj = self.Bj + 1
    if self.Bj == self.arglist[1] - 1 then
      self.caster.recordTable.passive = true
      self.Bj = -1
    end
  end
end

function bs_1032012:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_1032012
