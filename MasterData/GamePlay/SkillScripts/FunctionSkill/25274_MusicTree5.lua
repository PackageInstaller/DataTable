local bs_25274 = class("bs_25274", LuaSkillBase)
local base = LuaSkillBase
bs_25274.config = {buffId = 2133}

function bs_25274:ctor()
end

function bs_25274:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_25274_1", 1, self.OnAfterBattleStart)
  self.Timer = nil
  if self.Timer ~= nil then
    self.Timer:stop()
    self.Timer = nil
  end
end

function bs_25274:OnAfterBattleStart()
  local buffTier = self.arglist[2] // 50
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, buffTier, nil)
  if self.Timer ~= nil then
    self.Timer:stop()
    self.Timer = nil
  end
  local callback = BindCallback(self, self.FunSkill)
  self.Timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], callback, self, -1, 0)
end

function bs_25274:FunSkill()
  if self.caster:GetBuffTier(self.config.buffId) > 0 then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 1)
  elseif self.Timer ~= nil then
    self.Timer:Stop()
    self.Timer = nil
  end
end

function bs_25274:OnCasterDie()
  base.OnCasterDie(self)
  if self.Timer ~= nil then
    self.Timer:Stop()
    self.Timer = nil
  end
end

function bs_25274:LuaDispose()
  base.LuaDispose(self)
  if self.Timer ~= nil then
    self.Timer:Stop()
    self.Timer = nil
  end
end

return bs_25274
