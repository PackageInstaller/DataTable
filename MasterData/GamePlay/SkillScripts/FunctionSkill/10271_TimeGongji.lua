local bs_10271 = class("bs_10271", LuaSkillBase)
local base = LuaSkillBase
bs_10271.config = {
  buffId = 1186,
  buffTier = 1,
  effectId = 10892
}

function bs_10271:ctor()
end

function bs_10271:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10271_1", 1, self.OnAfterBattleStart)
end

function bs_10271:OnAfterBattleStart()
  if self.timer == nil then
    self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], self.CallBack, self, -1)
  end
end

function bs_10271:CallBack()
  if self.timer ~= nil and self.timer:IsOver() then
    self.timer = nil
  end
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 59, 10)
  if targetlist.Count < 1 then
    return
  end
  local targetRole = targetlist[0].targetRole
  if targetRole == self.caster and targetlist.Count > 1 and targetlist[1].targetRole.roleType == 1 then
    targetRole = targetlist[1].targetRole
  end
  if targetRole.roleType ~= 1 then
    return
  end
  LuaSkillCtrl:CallBuff(self, targetRole, self.config.buffId, self.config.buffTier, nil, true)
  LuaSkillCtrl:CallChipSuitInvoke(self.caster, targetRole)
  LuaSkillCtrl:CallEffect(targetRole, self.config.effectId, self)
  self:PlayChipEffect()
end

function bs_10271:OnCasterDie()
  base.OnCasterDie(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

return bs_10271
