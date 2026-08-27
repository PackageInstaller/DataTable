local base = require("GamePlay.SkillScripts.RoleFSkill.FakeCommonPassive")
local bs_1037012 = class("bs_1037012", base)
bs_1037012.config = {
  effectId_num1 = 10320,
  effectId_num2 = 10321,
  effectId_num3 = 10322,
  effectId_num4 = 10323,
  effectId_num5 = 10324,
  buffId1 = 10370101,
  audioId1 = 286
}

function bs_1037012:ctor()
end

function bs_1037012:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_1037012_12", 1, self.OnAfterPlaySkill)
  self.caster.recordTable.Passive = 0
  self.caster.recordTable.X_num = 0
end

function bs_1037012:OnAfterPlaySkill(skill, role)
  if role == self.caster and skill.isCommonAttack then
    self.caster.recordTable.Passive = self.caster.recordTable.Passive + 1
    if self.caster.recordTable.Passive >= self.arglist[1] and self.caster.recordTable.X_num < 5 then
      local X_number = self.caster.recordTable.X_num + 1
      local X_effect = self.config["effectId_num" .. tostring(X_number)]
      self.caster.recordTable.Passive = 0
      LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId1)
      LuaSkillCtrl:CallEffect(self.caster, X_effect, self, nil, nil, nil, false)
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId1, 1, nil, true)
      self.caster.recordTable.X_num = self.caster.recordTable.X_num + 1
    end
  end
end

function bs_1037012:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_1037012
