_class("BuffViewAddLayer", BuffViewBase)
BuffViewAddLayer = BuffViewAddLayer

function BuffViewAddLayer:PlayView(TT, notify, trace)
  local res = self._buffResult
  local curLayer = res:GetLayer()
  local buffseq = res:GetBuffSeq()
  local addLayer = res:GetAddLayer()
  local buffView = self._entity:BuffView()
  local viewInstance = buffView:GetBuffViewInstance(buffseq)
  if not viewInstance then
    Log.error("BuffViewAddLayer not find viewInstance! entity=", self._entity:GetID(), " layer=", curLayer)
    return
  end
  if self._isTrapDead then
    local curViewLayer = viewInstance:GetLayerCount() or 0
    if 0 < addLayer and curLayer < curViewLayer then
      return
    end
    if addLayer < 0 and curLayer > curViewLayer then
      return
    end
  end
  Log.debug("BuffViewAddLayer entity=", self._entity:GetID(), " layer=", curLayer)
  local casterEntity = self:BuffViewInstance():GetBuffViewContext() and self:BuffViewInstance():GetBuffViewContext().casterEntity or nil
  viewInstance:SetLayerCount(TT, curLayer, res.totalLayerCount, casterEntity)
  self._world:EventDispatcher():Dispatch(GameEventType.ChangeBuff)
  if res:IsDontDisplay() then
    return
  end
  if self._entity:HasPetPstID() then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.SetAccumulateNum, self._entity:PetPstID():GetPstID(), curLayer)
  end
  local buffEffectEntityID = viewInstance:GetBuffEffectEntityID()
  local effectAnimList = viewInstance:GetBuffEffectLayerAnimList()
  local buffEffectEntity = self._world:GetEntityByID(buffEffectEntityID)
  if effectAnimList and buffEffectEntity then
    local effectGameObj = buffEffectEntity:View().ViewWrapper.GameObject
    local anim = effectGameObj:GetComponentInChildren(typeof(UnityEngine.Animation))
    if anim then
      Log.info("CurLayer ", curLayer, " totalLayer ", res.totalLayerCount)
      local animName = effectAnimList[curLayer]
      Log.info(" CurAnim ", animName)
      anim:Play(animName)
    else
      Log.fatal("Can not find view layer animation cmpt")
    end
  end
  local buffConfigData = viewInstance:BuffConfigData()
  local viewParams = buffConfigData:GetViewParams() or {}
  if viewParams.IsHPEnergy then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateHPEnergy, self._entity:GetID(), curLayer)
  end
  self:TryShowLayerAsActiveSkillEnergy(TT, viewInstance, res)
end

function BuffViewAddLayer:TryShowLayerAsActiveSkillEnergy(TT, viewInstance, res)
  if not self._entity:HasSkillInfo() then
    return
  end
  local activeSkillID = self._entity:SkillInfo():GetActiveSkillID()
  local activeSkillConfig = self._world:GetService("Config"):GetSkillConfigData(activeSkillID, self._entity)
  if not activeSkillConfig or activeSkillConfig:GetSkillTriggerType() ~= SkillTriggerType.BuffLayer then
    return
  end
  local buffEffectType = viewInstance:GetBuffEffectType()
  local extraParam = activeSkillConfig:GetSkillTriggerExtraParam()
  if self._buffResult:GetLayerType() ~= extraParam.buffEffectType then
    return
  end
  if not self._entity:HasPetPstID() then
    return
  end
  local petPstID = self._entity:PetPstID():GetPstID()
  local curLayer = res:GetLayer()
  local ready = curLayer >= activeSkillConfig:GetSkillTriggerParam()
  if ready then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.PetActiveSkillGetReady, petPstID, ready)
  end
  local skillInfoCmpt = self._entity:SkillInfo()
  local variantActiveSkillInfo = skillInfoCmpt:GetVariantActiveSkillInfo()
  if variantActiveSkillInfo then
    local variantList = variantActiveSkillInfo[activeSkillID]
    for _, variantSkillID in pairs(variantList) do
      local variantSkillCfg = self._world:GetService("Config"):GetSkillConfigData(variantSkillID, self._entity)
      if variantSkillCfg:GetSkillTriggerType() == SkillTriggerType.BuffLayer and curLayer >= variantSkillCfg:GetSkillTriggerParam() then
        GameGlobal.EventDispatcher():Dispatch(GameEventType.PetActiveSkillGetReady, petPstID, true)
      end
    end
  end
  local notify = NTPowerReady:New(self._world:GetEntityByID(self._entity:GetID()))
  self._world:GetService("PlayBuff"):PlayBuffView(TT, notify)
end

function BuffViewAddLayer:IsNotifyMatch(notify)
  if notify:GetNotifyType() == NotifyType.PlayerEachMoveStart or notify:GetNotifyType() == NotifyType.PlayerEachMoveEnd or notify:GetNotifyType() == NotifyType.TeamLeaderEachMoveEnd then
    local movePos = self._buffResult:GetMovePos()
    return movePos == notify:GetPos()
  elseif notify:GetNotifyType() == NotifyType.BeforeHighFrequencyDamageHit then
    return notify:GetHitIndex() == self._buffResult:GetHighFrequencyDamageIndex()
  elseif notify:GetNotifyType() == NotifyType.AfterHighFrequencyDamageHit then
    return notify:GetHitIndex() == self._buffResult:GetHighFrequencyDamageIndex()
  elseif notify:GetNotifyType() == NotifyType.PlayerBeHit then
    local damageIndexMatch = true
    if self._buffResult.damageIndex and notify:GetDamageIndex() then
      damageIndexMatch = self._buffResult.damageIndex == notify:GetDamageIndex()
    end
    return self._buffResult.attackPos == notify:GetAttackPos() and self._buffResult.targetPos == notify:GetTargetPos() and self._buffResult.attackerEntity == notify:GetAttackerEntity() and self._buffResult.defenderEntity == notify:GetDefenderEntity() and damageIndexMatch
  elseif notify:GetNotifyType() == NotifyType.MonsterBeHit then
    local viewParams = self._viewInstance:BuffConfigData():GetViewParams()
    if viewParams and viewParams.ViewMatchNotifyIndex == 1 then
      local viewInstance = self._viewInstance
      local notifyMatchLayer = notify:GetMatchBuffViewLayer(viewInstance:BuffID())
      if notifyMatchLayer then
        return false
      end
      local curRoundCount = BattleStatHelper.GetLevelTotalRoundCount()
      local buffResultRound = self._buffResult:GetLevelTotalRoundCount()
      if curRoundCount ~= buffResultRound then
        return false
      end
      local curLayer = self._buffResult:GetLayer()
      notify:SetMatchBuffViewLayer(curLayer, viewInstance:BuffID())
      return true
    end
    local damageIndexMatch = true
    if self._buffResult:GetDamageStageIndex() and notify:GetDamageStageIndex() then
      damageIndexMatch = self._buffResult:GetDamageStageIndex() == notify:GetDamageStageIndex()
    end
    local curSkillDamageIndex = true
    if self._buffResult:GetCurSkillDamageIndex() and notify:GetCurSkillDamageIndex() then
      curSkillDamageIndex = self._buffResult:GetCurSkillDamageIndex() == notify:GetCurSkillDamageIndex()
    end
    return self._buffResult.attackPos == notify:GetAttackPos() and self._buffResult.targetPos == notify:GetTargetPos() and self._buffResult.attackerEntity == notify:GetAttackerEntity() and self._buffResult.defenderEntity == notify:GetDefenderEntity() and damageIndexMatch and curSkillDamageIndex
  elseif notify.GetAttackPos and notify.GetTargetPos and self._buffResult.attackPos and self._buffResult.targetPos then
    local viewParams = self._viewInstance:BuffConfigData():GetViewParams()
    if viewParams and viewParams.ViewMatchNotifyIndex == 1 then
      local viewInstance = self._viewInstance
      local notifyMatchLayer = notify:GetMatchBuffViewLayer(viewInstance:BuffID())
      if notifyMatchLayer then
        return false
      end
      local curLayer = self._buffResult:GetLayer()
      notify:SetMatchBuffViewLayer(curLayer, viewInstance:BuffID())
      return true
    end
    local attackIndexMatch = true
    if self._buffResult.normalAttackIndex and notify.GetNormalAttackIndex and notify:GetNormalAttackIndex() then
      attackIndexMatch = self._buffResult.normalAttackIndex == notify:GetNormalAttackIndex()
    end
    return self._buffResult.attackPos == notify:GetAttackPos() and self._buffResult.targetPos == notify:GetTargetPos() and attackIndexMatch
  elseif notify:GetNotifyType() == NotifyType.TrapSkillStart then
    local movePos = self._buffResult:GetMovePos()
    return movePos == notify:GetPos()
  elseif notify:GetNotifyType() == NotifyType.MinosAbsorbTrap then
    local notifyEntity = notify:GetNotifyEntity()
    return notifyEntity:GetID() == self._buffResult.abTrapID
  elseif notify:GetNotifyType() == NotifyType.PetMinosAbsorbTrap then
    local notifyEntity = notify:GetNotifyEntity()
    return notifyEntity:GetID() == self._buffResult.abTrapID
  elseif notify:GetNotifyType() == NotifyType.SuperGridTriggerEnd or notify:GetNotifyType() == NotifyType.PoorGridTriggerEnd then
    return notify:GetTriggerPos() == self._buffResult:GetTriggerPos()
  elseif notify:GetNotifyType() == NotifyType.ReduceShieldLayer then
    return notify:GetNotifyLayer() == self._buffResult:GetLayer() and notify:GetNotifyEntity() == self._viewInstance:Entity()
  elseif notify:GetNotifyType() == NotifyType.NotifyLayerChange then
    local n = notify
    local configData = self:BuffViewInstance():BuffConfigData()
    local viewParams = configData:GetViewParams() or {}
    local isIgnoreOldLayer = viewParams.ignoreOldLayer == 1
    if not isIgnoreOldLayer and self._buffResult.__oldFinalLayer ~= n.__oldFinalLayer then
      return false
    end
    if n:GetNotifyEntity() and self._buffResult:GetNotifyLayerChange_Entity() ~= n:GetNotifyEntity() then
      return false
    end
    return true
  elseif notify:GetNotifyType() == NotifyType.TrapDead then
    local entity = notify:GetNotifyEntity()
    self._isTrapDead = true
    return entity:GetID() == self._buffResult:GetEntityID()
  elseif notify:GetNotifyType() == NotifyType.BuffLoad then
    local buffLoadEntityID = notify:GetCasterEntityID()
    if buffLoadEntityID and self._buffResult.__buffLogicAddLayer_source then
      return buffLoadEntityID == self._buffResult.__buffLogicAddLayer_source
    else
      return true
    end
  else
    return true
  end
end

_class("BuffViewClearLayer", BuffViewBase)
BuffViewClearLayer = BuffViewClearLayer

function BuffViewClearLayer:PlayView(TT)
  local res = self._buffResult
  local curLayer = res:GetLayer()
  local dontDisplay = res:GetDonotDisplay()
  local ownerEntityID = res:GetOwnerEntityID()
  local targetBuffSeq = res:GetTargetBuffSeq()
  local ownerEntity = self._world:GetEntityByID(ownerEntityID)
  local changeLayer = res:GetChangeLayer()
  if not ownerEntity then
    return
  end
  local buffView = ownerEntity:BuffView()
  for _, value in ipairs(targetBuffSeq) do
    local viewInstance = buffView:GetBuffViewInstance(value)
    viewInstance = viewInstance or self._viewInstance
    if self._isTrapDead then
      local curViewLayer = viewInstance:GetLayerCount() or 0
      if changeLayer < 0 and curLayer > curViewLayer then
        goto lbl_57
      end
    end
    viewInstance:SetLayerCount(TT, curLayer, res:GetTotalLayer())
    if res:GetIsUnload() == 1 and curLayer == 0 then
      viewInstance:SetUnload()
    end
    ::lbl_57::
  end
  Log.debug("BuffViewClearLayer entity=", ownerEntity:GetID(), " layer=", curLayer)
  self._world:EventDispatcher():Dispatch(GameEventType.ChangeBuff)
  if dontDisplay then
    return
  end
  if ownerEntity:HasPetPstID() then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.SetAccumulateNum, ownerEntity:PetPstID():GetPstID(), curLayer)
  end
  for _, value in ipairs(targetBuffSeq) do
    local viewInstance = buffView:GetBuffViewInstance(value)
    viewInstance = viewInstance or self._viewInstance
    local buffConfigData = viewInstance:BuffConfigData()
    local viewParams = buffConfigData:GetViewParams() or {}
    if viewParams.IsHPEnergy then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateHPEnergy, self._entity:GetID(), curLayer)
    end
  end
end

function BuffViewClearLayer:IsNotifyMatch(notify)
  if notify:GetNotifyType() == NotifyType.NormalEachAttackStart or notify:GetNotifyType() == NotifyType.NormalEachAttackEnd or notify:GetNotifyType() == NotifyType.BuffCastSkillEachAttackBegin then
    local result = self._buffResult
    return result.attacker == notify:GetAttackerEntity() and result.defender == notify:GetDefenderEntity() and result.attackPos == notify:GetAttackPos() and result.targetPos == notify:GetTargetPos()
  elseif notify:GetNotifyType() == NotifyType.NotifyLayerChange then
    local n = notify
    if self._buffResult:GetTotalLayer() ~= n:GetTotalCount() then
      return false
    end
  elseif notify:GetNotifyType() == NotifyType.TrapSkillStart then
    local movePos = self._buffResult:GetMovePos()
    return movePos == notify:GetPos()
  elseif notify:GetNotifyType() == NotifyType.MinosAbsorbTrap then
    local notifyEntity = notify:GetNotifyEntity()
    return notifyEntity:GetID() == self._buffResult.abTrapID
  elseif notify:GetNotifyType() == NotifyType.PetMinosAbsorbTrap then
    local notifyEntity = notify:GetNotifyEntity()
    return notifyEntity:GetID() == self._buffResult.abTrapID
  elseif notify:GetNotifyType() == NotifyType.SuperGridTriggerEnd or notify:GetNotifyType() == NotifyType.PoorGridTriggerEnd then
    return notify:GetTriggerPos() == self._buffResult:GetTriggerPos()
  elseif notify:GetNotifyType() == NotifyType.ReduceShieldLayer then
    return notify:GetNotifyLayer() == self._buffResult:GetLayer() and notify:GetNotifyEntity() == self._viewInstance:Entity()
  elseif notify:GetNotifyType() == NotifyType.MonsterBeHit then
    local viewParams = self._viewInstance:BuffConfigData():GetViewParams()
    if viewParams and viewParams.ViewMatchNotifyIndex == 1 then
      local viewInstance = self._viewInstance
      local notifyMatchLayer = notify:GetMatchBuffViewLayer(viewInstance:BuffID())
      if notifyMatchLayer then
        return false
      end
      local curLayer = self._buffResult:GetLayer()
      notify:SetMatchBuffViewLayer(curLayer, viewInstance:BuffID())
      return true
    end
    return self._buffResult.attackPos == notify:GetAttackPos() and self._buffResult.targetPos == notify:GetTargetPos() and self._buffResult.attacker == notify:GetAttackerEntity() and self._buffResult.defender == notify:GetDefenderEntity()
  elseif notify:GetNotifyType() == NotifyType.TrapDead then
    local entity = notify:GetNotifyEntity()
    self._isTrapDead = true
    return entity:GetID() == self._buffResult:GetEntityID()
  end
  return true
end

_class("BuffViewForceRefreshLayer", BuffViewBase)
BuffViewForceRefreshLayer = BuffViewForceRefreshLayer

function BuffViewForceRefreshLayer:PlayView(TT)
  local result = self._buffResult
  local layer = result:GetBuffLayer()
  if type(layer) == "number" and 0 < layer then
    if self._entity:HasPetPstID() then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.SetAccumulateNum, self._entity:PetPstID():GetPstID(), layer)
    end
    if self._world:Player():IsLocalTeamEntity(self._entity) then
      self._entity:BuffView():SetBuffValue(result:GetBuffLayerName(), layer)
      self._world:EventDispatcher():Dispatch(GameEventType.ChangeBuff)
    end
  end
end
