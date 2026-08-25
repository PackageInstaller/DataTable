local BP = bc.BattleProperty
local Vector3 = CS.UnityEngine.Vector3
local Vector2 = CS.UnityEngine.Vector2
local BattleRoleFloatTextUI, Super = System.NewComponent("BattleRoleFloatTextUI")

function BattleRoleFloatTextUI:ctor(rootNode, battleRole)
  Super.ctor(self)
  self.role = battleRole
  self.roleUid = battleRole.uid
  self.roleData = bg.battleDataCenter:GetRoleDataModel(self.roleUid)
  self.floatingTextRoot = rootNode
  self.holdFloatingTexts = {}
  self.isMultiDamage = false
  self.damageList = {}
  self.floatTextList = {}
  self.tickTime = 0
  self.damageFloatTime = 0
  self.textFloatTime = 0
  self.floatingCount = 0
  self.floatingCountInRound = 0
  self.floatingDelay = 0
end

function BattleRoleFloatTextUI:Tick(deltaTime)
  self.tickTime = self.tickTime + deltaTime
  if #self.damageList > 0 and self.tickTime - self.damageFloatTime >= bc.DamageFloatInterval then
    self:ShowDamageFloat()
  end
  if #self.floatTextList > 0 and self.tickTime - self.textFloatTime >= self.floatingDelay then
    self:ShowFloatText()
  end
end

function BattleRoleFloatTextUI:OnBind(binder)
  self.binder = binder
  self:BindState(binder)
  self:BindTentaleDamage(binder)
  if bg.isPVE then
    self:BindPVEEnergy(binder)
  end
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.Confirm, self.OnConfirmSth, self)
end

function BattleRoleFloatTextUI:OnUnbind()
  self.binder = nil
  if bg.battleRender and bg.battleRender.eventMgr then
    bg.battleRender.eventMgr:UnregisterAllEventsByTarget(self)
  end
  Super.OnUnbind(self)
end

function BattleRoleFloatTextUI:BindPVEEnergy(binder)
  binder:BindToRaw(function(_, newValue, oldValue)
    if not bg.battleDataCenter.boutData:IsCamp1Action() then
      return
    end
    if newValue and oldValue and oldValue < newValue then
      local text = LT.Textf("CostTips", newValue - oldValue)
      self:PushFloatingText(bc.FloatingTextType.SlowText, text)
    end
  end, function()
    do return self.roleData.GetProperty, self.roleData end
    return self.roleData.GetProperty, self.roleData, BP.energy
  end)
end

function BattleRoleFloatTextUI:BindTentaleDamage(binder)
  if bg.isPVE then
    if self.roleData.camp == bc.BattleCamp.Camp1 and not bg.battleDataCenter:IsSchool(bc.SchoolCnID.DEEP_SEA) then
      return
    end
    if self.roleData.camp == bc.BattleCamp.Camp2 and self.roleData:GetTentacleMaxCount() <= 0 then
      return
    end
  end
  binder:BindToRaw(function(_, newValue, oldValue)
    if newValue and oldValue and oldValue < newValue then
      local text = LT.Textf("TentaclesTips", newValue - oldValue)
      self:PushFloatingText(bc.FloatingTextType.SlowText, text)
    end
  end, function()
    local tentaleDmg = self.roleData:GetProperty(BP.tentacle_dmg)
    return tentaleDmg
  end)
end

function BattleRoleFloatTextUI:BindState(binder)
end

function BattleRoleFloatTextUI:BindPVPUltiEnergy(binder)
end

function BattleRoleFloatTextUI:OnPVPUltiEnergyChange(changedValue, showText)
  local ultiEnergy = self.roleData:GetProperty(BP.ulti_energy)
  if changedValue > 0 and showText then
    local text = "+" .. changedValue
    self:PushFloatingText(bc.FloatingTextType.UltiEnergy, text)
  end
  if ultiEnergy == bc.UltiEnergyPerSkill then
    AudioManager.Instance:PostSoundEvent("FIGHT_EXSKILL_MAX_NOTICE")
  end
end

function BattleRoleFloatTextUI:OnStateDel(state)
  if state and state.isShowDelFloatText then
    local stateName = state.configData.Name
    local floatText = LT.Textf("Dispel_Tips", LT.Text(stateName, true))
    local floatType = bc.FloatingTextType.Text
    self:PushFloatingText(floatType, floatText)
  end
end

function BattleRoleFloatTextUI:OnStateChanged(state, changeLayer)
  local stateCfg = DT.State[state.stateId]
  if not stateCfg then
    return
  end
  local sc = BattleStateDataClient(state)
  if not sc:ShowJudgement() then
    return
  end
  if stateCfg.ShowType == CommonDefine.StateShowType.HideFloatText or stateCfg.ShowType == CommonDefine.StateShowType.Hide then
    return
  end
  local stateName = stateCfg.Name
  local floatType = bc.FloatingTextType.PositiveTextAndIcon
  if not bc.STR_BOOL[stateCfg.IsBuff] then
    floatType = bc.FloatingTextType.NegativeTextAndIcon
  end
  local icon = stateCfg.Icon and bc.ICON_PATH_PERFIX .. stateCfg.Icon
  local sign = changeLayer > 0 and 1 or changeLayer < 0 and -1 or 0
  self:PushFloatingText(floatType, nil, icon, {
    stateId = state.stateId,
    sign = sign,
    changeLayer = changeLayer,
    stateName = stateName
  })
end

function BattleRoleFloatTextUI:ShowHpChangeText(changedValue, reason, isRestrain, extraData)
  if reason == bc.PropertyChangeReason.DamageImmue then
    self:PushFloatingText(bc.FloatingTextType.Text, LT.Text("Battle_Tips_Immune", true))
  elseif reason == bc.PropertyChangeReason.DamageBlock then
    self:PushFloatingText(bc.FloatingTextType.Text, LT.Text("Battle_Tips_Block", true))
  elseif reason == bc.PropertyChangeReason.Heal or reason == bc.PropertyChangeReason.AttrModify and changedValue > 0 then
    self:PushFloatingText(bc.FloatingTextType.Heal, nil, nil, {rawValue = changedValue})
  elseif reason == bc.PropertyChangeReason.HealCrit then
    self:PushFloatingText(bc.FloatingTextType.HealCrit, nil, nil, {rawValue = changedValue})
  elseif reason == bc.PropertyChangeReason.Damage or reason == bc.PropertyChangeReason.AttrModify and changedValue < 0 then
    local value = changedValue
    if extraData.pvp_death_resist or bg.isPVE then
      value = extraData.castValue
    end
    if bg.isPVE and self.role.camp == bc.BattleCamp.Camp1 then
      value = changedValue
    end
    local data = {
      isCrit = false,
      value = value,
      isRestrain = isRestrain
    }
    local icon
    if extraData and extraData.stateId and table.contains(DT.GetOriginalConstant("ShowInBuffID"), extraData.stateId) then
      icon = bc.ICON_PATH_PERFIX .. DT.State[extraData.stateId].Icon
    end
    self:PushFloatingText(bc.FloatingTextType.Damage, value, icon, data)
  elseif reason == bc.PropertyChangeReason.DamageCrit then
    local value = changedValue
    if extraData.pvp_death_resist or bg.isPVE then
      value = extraData.castValue
    end
    local data = {
      isCrit = true,
      value = value,
      isRestrain = isRestrain
    }
    self:PushFloatingText(bc.FloatingTextType.DamageCrit, value, nil, data)
  end
end

function BattleRoleFloatTextUI:PushFloatingText(floatingTextType, text, icon, data)
  if floatingTextType == bc.FloatingTextType.Damage or floatingTextType == bc.FloatingTextType.DamageCrit then
    data.icon = icon
    self:PushToDamageTextQue(floatingTextType, data)
    return
  end
  local activeAwakerUid = bg.battleScene.activeAwaker and bg.battleScene.activeAwaker.uid
  local battleRole = bg.battleScene:GetRoleByUid(self.roleUid) or {}
  local awakerUid
  for _, subRole in ipairs(battleRole.awakerList or {}) do
    if subRole.uid == activeAwakerUid then
      awakerUid = activeAwakerUid
    end
  end
  if not awakerUid and bg.isPVP and battleRole.awakerList and 1 == #battleRole.awakerList then
    awakerUid = battleRole.awakerList[1].uid
  end
  local uid = bg.battleRender:GenUid()
  local floatData = {
    type = floatingTextType,
    text = text,
    icon = icon,
    data = data,
    awakerUid = awakerUid,
    uid = uid
  }
  self:PushToFloatTextQue(floatingTextType, floatData)
end

function BattleRoleFloatTextUI:PushToDamageTextQue(_, data)
  table.insert(self.damageList, {
    rawValue = math.abs(data.value),
    type = data.isCrit and bc.FloatingTextType.DamageCrit or bc.FloatingTextType.Damage,
    shiftX = 0,
    shiftY = 0,
    isMultiHurt = self.roleData.isMultiHurt,
    icon = data.icon
  })
end

function BattleRoleFloatTextUI:ShowDamageFloat()
  local damageInfo = table.remove(self.damageList, 1)
  if not damageInfo then
    return
  end
  if self.floatingCount >= BattlePerformanceLevel.GetFloatTextMergeLimit() then
    local mergedValue = self:_MergeDamageConsecutiveSameType(self.damageList, damageInfo)
    if 0 ~= mergedValue then
      damageInfo.rawValue = damageInfo.rawValue + mergedValue
    end
  end
  local text = bc.NumberToK(damageInfo.rawValue)
  self.damageFloatTime = self.tickTime
  local awaiter = Awaiter.Get()
  EventMgr.Instance.AnimAwaiterArise:Dispatch(awaiter, text)
  local floatingText = Pool.GetWithTag(RoleFloatingText, damageInfo.type, bg.battleScene.factoryLayer)
  self.holdFloatingTexts[floatingText] = true
  local position = CS.UnityEngine.Vector2(damageInfo.shiftX or 0, damageInfo.shiftY or 0)
  self:AddFloatingCount()
  floatingText:InitFloat(text, damageInfo.icon, self.floatingTextRoot, position, function()
    self:SubFloatingCount()
    self.holdFloatingTexts[floatingText] = nil
    awaiter:SetCompleted()
    self:ClearCompleteTimer()
  end, nil, damageInfo.isMultiHurt)
  
  function self.delayCall()
    awaiter:SetCompleted()
    self:ClearCompleteTimer()
  end
  
  self:ClearCompleteTimer()
  self.completeTimer = FrameWaiter.OnNextFrame(self.delayCall, 60)
end

function BattleRoleFloatTextUI:ClearCompleteTimer()
  if self.completeTimer then
    FrameWaiter.RemoveWaiter(self.delayCall)
    self.completeTimer = nil
  end
end

function BattleRoleFloatTextUI:GetFloatDelay()
  local miniGap = 0.04
  local maxGap = 0.5
  local k = 0.8
  local delay = math.max(maxGap * k ^ math.max(0, self.floatingCountInRound - 1), miniGap)
  return delay
end

function BattleRoleFloatTextUI:AddFloatingCount()
  self.floatingCount = self.floatingCount + 1
  self.floatingCountInRound = self.floatingCountInRound + 1
  self.floatingDelay = self:GetFloatDelay()
end

function BattleRoleFloatTextUI:SubFloatingCount()
  self.floatingCount = self.floatingCount - 1
  if self.floatingCount <= 0 then
    self.floatingCount = 0
    self.floatingCountInRound = 0
  end
  self.floatingDelay = self:GetFloatDelay()
end

function BattleRoleFloatTextUI:PushToFloatTextQue(floatingTextType, floatData)
  table.insert(self.floatTextList, {floatingTextType = floatingTextType, floatData = floatData})
end

function BattleRoleFloatTextUI:ShowFloatText()
  local floatInfo = table.remove(self.floatTextList, 1)
  if not floatInfo then
    return
  end
  if bg.battleDataCenter.isRecover then
    return
  end
  if self.floatingCount >= BattlePerformanceLevel.GetFloatTextMergeLimit() then
    local mergedValue = self:_MergeFloatTextConsecutiveSameType(self.floatTextList, floatInfo)
    if 0 ~= mergedValue then
      local currentData = floatInfo.floatData and floatInfo.floatData.data
      if currentData and currentData.changeLayer then
        currentData.changeLayer = currentData.changeLayer + mergedValue
      elseif currentData and currentData.rawValue then
        currentData.rawValue = currentData.rawValue + mergedValue
      else
        local baseValue = tonumber(floatInfo.floatData.text) or 0
        floatInfo.floatData.text = bc.NumberToK(math.abs(baseValue + mergedValue))
      end
    end
  end
  local currentData = floatInfo.floatData and floatInfo.floatData.data
  if currentData and currentData.changeLayer and currentData.stateName then
    floatInfo.floatData.text = string.format("%+d<space=0.2em>%s", currentData.changeLayer, LT.Text(currentData.stateName, true))
  elseif currentData and currentData.rawValue then
    floatInfo.floatData.text = bc.NumberToK(currentData.rawValue)
  end
  local type = floatInfo.floatingTextType
  local data = floatInfo.floatData
  self.textFloatTime = self.tickTime
  local awaiter = Awaiter.Get()
  EventMgr.Instance.AnimAwaiterArise:Dispatch(awaiter, data.text)
  if data.awakerUid and data.awakerUid ~= self.lastOverlapAwakerUid then
    self.overlapCountMap = {}
    self.overlapHeightMap = {}
  end
  self.overlapCountMap = self.overlapCountMap or {}
  local overlapCount = self.overlapCountMap[type] or 0
  self.overlapCountMap[type] = overlapCount + 1
  local classType = type
  if not bc.FloatRes[classType] then
    classType = bc.FloatingTextType.Text
  end
  local floatingText = Pool.GetWithTag(RoleFloatingText, classType, bg.battleScene.factoryLayer)
  local shiftX = 0
  local shiftY = -60
  local overlapHeight = 0
  local offsetAwaker
  if data.awakerUid then
    self.lastOverlapAwakerUid = data.awakerUid
    local transform = self.floatingTextRoot.transform
    local rootLocalPos = transform.localPosition
    local position = transform:TransformPoint(Vector3(shiftX, overlapHeight + 80, rootLocalPos.z))
    local rootPos = transform.position
    local distance = CS.Framework.UIUtilTool.GetDistancesFromNearPlane(bg.mainCamera, self.role:GetFootPos())
    local orgVec3 = CS.Framework.UIUtilTool.ConvertUIWorldPosToScene(rootPos, distance, bg.mainCamera, bg.uiCamera)
    local posVec3 = CS.Framework.UIUtilTool.ConvertUIWorldPosToScene(position, distance, bg.mainCamera, bg.uiCamera)
    offsetAwaker = Vector2(0, posVec3.y - orgVec3.y)
  else
    offsetAwaker = Vector2(shiftX, overlapHeight + shiftY)
  end
  self:AddFloatingCount()
  local isFastAnim = type == bc.FloatingTextType.Block and self.roleData.isMultiBlock
  local outlineColor = data.data and data.data.outlineColor
  floatingText:InitFloat(data.text, data.icon, self.floatingTextRoot, offsetAwaker, function()
    self:SubFloatingCount()
    self.holdFloatingTexts[floatingText] = nil
    awaiter:SetCompleted()
  end, data.awakerUid, isFastAnim, outlineColor)
end

function BattleRoleFloatTextUI:GetOverlayHeight()
  local totalHeight = 0
  return totalHeight
end

function BattleRoleFloatTextUI:GetFloatingPosition()
  if not self.floatingPoint then
    self:CalFloatingPosition()
  end
  return self.floatingPoint
end

function BattleRoleFloatTextUI:CalFloatingPosition()
  local uiLayer = bg.battleScene.uiLayer
  local uiTransform = uiLayer.transform
  local curTransform = self.floatingTextRoot
  local point = {
    x = 0,
    y = 0,
    z = 0
  }
  while curTransform and curTransform ~= uiTransform do
    local pos = curTransform.localPosition
    point.x = point.x + pos.x
    point.y = point.y + pos.y
    point.z = point.z + pos.z
    curTransform = curTransform.parent
  end
  self.floatingPoint = Vector3(point.x, point.y, point.z)
end

function BattleRoleFloatTextUI:OnConfirmSth(data)
  if data.confirmType == bc.ConfirmType.Respawn then
    print("复活提示，清空飘字列表")
    self.damageList = {}
    self.floatTextList = {}
  end
end

function BattleRoleFloatTextUI:_MergeDamageConsecutiveSameType(list, currentEntry)
  local accumulated = 0
  local currentType = currentEntry.type
  while #list > 0 do
    local next = list[1]
    if next.type ~= currentType then
      break
    end
    local numValue = next.rawValue or 0
    accumulated = accumulated + numValue
    table.remove(list, 1)
  end
  return accumulated
end

function BattleRoleFloatTextUI:_MergeFloatTextConsecutiveSameType(list, currentEntry)
  local accumulated = 0
  local currentType = currentEntry.floatingTextType
  local currentData = currentEntry.floatData and currentEntry.floatData.data
  local currentStateId = currentData and currentData.stateId
  local currentSign = currentData and currentData.sign
  while #list > 0 do
    local next = list[1]
    if next.floatingTextType ~= currentType then
      break
    end
    if currentStateId then
      local nextData = next.floatData and next.floatData.data
      local nextStateId = nextData and nextData.stateId
      local nextSign = nextData and nextData.sign
      if nextStateId ~= currentStateId or nextSign ~= currentSign then
        break
      end
      accumulated = accumulated + (nextData.changeLayer or 0)
    else
      local nextData = next.floatData and next.floatData.data
      if nextData and nextData.rawValue then
        accumulated = accumulated + nextData.rawValue
      else
        accumulated = accumulated + (tonumber(next.floatData and next.floatData.text) or 0)
      end
    end
    table.remove(list, 1)
  end
  return accumulated
end

return BattleRoleFloatTextUI
