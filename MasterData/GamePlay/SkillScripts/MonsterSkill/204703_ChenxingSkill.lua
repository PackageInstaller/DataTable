local bs_204703 = class("bs_204703", LuaSkillBase)
local base = LuaSkillBase
bs_204703.config = {
  actionId_start = 1022,
  actionId_loop = 1023,
  actionId_end = 1024,
  effectId = 10921,
  effectIdDie = 10922,
  buffID_1158 = 1158,
  audioId2 = 88,
  buffId_wudi = 88,
  effectHithurt = 10491,
  effectIdLight = 10492
}

function bs_204703:ctor()
end

function bs_204703:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_204703_1", 1, self.OnAfterBattleStart)
end

function bs_204703:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_wudi, 1, nil, true)
  LuaSkillCtrl:StartAvgWithPauseGame("23carnival_s23_1", nil, nil)
  LuaSkillCtrl:StartTimer(self, 5, function()
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 6, 0)
    if 0 < targetlist.Count then
      for i = 0, targetlist.Count - 1 do
        if targetlist[i].targetRole.roleDataId == 1068 then
          local hurt = targetlist[i].targetRole.maxHp + 1
          LuaSkillCtrl:RemoveLife(hurt, self, targetlist[i].targetRole, true, nil, true, true)
          self.effect = LuaSkillCtrl:CallEffect(self.caster, self.config.effectIdLight, self)
        end
      end
    end
  end)
end

function bs_204703:PlaySkill(data)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffID_1158, 1, 360, true)
  self:CallCasterWait(360)
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_start, 1)
  local arriveCallBack = BindCallback(self, self.CallBack)
  LuaSkillCtrl:StartTimer(nil, 12, arriveCallBack)
end

function bs_204703:CallBack()
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_loop, 1)
  local arriveCallBack = BindCallback(self, self.Damage)
  self.timer = LuaSkillCtrl:StartTimer(nil, 15, arriveCallBack, self, -1, 15)
  local target = LuaSkillCtrl:GetTargetWithGrid(3, 2)
  self.effect = LuaSkillCtrl:CallEffect(target, self.config.effectId, self)
  self.loopaudio = LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId2)
  local arriveCallBack1 = BindCallback(self, self.CallBackEnd)
  LuaSkillCtrl:StartTimer(nil, 300, arriveCallBack1)
  local arriveCallBack = BindCallback(self, self.DamageKill)
  self.timer1 = LuaSkillCtrl:StartTimer(nil, 75, arriveCallBack, self, -1, 0)
end

function bs_204703:Damage()
  if self.timer ~= nil and self.timer:IsOver() then
    self.timer = nil
  end
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  if targetlist.Count < 1 then
    return
  end
  for i = 0, targetlist.Count - 1 do
    local targetRole = targetlist[i].targetRole
    local hurt1 = targetRole.maxHp // 20
    LuaSkillCtrl:RemoveLife(hurt1, self, targetRole, true, nil, true, true)
  end
end

function bs_204703:DamageKill()
  if self.timer1 ~= nil and self.timer1:IsOver() then
    self.timer1 = nil
  end
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  if targetlist.Count < 1 then
    return
  end
  LuaSkillCtrl:CallEffect(targetlist[0].targetRole, self.config.effectHithurt, self)
  local maxHp = targetlist[0].targetRole.maxHp
  LuaSkillCtrl:RemoveLife(maxHp, self, targetlist[0].targetRole, true, nil, true, true)
end

function bs_204703:CallBackEnd()
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_end, 1)
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
  if self.timer1 ~= nil then
    self.timer1:Stop()
    self.timer1 = nil
  end
  local target = LuaSkillCtrl:GetTargetWithGrid(3, 2)
  self.effect = LuaSkillCtrl:CallEffect(target, self.config.effectIdDie, self)
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0)
  self:CancleCasterWait()
  LuaSkillCtrl:StopAudioByBack(self.loopaudio)
end

function bs_204703:OnCasterDie()
  base.OnCasterDie(self)
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
  if self.timer1 ~= nil then
    self.timer1:Stop()
    self.timer1 = nil
  end
  LuaSkillCtrl:StopAudioByBack(self.loopaudio)
  self.loopaudio = nil
end

function bs_204703:LuaDispose()
  base.LuaDispose(self)
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
  if self.timer1 ~= nil then
    self.timer1:Stop()
    self.timer1 = nil
  end
  LuaSkillCtrl:StopAudioByBack(self.loopaudio)
  self.loopaudio = nil
end

return bs_204703
