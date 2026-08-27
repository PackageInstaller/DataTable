local Feature_1023 = class("Feature_1023", LuaSkillBase)
local base = LuaSkillBase
Feature_1023.config = {buffId_1 = 2112, buffId_2 = 2113}

function Feature_1023:ctor()
end

function Feature_1023:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "Feature_1023", 1, self.OnBattleStart)
  self:AddAfterPlaySkillTrigger("Feature_1023", 1, self.OnAfterPlaySkill, nil, nil, nil, nil, nil, nil, nil, eSkillTag.ultSkill)
end

function Feature_1023:OnBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_1, self.arglist[1], nil, true)
end

function Feature_1023:OnAfterPlaySkill(skill, role)
  local buffTier_pre = self.caster:GetBuffTier(self.config.buffId_1)
  if buffTier_pre == 0 then
    return
  end
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_1, 1, true, false)
  local buffTier_now = self.caster:GetBuffTier(self.config.buffId_1)
  if buffTier_now == nil or buffTier_now == 0 then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_2, 1, nil, true)
  end
end

function Feature_1023:OnCasterDie()
  base.OnCasterDie(self)
end

return Feature_1023
