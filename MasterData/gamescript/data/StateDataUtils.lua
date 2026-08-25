local StateDataUtils = {}

function StateDataUtils.Reset()
  DataCenter.stateData.stateList = {}
  DataCenter.stateData.stateUidMap = {}
end

function StateDataUtils.GetLayer(stateId)
  for _, state in ipairs(DataCenter.stateData.stateList) do
    if state.stateId == stateId then
      return state.layer or 0
    end
  end
  return 0
end

function StateDataUtils.GetLayerByOwner(stateId, ownerUid)
  if not ownerUid then
    return 0
  end
  for _, state in ipairs(StateDataUtils.GetStateListByOwner(ownerUid)) do
    if state.stateId == stateId then
      return state.layer or 0
    end
  end
  return 0
end

function StateDataUtils.GetStateParamByOwner(stateId, index, ownerUid)
  if not ownerUid or not index then
    return 0
  end
  for _, state in ipairs(StateDataUtils.GetStateListByOwner(ownerUid)) do
    if state.stateId == stateId then
      return state.stateParams and state.stateParams[index] or 0
    end
  end
  return 0
end

function StateDataUtils.GetCopyStateByUid(stateUid)
  return DataCenter.stateData.stateUidMap[stateUid]
end

function StateDataUtils.OnSyncStateData(syncList)
  for _, state in ipairs(syncList) do
    if state.isRemove then
      DataCenter.stateData.stateUidMap[state.uid] = nil
    elseif DataCenter.stateData.stateUidMap[state.uid] then
      DataCenter.stateData.stateUidMap[state.uid] = state
    else
      DataCenter.stateData.stateUidMap[state.uid] = state
      table.insert(DataCenter.stateData.stateList, state)
    end
  end
  for i = #DataCenter.stateData.stateList, 1, -1 do
    local state = DataCenter.stateData.stateList[i]
    if not DataCenter.stateData.stateUidMap[state.uid] then
      table.remove(DataCenter.stateData.stateList, i)
    else
      DataCenter.stateData.stateList[i] = DataCenter.stateData.stateUidMap[state.uid]
    end
  end
end

function StateDataUtils.GetConfig(stateTid)
  if not stateTid then
    return
  end
  return DT.State[stateTid]
end

function StateDataUtils.GetPvpStatusLayerColor(configData)
  local langKey = CommonDefine.PvpStatusLayerColorLangKey.Other
  if configData and configData.IsBuff then
    langKey = bc.STR_BOOL[configData.IsBuff] and CommonDefine.PvpStatusLayerColorLangKey.Positive or CommonDefine.PvpStatusLayerColorLangKey.Negative
  end
  local color = LT.Text(langKey)
  if not color or "" == color then
    return
  end
  if not string.startswith(color, "#") then
    color = "#" .. color
  end
  return color
end

function StateDataUtils.GetStateCaster(state)
  if not (state and state.castRoleUid and bg) or not bg.battleDataCenter then
    return nil
  end
  do return bg.battleDataCenter.GetRoleDataModel, bg.battleDataCenter end
  return bg.battleDataCenter.GetRoleDataModel, bg.battleDataCenter, state.castRoleUid
end

function StateDataUtils.GetStateOwnerCamp(state)
  if not (state and state.ownerUid and bg) or not bg.battleDataCenter then
    return nil
  end
  local ownerRole = bg.battleDataCenter:GetRoleDataModel(state.ownerUid)
  if ownerRole then
    return ownerRole.camp
  end
  if state.stateType == bc.StateType.Card and bg.battleRender and bg.battleRender.cardMgr then
    local card = bg.battleRender.cardMgr:GetCardByUid(state.ownerUid)
    local cardOwnerRole = card and bg.battleDataCenter:GetRoleDataModel(card.ownerUid)
    return cardOwnerRole and cardOwnerRole.camp
  end
  return nil
end

function StateDataUtils.GetStatusApplierText(state)
  local caster = StateDataUtils.GetStateCaster(state)
  if not caster then
    return ""
  end
  local ownerCamp = StateDataUtils.GetStateOwnerCamp(state)
  local isSameCamp = ownerCamp and caster.camp == ownerCamp
  local langKey, name
  if caster:IsRoleType(bc.RoleType.Awaker) then
    langKey = isSameCamp and "StatusApplier2" or "StatusApplier1"
    name = caster:GetRoleName(false)
  elseif caster:IsRoleType(bc.RoleType.Player) then
    langKey = isSameCamp and "StatusApplier4" or "StatusApplier3"
    name = caster.playerName or caster:GetRoleName(false)
  end
  if not langKey then
    return ""
  end
  do return LT.Textf, langKey end
  return LT.Textf, langKey, name or ""
end

function StateDataUtils.GetMyLockedEnemyText(state)
  if not (state and state.ownerUid and bg) or not bg.battleDataCenter then
    return ""
  end
  local lockedUid = bg.battleDataCenter:GetLockedEnemyUid(state.ownerUid)
  if not lockedUid then
    return ""
  end
  local lockedRole = bg.battleDataCenter:GetRoleDataModel(lockedUid)
  if not lockedRole then
    return ""
  end
  do return LT.Textf, "StatusApplier1" end
  return LT.Textf, "StatusApplier1", lockedRole:GetRoleName(false) or "", lockedRole, false
end

function StateDataUtils.GetPosAwakerName(isAlly, pos)
  pos = tonumber(pos)
  local maxPos = #(CommonDefine.AllyPosAwakerNameWordsEffectKeys or {})
  if not pos or pos < 1 or pos > maxPos then
    return ""
  end
  if not (bg and bg.battleScene) or not bg.battleDataCenter then
    return ""
  end
  local myCamp = bg.battleDataCenter:GetMyCamp()
  if not myCamp then
    return ""
  end
  local camp = isAlly and myCamp or bg.battleDataCenter:GetEnemyCamp(myCamp)
  local roleList = bg.battleScene.roleList
  if not roleList then
    return ""
  end
  for _, role in ipairs(roleList) do
    if role.roleType ~= bc.RoleType.Player and role.camp == camp and role.battleFieldPos == pos then
      local roleDataModel = bg.battleDataCenter:GetRoleDataModel(role.uid)
      if roleDataModel then
        return roleDataModel:GetRoleName(false) or ""
      end
      return ""
    end
  end
  return ""
end

function StateDataUtils.ReplacePosAwakerNameTextByKeys(str, wordsEffectKeys, isAlly)
  if not wordsEffectKeys then
    return str
  end
  for i, key in ipairs(wordsEffectKeys) do
    local emptyTag = "<" .. key .. ":>"
    if string.find(str, emptyTag, 1, true) then
      local name = StateDataUtils.GetPosAwakerName(isAlly, i)
      local replaceStr = "" ~= name and "<" .. key .. ":" .. name .. ">" or ""
      str = string.replace(str, emptyTag, replaceStr, true)
    end
  end
  return str
end

function StateDataUtils.ReplacePosAwakerNameText(str)
  if not str or "" == str then
    return str or ""
  end
  if not string.find(str, "PosAwaker", 1, true) then
    return str
  end
  str = StateDataUtils.ReplacePosAwakerNameTextByKeys(str, CommonDefine.AllyPosAwakerNameWordsEffectKeys, true)
  str = StateDataUtils.ReplacePosAwakerNameTextByKeys(str, CommonDefine.EnemyPosAwakerNameWordsEffectKeys, false)
  return str
end

function StateDataUtils.ReplaceStatusApplierText(str, state)
  if not str then
    return ""
  end
  str = string.replace(str, "<StatusApplier:>", StateDataUtils.GetStatusApplierText(state), true)
  str = string.replace(str, "<MyLockedEnemy:>", StateDataUtils.GetMyLockedEnemyText(state), true)
  do return StateDataUtils.ReplacePosAwakerNameText end
  return StateDataUtils.ReplacePosAwakerNameText, str, "<MyLockedEnemy:>", StateDataUtils.GetMyLockedEnemyText(state), true
end

function StateDataUtils.GetStateByIdAndSource(stateId, source, sourceId, ownerUid)
  local states = {}
  for _, state in ipairs(DataCenter.stateData.stateList) do
    if state.source and state.source[1] and state.source[1].sourceType == source and state.source[1].tid == sourceId and state.ownerData.uid == ownerUid and state.stateId == stateId then
      table.insert(states, state)
    end
  end
  return states
end

function StateDataUtils.GetStateListByOwner(ownerUid)
  local states = {}
  for _, state in ipairs(DataCenter.stateData.stateList) do
    if state.ownerData.uid == ownerUid then
      table.insert(states, state)
    end
  end
  return states
end

return StateDataUtils
