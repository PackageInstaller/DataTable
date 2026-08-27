local bs_204702 = class("bs_204702", LuaSkillBase)
local base = LuaSkillBase
bs_204702.config = {
  actionId_start = 1022,
  actionId_loop = 1023,
  actionId_end = 1024,
  effectId = 11005,
  effectIdDie = 10922,
  buffID_1158 = 1158,
  audioId2 = 88,
  buffId1 = 175,
  buffId2 = 1033,
  buffId3 = 198,
  buffId4 = 88
}

function bs_204702:ctor()
end

function bs_204702:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_204702_03", 1, self.OnAfterBattleStart)
  self:AddSetDeadHurtTrigger("bs_204702_2", 1, self.OnSetDeadHurt, nil, self.caster)
  LuaSkillCtrl:CallBuff(self, self.caster, 3009, 1, nil, true, nil, true)
end

function bs_204702:OnSetDeadHurt(context)
  local plist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  for i = 0, plist.Count - 1 do
    LuaSkillCtrl:CallBuff(self, plist[i], 2176, 1, nil, true, nil, true)
    LuaSkillCtrl:CallBuff(self, plist[i], 3009, 1, nil, true, nil, true)
  end
  LuaSkillCtrl:CallBattleCamShakeByParam(0, 2, 0.6, 50)
  LuaSkillCtrl:CallStartLocalScale(self.caster, Vector3.New(1.5, 1.5, 1.5), 1)
  local target = LuaSkillCtrl:GetTargetWithGrid(3, 2)
  LuaSkillCtrl:CallEffect(target, 10937, self)
  LuaSkillCtrl:StartTimer(nil, 95, function()
    LuaSkillCtrl:ForceEndBattle(true)
  end)
end

function bs_204702:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId3, 1, nil, true)
end

function bs_204702:PlaySkill(data)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffID_1158, 1, 360, true)
  self:CallCasterWait(360)
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_start, 1)
  local arriveCallBack = BindCallback(self, self.CallBack)
  LuaSkillCtrl:StartTimer(nil, 12, arriveCallBack)
end

function bs_204702:CallBack()
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_loop, 1)
  local arriveCallBack = BindCallback(self, self.Damage)
  self.timer = LuaSkillCtrl:StartTimer(nil, 15, arriveCallBack, self, -1, 15)
  local target = LuaSkillCtrl:GetTargetWithGrid(3, 2)
  self.effect = LuaSkillCtrl:CallEffect(target, self.config.effectId, self)
  self.loopaudio = LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId2)
  local arriveCallBack = BindCallback(self, self.CallBackEnd)
  LuaSkillCtrl:StartTimer(nil, 100, arriveCallBack)
end

function bs_204702:Damage()
  if self.timer ~= nil and self.timer:IsOver() then
    self.timer = nil
  end
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 9, 0)
  if targetlist.Count < 1 then
    return
  end
  for i = 0, targetlist.Count - 1 do
    local targetRole = targetlist[i].targetRole
    local hurt1 = targetRole.maxHp // 3
    local hurt2 = targetRole.maxHp // 30
    if targetRole.roleDataId == 1003 then
      local IfRoleCotainsIgnoreDieBuff = LuaSkillCtrl:RoleContainsBuffFeature(targetRole, self.config.buffFeature_ignoreDie)
      if IfRoleCotainsIgnoreDieBuff then
        local buff_ignoreDie = LuaSkillCtrl:GetRoleAllBuffsByFeature(targetRole, self.config.buffFeature_ignoreDie)
        if 0 < buff_ignoreDie.Count then
          for i = 0, buff_ignoreDie.Count - 1 do
            LuaSkillCtrl:DispelBuff(targetRole, buff_ignoreDie[i].dataId, 0)
          end
        end
      end
      local IfRoleCotainsInvinciableBuff = LuaSkillCtrl:RoleContainsBuffFeature(targetRole, self.config.buffFeature_Invinciable)
      if IfRoleCotainsInvinciableBuff and not targetRole.recordTable.equipSummoner then
        local buff_invinciable = LuaSkillCtrl:GetRoleAllBuffsByFeature(targetRole, self.config.buffFeature_Invinciable)
        if 0 < buff_invinciable.Count then
          for i = 0, buff_invinciable.Count - 1 do
            LuaSkillCtrl:DispelBuff(targetRole, buff_invinciable[i].dataId, 0)
          end
        end
      end
      LuaSkillCtrl:DispelBuff(targetRole, 1252, 0)
      LuaSkillCtrl:RemoveLife(hurt1, self, targetRole, true, nil, true, true)
    else
      LuaSkillCtrl:RemoveLife(hurt2, self, targetRole, true, nil, true, true)
    end
  end
end

function bs_204702:CallBackEnd()
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_end, 1)
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
  local target = LuaSkillCtrl:GetTargetWithGrid(3, 2)
  self.effect = LuaSkillCtrl:CallEffect(target, self.config.effectIdDie, self)
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0)
  self:CancleCasterWait()
  LuaSkillCtrl:StopAudioByBack(self.loopaudio)
end

function bs_204702:OnCasterDie()
  base.OnCasterDie(self)
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
  LuaSkillCtrl:StopAudioByBack(self.loopaudio)
  self.loopaudio = nil
end

function bs_204702:LuaDispose()
  base.LuaDispose(self)
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
  LuaSkillCtrl:StopAudioByBack(self.loopaudio)
  self.loopaudio = nil
end

return bs_204702
