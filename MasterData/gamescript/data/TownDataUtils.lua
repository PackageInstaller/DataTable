local TownDataUtils = {}

function TownDataUtils.ResetAll()
  DataCenter.townData.InteractionDatas = {}
  DataCenter.townData.currStoryLineIndexMap = {}
end

function TownDataUtils.AddInteraction(sceneTid, data)
  if not data.uid then
    return
  end
  local info = {}
  info.uid = data.uid
  info.tid = data.tid
  info.keyId = data.keyId
  info.state = data.state
  info.attributeEffects = data.attributeEffects
  info.effectTid = data.effectTid
  info.sceneTid = sceneTid
  info.spawned = false
  DataCenter.townData.InteractionDatas[info.uid] = info
end

function TownDataUtils.RemoveInteraction(uid)
  DataCenter.townData.InteractionDatas[uid] = nil
end

function TownDataUtils.GetInteraction(uid)
  return DataCenter.townData.InteractionDatas[uid]
end

function TownDataUtils.SetInteractionState(uid, state)
  local interaction = TownDataUtils.GetInteraction(uid)
  interaction.state = state
end

function TownDataUtils.GetSceneInteractions(sceneTid)
  local list = {}
  for _, value in pairs(DataCenter.townData.InteractionDatas) do
    if value.sceneTid == sceneTid then
      table.insert(list, value)
    end
  end
  return list
end

function TownDataUtils.ClearInteractionsBySceneTid(sceneTid)
  local list = TownDataUtils.GetSceneInteractions(sceneTid)
  for _, value in ipairs(list) do
    DataCenter.townData.InteractionDatas[value.uid] = nil
  end
end

return TownDataUtils
