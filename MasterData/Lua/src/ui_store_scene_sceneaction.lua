local this = {}

function this:req_enterScene(sceneId, pointId, creatorId, callback, transport)
  local data = {
    map_id = sceneId,
    point_id = pointId,
    creator_id = creatorId,
    trans_type = transport
  }
  if AzurWorld.DungeonMgr:CheckIsDungeonScene() then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_cannot_goscene"))
    return
  end
  L_Net:sendMessage(MsgGenCode.CSProtoEnterWorldMap, data, function(sData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc then
      if callback then
        callback(sData, errorCode)
      end
    elseif errorCode == L_Const.errorCode.ErrCodeEnterFail then
      if callback then
        callback(sData, errorCode)
      end
    else
      if pointId then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_sceneStore"))
      else
      end
    end
  end, nil)
end

function this:req_transferInSameScene(pointId, transport, isStuck, callback)
  local data = {
    point_id = pointId,
    trans_type = transport,
    is_stuck = isStuck
  }
  L_Net:sendMessage(MsgGenCode.CSProtoWorldPoint, data, function(sData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc then
      if callback then
        callback(sData, errorCode)
      end
    else
      AzurWorld.playerMgr:CheckPosition()
    end
  end)
end

function this:transferToPoint(sceneId, pointId, creatorId, callback, transport, ignoreTaskLimit)
  if ignoreTaskLimit ~= true and AzurWorld.TaskMgr:GetTaskUIModule():CheckIsDisableMapTransfer() then
    return
  end
  if AzurWorld.FunctionModuleForbidMgr:CheckIsFunctionModuleForbid(C_EForbidModuleType.MapTransfer, true) then
    return
  end
  if L_GuideManager:checkIsDisableMapTransfer() then
    return
  end
  C_GameFlow.flowEvent:Dispatch(C_EGameFlowEvent.StartScnensOperation)
  local curSceneId = AzurWorldInstance.CurWorldId
  local targetSceneId = sceneId
  if pointId and 0 < pointId then
    local borthTpl = L_GameTpl:getWorldBorthposTpl():getTplById(pointId)
    if borthTpl then
      targetSceneId = borthTpl.cityId
    end
  end
  if curSceneId == targetSceneId then
    self:req_transferInSameScene(pointId, transport, false, callback)
  else
    self:req_enterScene(targetSceneId, pointId, creatorId, callback, transport)
  end
end

function this:rsp_syncMapPoint(sData)
  local all = self:getAllUnlockPoint()
  for _, v in ipairs(sData.u32s) do
    all[v] = true
  end
  self:call(self.event.refreshPoint, sData.u32s)
end

return this
