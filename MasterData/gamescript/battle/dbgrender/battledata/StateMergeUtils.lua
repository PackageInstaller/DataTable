local StateMergeUtils = {}
local COMMON_HIDE_TYPE_MAP = {
  [bc.StateShowType.WeaponIconAndDesc] = true
}

function StateMergeUtils.AddToMergedList(list, cachedMergedStateMap, state, hideTypeMap)
  local hideMap = hideTypeMap or COMMON_HIDE_TYPE_MAP
  if hideMap[state.configData.ShowType] then
    return
  end
  local mergedId = state.configData.MergeStateDisplay
  if not mergedId then
    table.insert(list, state)
  else
    local mergedState = cachedMergedStateMap[mergedId]
    if not mergedState then
      mergedState = StateMergeUtils.CreateMergedState(state)
      cachedMergedStateMap[mergedId] = mergedState
      table.insert(list, mergedState)
    end
    StateMergeUtils.MergeState(mergedState, state)
  end
end

function StateMergeUtils.RemoveFromMergedList(list, cachedMergedStateMap, state)
  local mergedId = state.configData.MergeStateDisplay
  if not mergedId then
    for i, v in ipairs(list) do
      if v.stateUid == state.stateUid then
        table.remove(list, i)
        break
      end
    end
  else
    local mergedState = cachedMergedStateMap[mergedId]
    if not mergedState then
      return
    end
    StateMergeUtils.UnMergeState(mergedState, state)
    if 0 == mergedState.layer then
      StateMergeUtils.ResetMergedState(mergedState)
      cachedMergedStateMap[mergedId] = nil
      for i, v in ipairs(list) do
        if v.stateUid == mergedState.stateUid then
          table.remove(list, i)
          break
        end
      end
    end
  end
end

function StateMergeUtils.UpdateMergedList(list, cachedMergedStateMap, state)
  local mergedId = state.configData.MergeStateDisplay
  if mergedId then
    local mergedState = cachedMergedStateMap[mergedId]
    if not mergedState then
      return
    end
    StateMergeUtils.UpdateMergedState(mergedState, state)
  end
end

function StateMergeUtils.CreateMergedState(state)
  local mergedState = table.clone(state)
  local mergedId = state.configData.MergeStateDisplay
  mergedState.stateId = mergedId
  mergedState.stateUid = -mergedId
  mergedState.mergeConfigData = DT.State[mergedId]
  mergedState.configData = mergedState.mergeConfigData
  mergedState.mergedStateMap = {}
  mergedState.layer = 0
  mergedState.layerCountCurrRound = {}
  mergedState.layerCountCurrRound.icon = CommonDefine.StateDurationIcon.CurrRound
  mergedState.layerCountCurrRound.desc = LT.Text("StateEffectDurationDesc_1")
  mergedState.layerCountCurrRound.count = 0
  mergedState.layerCountCurrBattle = {}
  mergedState.layerCountCurrBattle.icon = CommonDefine.StateDurationIcon.CurrBattle
  mergedState.layerCountCurrBattle.desc = LT.Text("StateEffectDurationDesc_2")
  mergedState.layerCountCurrBattle.count = 0
  mergedState.layerCountCurrExplore = {}
  mergedState.layerCountCurrExplore.icon = CommonDefine.StateDurationIcon.CurrExplore
  mergedState.layerCountCurrExplore.desc = LT.Text("StateEffectDurationDesc_3")
  mergedState.layerCountCurrExplore.count = 0
  return mergedState
end

function StateMergeUtils.ResetMergedState(mergedState)
  mergedState.mergedStateMap = {}
  mergedState.layer = 0
  mergedState.layerCountCurrRound.count = 0
  mergedState.layerCountCurrBattle.count = 0
  mergedState.layerCountCurrExplore.count = 0
end

function StateMergeUtils.MergeState(mergedState, state)
  local mergedStateMap = mergedState.mergedStateMap
  if not mergedStateMap then
    return
  end
  if mergedStateMap[state.stateUid] then
    return
  end
  mergedStateMap[state.stateUid] = state
  StateMergeUtils.CalStateLayer(mergedState)
end

function StateMergeUtils.UnMergeState(mergedState, state)
  if not mergedState.mergedStateMap then
    return
  end
  if not mergedState.mergedStateMap[state.stateUid] then
    return
  end
  mergedState.mergedStateMap[state.stateUid] = nil
  StateMergeUtils.CalStateLayer(mergedState)
end

function StateMergeUtils.UpdateMergedState(mergedState, state)
  if not mergedState.mergedStateMap then
    return
  end
  if not mergedState.mergedStateMap[state.stateUid] then
    return
  end
  StateMergeUtils.CalStateLayer(mergedState)
end

function StateMergeUtils.CalStateLayer(mergedState)
  mergedState.layer = 0
  mergedState.layerCountCurrRound.count = 0
  mergedState.layerCountCurrBattle.count = 0
  mergedState.layerCountCurrExplore.count = 0
  local stateData = bg.battleDataCenter and bg.battleDataCenter.stateData
  if not stateData then
    return
  end
  for uid in pairs(mergedState.mergedStateMap) do
    local state = stateData:GetState(uid)
    if state then
      local delta = state.layer
      mergedState.layer = mergedState.layer + delta
      if state.configData.ClearCond and (table.contains(state.configData.ClearCond, "BSTAfterBoutEnd") or table.contains(state.configData.ClearCond, "BSTBeforeBoutEnd") or table.contains(state.configData.ClearCond, "BSTBeforeBoutBegin") or table.contains(state.configData.ClearCond, "BSTAfterBoutBegin")) then
        mergedState.layerCountCurrRound.count = mergedState.layerCountCurrRound.count + delta
      end
      if state.configData.ClearCond and 1 == #state.configData.ClearCond and table.contains(state.configData.ClearCond, "BSTBeforeBattleEnd") then
        mergedState.layerCountCurrBattle.count = mergedState.layerCountCurrBattle.count + delta
      end
      if not state.configData.ClearCond or 0 == #state.configData.ClearCond then
        mergedState.layerCountCurrExplore.count = mergedState.layerCountCurrExplore.count + delta
      end
    end
  end
end

return StateMergeUtils
