local CopyRecordsController, Super = NewClass("CopyRecordsController", BaseController)

function CopyRecordsController:OnInit()
  self:OnReset()
end

function CopyRecordsController:OnReset()
end

function CopyRecordsController:ReqSetHideReview(numVal)
  ProtoManager.Instance:ReqServer("GameRequest", "SetHideReview", function(data, ret)
    Logger.Proto("SetHideReview Successful", numVal, table.tostring(ret), table.tostring(data))
    PlayerDataUtils.SetHideReview(numVal)
  end, function()
    Logger.Proto("SetHideReview Failed")
  end, numVal)
end

function CopyRecordsController:ReqQueryOthersRecentReview(uid, widList, callback, errorCallback)
  ProtoManager.Instance:ReqServer("GameRequest", "QueryOthersRecentReview", function(data, ret)
    Logger.Proto("QueryOthersRecentReview Successful", table.tostring(ret), table.tostring(data))
    if callback then
      callback(data)
    end
    EventMgr.Instance.OtherCopyRecordUpdate:Dispatch()
  end, function()
    Logger.Proto("QueryOthersRecentReview Failed")
    if errorCallback then
      errorCallback()
    end
  end, uid, widList)
end

function CopyRecordsController:ReqQueryReviewDetailByBattleUuid(battleUuid, callback)
  ProtoManager.Instance:ReqServer("GameRequest", "QueryReviewDetail2", function(data, ret)
    Logger.Proto("QueryReviewDetail2 Successful", table.tostring(ret), table.tostring(data))
    if callback then
      callback(data.data)
    end
  end, function()
  end, battleUuid)
end

function CopyRecordsController:ReqQueryMyRecord(page)
  ProtoManager.Instance:ReqServer("GameRequest", "QueryMyRecentReview", function(data, ret)
    Logger.Proto("QueryMyRecentReview", table.tostring(ret), table.tostring(data))
    CopyRecordsModel.Instance:SetMyRecords(data)
  end, function()
  end, page)
end

function CopyRecordsController:ReqQueryStageRecord(stageTid, page, sortType, callback)
  sortType = sortType or cd.CopyRecordsSortType.TimeDescend
  local awakerMap = AwakerFilterListController.Instance and AwakerFilterListController.Instance:GetCopyRecordsFilterAwakerMap() or nil
  local reqName = awakerMap and "QueryStageReviewByAwaker" or "QueryStageReview"
  
  local function onSuccess(data, ret)
    Logger.Proto(reqName, stageTid, page, sortType, table.tostring(data, 7))
    CopyRecordsModel.Instance:SetStagePageRecords(stageTid, page, sortType, data)
    if callback then
      callback()
    end
  end
  
  if awakerMap then
    ProtoManager.Instance:ReqServer("GameRequest", "QueryStageReviewByAwaker", onSuccess, function()
    end, stageTid, page, sortType, awakerMap)
  else
    ProtoManager.Instance:ReqServer("GameRequest", "QueryStageReview", onSuccess, function()
    end, stageTid, page, sortType)
  end
end

function CopyRecordsController:ReqQueryRecordDetail(stageTid, wid, callback)
  if not (stageTid and 0 ~= stageTid and wid) or "" == wid then
    Alert.Show("PVEReplayNoDataTips")
    return
  end
  ProtoManager.Instance:ReqServer("GameRequest", "QueryReviewDetail", function(svrData, ret)
    Logger.Proto("QueryReviewDetail", table.tostring(svrData, 3))
    if callback then
      callback(svrData.data)
    end
  end, function()
    Alert.Show("PVEReplayNoDataTips")
  end, stageTid, wid)
end

function CopyRecordsController:ReqPVEBattleRecord(battleUuid)
  PVPBattleReplayUtils.PlayPVPReplay(battleUuid)
end

function CopyRecordsController:OpenCopyRecordsView(stageTid)
  local specialTeamCfg = TeamAssignDataUtils.GetStageSpecialTeamCfg(stageTid) or {}
  local TeamAssignAwaker = CommonDefine.TeamAssignAwaker
  for _, v in ipairs(specialTeamCfg.data_list or {}) do
    local awakerType = v.IsOwnedAwaker
    if type(v.AwakerIndex) == "number" and not awakerType then
      awakerType = TeamAssignAwaker.UseConfigData
    end
    if awakerType == TeamAssignAwaker.UseConfigData or awakerType == TeamAssignAwaker.SwitchSameAwaker or awakerType == TeamAssignAwaker.Trail then
      Alert.Show("PVEReplaySpecialTeamAssignTips")
      return
    end
  end
  UIManager.Instance:Reopen(Urls.CopyRecordsView, stageTid)
end

function CopyRecordsController:OpenRecordDetailPanel(stageTid, wid, playerId, playerFacade)
  Logger.Info("OpenRecordDetailPanel", stageTid, wid, playerId, playerFacade and playerFacade.uid)
  if not stageTid or not wid then
    return
  end
  self:ReqQueryRecordDetail(stageTid, wid, function(data)
    local recordStageData = data.teamData.recordStageData
    local ownerUid = playerId
    if not ownerUid and playerFacade then
      ownerUid = playerFacade.uid
    end
    recordStageData = CopyBattleStatisticsDataUtils.ApplyRecordOwnerSnapshot(recordStageData, ownerUid or data.playerId)
    if type(recordStageData) == "table" and playerFacade then
      if playerFacade.uid then
        recordStageData.playerUid = tonumber(playerFacade.uid) or recordStageData.playerUid
      end
      if playerFacade.name and playerFacade.name ~= "" then
        recordStageData.playerName = playerFacade.name
      end
      if playerFacade.level then
        recordStageData.playerLevel = playerFacade.level
      end
      if playerFacade.gender ~= nil then
        recordStageData.playerGender = playerFacade.gender
      end
    end
    CopySettleModel.Instance:UpdateBySvrData({
      teamData = data.teamData,
      recordStageData = recordStageData
    })
    CopyController.Instance:OnOpenCopySettleBaseView()
  end)
end

function CopyRecordsController:ReqQueryFacadeFields(playerUid, params, callback)
  if not playerUid then
    return
  end
  ProtoManager.Instance:ReqServer("GameRequest", "OnQueryFacadeFields", function(data)
    Logger.Info("========== OnQueryFacadeFields successful ==========\n", table.tostring(data or {}))
    if callback then
      callback(data)
    end
  end, function(data)
    Logger.Info("========== OnQueryFacadeFields Failed ==========\n", table.tostring(data or {}))
  end, playerUid, params)
end

return CopyRecordsController
