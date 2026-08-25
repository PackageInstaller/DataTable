local TrinketRequest, Super = System.NewClass("TrinketRequest", ProtoBase)

function TrinketRequest:Startup()
  Super.Startup(self)
end

function TrinketRequest:Shutdown()
  Super.Shutdown(self)
end

function TrinketRequest:ClearData()
  Super.ClearData(self)
end

function TrinketRequest:OnShowTrinket()
  Logger.Debug("TrinketRequest:OnShowTrinket()")
  do return NetworkMgr.Instance.Item.OnShowTrinket end
  return NetworkMgr.Instance.Item.OnShowTrinket, NetworkMgr.Instance.Item
end

function TrinketRequest:OnLock(eid)
  Logger.Debug("TrinketRequest:OnLock(%s)", eid)
  do return NetworkMgr.Instance.Item.OnLock, NetworkMgr.Instance.Item end
  return NetworkMgr.Instance.Item.OnLock, NetworkMgr.Instance.Item, eid
end

function TrinketRequest:OnUnLock(eid)
  Logger.Debug("TrinketRequest:OnUnLock(%s)", eid)
  do return NetworkMgr.Instance.Item.OnUnlock, NetworkMgr.Instance.Item end
  return NetworkMgr.Instance.Item.OnUnlock, NetworkMgr.Instance.Item, eid
end

function TrinketRequest:OnPutOnTrinket(awakerTid, eid)
  Logger.Debug("TrinketRequest:OnPutOnTrinket(%s, %s)", awakerTid, eid)
  do return NetworkMgr.Instance.Item.OnPutOnTrinket, NetworkMgr.Instance.Item, awakerTid end
  return NetworkMgr.Instance.Item.OnPutOnTrinket, NetworkMgr.Instance.Item, awakerTid, eid
end

function TrinketRequest:OnTakeoffTrinket(eid)
  Logger.Debug("TrinketRequest:OnTakeoffTrinket(%d)", eid)
  do return NetworkMgr.Instance.Item.OnTakeoffTrinket, NetworkMgr.Instance.Item end
  return NetworkMgr.Instance.Item.OnTakeoffTrinket, NetworkMgr.Instance.Item, eid
end

function TrinketRequest:OnUpgradeTrinket(eid, useEids)
  Logger.Debug("TrinketRequest:OnUpgradeTrinket(%s, %s)", eid, table.tostring(useEids, "", ""))
  do return NetworkMgr.Instance.Item.OnUpgradeTrinket, NetworkMgr.Instance.Item, eid end
  return NetworkMgr.Instance.Item.OnUpgradeTrinket, NetworkMgr.Instance.Item, eid, useEids, table.tostring(useEids, "", "")
end

function TrinketRequest:OnChooseTrinket(eid)
  Logger.Debug("TrinketRequest:OnChooseTrinket(%s)", eid)
  do return NetworkMgr.Instance.Item.OnChooseTrinket, NetworkMgr.Instance.Item end
  return NetworkMgr.Instance.Item.OnChooseTrinket, NetworkMgr.Instance.Item, eid
end

function TrinketRequest:OnRecommendTrinket(awakerTid, curTeamType, curTeamIndex)
  Logger.Debug("TrinketRequest:OnRecommendTrinket(%s,%s,%s)", awakerTid, curTeamType, curTeamIndex)
  do return NetworkMgr.Instance.Awaker.OnRecommendTrinket, NetworkMgr.Instance.Awaker, awakerTid, curTeamType end
  return NetworkMgr.Instance.Awaker.OnRecommendTrinket, NetworkMgr.Instance.Awaker, awakerTid, curTeamType, curTeamIndex
end

function TrinketRequest:OnTakeoffAllTrinket(awakerTid)
  Logger.Debug("TrinketRequest:OnTakeoffAllTrinket(%s)", awakerTid)
  do return NetworkMgr.Instance.Awaker.OnTakeoffAllTrinket, NetworkMgr.Instance.Awaker end
  return NetworkMgr.Instance.Awaker.OnTakeoffAllTrinket, NetworkMgr.Instance.Awaker, awakerTid
end

function TrinketRequest:OnTrainingTrinket(uid, attrsLock, isAutoSupply)
  Logger.Debug("TrinketRequest:OnTrainingTrinket(%s, %s, %s)", uid, table.tostring(attrsLock, "", ""), isAutoSupply)
  do return NetworkMgr.Instance.Item.OnTrainingTrinket, NetworkMgr.Instance.Item, uid, attrsLock end
  return NetworkMgr.Instance.Item.OnTrainingTrinket, NetworkMgr.Instance.Item, uid, attrsLock, isAutoSupply or false, "", ""
end

function TrinketRequest:OnAutoTrainingTrinket(uid, attrsLock, isAutoSupply, clientMaxTimes, chooseList)
  Logger.Debug("TrinketRequest:OnAutoTrainingTrinket(%s, %s, %s, %s, %s)", uid, table.tostring(attrsLock, "", ""), isAutoSupply, clientMaxTimes, table.tostring(chooseList or {}, "", ""))
  do return NetworkMgr.Instance.Item.OnAutoTrainingTrinket, NetworkMgr.Instance.Item, uid, attrsLock, isAutoSupply, clientMaxTimes end
  return NetworkMgr.Instance.Item.OnAutoTrainingTrinket, NetworkMgr.Instance.Item, uid, attrsLock, isAutoSupply, clientMaxTimes, chooseList, table.tostring(chooseList or {}, "", "")
end

function TrinketRequest:OnTrinketConfirmTraining(uid)
  Logger.Debug("TrinketRequest:OnTrinketConfirmTraining(%s, %s)", uid)
  do return NetworkMgr.Instance.Item.OnTrinketConfirmTraining, NetworkMgr.Instance.Item end
  return NetworkMgr.Instance.Item.OnTrinketConfirmTraining, NetworkMgr.Instance.Item, uid
end

function TrinketRequest:OnOpen()
  Logger.Debug("TrinketRequest:OnOpen()")
  do return NetworkMgr.Instance.Trinket.OnOpen end
  return NetworkMgr.Instance.Trinket.OnOpen, NetworkMgr.Instance.Trinket
end

function TrinketRequest:UpdateTrinketSuit(id, name, trinkets)
  Logger.Debug("TrinketRequest:UpdateTrinketSuit(%s, %s, %s)", id, name, trinkets)
  do return NetworkMgr.Instance.Trinket.UpdateTrinketSuit, NetworkMgr.Instance.Trinket, id, name end
  return NetworkMgr.Instance.Trinket.UpdateTrinketSuit, NetworkMgr.Instance.Trinket, id, name, trinkets
end

function TrinketRequest:RemoveTrinketSuit(id)
  Logger.Debug("TrinketRequest:RemoveTrinketSuit(%s)", id)
  do return NetworkMgr.Instance.Trinket.RemoveTrinketSuit, NetworkMgr.Instance.Trinket end
  return NetworkMgr.Instance.Trinket.RemoveTrinketSuit, NetworkMgr.Instance.Trinket, id
end

function TrinketRequest:BatchBindTrinkets(awakerTid, targetTrinkets, costTrinketUids)
  Logger.Debug("TrinketRequest:BatchBindTrinkets(%s, %s, %s)", awakerTid, table.tostring(targetTrinkets, "", ""), table.tostring(costTrinketUids, "", ""))
  do return NetworkMgr.Instance.Trinket.BatchBindTrinkets, NetworkMgr.Instance.Trinket, awakerTid, targetTrinkets end
  return NetworkMgr.Instance.Trinket.BatchBindTrinkets, NetworkMgr.Instance.Trinket, awakerTid, targetTrinkets, costTrinketUids, table.tostring(costTrinketUids, "", "")
end

return TrinketRequest
