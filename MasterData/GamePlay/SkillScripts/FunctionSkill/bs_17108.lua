local bs_17108 = class("bs_17108", LuaSkillBase)
local base = LuaSkillBase
bs_17108.config = {buffId = 2169}

function bs_17108:ctor()
end

function bs_17108:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.OnSelfAttrChanged, "bs_17108_1", 1, self.OnCasterAttributeChange)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_17108_2", 1, self.OnAfterBattleStart)
  self.dodge = nil
  self.caster.recordTable["self.dodge"] = self.caster.dodge
end

function bs_17108:OnAfterBattleStart()
  local AtrrFromDodge = self.caster.dodge
  if AtrrFromDodge > self.arglist[1] then
    AtrrFromDodge = self.arglist[1]
  end
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0, true, false)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, AtrrFromDodge, nil, true)
end

function bs_17108:OnCasterAttributeChange()
  if self.caster.recordTable["self.dodge"] ~= self.caster.dodge then
    self.caster.recordTable["self.dodge"] = self.caster.dodge
    local AtrrFromDodge = self.caster.dodge
    if AtrrFromDodge > self.arglist[1] then
      AtrrFromDodge = self.arglist[1]
    end
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0, true, false)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, AtrrFromDodge, nil, true)
    self:PlayChipEffect()
  end
end

function bs_17108:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_17108
