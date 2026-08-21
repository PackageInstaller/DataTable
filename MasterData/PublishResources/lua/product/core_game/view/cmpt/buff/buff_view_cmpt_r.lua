_class("BuffViewComponent", Object)
BuffViewComponent = BuffViewComponent

function BuffViewComponent:Constructor()
  self._viewInstanceArray = {}
  self._viewData = {}
  self._lockIndex = 0
  self._lockGSMState = 0
  self._lockHpRoundIndex = 0
  self._isAlwaysHPLock = false
end

function BuffViewComponent:AddBuffViewInstance(viewInstance)
  table.insert(self._viewInstanceArray, viewInstance)
end

function BuffViewComponent:RemoveBuffViewInstance(buffViewInstance)
  table.removev(self._viewInstanceArray, buffViewInstance)
  Log.debug("RemoveBuffViewInstance() entity=", self._entity:GetID(), " buffseq=", buffViewInstance:BuffSeq())
end

function BuffViewComponent:GetBuffViewInstanceArray()
  return self._viewInstanceArray
end

function BuffViewComponent:GetBuffViewInstance(seq)
  for i, buffView in ipairs(self._viewInstanceArray) do
    if buffView:BuffSeq() == seq then
      return buffView
    end
  end
end

function BuffViewComponent:GetSingleBuffByBuffEffect(et)
  for i, buffView in ipairs(self._viewInstanceArray) do
    if buffView:GetBuffEffectType() == et then
      return buffView
    end
  end
  return nil
end

function BuffViewComponent:HasBuffEffect(et)
  for i, buffView in ipairs(self._viewInstanceArray) do
    if buffView:GetBuffEffectType() == et then
      return true
    end
  end
  return false
end

function BuffViewComponent:GetHPLockIndex()
  return self._lockIndex
end

function BuffViewComponent:ResetHPLockState()
  self._lockHpRoundIndex = 0
  self._lockIndex = 0
  self._lockGSMState = 0
end

function BuffViewComponent:IsAlwaysHPLock()
  return self._isAlwaysHPLock
end

function BuffViewComponent:AddHpLockState(roundIndex, lockIndex, lockGSMState, isAlwaysHPLock, lockHPType, unlockHPIndex)
  self._lockHpRoundIndex = roundIndex
  self._lockIndex = lockIndex
  self._lockGSMState = lockGSMState
  self._isAlwaysHPLock = isAlwaysHPLock
  self._lockHPType = lockHPType
  self._unlockIndex = unlockHPIndex
end

function BuffViewComponent:GetUnlockHPIndex()
  return self._unlockIndex
end

function BuffViewComponent:IsHPNeedUnLock(roundIndex, nowGSMState)
  if self:IsAlwaysHPLock() then
    return false
  end
  if roundIndex and self._lockHpRoundIndex ~= 0 and self._lockHpRoundIndex == roundIndex then
    if self._lockGSMState == GameStateID.MonsterTurn then
      if self._lockHPType == LockHPType.MonsterTurnUnLock then
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

function BuffViewComponent:GetBuffViewShowList(onBlood)
  local buffIDList = {}
  local showList = {}
  for i, buffView in ipairs(self._viewInstanceArray) do
    local isShowBuffIcon = self:_GetBuffShowBuffIcon(buffView, onBlood)
    local canShowBuff = self:_GetShowBuffLayer(buffView)
    if not table.intable(buffIDList, buffView:BuffID()) and isShowBuffIcon and canShowBuff then
      table.insert(buffIDList, buffView:BuffID())
      table.insert(showList, buffView)
    end
  end
  return showList
end

function BuffViewComponent:_GetBuffShowBuffIcon(buffView, onBlood)
  local onBloodShowLayerShield = onBlood and true or buffView:GetBuffEffectType() ~= BuffEffectType.LayerShield
  local buffShowBuffIcon = buffView:BuffConfigData():GetBuffShowBuffIcon()
  return onBloodShowLayerShield and buffShowBuffIcon
end

function BuffViewComponent:GetBuffTeamStateShowList(onBlood)
  local buffIDList = {}
  local showList = {}
  for i, buffView in ipairs(self._viewInstanceArray) do
    local isShowBuffTeamState = self:_GetBuffShowTeamState(buffView, onBlood)
    local canShowBuff = self:_GetShowBuffLayer(buffView)
    if not table.intable(buffIDList, buffView:BuffID()) and isShowBuffTeamState and canShowBuff then
      table.insert(buffIDList, buffView:BuffID())
      table.insert(showList, buffView)
    end
  end
  return showList
end

function BuffViewComponent:_GetBuffShowTeamState(buffView, onBlood)
  local onBloodShowLayerShield = onBlood and true or buffView:GetBuffEffectType() ~= BuffEffectType.LayerShield
  local buffShowTeamState = buffView:BuffConfigData():GetBuffShowTeamState()
  return onBloodShowLayerShield and buffShowTeamState
end

function BuffViewComponent:_GetShowBuffLayer(buffView)
  local buffLayer = buffView:GetLayerCount()
  local isUnload = buffView:IsUnload()
  local hasLayer = buffView:HasLayer()
  local isNoLayerBuff = not hasLayer and buffView:IsShow()
  local canShow = isNoLayerBuff or buffLayer and 0 < buffLayer
  return canShow
end

function BuffViewComponent:GetMaterialAnimiationArray()
  local anims = {}
  for i, buffv in ipairs(self._viewInstanceArray) do
    local cfg = buffv:BuffConfigData()
    if buffv:IsShow() and (cfg:GetBuffType() == BuffType.DOT or cfg:GetMaterialAnimationMode() == BuffMaterialAnimationMode.Alternating) then
      local anim = cfg:GetMaterialAnimation()
      if anim and not table.icontains(anims, anim) then
        anims[#anims + 1] = anim
      end
    end
  end
  return anims
end

function BuffViewComponent:GetHeadBuff()
  local min_priority = 0
  local head_buff
  for _, buffv in ipairs(self._viewInstanceArray) do
    if buffv:GetBuffType() == BuffType.Control and buffv:IsShow() then
      local cfg = buffv:BuffConfigData()
      local priority = cfg:GetBuffPriority()
      if 0 < priority and (min_priority == 0 or min_priority > priority) then
        min_priority = priority
        head_buff = buffv
      end
    end
  end
  return head_buff
end

function BuffViewComponent:GetBuffValue(key)
  return self._viewData[key]
end

function BuffViewComponent:SetBuffValue(key, value)
  self._viewData[key] = value
end

function BuffViewComponent:HasBuffByID(buffId)
  for _, v in ipairs(self._viewInstanceArray) do
    local buffViewInstance = v
    if buffViewInstance:BuffID() == buffId then
      return true
    end
  end
  return false
end

function Entity:BuffView()
  return self:GetComponent(self.WEComponentsEnum.BuffView)
end

function Entity:AddBuffView()
  local component = BuffViewComponent:New()
  self:AddComponent(self.WEComponentsEnum.BuffView, component)
end

function Entity:RemoveBuffViewInstance(buffViewInstance)
  if self:BuffView() then
    self:BuffView():RemoveBuffViewInstance(buffViewInstance)
  end
end
