local csRoleState = CS.eBattleRoleState
local LuaSkillBase = class("LuaSkillBase")

function LuaSkillBase:ctor()
end

function LuaSkillBase:__InitSkillInternal(cskill, isMidwaySkill)
  self.cskill = cskill
  self.isCommonAttack = cskill.isCommonAttack
  self.caster = cskill.maker
  self.level = cskill.level
  self.dataID = cskill.dataId
  self.timers = nil
  self.effects = nil
  self.luaTriggerDict = nil
  self.luaTriggerList = nil
  local arglist = {}
  for i = 0, cskill.skillFormulaArgs.Length - 1 do
    arglist[i + 1] = cskill.skillFormulaArgs[i]
  end
  self.arglist = arglist
  self._skillLogicType = cskill.skillType
  if LuaSkillCtrl.IsInBrotatoBattle then
    LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.OnSkillInit, self)
  end
  self:InitSkill(isMidwaySkill)
  local skillComp = self.caster:GetSkillComponent()
  if skillComp ~= nil and skillComp.disableAutoTakeSkill and self.caster.roleType ~= eBattleRoleType.skillCaster then
    skillComp.disableAutoTakeSkill = false
  end
end

function LuaSkillBase:IsConsumeSkill()
  return self._skillLogicType == eBattleSkillLogicType.ChipConsume
end

function LuaSkillBase:IsSkillCasterUltSkill()
  return self.caster.roleType == eBattleRoleType.skillCaster
end

function LuaSkillBase:GetSelfBindingObj()
  local binding
  if self.caster == nil then
    return
  end
  if self.caster.lsObject.gameObject ~= nil then
    binding = {}
    UIUtil.LuaUIBindingTable(self.caster.lsObject.gameObject, binding)
  end
  return binding
end

function LuaSkillBase:AddTimer(timer)
  if timer ~= nil then
    if self.timers == nil then
      self.timers = {}
    end
    table.insert(self.timers, timer)
  end
end

function LuaSkillBase:RemoveTimer(timer)
  if self.timers ~= nil and timer ~= nil then
    table.removebyvalue(self.timers, timer)
  end
end

function LuaSkillBase:InitSkill(isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.OnBreakSkill, "base_breakSkill", 1, self.OnBreakSkill)
end

function LuaSkillBase:OnCasterBorn()
end

function LuaSkillBase:TryPlayByLua(moveSelectTarget, selectTargetCoord, selectRoles)
  return false
end

function LuaSkillBase:PlaySkill(data, selectTargetCoord, selectRoles, selectRolesType)
  return true
end

function LuaSkillBase:OnUltInternalPlaySkill(data, selectTargetCoord, selectRoles, selectRolesType)
  LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.OnUltSkillPlayed, self.caster, self.cskill)
  return self:PlaySkill(data, selectTargetCoord, selectRoles, selectRolesType)
end

function LuaSkillBase:PlayMonsterUltSkill(triggerDelay, data)
  local targetRoles = self:HandleSelectTarget()
  if targetRoles == nil then
    return nil
  end
  self:CallCasterWait(triggerDelay)
  if data.buffId_Super ~= nil then
    LuaSkillCtrl:CallBuff(self, self.caster, data.buffId_Super, 1, 15, true)
  end
  if data.actionId_start ~= nil then
    LuaSkillCtrl:CallRoleAction(self.caster, data.actionId_start)
  end
  local invokeTimer = LuaSkillCtrl:StartTimer(nil, data.delayInvoke, BindCallback(self, self.InternalInvoke, data, targetRoles))
  return invokeTimer
end

function LuaSkillBase:HandleSelectTarget()
  local target = self:GetMoveSelectTarget()
  if target == nil then
    return nil
  end
  self.caster:LookAtInstantly(target.targetRole)
  return target.targetRole
end

function LuaSkillBase:InternalInvoke(data, role)
end

function LuaSkillBase:OnMonsterUltPlay(data, selectTargetCoord, selectRoles, containsMovie, funcPlaySkill)
  LuaSkillCtrl.cUltSkillCtrl:SetCurrentUltSkill(self.cskill, containsMovie)
  LuaSkillCtrl.battleCtrl:SetUltSkillFreeze(self.cskill)
  self:RemoveSkillTrigger(eSkillTriggerType.AfterSelfUltSpecTimeLineEnd)
  self:AddTrigger(eSkillTriggerType.AfterSelfUltSpecTimeLineEnd, "baseult_afterSpec", 1, self.AfterUltSpecView)
  self:RemoveSkillTrigger(eSkillTriggerType.AfterSelfUltEffectEnd)
  self:AddTrigger(eSkillTriggerType.AfterSelfUltEffectEnd, "baseult_after", 1, BindCallback(self, funcPlaySkill, data, selectTargetCoord, selectRoles))
  local isCancleTake = false
  self:RemoveSkillTrigger(eSkillTriggerType.StartSelfUltRoleAction)
  self:AddTrigger(eSkillTriggerType.StartSelfUltRoleAction, "baseult_startaction", 1, self.CkeckAndCallUltRoleAction)
  isCancleTake = self:PlayUltEffect(data, selectTargetCoord, selectRoles)
  if isCancleTake then
    return false
  end
  MsgCenter:Broadcast(eMsgEventId.OnUltSkillRoleActionStart, self.caster)
end

function LuaSkillBase:TakeSkillPlay(data, isUltSkill, moveSelectTarget, selectTargetCoord, selectRoles)
  self.__isBrodcastDamageEnd = false
  if isUltSkill then
    self.caster.recordTable.lastSkill = self.dataID
    self.ultHmp = LuaSkillCtrl:GetUltHMp()
    self:RemoveSkillTrigger(eSkillTriggerType.AfterSelfUltSpecTimeLineEnd)
    self:AddTrigger(eSkillTriggerType.AfterSelfUltSpecTimeLineEnd, "baseult_afterSpec", 1, self.AfterUltSpecView)
    self:RemoveSkillTrigger(eSkillTriggerType.AfterSelfUltEffectEnd)
    self:AddTrigger(eSkillTriggerType.AfterSelfUltEffectEnd, "baseult_after", 1, BindCallback(self, self.OnUltInternalPlaySkill, data, selectTargetCoord, selectRoles, SelectRolesType.CsBattleRoleList))
    local isCancleTake = false
    if self:IsSkillCasterUltSkill() then
      isCancleTake = self:PlayUltMovie(moveSelectTarget, selectTargetCoord, selectRoles)
      if isCancleTake then
        if self.cskill.maker == nil then
          return true
        end
        local makerSkillMgr = self.cskill.maker:GetSkillComponent()
        if makerSkillMgr == nil then
          return true
        end
        makerSkillMgr:SetUltSkillNull()
        local playerCtrl = LuaSkillCtrl.battleCtrl.PlayerController
        playerCtrl:OnUltSkillTakeComplete(self.cskill)
        LuaSkillCtrl.cUltSkillCtrl.isStartUltEffect = false
        local curUltMp = LuaSkillCtrl.cUltSkillCtrl.ultSkillModel.UltMp
        LuaSkillCtrl.cUltSkillCtrl.ultSkillModel.ultMp = curUltMp - ConfigData.game_config.ultMpCost
        return false
      end
    else
      self:RemoveSkillTrigger(eSkillTriggerType.StartSelfUltRoleAction)
      self:AddTrigger(eSkillTriggerType.StartSelfUltRoleAction, "baseult_startaction", 1, self.CkeckAndCallUltRoleAction)
      isCancleTake = self:PlayUltEffect(data, selectTargetCoord, selectRoles)
      if isCancleTake then
        return false
      end
      local returnArg = 0
      if self.caster ~= nil then
        local dynHero = self.caster.character
        if dynHero ~= nil then
          returnArg = dynHero:GetRawAttr(eRawAttr.RawAttributionIdEnergyReturn)
        end
      end
      if 0 < returnArg then
        local curMp = LuaSkillCtrl.cUltSkillCtrl.ultSkillModel.ultMp
        local returnVal = ConfigData.game_config.ultMpCost * returnArg // 1000
        LuaSkillCtrl.cUltSkillCtrl.ultSkillModel.ultMp = curMp + returnVal
      end
      MsgCenter:Broadcast(eMsgEventId.OnUltSkillRoleActionStart, self.caster)
    end
    return true
  else
    self.moveSelectTarget = moveSelectTarget
    local result = self:PlaySkill(data, selectTargetCoord, selectRoles)
    self.caster.recordTable.lastSkill = self.dataID
    return result
  end
end

function LuaSkillBase:CheckSortTarget(targetA, targetB, finalCoordA, finalCoordB)
  return 0
end

function LuaSkillBase:GetMoveSelectTarget()
  if self.moveSelectTarget == nil or self.moveSelectTarget.targetRole == nil or self.moveSelectTarget.targetRole.hp <= 0 then
    return nil
  end
  return self.moveSelectTarget
end

function LuaSkillBase:CkeckAndCallUltRoleAction()
  if LuaSkillCtrl.cUltSkillCtrl.currentSkill == nil then
    return
  end
  self:OnUltRoleAction()
end

function LuaSkillBase:OnUltRoleAction()
end

function LuaSkillBase:AfterUltSpecView(isFromBreak)
  if self:IsSkillCasterUltSkill() then
    LuaSkillCtrl:CallEndUltEffect(self.caster)
  else
    LuaSkillCtrl:CallBackViewTimeLine(self.caster, true)
  end
  self:OnAfterUltEffect(isFromBreak)
end

function LuaSkillBase:GetSelectTargetAndExecute(selectRoles, executeFunc, selectRolesType)
  if executeFunc == nil then
    return true
  end
  selectRolesType = selectRolesType or SelectRolesType.CsBattleRoleList
  local takeAvailable = false
  if selectRolesType == SelectRolesType.SingleRole then
    local curSkilltakeAvailable = self:CheckManualSkillTakeAvailable(selectRoles)
    if curSkilltakeAvailable then
      takeAvailable = curSkilltakeAvailable
      executeFunc(selectRoles)
    end
    return takeAvailable
  elseif selectRolesType == SelectRolesType.LuaRoleArray then
    if #selectRoles <= 0 then
      return false
    end
    for _, curRole in ipairs(selectRoles) do
      local curSkilltakeAvailable = self:CheckManualSkillTakeAvailable(curRole)
      if curSkilltakeAvailable then
        takeAvailable = curSkilltakeAvailable
        executeFunc(curRole)
      end
    end
    return takeAvailable
  end
  if selectRoles == nil or 0 >= selectRoles.Count then
    return false
  end
  for i = selectRoles.Count - 1, 0, -1 do
    if selectRoles == nil or i >= selectRoles.Count then
      return
    end
    local curRole = selectRoles[i]
    if selectRolesType == SelectRolesType.CsBattleTargetList then
      curRole = curRole.targetRole
    end
    local curSkilltakeAvailable = self:CheckManualSkillTakeAvailable(curRole)
    if curSkilltakeAvailable then
      takeAvailable = curSkilltakeAvailable
      executeFunc(curRole)
    end
  end
  return takeAvailable
end

function LuaSkillBase:CheckManualSkillTakeAvailable(role)
  if role == nil or role.hp <= 0 then
    return false
  end
  local manualCfg = self.cskill:GetManualSkillCfg()
  local isIgnoreUnselectableSameBelong = manualCfg ~= nil and manualCfg.IgnoreUnselectableSameBelong
  if not isIgnoreUnselectableSameBelong and role:IsUnSelect(self.caster) then
    return false
  end
  if self.AbandonTakeFeature == nil or #self.AbandonTakeFeature == nil then
    return true
  end
  for i = 1, #self.AbandonTakeFeature do
    if (self.AbandonTakeFeature[i] ~= eBuffFeatureType.AbandonMove or role.recordTable.IngnoreStopMove ~= true) and LuaSkillCtrl:RoleContainsBuffFeature(role, self.AbandonTakeFeature[i]) then
      return false
    end
  end
  return true
end

function LuaSkillBase:InjectActionTrigger(mainAction)
  self.actionTrigger = mainAction
end

function LuaSkillBase:TakeActionTrigger()
  self.isSkillUncompleted = false
  if self.actionTrigger ~= nil then
    if not self.isCommonAttack then
      LuaSkillCtrl:StopShowSkillDurationTime(self)
    end
    self.actionTrigger()
    self.actionTrigger = nil
  end
end

function LuaSkillBase:OnBreakSkill(role)
  if role ~= self.caster then
    return
  end
  self:RemoveAllTimers()
  self:RemoveAllBreakKillEffects()
  if not self.isCommonAttack and self.caster.roleType ~= eBattleRoleType.skillCaster then
    local curShowDurationSkill = self.caster.recordTable.curStartShowDurationSkill
    local bIsCanStop = false
    if curShowDurationSkill ~= nil then
      if curShowDurationSkill == self then
        bIsCanStop = true
      end
    else
      bIsCanStop = true
    end
    if bIsCanStop then
      LuaSkillCtrl:StopShowSkillDurationTime(self)
    end
  end
  if self.isSkillUncompleted then
    self.caster:RemoveSkillWaitBuff()
    if LuaSkillCtrl.IsInBrotatoBattle then
      self.cskill:ResetCDTimeRatio(100)
    else
      self.cskill:ReturnCDTimeFromBreak()
    end
    self.isSkillUncompleted = false
  end
  if self.cskill.isNormalSkill and self.dataID == self.caster.recordTable.lastSkill then
    self:OnSkillDamageEnd()
  end
end

function LuaSkillBase:TryResetMoveState(role)
  if role == nil or role.hp <= 0 then
    return
  end
  if role.eState == csRoleState.Moving then
    role:SetRoleState(csRoleState.Normal)
  end
end

function LuaSkillBase:OnCasterDie()
  self:KillEquipmentSummoner()
  LuaSkillCtrl:RemoveHandleAllTrigger(self.cskill)
  self:RemoveAllTimers()
  self:RemoveAllBreakKillEffects()
  self:RemoveAllLuaTrigger()
  self:RemoveAllHaleEmission()
  if self.caster.recordTable.lastSkill == self.dataID then
    self:OnSkillDamageEnd()
  end
end

function LuaSkillBase:KillEquipmentSummoner()
  local equipmentSummonerKey = ConfigData.buildinConfig.EquipmentSummonerKey
  local equipmentSummoner = self.caster.recordTable[equipmentSummonerKey]
  if equipmentSummoner ~= nil then
    self.caster.recordTable[equipmentSummonerKey] = nil
    LuaSkillCtrl:DispelBuff(equipmentSummoner, ConfigData.buildinConfig.EquipmentSummonerInvinsibleBuffId, 1, true, true)
    equipmentSummoner:SubHp(equipmentSummoner.hp)
    if equipmentSummoner.isDead and equipmentSummoner.eState ~= csRoleState.Deading then
      equipmentSummoner:OnDead(equipmentSummoner, nil)
    end
  end
end

function LuaSkillBase:RemoveAllTimers()
  if self.timers == nil then
    return
  end
  local leng = #self.timers
  for i = 1, leng do
    if self.timers[i] ~= nil then
      self.timers[i]:Stop()
      self.timers[i] = nil
    end
  end
  for k, v in pairs(self.timers) do
    self.timers[k] = nil
  end
end

function LuaSkillBase:AddEffect(effect)
  if effect ~= nil then
    if self.effects == nil then
      self.effects = {}
    end
    table.insert(self.effects, effect)
  end
end

function LuaSkillBase:RemoveAllBreakKillEffects()
  if self.effects == nil then
    return
  end
  local leng = #self.effects
  for i = 1, leng do
    local effect = self.effects[i]
    self.effects[i] = nil
    if effect ~= nil and not effect:IsDie() then
      local skillMaker = effect.skillMaker
      if skillMaker == nil or skillMaker == self.caster then
        effect:Die()
      end
    end
  end
  for k, v in pairs(self.effects) do
    self.effects[k] = nil
  end
end

function LuaSkillBase:BreakSkill()
  self:RemoveAllTimers()
  self:RemoveAllBreakKillEffects()
  LuaSkillCtrl:CallResetComAtkCDRatioForRole(self.caster, 100)
  LuaSkillCtrl:BreakCurrentAction(self.caster)
  self:OnSkillDamageEnd()
end

function LuaSkillBase:OnSkillRemove()
  if self.ultCv ~= nil then
    LuaSkillCtrl:StopAudioByBack(self.ultCv)
    self.ultCv = nil
  end
  LuaSkillCtrl:RemoveHandleAllTrigger(self.cskill)
  self:RemoveAllTimers()
  self:RemoveAllBreakKillEffects()
  self:RemoveAllLuaTrigger()
  if self.caster.recordTable.curStartShowDurationSkill == self then
    LuaSkillCtrl:StopShowSkillDurationTime(self)
  end
end

function LuaSkillBase:OnSkillDamageEnd()
  if self.__isBrodcastDamageEnd == false and self.cskill.isNormalSkill then
    self.__isBrodcastDamageEnd = true
    LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.OnDamageEnd, self)
  end
end

function LuaSkillBase:AddTrigger(triggerType, name, priority, eventFunc)
  local bindFunc = BindCallback(self, eventFunc)
  LuaSkillCtrl:AddSkillTrigger(triggerType, self.cskill, eTriggerSkillType.RoleSkill, name, priority, bindFunc, false)
end

function LuaSkillBase:AddSelfTrigger(triggerType, name, priority, eventFunc)
  local bindFunc = BindCallback(self, eventFunc)
  LuaSkillCtrl:AddSkillTrigger(triggerType, self.cskill, eTriggerSkillType.RoleSkill, name, priority, bindFunc, true, self.caster)
end

function LuaSkillBase:RemoveSkillTrigger(triggerType)
  LuaSkillCtrl:RemoveTrigger(self.cskill, triggerType)
end

function LuaSkillBase:AddSetHurtTrigger(name, priority, eventFunc, sender, target, senderBelongNum, targetBelongNum, senderRoleType, targetRoleType, skillId, skillTag, isTriggerSet)
  if isTriggerSet == true then
    isTriggerSet = 1
  elseif isTriggerSet == false then
    isTriggerSet = 0
  else
    isTriggerSet = -1
  end
  local bindFunc = BindCallback(self, eventFunc)
  LuaSkillCtrl:AddSkillTriggerWithBindArg(eSkillTriggerType.SetHurt, self.cskill, eTriggerSkillType.RoleSkill, name, priority, bindFunc, false, sender, target, senderBelongNum, targetBelongNum, senderRoleType, targetRoleType, skillId, skillTag, isTriggerSet)
end

function LuaSkillBase:AddSetDeadHurtTrigger(name, priority, eventFunc, sender, target, senderBelongNum, targetBelongNum, senderRoleType, targetRoleType, skillId, skillTag, isTriggerSet)
  if isTriggerSet == true then
    isTriggerSet = 1
  elseif isTriggerSet == false then
    isTriggerSet = 0
  else
    isTriggerSet = -1
  end
  local bindFunc = BindCallback(self, eventFunc)
  LuaSkillCtrl:AddSkillTriggerWithBindArg(eSkillTriggerType.SetDeadHurt, self.cskill, eTriggerSkillType.RoleSkill, name, priority, bindFunc, false, sender, target, senderBelongNum, targetBelongNum, senderRoleType, targetRoleType, skillId, skillTag, isTriggerSet)
end

function LuaSkillBase:AddAfterHurtTrigger(name, priority, eventFunc, sender, target, senderBelongNum, targetBelongNum, senderRoleType, targetRoleType, skillId, skillTag, isTriggerSet)
  if isTriggerSet == true then
    isTriggerSet = 1
  elseif isTriggerSet == false then
    isTriggerSet = 0
  else
    isTriggerSet = -1
  end
  local bindFunc = BindCallback(self, self.__BaseOnAfterHurt, eventFunc)
  LuaSkillCtrl:AddSkillTriggerWithBindArg(eSkillTriggerType.AfterHurt, self.cskill, eTriggerSkillType.RoleSkill, name, priority, bindFunc, false, sender, target, senderBelongNum, targetBelongNum, senderRoleType, targetRoleType, skillId, skillTag, isTriggerSet)
end

function LuaSkillBase:__BaseOnAfterHurt(eventFunc, sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet, extraArg)
  if extraArg ~= nil and extraArg == ConfigData.buildinConfig.HurtIgnoreKey then
    return
  end
  if eventFunc ~= nil then
    eventFunc(self, sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet, extraArg)
  end
end

function LuaSkillBase:AddSetHealTrigger(name, priority, eventFunc, sender, target, senderBelongNum, targetBelongNum, senderRoleType, targetRoleType, skillId, skillTag, isTriggerSet)
  if isTriggerSet == true then
    isTriggerSet = 1
  elseif isTriggerSet == false then
    isTriggerSet = 0
  else
    isTriggerSet = -1
  end
  local bindFunc = BindCallback(self, eventFunc)
  LuaSkillCtrl:AddSkillTriggerWithBindArg(eSkillTriggerType.SetHeal, self.cskill, eTriggerSkillType.RoleSkill, name, priority, bindFunc, false, sender, target, senderBelongNum, targetBelongNum, senderRoleType, targetRoleType, skillId, skillTag, isTriggerSet)
end

function LuaSkillBase:AddAfterHealTrigger(name, priority, eventFunc, sender, target, senderBelongNum, targetBelongNum, senderRoleType, targetRoleType, skillId, skillTag, isTriggerSet)
  if isTriggerSet == true then
    isTriggerSet = 1
  elseif isTriggerSet == false then
    isTriggerSet = 0
  else
    isTriggerSet = -1
  end
  local bindFunc = BindCallback(self, eventFunc)
  LuaSkillCtrl:AddSkillTriggerWithBindArg(eSkillTriggerType.AfterHeal, self.cskill, eTriggerSkillType.RoleSkill, name, priority, bindFunc, false, sender, target, senderBelongNum, targetBelongNum, senderRoleType, targetRoleType, skillId, skillTag, isTriggerSet)
end

function LuaSkillBase:AddAfterAddBuffTrigger(name, priority, eventFunc, sender, target, senderBelongNum, targetBelongNum, buffId, buffType, buffFeature)
  local bindFunc = BindCallback(self, eventFunc)
  LuaSkillCtrl:AddSkillTriggerWithBindArg(eSkillTriggerType.AfterAddBuff, self.cskill, eTriggerSkillType.RoleSkill, name, priority, bindFunc, false, sender, target, senderBelongNum, targetBelongNum, 0, 0, buffId, buffType, buffFeature)
end

function LuaSkillBase:AddAfterAddBuffHitMaxTierTrigger(name, priority, eventFunc, sender, target, senderBelongNum, targetBelongNum, buffId, buffType, buffFeature)
  local bindFunc = BindCallback(self, eventFunc)
  LuaSkillCtrl:AddSkillTriggerWithBindArg(eSkillTriggerType.AfterBuffAddHitMaxTier, self.cskill, eTriggerSkillType.RoleSkill, name, priority, bindFunc, false, sender, target, senderBelongNum, targetBelongNum, 0, 0, buffId, buffType, buffFeature)
end

function LuaSkillBase:AddBeforeAddBuffTrigger(name, priority, eventFunc, sender, target, senderBelongNum, targetBelongNum, buffId, buffType, buffFeature)
  local bindFunc = BindCallback(self, eventFunc)
  LuaSkillCtrl:AddSkillTriggerWithBindArg(eSkillTriggerType.BeforeAddBuff, self.cskill, eTriggerSkillType.RoleSkill, name, priority, bindFunc, false, sender, target, senderBelongNum, targetBelongNum, 0, 0, buffId, buffType, buffFeature)
end

function LuaSkillBase:AddBeforeJudgeAndAddBuffTrigger(name, priority, eventFunc, sender, target, senderBelongNum, targetBelongNum, buffId, buffType, buffFeature)
  local bindFunc = BindCallback(self, eventFunc)
  LuaSkillCtrl:AddSkillTriggerWithBindArg(eSkillTriggerType.BeforeJudgeAndAddBuff, self.cskill, eTriggerSkillType.RoleSkill, name, priority, bindFunc, false, sender, target, senderBelongNum, targetBelongNum, 0, 0, buffId, buffType, buffFeature)
end

function LuaSkillBase:AddBeforeBuffDispelTrigger(name, priority, eventFunc, target, targetBelongNum, buffId, buffType, buffFeature)
  local bindFunc = BindCallback(self, eventFunc)
  LuaSkillCtrl:AddSkillTriggerWithBindArg(eSkillTriggerType.BeforeBuffDispel, self.cskill, eTriggerSkillType.RoleSkill, name, priority, bindFunc, false, nil, target, -1, targetBelongNum, 0, 0, buffId, buffType, buffFeature)
end

function LuaSkillBase:AddBuffDieTrigger(name, priority, eventFunc, target, targetBelongNum, buffId, buffType, buffFeature)
  local bindFunc = BindCallback(self, eventFunc)
  LuaSkillCtrl:AddSkillTriggerWithBindArg(eSkillTriggerType.BuffDie, self.cskill, eTriggerSkillType.RoleSkill, name, priority, bindFunc, false, nil, target, -1, targetBelongNum, 0, 0, buffId, buffType, buffFeature)
end

function LuaSkillBase:AddAfterBuffRemoveTrigger(name, priority, eventFunc, target, targetBelongNum, buffId, buffType, buffFeature)
  local bindFunc = BindCallback(self, eventFunc)
  LuaSkillCtrl:AddSkillTriggerWithBindArg(eSkillTriggerType.AfterBuffRemove, self.cskill, eTriggerSkillType.RoleSkill, name, priority, bindFunc, false, nil, target, -1, targetBelongNum, 0, 0, buffId, buffType, buffFeature)
end

function LuaSkillBase:AddOnRoleDieTrigger(name, priority, eventFunc, sender, target, senderBelongNum, targetBelongNum, senderRoleType, targetRoleType, skillId)
  local bindFunc = BindCallback(self, eventFunc)
  LuaSkillCtrl:AddSkillTriggerWithBindArg(eSkillTriggerType.RoleDie, self.cskill, eTriggerSkillType.RoleSkill, name, priority, bindFunc, false, sender, target, senderBelongNum, targetBelongNum, senderRoleType, targetRoleType, skillId)
end

function LuaSkillBase:AddOnPlayerMpCostedTrigger(name, priority, eventFunc, costTargetValue)
  local bindFunc = BindCallback(self, eventFunc)
  LuaSkillCtrl:AddSkillTriggerWithBindArg(eSkillTriggerType.OnPlayerMpCostToTargetValue, self.cskill, eTriggerSkillType.RoleSkill, name, priority, bindFunc, false, nil, nil, nil, nil, 0, 0, costTargetValue)
end

function LuaSkillBase:AddHurtResultStartTrigger(name, priority, eventFunc, sender, target, senderBelongNum, targetBelongNum, senderRoleType, targetRoleType, skillId, skillTag, isTriggerSet)
  if isTriggerSet == true then
    isTriggerSet = 1
  elseif isTriggerSet == false then
    isTriggerSet = 0
  else
    isTriggerSet = -1
  end
  local bindFunc = BindCallback(self, eventFunc)
  LuaSkillCtrl:AddSkillTriggerWithBindArg(eSkillTriggerType.HurtResultStart, self.cskill, eTriggerSkillType.RoleSkill, name, priority, bindFunc, false, sender, target, senderBelongNum, targetBelongNum, senderRoleType, targetRoleType, skillId, skillTag, isTriggerSet)
end

function LuaSkillBase:AddHurtResultEndTrigger(name, priority, eventFunc, sender, target, senderBelongNum, targetBelongNum, senderRoleType, targetRoleType, skillId, skillTag, isTriggerSet)
  if isTriggerSet == true then
    isTriggerSet = 1
  elseif isTriggerSet == false then
    isTriggerSet = 0
  else
    isTriggerSet = -1
  end
  local bindFunc = BindCallback(self, eventFunc)
  LuaSkillCtrl:AddSkillTriggerWithBindArg(eSkillTriggerType.HurtResultEnd, self.cskill, eTriggerSkillType.RoleSkill, name, priority, bindFunc, false, sender, target, senderBelongNum, targetBelongNum, senderRoleType, targetRoleType, skillId, skillTag, isTriggerSet)
end

function LuaSkillBase:AddHealResultStartTrigger(name, priority, eventFunc, sender, target, senderBelongNum, targetBelongNum, senderRoleType, targetRoleType, skillId, skillTag, isTriggerSet)
  if isTriggerSet == true then
    isTriggerSet = 1
  elseif isTriggerSet == false then
    isTriggerSet = 0
  else
    isTriggerSet = -1
  end
  local bindFunc = BindCallback(self, eventFunc)
  LuaSkillCtrl:AddSkillTriggerWithBindArg(eSkillTriggerType.HealResultStart, self.cskill, eTriggerSkillType.RoleSkill, name, priority, bindFunc, false, sender, target, senderBelongNum, targetBelongNum, senderRoleType, targetRoleType, skillId, skillTag, isTriggerSet)
end

function LuaSkillBase:AddHealResultEndTrigger(name, priority, eventFunc, sender, target, senderBelongNum, targetBelongNum, senderRoleType, targetRoleType, skillId, skillTag, isTriggerSet)
  if isTriggerSet == true then
    isTriggerSet = 1
  elseif isTriggerSet == false then
    isTriggerSet = 0
  else
    isTriggerSet = -1
  end
  local bindFunc = BindCallback(self, eventFunc)
  LuaSkillCtrl:AddSkillTriggerWithBindArg(eSkillTriggerType.HealResultEnd, self.cskill, eTriggerSkillType.RoleSkill, name, priority, bindFunc, false, sender, target, senderBelongNum, targetBelongNum, senderRoleType, targetRoleType, skillId, skillTag, isTriggerSet)
end

function LuaSkillBase:AddAfterPlaySkillTrigger(name, priority, eventFunc, sender, target, senderBelongNum, targetBelongNum, senderRoleType, targetRoleType, skillId, skillTag)
  local bindFunc = BindCallback(self, eventFunc)
  LuaSkillCtrl:AddSkillTriggerWithBindArg(eSkillTriggerType.AfterPlaySkill, self.cskill, eTriggerSkillType.RoleSkill, name, priority, bindFunc, false, sender, target, senderBelongNum, targetBelongNum, senderRoleType, targetRoleType, skillId, skillTag)
end

function LuaSkillBase:AddBeforePlaySkillTrigger(name, priority, eventFunc, sender, target, senderBelongNum, targetBelongNum, senderRoleType, targetRoleType, skillId, skillTag)
  local bindFunc = BindCallback(self, eventFunc)
  LuaSkillCtrl:AddSkillTriggerWithBindArg(eSkillTriggerType.BeforePlaySkill, self.cskill, eTriggerSkillType.RoleSkill, name, priority, bindFunc, false, sender, target, senderBelongNum, targetBelongNum, senderRoleType, targetRoleType, skillId, skillTag)
end

function LuaSkillBase:AddAfterResurrectionCharacterTrigger(name, priority, eventFunc, resurrectionRole, resurrectionRoleBelongNum, resurrectionRoleRoleType)
  local bindFunc = BindCallback(self, eventFunc)
  LuaSkillCtrl:AddSkillTriggerWithBindArg(eSkillTriggerType.OnAfterResurrectionCharacter, self.cskill, eTriggerSkillType.RoleSkill, name, priority, bindFunc, false, resurrectionRole, nil, resurrectionRoleBelongNum, nil, resurrectionRoleRoleType)
end

function LuaSkillBase:TransformBoolForTigger(bValue)
  if bValue == true then
    return 1
  elseif bValue == false then
    return 0
  else
    return -1
  end
end

function LuaSkillBase:AddSetHurtTriggerForTable(name, priority, eventFunc, args)
  args.extraArg2 = self:TransformBoolForTigger(args.extraArg2)
  args.extraArg3 = self:TransformBoolForTigger(args.extraArg3)
  local bindFunc = BindCallback(self, eventFunc)
  LuaSkillCtrl:AddSkillTriggerWithBindTable(eSkillTriggerType.SetHurt, self.cskill, eTriggerSkillType.RoleSkill, name, priority, bindFunc, false, args)
end

function LuaSkillBase:AddSetDeadHurtTriggerForTable(name, priority, eventFunc, args)
  args.extraArg2 = self:TransformBoolForTigger(args.extraArg2)
  args.extraArg3 = self:TransformBoolForTigger(args.extraArg3)
  local bindFunc = BindCallback(self, eventFunc)
  LuaSkillCtrl:AddSkillTriggerWithBindTable(eSkillTriggerType.SetDeadHurt, self.cskill, eTriggerSkillType.RoleSkill, name, priority, bindFunc, false, args)
end

function LuaSkillBase:AddAfterHurtTriggerForTable(name, priority, eventFunc, args)
  args.extraArg2 = self:TransformBoolForTigger(args.extraArg2)
  args.extraArg3 = self:TransformBoolForTigger(args.extraArg3)
  local bindFunc = BindCallback(self, self.__BaseOnAfterHurt, eventFunc)
  LuaSkillCtrl:AddSkillTriggerWithBindTable(eSkillTriggerType.AfterHurt, self.cskill, eTriggerSkillType.RoleSkill, name, priority, bindFunc, false, args)
end

function LuaSkillBase:AddSetHealTriggerForTable(name, priority, eventFunc, args)
  args.extraArg2 = self:TransformBoolForTigger(args.extraArg2)
  local bindFunc = BindCallback(self, eventFunc)
  LuaSkillCtrl:AddSkillTriggerWithBindTable(eSkillTriggerType.SetHeal, self.cskill, eTriggerSkillType.RoleSkill, name, priority, bindFunc, false, args)
end

function LuaSkillBase:AddAfterHealTriggerForTable(name, priority, eventFunc, args)
  args.extraArg2 = self:TransformBoolForTigger(args.extraArg2)
  local bindFunc = BindCallback(self, eventFunc)
  LuaSkillCtrl:AddSkillTriggerWithBindTable(eSkillTriggerType.AfterHeal, self.cskill, eTriggerSkillType.RoleSkill, name, priority, bindFunc, false, args)
end

function LuaSkillBase:AddAfterAddBuffTriggerForTable(name, priority, eventFunc, args)
  local bindFunc = BindCallback(self, eventFunc)
  LuaSkillCtrl:AddSkillTriggerWithBindTable(eSkillTriggerType.AfterAddBuff, self.cskill, eTriggerSkillType.RoleSkill, name, priority, bindFunc, false, args)
end

function LuaSkillBase:AddAfterAddBuffHitMaxTierTriggerForTable(name, priority, eventFunc, args)
  local bindFunc = BindCallback(self, eventFunc)
  LuaSkillCtrl:AddSkillTriggerWithBindTable(eSkillTriggerType.AfterBuffAddHitMaxTier, self.cskill, eTriggerSkillType.RoleSkill, name, priority, bindFunc, false, args)
end

function LuaSkillBase:AddBeforeAddBuffTriggerForTable(name, priority, eventFunc, args)
  local bindFunc = BindCallback(self, eventFunc)
  LuaSkillCtrl:AddSkillTriggerWithBindTable(eSkillTriggerType.BeforeAddBuff, self.cskill, eTriggerSkillType.RoleSkill, name, priority, bindFunc, false, args)
end

function LuaSkillBase:AddBeforeBuffDispelTriggerForTable(name, priority, eventFunc, args)
  local bindFunc = BindCallback(self, eventFunc)
  LuaSkillCtrl:AddSkillTriggerWithBindTable(eSkillTriggerType.BeforeBuffDispel, self.cskill, eTriggerSkillType.RoleSkill, name, priority, bindFunc, false, args)
end

function LuaSkillBase:AddBuffDieTriggerForTable(name, priority, eventFunc, args)
  local bindFunc = BindCallback(self, eventFunc)
  LuaSkillCtrl:AddSkillTriggerWithBindTable(eSkillTriggerType.BuffDie, self.cskill, eTriggerSkillType.RoleSkill, name, priority, bindFunc, false, args)
end

function LuaSkillBase:AddAfterBuffRemoveTriggerForTable(name, priority, eventFunc, args)
  local bindFunc = BindCallback(self, eventFunc)
  LuaSkillCtrl:AddSkillTriggerWithBindTable(eSkillTriggerType.AfterBuffRemove, self.cskill, eTriggerSkillType.RoleSkill, name, priority, bindFunc, false, args)
end

function LuaSkillBase:AddOnRoleDieTriggerForTable(name, priority, eventFunc, args)
  local bindFunc = BindCallback(self, eventFunc)
  LuaSkillCtrl:AddSkillTriggerWithBindTable(eSkillTriggerType.RoleDie, self.cskill, eTriggerSkillType.RoleSkill, name, priority, bindFunc, false, args)
end

function LuaSkillBase:AddOnPlayerMpCostedTriggerForTable(name, priority, eventFunc, args)
  local bindFunc = BindCallback(self, eventFunc)
  LuaSkillCtrl:AddSkillTriggerWithBindTable(eSkillTriggerType.OnPlayerMpCostToTargetValue, self.cskill, eTriggerSkillType.RoleSkill, name, priority, bindFunc, false, args)
end

function LuaSkillBase:AddHurtResultStartTriggerForTable(name, priority, eventFunc, args)
  local isTriggerSet = args.extraArg2
  if isTriggerSet == true then
    isTriggerSet = 1
  elseif isTriggerSet == false then
    isTriggerSet = 0
  else
    isTriggerSet = -1
  end
  local bindFunc = BindCallback(self, eventFunc)
  LuaSkillCtrl:AddSkillTriggerWithBindTable(eSkillTriggerType.HurtResultStart, self.cskill, eTriggerSkillType.RoleSkill, name, priority, bindFunc, false, args)
end

function LuaSkillBase:AddHurtResultEndTriggerForTable(name, priority, eventFunc, args)
  local isTriggerSet = args.extraArg2
  if isTriggerSet == true then
    isTriggerSet = 1
  elseif isTriggerSet == false then
    isTriggerSet = 0
  else
    isTriggerSet = -1
  end
  local bindFunc = BindCallback(self, eventFunc)
  LuaSkillCtrl:AddSkillTriggerWithBindTable(eSkillTriggerType.HurtResultEnd, self.cskill, eTriggerSkillType.RoleSkill, name, priority, bindFunc, false, args)
end

function LuaSkillBase:AddHealResultStartTriggerForTable(name, priority, eventFunc, args)
  local isTriggerSet = args.extraArg2
  if isTriggerSet == true then
    isTriggerSet = 1
  elseif isTriggerSet == false then
    isTriggerSet = 0
  else
    isTriggerSet = -1
  end
  local bindFunc = BindCallback(self, eventFunc)
  LuaSkillCtrl:AddSkillTriggerWithBindTable(eSkillTriggerType.HealResultStart, self.cskill, eTriggerSkillType.RoleSkill, name, priority, bindFunc, false, args)
end

function LuaSkillBase:AddHealResultEndTriggerForTable(name, priority, eventFunc, args)
  local isTriggerSet = args.extraArg2
  if isTriggerSet == true then
    isTriggerSet = 1
  elseif isTriggerSet == false then
    isTriggerSet = 0
  else
    isTriggerSet = -1
  end
  local bindFunc = BindCallback(self, eventFunc)
  LuaSkillCtrl:AddSkillTriggerWithBindTable(eSkillTriggerType.HealResultEnd, self.cskill, eTriggerSkillType.RoleSkill, name, priority, bindFunc, false, args)
end

function LuaSkillBase:AddAfterPlaySkillTriggerForTable(name, priority, eventFunc, args)
  local bindFunc = BindCallback(self, eventFunc)
  LuaSkillCtrl:AddSkillTriggerWithBindTable(eSkillTriggerType.AfterPlaySkill, self.cskill, eTriggerSkillType.RoleSkill, name, priority, bindFunc, false, args)
end

function LuaSkillBase:AddBeforePlaySkillTriggerForTable(name, priority, eventFunc, args)
  local bindFunc = BindCallback(self, eventFunc)
  LuaSkillCtrl:AddSkillTriggerWithBindTable(eSkillTriggerType.BeforePlaySkill, self.cskill, eTriggerSkillType.RoleSkill, name, priority, bindFunc, false, args)
end

function LuaSkillBase:AddAfterResurrectionCharacterTriggerForTable(name, priority, eventFunc, args)
  local bindFunc = BindCallback(self, eventFunc)
  LuaSkillCtrl:AddSkillTriggerWithBindTable(eSkillTriggerType.OnAfterResurrectionCharacter, self.cskill, eTriggerSkillType.RoleSkill, name, priority, bindFunc, false, args)
end

function LuaSkillBase:AddLuaTrigger(luaTriggerId, action, priority)
  if self.luaTriggerDict == nil then
    self.luaTriggerDict = {}
  end
  if self.luaTriggerList == nil then
    self.luaTriggerList = {}
  end
  if action ~= nil then
    local cb = BindCallback(self, action)
    if self.luaTriggerDict[luaTriggerId] ~= nil then
      error(string.format("%s已经包含了%s的特殊Lua触发器，请检查%s", self.cskill.name, luaTriggerId, self.cskill.dataId))
      return
    end
    self.luaTriggerDict[luaTriggerId] = cb
    table.insert(self.luaTriggerList, luaTriggerId)
    LuaSkillCtrl:RegisterLuaTrigger(luaTriggerId, cb, priority)
  end
end

function LuaSkillBase:UnRegisterLuaTrigger(luaTriggerId)
  if luaTriggerId == nil or self.luaTriggerDict == nil then
    return
  end
  local cb
  if self.luaTriggerDict[luaTriggerId] ~= nil then
    cb = self.luaTriggerDict[luaTriggerId]
  end
  if cb == nil then
    return
  end
  LuaSkillCtrl:UnRegisterLuaTrigger(luaTriggerId, cb)
  self.luaTriggerDict[luaTriggerId] = nil
  table.removebyvalue(self.luaTriggerList, luaTriggerId)
end

function LuaSkillBase:RemoveAllLuaTrigger()
  if self.luaTriggerDict == nil or self.luaTriggerList == nil then
    return
  end
  for i = #self.luaTriggerList, 1, -1 do
    local triggerId = self.luaTriggerList[i]
    self.luaTriggerList[i] = nil
    if self.luaTriggerDict[triggerId] ~= nil then
      local cb = self.luaTriggerDict[triggerId]
      LuaSkillCtrl:UnRegisterLuaTrigger(triggerId, cb)
      self.luaTriggerDict[triggerId] = nil
    end
  end
  for k, v in pairs(self.luaTriggerDict) do
    self.luaTriggerDict[k] = nil
  end
  for k, v in pairs(self.luaTriggerList) do
    self.luaTriggerList[k] = nil
  end
end

function LuaSkillBase:CallCaterAtion(id)
  LuaSkillCtrl:CallRoleAction(self.caster, id)
end

function LuaSkillBase:CallCasterWait(duration, isWaiteToCallNextSkillUnFreeze)
  self.caster:AddSkillWaitBuff(duration, isWaiteToCallNextSkillUnFreeze or false)
end

function LuaSkillBase:AddCasterWait(duration)
  if duration ~= nil and 0 < duration and self.caster.eState == csRoleState.Casting then
    self.caster:SetRoleState(csRoleState.Casting, duration)
  end
end

function LuaSkillBase:AbandonSkillCdAutoReset(isAbandon)
  self.cskill:SetSkillAbandonAutoResetCd(isAbandon)
end

function LuaSkillBase:CancleCasterWait()
  self.caster:RemoveSkillWaitBuff()
end

function LuaSkillBase:CallNextBossSkill()
  self:OnSkillTake()
  self.caster:CallUnFreezeNextSkill()
end

function LuaSkillBase:CallCasterLookAt(targetList)
  if targetList.Count > 0 then
    self.caster:LookAtTarget(targetList[0])
  end
end

function LuaSkillBase:IsReadyToTake()
  return self.cskill:IsReadyToTake()
end

function LuaSkillBase:OnSkillTake()
  self.cskill:OnSkillTake()
end

function LuaSkillBase:PlayChipEffect()
end

function LuaSkillBase:PlayUltEffect(data, selectTargetCoord, selectRoles)
  LuaSkillCtrl:ResetUltFactor()
  if self.config.ultHFactor ~= nil then
    LuaSkillCtrl:SetUltHFactor(self.config.ultHFactor)
  end
  if self.config.ultVFactor ~= nil then
    LuaSkillCtrl:SetUltVFactor(self.config.ultVFactor)
  end
  self.ultCv = LuaSkillCtrl:PlaySkillCv(self.caster.roleDataId)
  if self.config.audioIdStart == nil then
    return
  end
  self.startAudio = LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioIdStart, function(auback)
    if auback == self.startAudio then
      self.startAudio = nil
    end
  end)
end

function LuaSkillBase:PlayUltMovie(moveSelectTarget, selectTargetCoord, selectRoles)
  MsgCenter:Broadcast(eMsgEventId.OnUltSkillVideoStart)
  if string.IsNullOrEmpty(LuaSkillCtrl.cUltSkillCtrl.curUltMovieFileName) then
    self:OnMovieFadeOut()
    return
  end
  if not CommonUtil.GetIsNeedPlayUltrSkillAnimi(self.cskill.dataId, true) then
    self:OnMovieFadeOut()
    return
  end
  self:RemoveSkillTrigger(eSkillTriggerType.OnSelfUltMovieFadeOut)
  self:AddTrigger(eSkillTriggerType.OnSelfUltMovieFadeOut, "OnMovieFadeOut", 1, self.OnMovieFadeOut)
  LuaSkillCtrl:CallPlayUltMovie()
  if self.config.audioIdMovie == nil then
    return
  end
  self.actionAudio = LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioIdMovie, function(auback)
    if auback == self.actionAudio then
      self.actionAudio = nil
    end
  end)
end

function LuaSkillBase:PlayUltMovieSpec(moveSelectTarget, selectTargetCoord, selectRoles)
  MsgCenter:Broadcast(eMsgEventId.OnUltSkillVideoStart)
  if string.IsNullOrEmpty(LuaSkillCtrl.cUltSkillCtrl.curUltMovieFileName) then
    self:OnMovieFadeOut()
    return
  end
  if not CommonUtil.GetIsNeedPlayUltrSkillAnimi(self.cskill.dataId, true) then
    self:OnMovieFadeOut()
    return
  end
  self:RemoveSkillTrigger(eSkillTriggerType.OnSelfUltMovieFadeOut)
  self:AddTrigger(eSkillTriggerType.OnSelfUltMovieFadeOut, "OnMovieFadeOut", 1, self.OnMovieFadeOut)
  local win = UIManager:ShowWindow(UIWindowTypeID.UltSkillVideo)
  win:InitBattlePlayerUltVideo()
  local ultMoviePath = LuaSkillCtrl:GetPlayUltMoviePath()
  win:PlayUltMoive(ultMoviePath)
  if self.config.audioIdMovie == nil then
    return
  end
  self.actionAudio = LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioIdMovie, function(auback)
    if auback == self.actionAudio then
      self.actionAudio = nil
    end
  end)
end

function LuaSkillBase:OnMovieFadeOut()
  self:RemoveSkillTrigger(eSkillTriggerType.OnSelfUltMovieFadeOut)
  if self:IsSkillCasterUltSkill() then
    LuaSkillCtrl:CallEndUltEffect(self.caster)
  else
    if self.config.movieEndRoleActionId ~= nil then
      LuaSkillCtrl:CallRoleAction(self.caster, self.config.movieEndRoleActionId)
    end
    LuaSkillCtrl:CallBackViewTimeLine(self.caster, true)
  end
  self:OnAfterUltEffect()
end

function LuaSkillBase:OnAfterUltEffect(isFromBreak)
  if isFromBreak and self.actionAudio ~= nil then
    LuaSkillCtrl:StopAudioByBack(self.actionAudio)
    self.actionAudio = nil
  end
  if self.startAudio ~= nil then
    LuaSkillCtrl:StopAudioByBack(self.startAudio)
    self.startAudio = nil
  end
  if self.config.audioIdEnd ~= nil then
    LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioIdEnd)
  end
  MsgCenter:Broadcast(eMsgEventId.OnUltSkillViewEnd)
end

function LuaSkillBase:GetRoleMoveSpeed()
  return self.caster.moveSpeed
end

function LuaSkillBase:GetRoleAttackSpeed()
  return self.caster.speed
end

function LuaSkillBase:CalcAtkActionSpeed(atkInterval, atkId)
  if LuaSkillCtrl.IsInBrotatoBattle then
    return 1
  end
  local atkTotalFrames = self:GetTotalAtkActionFrames(atkId)
  if atkInterval < atkTotalFrames then
    return atkTotalFrames / atkInterval
  else
    return 1
  end
end

function LuaSkillBase:GetTotalAtkActionFrames(atkId)
  local srcId = self.caster.resSrcId
  if srcId == 0 then
    return 0
  end
  if atkId == 1 then
    return ConfigData.resource_model[srcId].atk1_frames
  elseif atkId == 2 then
    return ConfigData.resource_model[srcId].atk2_frames
  else
    return 0
  end
end

function LuaSkillBase:GetAtkTriggerFrame(atkId, atkInterval)
  local srcId = self.caster.resSrcId
  if srcId == 0 then
    return 0
  end
  local atkTotalFrames = self:GetTotalAtkActionFrames(atkId)
  local triggerFrameCfg = 0
  if atkId == 1 then
    triggerFrameCfg = ConfigData.resource_model[srcId].atk1_trigger_frames
  elseif atkId == 2 then
    triggerFrameCfg = ConfigData.resource_model[srcId].atk2_trigger_frames
  end
  if atkInterval < atkTotalFrames then
    return triggerFrameCfg * atkInterval // atkTotalFrames
  else
    return triggerFrameCfg
  end
end

function LuaSkillBase:GetBehindTargetsPos(count, selectX, selectY, targetX, targetY)
  local coordSX, coordSY = self:__ChessBoardToCoord(selectX, selectY)
  local coordTX, coordTY = self:__ChessBoardToCoord(targetX, targetY)
  local disX = coordTX - coordSX
  local disY = coordTY - coordSY
  local targets = {}
  for i = 1, count do
    local curChkBoardX, curChkBoardY = self:__CoordToChessBoard(disX * i + coordSX, disY * i + coordSY)
    local role = LuaSkillCtrl.battleCtrl:GetBattleRole(curChkBoardX, curChkBoardY)
    if role ~= nil and not role.isDead then
      targets[i] = role
    end
  end
  return targets
end

function LuaSkillBase:__ChessBoardToCoord(x, y)
  return x * 2 + y % 2, y
end

function LuaSkillBase:__CoordToChessBoard(x, y)
  return (x - y % 2) // 2, y
end

function LuaSkillBase:CallHalo(haloBuffId, caster, target, radius, influenceType, onColiEnter, onColiStay, onColiExit, bindRole)
  local collisionEnter = BindCallback(self, self.__Halo_OnCollisionEnter, onColiEnter, haloBuffId)
  local collisionExit = BindCallback(self, self.__Halo_OnCollisionExit, onColiExit, haloBuffId)
  local emission = LuaSkillCtrl:CallCircledEmissionStraightly(self, caster, target, radius, 0, influenceType, collisionEnter, onColiStay, collisionExit, nil, false, false, nil, bindRole)
  self._haloEmissionList = self._haloEmissionList or {}
  table.insert(self._haloEmissionList, emission)
  return emission
end

function LuaSkillBase:__Halo_OnCollisionEnter(onColiEnter, haloBuffId, collider, index, entity)
  LuaSkillCtrl:CallBuff(self, entity, haloBuffId, 1, nil, true)
  if onColiEnter ~= nil then
    onColiEnter(collider, index, entity)
  end
end

function LuaSkillBase:__Halo_OnCollisionExit(onColiExit, haloBuffId, collider, entity)
  LuaSkillCtrl:DispelBuff(entity, haloBuffId, 0, true)
  if onColiExit ~= nil then
    onColiExit(collider, entity)
  end
end

function LuaSkillBase:RemoveAllHaleEmission()
  if self._haloEmissionList == nil then
    return
  end
  for k, emission in ipairs(self._haloEmissionList) do
    emission:EndAndDisposeEmission()
  end
  self._haloEmissionList = nil
end

function LuaSkillBase:OnSkipUltView()
  self:RemoveSkillTrigger(eSkillTriggerType.OnSelfUltMovieFadeOut)
end

function LuaSkillBase:CustomCostPlayerUltMp()
  self.isUltCanSpeicalPlay = false
end

function LuaSkillBase:CustomRecoverPlayerUltMpForOnceTake()
  self.isUltCanSpeicalPlay = true
end

function LuaSkillBase:GetHurtResultConfig(configId)
  if self.hurtResultConfig == nil then
    self.hurtResultConfig = {}
  end
  if self.hurtResultConfig[configId] == nil then
    local config = ConfigData.battle_skill_hurt_result_config[configId]
    if config == nil then
      warn("找不到对应的技能伤害配置:" .. tostring(configId))
      config = generalHurtConfig
    end
    self.hurtResultConfig[configId] = self:__GetTempHurtConfig(config)
  end
  return self.hurtResultConfig[configId]
end

function LuaSkillBase:GetHealResultConfig(configId)
  if self.healResultConfig == nil then
    self.healResultConfig = {}
  end
  if self.healResultConfig[configId] == nil then
    local config = ConfigData.battle_skill_heal_result_config[configId]
    if config == nil then
      warn("找不到对应的技能治疗配置:" .. tostring(configId))
      config = generalHealConfig
    end
    self.healResultConfig[configId] = self:__GetTempHealConfig(config)
  end
  return self.healResultConfig[configId]
end

function LuaSkillBase:__GetTempHealConfig(config)
  local tempConfig = {}
  for _, v in ipairs(ConfigData.battle_skill_heal_result_config.formulaTypes) do
    tempConfig[v] = config[v]
  end
  return tempConfig
end

function LuaSkillBase:__GetTempHurtConfig(config)
  local tempConfig = {}
  for _, v in ipairs(ConfigData.battle_skill_hurt_result_config.formulaTypes) do
    tempConfig[v] = config[v]
  end
  return tempConfig
end

function LuaSkillBase:SetLastSelectTarget(target)
  if LuaSkillCtrl.IsInBrotatoBattle then
    self.caster.recordTable.lastSelectTarget = target
  end
end

function LuaSkillBase:PauseAllTimer()
  if self.timers == nil then
    self.timers = {}
  end
  local leng = table.length(self.timers)
  if 0 < leng then
    for i = 1, leng do
      if self.timers[i] ~= nil then
        self.timers[i]:Pause()
      end
    end
  end
end

function LuaSkillBase:RePlayAllTimer()
  if self.timers == nil then
    self.timers = {}
  end
  local leng = table.length(self.timers)
  if 0 < leng then
    for i = 1, leng do
      if self.timers[i] ~= nil then
        self.timers[i]:Start()
      end
    end
  end
end

function LuaSkillBase:LuaDispose()
  if self.ultCv ~= nil then
    LuaSkillCtrl:StopAudioByBack(self.ultCv)
    self.ultCv = nil
  end
  self:RemoveAllBreakKillEffects()
  self:RemoveAllTimers()
  self.cskill = nil
  self.caster = nil
  self.moveSelectTarget = nil
  self.actionTrigger = nil
  self.actionAudio = nil
  self.startAudio = nil
  self.hurtResultConfig = nil
  self.healResultConfig = nil
end

return LuaSkillBase
