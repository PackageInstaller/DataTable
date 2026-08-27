local bs_17207 = class("bs_17207", LuaSkillBase)
local base = LuaSkillBase
bs_17207.config = {buffid_counter = 107801, buffId = 2201}

function bs_17207:ctor()
end

function bs_17207:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_17207_1", 1, self.OnAfterBattleStart)
  self:AddSetHurtTrigger("bs_17207_2", 2, self.OnSetHurt, nil, nil, self.caster.belongNum, eBattleRoleBelong.enemy)
end

function bs_17207:OnAfterBattleStart()
  self.damTimer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], self.CallBack, self, -1)
  self:CallBack()
end

function bs_17207:CallBack()
  if self.damTimer ~= nil and self.damTimer:IsOver() then
    self.damTimer = nil
  end
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  if targetlist == nil or targetlist.Count == 0 then
    return
  end
  if targetlist.Count > 0 then
    for i = 0, targetlist.Count - 1 do
      if 1 > targetlist[i].targetRole:GetBuffTier(self.config.buffId) then
        LuaSkillCtrl:CallBuff(self, targetlist[i].targetRole, self.config.buffId, 1, self.arglist[3], true)
      end
    end
  end
end

function bs_17207:OnSetHurt(context)
  local target = context.target
  if target:GetBuffTier(self.config.buffId) > 0 and LuaSkillCtrl:CallRange(1, 1000) <= self.arglist[2] then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffid_counter, 1, nil, false)
    LuaSkillCtrl:DispelBuff(target, self.config.buffId, 0, false)
  end
end

function bs_17207:OnCasterDie()
  base.OnCasterDie(self)
  if self.damTimer then
    self.damTimer:Stop()
    self.damTimer = nil
  end
end

return bs_17207
