local StageRequest, Super = System.NewClass("StageRequest", ProtoBase)

function StageRequest:Startup()
  Super.Startup(self)
end

function StageRequest:Shutdown()
  Super.Shutdown(self)
end

function StageRequest:ClearData()
  Super.ClearData(self)
end

function StageRequest:GetStageInfo(featureID, copyID)
  Logger.Info("StageRequest.GetStageInfo", featureID, copyID)
  do return NetworkMgr.Instance.Stage.GetStageInfo, NetworkMgr.Instance.Stage, featureID end
  return NetworkMgr.Instance.Stage.GetStageInfo, NetworkMgr.Instance.Stage, featureID, copyID
end

function StageRequest:GetStageInfoList(stageGroupIDList)
  Logger.Info("StageRequest.GetStageInfoList", table.concat(stageGroupIDList, ","))
  do return NetworkMgr.Instance.Stage.GetStageInfoList, NetworkMgr.Instance.Stage end
  return NetworkMgr.Instance.Stage.GetStageInfoList, NetworkMgr.Instance.Stage, stageGroupIDList, table.concat(stageGroupIDList, ",")
end

function StageRequest:Enter(stageID, teamIdx, assistAwakerTid, playerUid, extraParams)
  Logger.Info("StageRequest.Enter : ", stageID, teamIdx, assistAwakerTid, playerUid, table.tostring(extraParams or {}))
  do return NetworkMgr.Instance.Stage.Enter, NetworkMgr.Instance.Stage, stageID, teamIdx, assistAwakerTid or 0, playerUid or 0 end
  return NetworkMgr.Instance.Stage.Enter, NetworkMgr.Instance.Stage, stageID, teamIdx, assistAwakerTid or 0, playerUid or 0, extraParams or {}, table.tostring(extraParams or {})
end

function StageRequest:EnterStageSecondMode(stageID, teamIdx, assistAwakerTid, playerUid)
  Logger.Info("StageRequest.EnterStageSecondMode : ", stageID, teamIdx, assistAwakerTid, playerUid)
  do return NetworkMgr.Instance.Stage.EnterStageSecondMode, NetworkMgr.Instance.Stage, stageID, teamIdx, assistAwakerTid or 0 end
  return NetworkMgr.Instance.Stage.EnterStageSecondMode, NetworkMgr.Instance.Stage, stageID, teamIdx, assistAwakerTid or 0, playerUid or 0
end

function StageRequest:EnterSpecialStage(stageID, tAwakerTids, keeperSkillItem, teamIdx)
  Logger.Info("StageRequest.EnterSpecialStage", stageID, table.tostring(tAwakerTids), keeperSkillItem, teamIdx)
  do return NetworkMgr.Instance.Stage.EnterSpecialStage, NetworkMgr.Instance.Stage, stageID, tAwakerTids, keeperSkillItem end
  return NetworkMgr.Instance.Stage.EnterSpecialStage, NetworkMgr.Instance.Stage, stageID, tAwakerTids, keeperSkillItem, teamIdx
end

function StageRequest:UnlockStageByItem(stageID)
  Logger.Info("StageRequest.UnlockStageByItem", stageID)
  do return NetworkMgr.Instance.Stage.UnlockStageByItem, NetworkMgr.Instance.Stage end
  return NetworkMgr.Instance.Stage.UnlockStageByItem, NetworkMgr.Instance.Stage, stageID
end

function StageRequest:UnlockStageGroupByItem(stageGroupId)
  Logger.Info("StageRequest.UnlockStageGroupByItem", stageGroupId)
  do return NetworkMgr.Instance.Stage.UnlockStageGroupByItem, NetworkMgr.Instance.Stage end
  return NetworkMgr.Instance.Stage.UnlockStageGroupByItem, NetworkMgr.Instance.Stage, stageGroupId
end

function StageRequest:Sweep(stageID, count, teamId)
  Logger.Info("StageRequest.MoppingUp", stageID, count, teamId)
  do return NetworkMgr.Instance.Stage.MoppingUp, NetworkMgr.Instance.Stage, stageID, count end
  return NetworkMgr.Instance.Stage.MoppingUp, NetworkMgr.Instance.Stage, stageID, count, teamId
end

function StageRequest:OnExit(stageID)
  Logger.Info("StageRequest.OnExit:", stageID)
  do return NetworkMgr.Instance.Stage.Exit, NetworkMgr.Instance.Stage end
  return NetworkMgr.Instance.Stage.Exit, NetworkMgr.Instance.Stage, stageID
end

function StageRequest:OnSaveAndExit(stageID)
  Logger.Info("StageRequest.OnSaveAndExit:", stageID)
  do return NetworkMgr.Instance.Stage.OnSaveAndExit, NetworkMgr.Instance.Stage end
  return NetworkMgr.Instance.Stage.OnSaveAndExit, NetworkMgr.Instance.Stage, stageID
end

function StageRequest:AwardProgress(copyID)
  Logger.Debug("StageRequest.ReqAwardProgress", copyID)
  do return NetworkMgr.Instance.Stage.SendStageGroupStarList, NetworkMgr.Instance.Stage end
  return NetworkMgr.Instance.Stage.SendStageGroupStarList, NetworkMgr.Instance.Stage, copyID
end

function StageRequest:AwardGet(copyID, star)
  Logger.Info("StageRequest.AwardGet", copyID, star)
  do return NetworkMgr.Instance.Stage.GainStageGroupStarRw, NetworkMgr.Instance.Stage, copyID end
  return NetworkMgr.Instance.Stage.GainStageGroupStarRw, NetworkMgr.Instance.Stage, copyID, star
end

function StageRequest:OnGainUnlockStageGroupReward(stageGroupTid)
  Logger.Proto("[ac]StageRequest:OnGainUnlockStageGroupReward stageGroupTid=%s", stageGroupTid)
  do return NetworkMgr.Instance.Stage.GainUnlockStageGroupReward, NetworkMgr.Instance.Stage end
  return NetworkMgr.Instance.Stage.GainUnlockStageGroupReward, NetworkMgr.Instance.Stage, stageGroupTid
end

function StageRequest:GetStageSpecialAwakerData(specialTeamId)
  Logger.Proto("StageRequest:GetStageSpecialAwakerData specialTeamId=%s", specialTeamId)
  do return NetworkMgr.Instance.Stage.GetStageSpecialAwakerData, NetworkMgr.Instance.Stage end
  return NetworkMgr.Instance.Stage.GetStageSpecialAwakerData, NetworkMgr.Instance.Stage, specialTeamId
end

return StageRequest
