local table = _ENV.table
local WorldRequest, Super = System.NewClass("WorldRequest", ProtoBase)

function WorldRequest:Startup()
  Super.Startup(self)
end

function WorldRequest:Shutdown()
  Super.Shutdown(self)
end

function WorldRequest:ClearData()
  Super.ClearData(self)
end

function WorldRequest:OnTriggerEvent(evuuid)
  Logger.Info("OnTriggerEvent: 事件触发 evUid=%s", evuuid)
  local data, errcode = NetworkMgr.Instance.GearEvent:OnTriggerEvent(evuuid)
  return data, errcode
end

function WorldRequest:OnEventOptionHandle(optionTid, isPlot)
  isPlot = isPlot or 0
  Logger.Info("OnEventOptionHandle: OptionTid=%s isPlot=%s", optionTid, isPlot)
  local data, errcode = NetworkMgr.Instance.GearEvent:OnOptionHandle(optionTid, isPlot)
  return data, errcode
end

function WorldRequest:OnHandleEffect(uid, params)
  Logger.Info("WorldRequest:OnHandleEffect: ", uid, table.tostring(params, "  ", "  "))
  local data, errcode = NetworkMgr.Instance.WorldEffect:HandleEffect(uid, params)
  return data, errcode
end

function WorldRequest:SelectChaosRelic(tid)
  Logger.Info("WorldRequest:SelectChaosRelic: ", tid)
  local data, errcode = NetworkMgr.Instance.WorldRelic:SelectChaosRelic(tid)
  return data, errcode
end

function WorldRequest:OnCheckCondition(conditionStr)
  Logger.Info("OnCheckCondition: conditionStr=%s", conditionStr)
  local data, errcode = NetworkMgr.Instance.GearEvent:OnCheckCondition(conditionStr)
  return data, errcode
end

function WorldRequest:OnEventShopHandle(itemUid, shopType)
  Logger.Info("OnEventShopHandle: itemUid=%s shopType=%s", itemUid, shopType)
  local data, errcode = NetworkMgr.Instance.GearEvent:OnShopHandle(itemUid, shopType)
  return data, errcode
end

function WorldRequest:OnEventCampRestHandle()
  Logger.Info("OnEventCampRestHandle ")
  local data, errcode = NetworkMgr.Instance.GearEvent:OnCampHandle(1, 0)
  return data, errcode
end

function WorldRequest:OnEventNodeRefresh(refreshType)
  Logger.Info("OnEventRefresh : carduuid=%s %s", refreshType)
  local data, errcode = NetworkMgr.Instance.GearEvent:OnNodeRefresh(refreshType or "")
  return data, errcode
end

function WorldRequest:OnRpgBattleEnd(battleRet, battleData)
  Logger.Info("OnRpgBattleEnd: ret=%s data=%s", battleRet, table.tostring(battleData))
  local data, errcode = NetworkMgr.Instance.GearEvent:OnBattleRet(battleRet, battleData or {})
  return data, errcode
end

function WorldRequest:OnGainEventPrize(prizes, giveUpGold)
  Logger.Info("OnGainEventPrize: data=%s, giveUpGold:%s", table.tostring(prizes), tostring(giveUpGold))
  local data, errcode = NetworkMgr.Instance.GearEvent:OnGainEventPrize(prizes, giveUpGold)
  return data, errcode
end

function WorldRequest:OnGainEventAllPrize(data)
  Logger.Info("OnGainEventAllPrize: data = %s", table.tostring(data))
  local ret_data, errcode = NetworkMgr.Instance.GearEvent:OnGainEventPrize(data)
  return ret_data, errcode
end

function WorldRequest:OnRelicHandle(evUid, relicList, changeRelicList)
  Logger.Info("OnRelicHandle: evUid=%s relicList%s, changeRelicList=%s", evUid, table.tostring(relicList, "", ""), table.tostring(changeRelicList or {}, "", ""))
  local data, errcode = NetworkMgr.Instance.GearEvent:OnRelicHandle(evUid, relicList, changeRelicList or {})
  return data, errcode
end

function WorldRequest:OnEventHandle(param)
  Logger.Info("%sOnEventHandle: param=%s", self.__name, table.tostring(param, "", ""))
  do return NetworkMgr.Instance.GearEvent.OnEventHandle, NetworkMgr.Instance.GearEvent end
  return NetworkMgr.Instance.GearEvent.OnEventHandle, NetworkMgr.Instance.GearEvent, param, table.tostring(param, "", "")
end

function WorldRequest:PutRune(uid, runeTid)
  Logger.Info("WorldRequest:PutRune: ", self.__name, uid, runeTid)
  do return NetworkMgr.Instance.WorldCards.PutRune, NetworkMgr.Instance.WorldCards, uid end
  return NetworkMgr.Instance.WorldCards.PutRune, NetworkMgr.Instance.WorldCards, uid, runeTid, runeTid
end

function WorldRequest:OnGiveupNode(evUid)
  Logger.Info("%sOnGiveupNode: evUid=%s", self.__name, evUid)
  do return NetworkMgr.Instance.GearEvent.OnGiveupNode, NetworkMgr.Instance.GearEvent end
  return NetworkMgr.Instance.GearEvent.OnGiveupNode, NetworkMgr.Instance.GearEvent, evUid, evUid
end

function WorldRequest:OnSyncRoleAttr(data)
  Logger.Info("OnSyncRoleAttr: data = %s", table.tostring(data))
  local ret_data, errcode = NetworkMgr.Instance.WorldRoles:OnRoleAttr(data)
  return ret_data, errcode
end

function WorldRequest:OnAddCard(info)
  Logger.Info("OnAddCard: cardTid %s", table.tostring(info))
  local data, errcode = NetworkMgr.Instance.WorldCards:OnClientByAddCard(info)
  return data, errcode
end

function WorldRequest:OnPlotSayHandle(dialogTid, eventUid)
  Logger.Info("OnPlotSayHandle: dialogTid %s, %s", dialogTid, eventUid)
  local data, errcode = NetworkMgr.Instance.GearEvent:OnPlotSayHandle(dialogTid, eventUid)
  return data, errcode
end

function WorldRequest:OnPlotSayEnd(dialogTid)
  Logger.Info("OnPlotSayEnd: dialogTid %s", dialogTid)
  local data, errcode = NetworkMgr.Instance.City:OnPlotSayEnd(dialogTid, 0)
  return data, errcode
end

function WorldRequest:OnShowCopiesTask()
  local data, errcode = NetworkMgr.Instance.WorldCourse:OnShowCopiesTask()
  return data, errcode
end

function WorldRequest:OnGainFinishPrize(unitTid)
  Logger.Info("OnGainFinishPrize: unitTid:%s", unitTid)
  local data, errcode = NetworkMgr.Instance.WorldCourse:OnGainFinishPrize(unitTid)
  return data, errcode
end

function WorldRequest:OnShowModuleList()
  local data, errcode = NetworkMgr.Instance.WorldCourse:OnShowModuleList()
  return data, errcode
end

function WorldRequest:OnShowModule(moduleTid)
  Logger.Info("显示课题分某个模块数据,请求: moduleTid:%s", moduleTid)
  local data, errcode = NetworkMgr.Instance.WorldCourse:OnShowModule(moduleTid)
  return data, errcode
end

function WorldRequest:OnGetCurKeepRelicData()
  Logger.Info("OnGetCurKeepRelicData discard discard discard discard discard discard discard discard discard discard")
end

function WorldRequest:OnSetCurKeepRelicData(index, relicUid)
  Logger.Info("OnGetCurKeepRelicData")
  local data, errcode = NetworkMgr.Instance.WorldRelic:SetKeepRelic(index, relicUid)
  return data, errcode
end

function WorldRequest:OnChooseGameRelics(relicTids)
  Logger.Info("OnChooseGameRelics")
  local data, errcode = NetworkMgr.Instance.WorldRelic:ChooseGameRelics(relicTids)
  return data, errcode
end

function WorldRequest:OnMove(x, y)
  do return NetworkMgr.Instance.Map.OnMove, NetworkMgr.Instance.Map, x end
  return NetworkMgr.Instance.Map.OnMove, NetworkMgr.Instance.Map, x, y
end

function WorldRequest:GetWorldResonanceGroup()
  Logger.Info("WorldRequest:GetWorldResonanceGroup")
  local data, errcode = NetworkMgr.Instance.WorldTalent:GetWorldResonanceGroup()
  return data, errcode
end

function WorldRequest:OnGearChoose(uid, index)
  Logger.Info("OnStageEventChoose param=" .. uid, index)
  do return NetworkMgr.Instance.GearMgr.OnChoose, NetworkMgr.Instance.GearMgr, uid end
  return NetworkMgr.Instance.GearMgr.OnChoose, NetworkMgr.Instance.GearMgr, uid, index
end

function WorldRequest:OnTrigger(uid, extraParams)
  Logger.Info("WorldRequest.OnTrigger", uid, table.tostring(extraParams), debug.traceback())
  do return NetworkMgr.Instance.GearMgr.OnTrigger, NetworkMgr.Instance.GearMgr, uid end
  return NetworkMgr.Instance.GearMgr.OnTrigger, NetworkMgr.Instance.GearMgr, uid, extraParams, debug.traceback()
end

function WorldRequest:OnGearHandle(...)
  Logger.Info("WorldRequest:OnGearHandle", table.tostring({
    ...
  }))
  do return NetworkMgr.Instance.GearMgr.OnHandle, NetworkMgr.Instance.GearMgr, ... end
  return NetworkMgr.Instance.GearMgr.OnHandle, NetworkMgr.Instance.GearMgr, ...
end

function WorldRequest:OnGearGainBattlePrize(param)
  Logger.Info("OnGearGainBattlePrize", table.tostring(param))
  do return NetworkMgr.Instance.GearMgr.OnGainBattlePrize, NetworkMgr.Instance.GearMgr end
  return NetworkMgr.Instance.GearMgr.OnGainBattlePrize, NetworkMgr.Instance.GearMgr, param, table.tostring(param)
end

function WorldRequest:OnGearShopRefresh(params)
  Logger.Info("OnGearShopRefresh: params=%s", table.tostring(params))
  do return NetworkMgr.Instance.GearMgr.OnShopRefresh, NetworkMgr.Instance.GearMgr end
  return NetworkMgr.Instance.GearMgr.OnShopRefresh, NetworkMgr.Instance.GearMgr, params, table.tostring(params)
end

function WorldRequest:OnShopCustomCmd()
  Logger.Info("OnShopCustomCmd")
  do return NetworkMgr.Instance.GearMgr.OnShopCustomCmd end
  return NetworkMgr.Instance.GearMgr.OnShopCustomCmd, NetworkMgr.Instance.GearMgr
end

function WorldRequest:OnEnhanceRelic(params)
  Logger.Info("OnEnhanceRelic: params=%s", table.tostring(params))
  do return NetworkMgr.Instance.GearMgr.OnEnhanceRelic, NetworkMgr.Instance.GearMgr end
  return NetworkMgr.Instance.GearMgr.OnEnhanceRelic, NetworkMgr.Instance.GearMgr, params, table.tostring(params)
end

function WorldRequest:OnCmdChooseTarget(cmdUid, uids)
  do return NetworkMgr.Instance.CmdMgr.OnCmdChooseTarget, NetworkMgr.Instance.CmdMgr, cmdUid end
  return NetworkMgr.Instance.CmdMgr.OnCmdChooseTarget, NetworkMgr.Instance.CmdMgr, cmdUid, uids
end

function WorldRequest:OnPlotEnd()
  Logger.Info("%s OnPlotEnd", self.__name)
  do return NetworkMgr.Instance.Map.OnPlotEnd end
  return NetworkMgr.Instance.Map.OnPlotEnd, NetworkMgr.Instance.Map, self.__name
end

function WorldRequest:OnGearClose(uid)
  Logger.Info("%s OnGearClose", self.__name)
  do return NetworkMgr.Instance.GearMgr.OnClose, NetworkMgr.Instance.GearMgr end
  return NetworkMgr.Instance.GearMgr.OnClose, NetworkMgr.Instance.GearMgr, uid
end

function WorldRequest:OnRevive(chooseRet)
  Logger.Proto("%s OnRevive: chooseRet=%s", self.__name, chooseRet)
  do return NetworkMgr.Instance.WorldRoles.OnRevive end
  return NetworkMgr.Instance.WorldRoles.OnRevive, chooseRet, self.__name, chooseRet
end

function WorldRequest:OnReceiveCommand(msgId, msgData)
  Logger.Info("Battle ,请求: msg:%s", msgId, table.tostring(msgData, "", ""))
  NetworkMgr.Instance.Battle.OnReceiveCommand(msgId, msgData or {})
  return true
end

function WorldRequest:StartBattle(boolVal)
  Logger.Info("Battle ,请求: msg:StartBattle:%s", boolVal)
  do return NetworkMgr.Instance.Battle.StartBattle, NetworkMgr.Instance.Battle end
  return NetworkMgr.Instance.Battle.StartBattle, NetworkMgr.Instance.Battle, boolVal
end

function WorldRequest:AfterInitBattleRender()
  Logger.Info("Battle ,请求: msg:AfterInitBattleRender")
  NetworkMgr.Instance.Battle.AfterInitBattleRender()
end

function WorldRequest:ExitBattle()
  Logger.Info("Battle ,请求: msg:ExitBattle")
  local data, errcode = NetworkMgr.Instance.Battle:ExitBattle()
  return data, errcode
end

return WorldRequest
