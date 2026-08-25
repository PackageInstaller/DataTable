local tempUidList = {}
local ROLE_STATE_HIDE_TYPES = {
  [bc.StateShowType.Affix] = true,
  [bc.StateShowType.Describe] = true,
  [bc.StateShowType.WeaponIconAndDesc] = true,
  [bc.StateShowType.AwakerAffix] = true
}

local function createBattleStateDataModelState()
  local data = {}
  data.isInit = false
  return data
end

local function createBattleStateDataModelViews(_)
  local views = {}
  return views
end

local function createBattleStateDataModelActions(data)
  local actions = {}
  local DT = bg.DT
  
  function actions:InitData(stateList)
    data.isInit = true
    data.yellowUidMap = {}
    data.redUidMap = {}
    data.faceVFXUidMap = {}
    data.ownerStateList = {}
    data.stateUidMap = {}
    data.stateTidList = {}
    data.stateMergedListMap = {}
    data.cachedMergedStateMap = {}
    for _, state in ipairs(stateList or {}) do
      self:AddState(state)
    end
  end
  
  function actions:AddState(stateData)
    local configData = table.clone(DT.State[stateData.stateId] or {})
    if not table.next(configData) then
      return
    end
    local ownerStateList = data.ownerStateList[stateData.ownerUid] or {}
    stateData.configData = configData
    table.insert(ownerStateList, stateData)
    data.ownerStateList[stateData.ownerUid] = ownerStateList
    data.stateUidMap[stateData.stateUid] = stateData
    data.stateTidList[stateData.stateId] = data.stateTidList[stateData.stateId] or {}
    table.insert(data.stateTidList[stateData.stateId], stateData)
    self:CheckCardLightState(stateData, true)
    self:CheckCardFaceVFX(stateData, true)
    self:AddMergedState(stateData)
  end
  
  function actions:GetStateDescByTid(stateTid)
    local stateList = self:GetStateListByTid(stateTid)
    local firstState = stateList[1]
    if not firstState then
      return ""
    end
    local stateC = BattleStateDataClient(firstState)
    do return stateC.GetDesc end
    return stateC.GetDesc, stateC
  end
  
  function actions:GetStateDesc(stateUid)
    local state = self:GetState(stateUid)
    if not state then
      return ""
    end
    local stateC = BattleStateDataClient(state)
    do return stateC.GetDesc end
    return stateC.GetDesc, stateC
  end
  
  function actions:CheckCardLightState(stateData, isAdd)
    local state = self:GetState(stateData.stateUid)
    local configData = state.configData
    local map
    if configData.CardVFX == "YellowGlow" then
      map = self.yellowUidMap
    elseif configData.CardVFX == "RedGlow" then
      map = self.redUidMap
    else
      return
    end
    local ownerUid, stateUid = stateData.ownerUid, stateData.stateUid
    if isAdd then
      map[ownerUid] = map[ownerUid] or {}
      map[ownerUid][stateUid] = true
    elseif map[ownerUid] then
      map[ownerUid][stateUid] = nil
      if not table.next(map[ownerUid]) then
        map[ownerUid] = nil
      end
    end
  end
  
  function actions:CheckCardFaceVFX(stateData, isAdd)
    local state = self:GetState(stateData.stateUid)
    local configData = state.configData
    local map = self.faceVFXUidMap
    if configData.CardFaceVFX == nil then
      return
    end
    local ownerUid, stateUid = stateData.ownerUid, stateData.stateUid
    if isAdd then
      map[ownerUid] = map[ownerUid] or {}
      map[ownerUid][stateUid] = configData.CardFaceVFX
    elseif map[ownerUid] then
      map[ownerUid][stateUid] = nil
      if not table.next(map[ownerUid]) then
        map[ownerUid] = nil
      end
    end
  end
  
  function actions:GetStateListByOwner(ownerUid)
    return data.ownerStateList[ownerUid] or {}
  end
  
  function actions:GetStateListByOwnerAndStateId(ownerUid, stateId)
    local stateList = data.ownerStateList[ownerUid] or {}
    local retList = {}
    for _, state in ipairs(stateList) do
      if state.stateId == stateId then
        table.insert(retList, state)
      end
    end
    return retList
  end
  
  function actions:GetStateListByTid(stateId)
    if not data.stateTidList[stateId] then
      data.stateTidList[stateId] = {}
    end
    return data.stateTidList[stateId]
  end
  
  function actions:GetRoleState(roleUid, stateId)
    if not roleUid or not stateId then
      return
    end
    local stateList = self:GetStateListByTid(stateId)
    for _, state in ipairs(stateList) do
      if state.ownerUid == roleUid then
        return state
      end
    end
  end
  
  function actions:GetCardStateList(cardUid)
    if not cardUid then
      return {}
    end
    do return self.GetShowStateList, self end
    return self.GetShowStateList, self, cardUid
  end
  
  function actions:GetCardStateListDesc(cardUid, ...)
    if not cardUid then
      return ""
    end
    local desc = ""
    local cardStateList = table.clone(self:GetShowStateList(cardUid))
    for _, uid in ipairs({
      ...
    }) do
      table.append(cardStateList, self:GetShowStateList(uid))
    end
    table.sort(cardStateList, function(a, b)
      local aCfg = a.configData
      local bCfg = b.configData
      local aSort = aCfg.ShowSortOrder or 0
      local bSort = bCfg.ShowSortOrder or 0
      if aSort ~= bSort then
        return aSort > bSort
      end
      return aCfg.BaseSortID > bCfg.BaseSortID
    end)
    local usedStates = {}
    for _, state in pairs(cardStateList) do
      if usedStates[state.stateId] then
      else
        usedStates[state.stateId] = true
        local stateCfg = bg.DT.State[state.stateId]
        if stateCfg.ShowType == bc.StateShowType.Normal or stateCfg.ShowType == bc.StateShowType.Describe then
          local stateC = BattleStateDataClient(state)
          if stateC:ShowJudgement() then
            desc = SkillUtils.AppendStateShowNameToDesc(desc, stateC:GetBuffName())
          end
        end
      end
    end
    return desc
  end
  
  function actions:GetStateByUid(stateUid)
    return data.stateUidMap[stateUid]
  end
  
  function actions:GetState(stateUid)
    return data.stateUidMap[stateUid]
  end
  
  function actions:ChangeState(changedStateData)
    local stateData = data.stateUidMap[changedStateData.stateUid]
    if stateData then
      for k, v in pairs(changedStateData) do
        stateData[k] = v
      end
      if changedStateData.newLayer then
        stateData.layer = changedStateData.newLayer
      end
      self:UpdateMergedState(stateData)
    end
  end
  
  function actions:UpdateStateArgs(updateList)
    for stateUid, updateData in pairs(updateList) do
      local stateData = data.stateUidMap[stateUid]
      if stateData then
        for k, v in pairs(updateData) do
          stateData[k] = v
        end
      end
    end
  end
  
  function actions:GetIsCardYellowState(uid)
    return self.yellowUidMap[uid] ~= nil
  end
  
  function actions:GetCardFaceVFXList(cardUid)
    local t = self.faceVFXUidMap[cardUid]
    if t then
      local highPrioritySfxIdList = {}
      local highPriority = 0
      local curPriority
      for _, sfxId in pairs(t) do
        local sfxConfig = DT.BattleSfxConfig[sfxId]
        curPriority = sfxConfig.DisplayPriority or 0
        if highPriority < curPriority then
          highPriority = curPriority
          highPrioritySfxIdList = {sfxId}
        elseif curPriority == highPriority then
          table.insert(highPrioritySfxIdList, sfxId)
        end
      end
      return highPrioritySfxIdList
    else
      return nil
    end
  end
  
  function actions:GetIsCardRedState(uid)
    return self.redUidMap[uid] ~= nil
  end
  
  function actions:RemoveState(stateData)
    local uid = stateData.stateUid
    if not uid then
      return
    end
    local curState = self:GetState(uid)
    if not curState then
      return
    end
    self:CheckCardLightState(stateData, false)
    self:CheckCardFaceVFX(stateData, false)
    curState.isShowDelFloatText = stateData.showText
    local stateId
    data.stateUidMap[uid] = nil
    local ownerStateList = data.ownerStateList[curState.ownerUid] or {}
    for i, state in ipairs(ownerStateList) do
      if state.stateUid == uid then
        stateId = state.stateId
        table.remove(ownerStateList, i)
        break
      end
    end
    local stateList = stateId and data.stateTidList[stateId] or {}
    for i, state in ipairs(stateList) do
      if state.stateUid == uid then
        table.remove(stateList, i)
        break
      end
    end
    self:RemoveMergedState(curState)
    return curState
  end
  
  function actions:GetStateByIdAndSource(stateId, source, sourceId, ownerUid)
    local states = {}
    if not stateId then
      return states
    end
    local ownerStateList = self:GetStateListByOwner(ownerUid)
    for _, state in ipairs(ownerStateList) do
      if state.source and state.source[1] and state.source[1].sourceType == source and state.source[1].tid == sourceId then
        table.insert(states, state)
      end
    end
    return states
  end
  
  function actions:GetShowStateList(ownerUid)
    local caredUidList = self:GetCaredUidList(ownerUid)
    if #caredUidList > 1 then
      do return self.GenerateShowStateList, self, ownerUid end
      return self.GenerateShowStateList, self, ownerUid, ROLE_STATE_HIDE_TYPES
    end
    if not self.stateMergedListMap then
      return {}
    end
    return self.stateMergedListMap[ownerUid] or {}
  end
  
  function actions:AddMergedState(state)
    local ownerUid = state.ownerUid
    local mergedList = self.stateMergedListMap[ownerUid] or {}
    self.stateMergedListMap[ownerUid] = mergedList
    local cachedMergedStateMap = self.cachedMergedStateMap[ownerUid] or {}
    self.cachedMergedStateMap[ownerUid] = cachedMergedStateMap
    StateMergeUtils.AddToMergedList(mergedList, cachedMergedStateMap, state)
  end
  
  function actions:RemoveMergedState(state)
    local ownerUid = state.ownerUid
    local mergedList = self.stateMergedListMap[ownerUid] or {}
    local cachedMergedStateMap = self.cachedMergedStateMap[ownerUid] or {}
    StateMergeUtils.RemoveFromMergedList(mergedList, cachedMergedStateMap, state)
  end
  
  function actions:UpdateMergedState(state)
    local ownerUid = state.ownerUid
    local mergedList = self.stateMergedListMap[ownerUid] or {}
    local cachedMergedStateMap = self.cachedMergedStateMap[ownerUid] or {}
    StateMergeUtils.UpdateMergedList(mergedList, cachedMergedStateMap, state)
  end
  
  function actions:GenerateShowStateList(ownerUid, hideStateTypeMap)
    local stateList = self.stateMergedListMap[ownerUid] or {}
    table.clear(stateList)
    self.stateMergedListMap[ownerUid] = stateList
    local cachedMergedStateMap = self.cachedMergedStateMap[ownerUid] or {}
    table.clear(cachedMergedStateMap)
    local caredUidList = self:GetCaredUidList(ownerUid)
    for _, uid in pairs(caredUidList) do
      local roleStateList = self:GetStateListByOwner(uid)
      for _, state in pairs(roleStateList) do
        StateMergeUtils.AddToMergedList(stateList, cachedMergedStateMap, state, hideStateTypeMap)
      end
    end
    return stateList
  end
  
  function actions:GetCaredUidList(ownerUid)
    local uidList = tempUidList
    table.clear(uidList)
    local roleData = bg.battleDataCenter:GetRoleDataModel(ownerUid)
    if roleData and roleData:IsRoleType(bc.RoleType.Player) then
      local allRole = bg.battleScene:GetRoleListByCamp(roleData.camp, false)
      for _, role in ipairs(allRole) do
        table.insert(uidList, role.uid)
      end
    else
      table.insert(uidList, ownerUid)
    end
    return uidList
  end
  
  function actions:SetStateLayer(state, layer)
    if state then
      state.layer = layer
    end
  end
  
  function actions:GetRoleShowStateEffectDescGroup(roleUid, mergeStates)
    local stateList = self:GetShowStateList(roleUid, mergeStates)
    do return self._GetRoleAndAwakerShowStateEffectDescGroup, self end
    return self._GetRoleAndAwakerShowStateEffectDescGroup, self, stateList
  end
  
  function actions:_GetRoleAndAwakerShowStateEffectDescGroup(stateList)
    local effectDescGroup = {}
    effectDescGroup.name = LT.Text("StateEffectDesc")
    effectDescGroup.descList = {}
    local showType
    for _, state in ipairs(stateList) do
      showType = state.configData.ShowType
      if not showType or not bc.StateHideMap[showType] then
        local effectDesc = {}
        local stateDataClient = BattleStateDataClient(state, true)
        if stateDataClient.configData.Icon ~= nil then
          effectDesc.icon = bc.ICON_PATH_PERFIX .. stateDataClient.configData.Icon
        end
        effectDesc.name = stateDataClient:GetBuffName()
        effectDesc.desc = stateDataClient:GetDesc()
        local layer = state.layer or 0
        effectDesc.subDesc = layer > 0 and LT.Textf("Battle_State_Layer", layer) or ""
        effectDesc.layerCountList = {}
        if state.layerCountCurrRound and state.layerCountCurrRound.count > 0 then
          table.insert(effectDesc.layerCountList, state.layerCountCurrRound)
        end
        if state.layerCountCurrBattle and state.layerCountCurrBattle.count > 0 then
          table.insert(effectDesc.layerCountList, state.layerCountCurrBattle)
        end
        if state.layerCountCurrExplore and state.layerCountCurrExplore.count > 0 then
          table.insert(effectDesc.layerCountList, state.layerCountCurrExplore)
        end
        table.insert(effectDescGroup.descList, effectDesc)
      end
    end
    return effectDescGroup
  end
  
  return actions
end

local function onSetup(_, _)
end

local BattleStateDataModel = Vue.model("BattleStateDataModel", createBattleStateDataModelState):views(createBattleStateDataModelViews):actions(createBattleStateDataModelActions):setup(onSetup)
return BattleStateDataModel
