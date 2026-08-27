local bs_17512 = class("bs_17512", LuaSkillBase)
local base = LuaSkillBase
bs_17512.config = {buffId = 2253}

function bs_17512:ctor()
end

function bs_17512:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.OnSelfStartMove, "bs_17512_1", 1, self.OnStartMove)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_17511_2", 1, self.OnAfterBattleStart)
end

function bs_17512:OnAfterBattleStart()
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], self.TimerCallBack, self)
end

function bs_17512:TimerCallBack()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, false, self.caster, true)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], self.TimerCallBack, self)
end

function bs_17512:OnStartMove()
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0, false, false)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], self.TimerCallBack, self)
  if 1 > self.caster:GetBuffTier(self.config.buffId) then
    return
  end
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0, false, false)
end

function bs_17512:OnCasterDie()
  base.OnCasterDie(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

function bs_17512:OnDispose()
  base.OnDispose(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

return bs_17512
