_class("BuffComponent", Object)
BuffComponent = BuffComponent

function BuffComponent:Constructor(world)
  self._world = world
  self._buffArray = {}
  self._buffSourceList = {}
  self._buffFlags = FlagValue:New(0)
  self._buffValues = {}
  self._curHitIndex = 0
  self._hasDropHpPercent = {}
  self._lockHpPercent = {}
  self._lockHpRoundIndex = 0
  self._lastUnlockHpRound = 0
  self._lockIndex = 0
  self._lockGSMState = 0
  self._unlockIndex = {}
  self._lastEffectedInfo = {}
  self._poisonByAttackCasterID = nil
  self._rebeccaPoisonCasterID = nil
  self._shieldViewType = nil
end

function BuffComponent:Dispose()
end

function BuffComponent:HasFlag(flag)
  return self._buffFlags:CheckFlag(flag)
end

function BuffComponent:SetFlag(flag)
  self._buffFlags:SetFlag(flag)
end

function BuffComponent:ResetFlag(flag)
  self._buffFlags:ResetFlag(flag)
end

function BuffComponent:GetBuffValues()
  return self._buffValues
end

function BuffComponent:GetBuffValue(key)
  return self._buffValues[key]
end

function BuffComponent:SetBuffValue(key, value)
  self._buffValues[key] = value
end

function BuffComponent:AddBuffValue(key, value)
  if not self._buffValues[key] then
    self._buffValues[key] = 0
  end
  self._buffValues[key] = self._buffValues[key] + value
  return self._buffValues[key]
end

function BuffComponent:SetActive(active)
  for i, inst in ipairs(self._buffArray) do
    inst:SetActive(active)
  end
end

function BuffComponent:GetBuffArray()
  return self._buffArray
end

function BuffComponent:GetBuffArrayByBuffEffect(et)
  local ret = {}
  for i, buff in ipairs(self._buffArray) do
    if buff:GetBuffEffectType() == et and not buff:IsUnload() then
      ret[#ret + 1] = buff
    end
  end
  return ret
end

function BuffComponent:GetSingleBuffByBuffEffect(et)
  for i, buff in ipairs(self._buffArray) do
    if buff:GetBuffEffectType() == et and not buff:IsUnload() then
      return buff
    end
  end
  return nil
end

function BuffComponent:CheckHaveBuffById(buffId)
  for i, buff in ipairs(self._buffArray) do
    if buff:BuffID() == buffId then
      return true
    end
  end
  return false
end

function BuffComponent:GetBuffById(buffId)
  for i, buff in ipairs(self._buffArray) do
    local cur_buffid = buff:BuffID()
    if cur_buffid == buffId and not buff:IsUnload() then
      return buff
    end
  end
  return nil
end

function BuffComponent:GetBuffArrayByBuffType(type)
  local ret = {}
  for i, buff in ipairs(self._buffArray) do
    if buff:GetBuffType() == type then
      ret[#ret + 1] = buff
    end
  end
  return ret
end

function BuffComponent:HasBuffEffect(et)
  for i, buff in ipairs(self._buffArray) do
    if buff:GetBuffEffectType() == et and not buff:IsUnload() then
      return true
    end
  end
  return false
end

function BuffComponent:AddBuffSource(buffSource, buffInstance)
  if not buffSource then
    return
  end
  for _buffSource, list in pairs(self._buffSourceList) do
    if _buffSource == buffSource then
      self:PrintBuffCmptLog("AddBuff SourceType:", buffSource._sourceType, "SourceID:", buffSource._sourceID, " BuffID:", buffInstance:BuffID(), "BuffSeq:", buffInstance:BuffSeq())
      table.insert(list, buffInstance)
      return
    end
  end
  self._buffSourceList[buffSource] = {buffInstance}
  self:PrintBuffCmptLog("AddBuff SourceType:", buffSource._sourceType, "SourceID:", buffSource._sourceID, " BuffID:", buffInstance:BuffID(), "BuffSeq:", buffInstance:BuffSeq())
end

function BuffComponent:UnLoadBuff(buffSource)
  for _buffSource, list in pairs(self._buffSourceList) do
    if _buffSource == buffSource then
      for _, buffInstance in pairs(list) do
        buffInstance:Unload(NTBuffUnload:New())
        self:PrintBuffCmptLog("UnLoad BuffID:", buffInstance:BuffID(), "BuffSeq:", buffInstance:BuffSeq())
      end
      return
    end
  end
end

function BuffComponent:GetBuffSourceByBuffID(buffID)
  for _buffSource, list in pairs(self._buffSourceList) do
    for k, buffInstance in pairs(list) do
      if buffInstance:BuffID() == buffID then
        return _buffSource
      end
    end
  end
  return nil
end

function BuffComponent:AddBuffInstance(buffInstance)
  table.insert(self._buffArray, buffInstance)
  local res = DataBuffAddResult:New(self._entity:GetID(), buffInstance:BuffSeq(), buffInstance:BuffID(), buffInstance:Context())
  self._world:EventDispatcher():Dispatch(GameEventType.DataLogicResult, 0, res)
  buffInstance:Load()
end

function BuffComponent:RemoveBuffInstance(buffInstance)
  if table.icontains(self._buffArray, buffInstance) then
    table.removev(self._buffArray, buffInstance)
  end
end

function BuffComponent:GetBuffBySeq(buffSeq)
  for i, buff in ipairs(self._buffArray) do
    if buff:BuffSeq() == buffSeq then
      return buff
    end
  end
end

function BuffComponent:RemoveBuffBySeq(buffSeq, notice)
  for i = #self._buffArray, 1, -1 do
    local buff = self._buffArray[i]
    if buff:BuffSeq() == buffSeq then
      buff:Unload(notice)
      return
    end
  end
end

function BuffComponent:RemoveBuffByEffectType(effectType, notice)
  local tSeqID = {}
  for i = #self._buffArray, 1, -1 do
    local buff = self._buffArray[i]
    if buff:GetBuffEffectType() == effectType then
      table.insert(tSeqID, buff:BuffSeq())
      buff:Unload(notice)
    end
  end
  return tSeqID
end

function BuffComponent:RemoveUnloadedBuffInstance()
  for i = #self._buffArray, 1, -1 do
    local buffInstance = self._buffArray[i]
    if buffInstance:IsUnload() then
      self:PrintBuffCmptLog("RemoveUnloadedBuffInstance entity=", self._entity:GetID(), " buffID=", buffInstance:BuffID())
      table.remove(self._buffArray, i)
    end
  end
end

function BuffComponent:ClearAllBuffInstances()
  for i, buff in ipairs(self._buffArray) do
    buff:OnUnload(nil, true)
  end
  self._buffArray = {}
  self._buffFlags:Clear()
  self._buffValues = {}
end

function BuffComponent:HasDebuff()
  for i, buff in ipairs(self._buffArray) do
    local buffcfgdata = buff:BuffConfigData()
    if buffcfgdata:IsDebuff() then
      return true
    end
  end
  return false
end

function BuffComponent:GetCurHitIndex()
  return self._curHitIndex
end

function BuffComponent:AddHitIndex()
  self._curHitIndex = self._curHitIndex + 1
  return self._curHitIndex
end

function BuffComponent:IsHPPercentHasDrop(hpPercent)
  for _, v in ipairs(self._hasDropHpPercent) do
    if v == hpPercent then
      return true
    end
  end
  return false
end

function BuffComponent:AddHasDropHpPercent(hpPercent)
  table.insert(self._hasDropHpPercent, hpPercent)
end

function BuffComponent:IsAlwaysLock()
  return self:GetBuffValue("LockHPAlways")
end

function BuffComponent:GetLockHPRoundIndex()
  return self._lockHpRoundIndex
end

function BuffComponent:GetLockGSMState()
  return self._lockGSMState
end

function BuffComponent:IsHPNeedUnLock(roundIndex, nowGSMState)
  if self:GetBuffValue("LockHPAlways") then
    return false
  end
  if roundIndex and self._lockHpRoundIndex ~= 0 and self._lockHpRoundIndex == roundIndex then
    if self._lockGSMState == GameStateID.MonsterTurn then
      if self:GetBuffValue("LockHPType") == LockHPType.MonsterTurnUnLock then
        return true
      end
      if self._lockGSMState == nowGSMState then
        return true
      end
    else
      return true
    end
  end
  return false
end

function BuffComponent:IsHPLock(roundIndex)
  if roundIndex and self._lockHpRoundIndex ~= 0 and self._lockHpRoundIndex == roundIndex then
    return true
  end
  return false
end

function BuffComponent:AddHpLockState(roundIndex, hpPercent, lockIndex, lockGSMState)
  self._lockHpRoundIndex = roundIndex
  table.insert(self._lockHpPercent, hpPercent)
  self._lockIndex = lockIndex
  self._lockGSMState = lockGSMState
end

function BuffComponent:GetHPLockIndex()
  return self._lockIndex
end

function BuffComponent:ResetHPLockState()
  self._lockHpRoundIndex = 0
  self._lockIndex = 0
  self._lockGSMState = 0
end

function BuffComponent:HpIsHasLocked(hpPercent)
  if #self._lockHpPercent == 0 then
    return false
  end
  return table.icontains(self._lockHpPercent, hpPercent)
end

function BuffComponent:HpHasLocked()
  return #self._lockHpPercent ~= 0
end

function BuffComponent:RecordUnlockHPIndex(index)
  self._unlockIndex[#self._unlockIndex + 1] = index
end

function BuffComponent:GetUnlockHPIndex()
  return self._unlockIndex
end

function BuffComponent:RecordLastUnlockHPRound(round)
  self._lastUnlockHpRound = round
end

function BuffComponent:GetLastUnlockHPRound()
  return self._lastUnlockHpRound
end

function BuffComponent:SaveArchivedData()
  local lockHpList = self:GetBuffValue("LockHPList")
  if lockHpList then
    local buffData = {}
    buffData._lockHpRoundIndex = self._lockHpRoundIndex
    buffData._lockGSMState = self._lockGSMState
    buffData._lockIndex = self._lockIndex
    buffData._lockHpPercent = self._lockHpPercent
    buffData._unlockIndex = self._unlockIndex
    return buffData
  end
  return nil
end

function BuffComponent:LoadArchivedData(buffData)
  if buffData then
    self._lockHpRoundIndex = buffData._lockHpRoundIndex
    self._lockGSMState = buffData._lockGSMState
    self._lockIndex = buffData._lockIndex
    self._lockHpPercent = buffData._lockHpPercent
    self._unlockIndex = buffData._unlockIndex or {}
  end
end

function BuffComponent:IsBuffFreeze()
  return self:GetBuffValue("Freeze") == 1
end

function BuffComponent:PrintBuffCmptLog(...)
  if self._world and self._world:IsDevelopEnv() then
    Log.debug(...)
  end
end

function BuffComponent:GetLastEffectedLogicInfo(key)
  return self._lastEffectedInfo[key]
end

function BuffComponent:SetLastEffectedLogicInfo(key, info)
  self._lastEffectedInfo[key] = info
end

function BuffComponent:RemoveLastEffectedLogicInfo(key)
  self._lastEffectedInfo[key] = nil
end

function BuffComponent:IsGreyHPEnabled()
  return self:GetBuffValue("GreyHPEnabled") == 1
end

function BuffComponent:SetGreyHPEnable(enabled)
  self:SetBuffValue("GreyHPEnabled", enabled and 1 or 0)
end

function BuffComponent:GetGreyHPValue(safety)
  local v = self:GetBuffValue("GreyHPValue")
  if safety and not v then
    v = 0
  end
  return v
end

function BuffComponent:SetGreyHPValue(v)
  self:SetBuffValue("GreyHPValue", v)
end

function BuffComponent:ClearGreyHPValue()
  self:SetBuffValue("GreyHPValue", nil)
end

function BuffComponent:GetRecoverByMaxHPCountValue()
  local v = self:GetBuffValue("RecoverByMaxHPCount")
  v = v or 0
  return v
end

function BuffComponent:SetRecoverByMaxHPCountValue(v)
  self:SetBuffValue("RecoverByMaxHPCount", v)
end

function BuffComponent:ClearRecoverByMaxHPCountValue()
  self:SetBuffValue("RecoverByMaxHPCount", nil)
end

function BuffComponent:SetPoisonByAttackCasterID(casterID)
  if not self._poisonByAttackCasterID then
    self._poisonByAttackCasterID = casterID
  end
end

function BuffComponent:ClearPoisonByAttackCasterID()
  self._poisonByAttackCasterID = nil
end

function BuffComponent:GetPoisonByAttackCasterID()
  return self._poisonByAttackCasterID
end

function BuffComponent:SetRebeccaPoisonCasterID(casterID)
  if not self._rebeccaPoisonCasterID then
    self._rebeccaPoisonCasterID = casterID
  end
end

function BuffComponent:ClearRebeccaPoisonCasterID()
  self._rebeccaPoisonCasterID = nil
end

function BuffComponent:GetRebeccaPoisonCasterID()
  return self._rebeccaPoisonCasterID
end

function BuffComponent:IsCurseHPEnabled()
  return self:GetBuffValue("CurseHPEnabled") == 1
end

function BuffComponent:GetCurseHPSourceEntityID()
  return self:GetBuffValue("CurseHPSourceEntityID")
end

function BuffComponent:SetCurseHPEnable(enabled)
  self:SetBuffValue("CurseHPEnabled", enabled and 1 or 0)
end

function BuffComponent:SetCurseHPSourceEntityID(entityID)
  self:SetBuffValue("CurseHPSourceEntityID", entityID)
end

function BuffComponent:GetCurseHPValue(safety)
  local v = self:GetBuffValue("CurseHPValue")
  if safety and not v then
    v = 0
  end
  return v
end

function BuffComponent:SetCurseHPValue(v)
  self:SetBuffValue("CurseHPValue", v)
end

function BuffComponent:ClearCurseHPValue()
  self:SetBuffValue("CurseHPValue", nil)
end

function Entity:BuffComponent()
  return self:GetComponent(self.WEComponentsEnum.Buff)
end

function Entity:HasBuff()
  return self:HasComponent(self.WEComponentsEnum.Buff)
end

function Entity:AddBuffComponent()
  local world = self:GetOwnerWorld()
  local index = self.WEComponentsEnum.Buff
  local component = BuffComponent:New(world)
  self:AddComponent(index, component)
end

function Entity:RemoveBuffComponent()
  if self:HasBuff() then
    self:RemoveComponent(self.WEComponentsEnum.Buff)
  end
end

function Entity:HasBuffFlag(flag)
  if not self:HasBuff() then
    return false
  end
  return self:BuffComponent():HasFlag(flag)
end
