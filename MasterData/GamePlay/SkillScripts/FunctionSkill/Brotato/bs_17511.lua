local bs_17511 = class("bs_17511", LuaSkillBase)
local base = LuaSkillBase
bs_17511.config = {buffId = 2252}

function bs_17511:ctor()
end

function bs_17511:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterPlaySkillTrigger("bs_17511_1", 1, self.OnAfterPlaySkill, self.caster, nil, nil, nil, nil, nil, nil, eSkillTag.commonAttack)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_17511_2", 1, self.OnAfterBattleStart)
end

function bs_17511:OnAfterBattleStart()
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], self.TimerCallBack, self)
end

function bs_17511:TimerCallBack()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true, self.caster, true)
end

function bs_17511:OnAfterPlaySkill(skill, role)
  if role ~= self.caster then
    return
  end
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], self.TimerCallBack, self)
  if 1 > self.caster:GetBuffTier(self.config.buffId) then
    return
  end
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0, true, false)
end

function bs_17511:OnCasterDie()
  base.OnCasterDie(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

function bs_17511:OnDispose()
  base.OnDispose(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

return bs_17511
