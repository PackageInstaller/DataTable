local BarrierDataUtils = {}

function BarrierDataUtils.ResetAll(isExit)
  DataCenter.barrierData.EventInfos = {}
  DataCenter.barrierData.curTriggerEventUid = 0
  DataCenter.barrierData.nextTriggerNodeId = 0
  DataCenter.barrierData.curTriggerNodeId = 0
  DataCenter.barrierData.InBattle = false
  if isExit then
    BarrierDataUtils.SetCurrArea(0)
    DataCenter.barrierData.areas = {}
  end
  DataCenter.barrierData.showLevelName = false
  DataCenter.barrierData.enableShowEvents = {}
  DataCenter.barrierData.passArea = {}
  DataCenter.barrierData.triggeredEvents = {}
  DataCenter.barrierData.showStack = {}
  DataCenter.barrierData.areaGroupInfo = {}
end

function BarrierDataUtils.AddEventInfo(data)
  local info = {}
  info.uid = data.uid
  info.tid = data.tid
  info.keyId = data.keyId
  info.state = 1 == data.state and true or false
  info.nodeId = data.nodeId
  info.plotSubTasks = data.plotSubTasks
  info.logicTid = data.logicTid
  info.pos = {
    x = 0,
    y = 0,
    z = 0
  }
  DataCenter.barrierData.EventInfos[data.uid] = info
end

function BarrierDataUtils.RemoveEventInfo(uid)
  if DataCenter.barrierData.EventInfos[uid] then
    DataCenter.barrierData.EventInfos[uid] = nil
  end
end

function BarrierDataUtils.SetEventState(uid, state)
  if DataCenter.barrierData.EventInfos[uid] then
    DataCenter.barrierData.EventInfos[uid].state = state
  end
end

function BarrierDataUtils.SetEventNode(uid, nodeTid)
  if DataCenter.barrierData.EventInfos[uid] then
    DataCenter.barrierData.EventInfos[uid].nodeId = nodeTid
    Logger.Info("当前运行到 事件Uid == %s, 事件Tid == %s, 节点ID == %s", uid, DataCenter.barrierData.EventInfos[uid].tid, nodeTid)
  end
end

function BarrierDataUtils.InitEventPos(uid, pos)
  if DataCenter.barrierData.EventInfos[uid] then
    DataCenter.barrierData.EventInfos[uid].pos = {
      x = pos[1],
      y = pos[2],
      z = pos[3]
    }
  end
end

function BarrierDataUtils.GetEventPos(uid)
  if DataCenter.barrierData.EventInfos[uid] then
    return DataCenter.barrierData.EventInfos[uid].pos
  end
  return nil
end

function BarrierDataUtils.GetEvent(uid)
  if DataCenter.barrierData.EventInfos[uid] then
    return DataCenter.barrierData.EventInfos[uid]
  end
  return nil
end

function BarrierDataUtils.GetEventTid(uid)
  if DataCenter.barrierData.EventInfos[uid] then
    return DataCenter.barrierData.EventInfos[uid].tid
  end
  return nil
end

function BarrierDataUtils.GetEventKeyId(uid)
  if DataCenter.barrierData.EventInfos[uid] then
    return DataCenter.barrierData.EventInfos[uid].keyId
  end
  return nil
end

function BarrierDataUtils.GetEventPlotCourseSubTask(uid)
  if DataCenter.barrierData.EventInfos[uid] then
    return DataCenter.barrierData.EventInfos[uid].plotSubTasks
  end
  return {}
end

function BarrierDataUtils.GetEventBelongArea(uid)
  local eventLogicCfg = BarrierDataUtils.GetEventLogicCfgByUid(DataCenter.copiesData.BarrierId, uid)
  return eventLogicCfg.Region
end

function BarrierDataUtils.GetEventState(uid)
  local status
  if DataCenter.barrierData.EventInfos[uid] then
    status = DataCenter.barrierData.EventInfos[uid].state
  end
  return status
end

function BarrierDataUtils.SetEventExistState(uid, value)
  if DataCenter.barrierData.eventExistStatus[uid] then
    DataCenter.barrierData.eventExistStatus[uid] = value
    return uid
  end
  return nil
end

function BarrierDataUtils.GetEventExistState(uid)
  return DataCenter.barrierData.eventExistStatus[uid]
end

function BarrierDataUtils.SetSightRadius()
  local role = RoleManager.Instance:GetRole(DataCenter.playerData.DRole.uid)
  DataCenter.barrierData.sightRadius = role:GetSightRadius()
end

function BarrierDataUtils.ClearPos()
  DataCenter.barrierData.pos.x = 0
  DataCenter.barrierData.pos.y = 0
  DataCenter.barrierData.pos.z = 0
end

function BarrierDataUtils.GetEventLogicCfgByUid(barrierTid, eventUid)
  local barrierCfg = DT["Barrier.Barrier_" .. barrierTid]
  if not barrierCfg.events or not BarrierDataUtils.GetEvent(eventUid) then
    return nil
  end
  local logicTid = BarrierDataUtils.GetEvent(eventUid).logicTid
  if barrierCfg.events[logicTid] == nil then
    Logger.Error("关卡事件配置没有 logicTid==%s 但是服务器下发了", logicTid)
  end
  return barrierCfg.events[logicTid]
end

function BarrierDataUtils.GetEventTypeByUid(barrierTid, eventUid)
  local barrierCfg = DT["Barrier.Barrier_" .. barrierTid]
  if not barrierCfg.events or not BarrierDataUtils.GetEvent(eventUid) then
    return nil
  end
  local logicTid = BarrierDataUtils.GetEvent(eventUid).logicTid
  if barrierCfg.events[logicTid] == nil then
    Logger.Error("关卡事件配置没有 logicTid==%s 但是服务器下发了", logicTid)
  end
  return barrierCfg.events[logicTid].EventType
end

function BarrierDataUtils.GetPointConvertRelation(leftLowerPos, rightUpperPos, worldSize, textureSize)
  local xDir = textureSize.x / worldSize.x
  local yDir = textureSize.y / worldSize.y
  if rightUpperPos.x - leftLowerPos.x < 0 then
    xDir = -1 * xDir
  end
  if rightUpperPos.y - leftLowerPos.y < 0 then
    yDir = -1 * yDir
  end
  local xDelta = 0
  if 0 ~= leftLowerPos.x then
    xDelta = -leftLowerPos.x
  end
  local yDelta = 0
  if 0 ~= leftLowerPos.y then
    yDelta = -leftLowerPos.y
  end
  return xDir, yDir, xDelta, yDelta
end

function BarrierDataUtils.SetBarrierSceneSize(x, y)
  DataCenter.barrierData.sceneSize = {x = x, y = y}
end

function BarrierDataUtils.SetBoundsPos(leftLowerPos, rightUpperPos)
  DataCenter.barrierData.boundsPos = {leftLowerPos = leftLowerPos, rightUpperPos = rightUpperPos}
end

function BarrierDataUtils.AddShowEvent(uid)
  DataCenter.barrierData.enableShowEvents[uid] = true
end

function BarrierDataUtils.RemoveShowEvent(uid)
  if DataCenter.barrierData.enableShowEvents[uid] ~= nil then
    DataCenter.barrierData.enableShowEvents[uid] = nil
  end
end

function BarrierDataUtils.GetShowEvents()
  return DataCenter.barrierData.enableShowEvents
end

function BarrierDataUtils.GetWalkedPath(copiesId, barrierId)
  local curCopiesId = copiesId
  local curBarrierId = barrierId
  if curCopiesId <= 0 or curBarrierId <= 0 then
    return {}
  end
  if not DataCenter.barrierData.movePath[curCopiesId] then
    DataCenter.barrierData.movePath[curCopiesId] = BarrierDataUtils.ReadMapWalkedPath(curCopiesId) or {}
  end
  if not DataCenter.barrierData.movePath[curCopiesId][curBarrierId] then
    DataCenter.barrierData.movePath[curCopiesId][curBarrierId] = {}
  end
  return DataCenter.barrierData.movePath[curCopiesId][curBarrierId]
end

function BarrierDataUtils.ReadMapWalkedPath(copiesId)
  local key = CommonDefine.LocalSaveKey.MapPrefix .. copiesId
  local ret = MobileFileDataManager.Instance:GetPlayerFileValue(key)
  if not ret then
    return {}
  end
  return ret
end

function BarrierDataUtils.WriteDatas()
  BarrierDataUtils.WriteMapWalkedPath()
end

function BarrierDataUtils.WriteMapWalkedPath()
  for copiesId, copiesMapData in pairs(DataCenter.barrierData.movePath) do
    local data = {}
    for barrierId, barrierMapData in pairs(copiesMapData) do
      data[barrierId] = {}
      for idx, pos in ipairs(barrierMapData) do
        data[barrierId][idx] = {
          x = pos.x,
          z = pos.z
        }
      end
    end
    local key = CommonDefine.LocalSaveKey.MapPrefix .. copiesId
    MobileFileDataManager.Instance:SetPlayerFileValue(key, data)
  end
  MobileFileDataManager.Instance:OnSavePlayerFileInfo()
end

function BarrierDataUtils.GetEventAudioInfo(uid)
  if DataCenter.barrierData.EventInfos[uid] then
    local eventTid = DataCenter.barrierData.EventInfos[uid].tid
    local audioInfo = DT["Event.Event_" .. tostring(eventTid)].AudioInfo
    return audioInfo
  end
  return nil
end

function BarrierDataUtils.GetArea(barrierTid, areaTid)
  if not barrierTid or 0 == barrierTid then
    return nil
  end
  if not areaTid or 0 == areaTid then
    return nil
  end
  barrierTid = tostring(barrierTid)
  areaTid = tostring(areaTid)
  if not DataCenter.barrierData.areas[barrierTid] then
    return nil
  end
  return DataCenter.barrierData.areas[barrierTid][areaTid]
end

function BarrierDataUtils.GetAreas(barrierTid)
  if not barrierTid or 0 == barrierTid then
    return nil
  end
  barrierTid = tostring(barrierTid)
  return DataCenter.barrierData.areas[barrierTid]
end

function BarrierDataUtils.GetCurrArea()
  return DataCenter.barrierData.currArea
end

function BarrierDataUtils.SetCurrArea(area)
  if not area or 0 == area or DataCenter.barrierData.currArea == area then
    return
  end
  Logger.Info("Set curr area, old=%s now=%s", tostring(DataCenter.barrierData.currArea), tostring(area))
  DataCenter.barrierData.passArea = {
    [DataCenter.barrierData.currArea] = true
  }
  DataCenter.barrierData.currArea = area
end

function BarrierDataUtils.GetEventsRepulsion(barrierTid, eventUid)
  if not barrierTid or not eventUid then
    return 0
  end
  local config = BarrierDataUtils.GetEventLogicCfgByUid(barrierTid, eventUid)
  return config.RepulsionAddValue or 0
end

function BarrierDataUtils.GetHasTriggeredEvent(eventTid)
  return DataCenter.barrierData.triggeredEvents[eventTid]
end

function BarrierDataUtils.SetHasTriggeredEvent(eventTid)
  DataCenter.barrierData.triggeredEvents[eventTid] = true
end

function BarrierDataUtils.SetHasTriggeredBeginGroup(groupId)
  local areaData = BarrierDataUtils.GetArea(DataCenter.copiesData.BarrierId, DataCenter.barrierData.currArea)
  areaData.triggeredConveyGroup = groupId or 0
end

function BarrierDataUtils.GetHasTriggeredBegeinGroup(areaId)
  areaId = areaId or DataCenter.barrierData.currArea
  local areaData = BarrierDataUtils.GetArea(DataCenter.copiesData.BarrierId, areaId)
  if not areaData or not areaData.triggeredConveyGroup then
    return 0
  end
  return areaData.triggeredConveyGroup
end

function BarrierDataUtils.SetAreaGroupInfo()
  DataCenter.barrierData.areaGroupInfo = {}
  for _, event in pairs(DataCenter.barrierData.EventInfos) do
    if event and BarrierDataUtils.GetEventState(event.uid) then
      local logicConfig = BarrierDataUtils.GetEventLogicCfgByUid(DataCenter.copiesData.BarrierId, event.uid)
      if logicConfig and logicConfig.EventType == "Convey" then
        local eventConfig = DT["Event.Event_" .. event.tid]
        if eventConfig and eventConfig.NodeList[eventConfig.FirstNode] then
          local nodeConfig = eventConfig.NodeList[eventConfig.FirstNode]
          if nodeConfig.NodeAttr.targetArea and 0 ~= nodeConfig.NodeAttr.targetArea then
            DataCenter.barrierData.areaGroupInfo[nodeConfig.NodeAttr.groupId] = nodeConfig.NodeAttr.targetArea
          end
        end
      end
    end
  end
end

function BarrierDataUtils.GetAreaGroupInfo()
  return DataCenter.barrierData.areaGroupInfo
end

function BarrierDataUtils.SetEventGiveUp(giveUp)
  DataCenter.barrierData.triggerGiveUpEvent = giveUp
end

function BarrierDataUtils.NeedGiveUpEvent()
  return DataCenter.barrierData.triggerGiveUpEvent
end

function BarrierDataUtils.SetTopInfoLastShow()
  table.remove(DataCenter.barrierData.showStack)
  local size = #DataCenter.barrierData.showStack
  if 0 == size then
    BarrierDataUtils.SetTopInfoDefaultShow()
    return
  end
  local showData = DataCenter.barrierData.showStack[#DataCenter.barrierData.showStack]
  DataCenter.barrierData.showTopBag = showData.showBag
  DataCenter.barrierData.showHp = showData.showHp
  DataCenter.barrierData.showCurrencyBanner = showData.showCurrencyBanner
  DataCenter.barrierData.showRepel = showData.showRepel
end

function BarrierDataUtils.ResetDefaultShow()
  DataCenter.barrierData.showStack = {}
  BarrierDataUtils.SetTopInfoDefaultShow()
end

function BarrierDataUtils.SetTopInfoDefaultShow()
  DataCenter.barrierData.showTopBag = true
  DataCenter.barrierData.showHp = true
  DataCenter.barrierData.showCurrencyBanner = true
  DataCenter.gameData.IsShowGmEntry = true
end

function BarrierDataUtils:HideTopInfo()
  BarrierDataUtils.SetTopInfoShow(false, false, false, false, false)
end

function BarrierDataUtils.SetTopInfoShow(showBag, showHp, showCurrencyBanner, showMiniMap, showRepel)
  table.insert(DataCenter.barrierData.showStack, {
    showBag = showBag,
    showHp = showHp,
    showCurrencyBanner = showCurrencyBanner,
    showRepel = showRepel
  })
  DataCenter.barrierData.showTopBag = showBag
  DataCenter.barrierData.showHp = showHp
  DataCenter.barrierData.showCurrencyBanner = showCurrencyBanner
end

return BarrierDataUtils
