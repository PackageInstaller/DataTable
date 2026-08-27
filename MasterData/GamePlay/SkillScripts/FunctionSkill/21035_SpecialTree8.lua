local bs_21035 = class("bs_21035", LuaSkillBase)
local base = LuaSkillBase
bs_21035.config = {buffId = 110024}

function bs_21035:ctor()
end

function bs_21035:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_21035_1", 1, self.OnAfterBattleStart)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_21035_12", 1, self.OnAfterPlaySkill)
  self.Timer = nil
end

function bs_21035:OnAfterBattleStart()
  if self.Timer ~= nil then
    self.Timer:Stop()
    self.Timer = nil
  end
  self.Timer = LuaSkillCtrl:StartTimer(nil, 15, function()
    if self.caster:GetBuffTier(self.config.buffId) <= 45 - self.arglist[1] // 10 then
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.arglist[1] // 10)
    end
  end, nil, -1)
end

function bs_21035:OnAfterPlaySkill(skill, role)
  if role == self.caster and not skill.isCommonAttack then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0)
  end
end

function bs_21035:OnCasterDie()
  base.OnCasterDie(self)
  if self.Timer ~= nil then
    self.Timer:Stop()
    self.Timer = nil
  end
end

function bs_21035:LuaDispose()
  base.LuaDispose(self)
  if self.Timer ~= nil then
    self.Timer:Stop()
    self.Timer = nil
  end
end

return bs_21035
