local TutorialItemState = CommonDefine.TutorialItemState
local TutorialData = DataCenter.tutorialData
local TutorialDataUtils = {}

function TutorialDataUtils.InitByCfgData()
  for _, cfg in pairs(DT.Tutorial) do
    TutorialData.tutorialItemMap[cfg.ID] = TutorialDataUtils.CreateTutorialItemData(cfg.ID)
  end
end

function TutorialDataUtils.InitBySvrData(svrDatas)
  for sortWeight, svrData in pairs(svrDatas.entries) do
    TutorialDataUtils.UpdateTutorialItemData(svrData, sortWeight)
  end
end

function TutorialDataUtils.UpdateTutorialItemData(newItemData, sortWeight)
  local cacheTutorialItemData = TutorialData.tutorialItemMap[newItemData.tid]
  if cacheTutorialItemData then
    for key, val in pairs(newItemData) do
      if cacheTutorialItemData[key] then
        cacheTutorialItemData[key] = val
      end
    end
    if sortWeight then
      cacheTutorialItemData.sortWeight = sortWeight
    end
  else
    if sortWeight then
      newItemData.sortWeight = sortWeight
    end
    TutorialData.tutorialItemMap[newItemData.tid] = newItemData
  end
end

function TutorialDataUtils.CreateTutorialItemData(tid, sortWeight, state)
  local tutorialData = {
    tid = tid or 0,
    sortWeight = sortWeight or 0,
    state = state or TutorialItemState.Hide
  }
  return tutorialData
end

function TutorialDataUtils.CreateTestSvrData()
  local testSvrData = {
    [1] = {
      tid = 1,
      uid = 0,
      unlock = true,
      ts = 0,
      readed = true
    },
    [2] = {
      tid = 2,
      uid = 0,
      unlock = true,
      ts = 0,
      readed = true
    },
    [3] = {
      tid = 3,
      uid = 0,
      unlock = true,
      ts = 0,
      readed = false
    }
  }
  return testSvrData
end

function TutorialDataUtils.OpenTutorialPopTip(tidGroup)
  if not tidGroup or type(tidGroup) ~= "table" or 0 == #tidGroup then
    return
  end
  UIManager.Instance:Reopen(Urls.TutorialPopTipView, tidGroup)
end

function TutorialDataUtils.OpenTutorialMainPanel(tidGroup, hideToggles)
  RedPointDataUtils.ReqRemoveData(RedPointDataUtils.RedType.Tutorial, RedPointDataUtils.RedAttrType.IsNew)
  UIManager.Instance:Reopen(Urls.TaskMainView, CommonDefine.TaskPage.Tutorial, nil, tidGroup or hideToggles)
end

function TutorialDataUtils.ReqClickBoardGirl(callback)
  Logger.Debug("TutorialDataUtils.ReqClickBoardGirl")
  EventMgr.Instance.OpenReqMask:Dispatch()
  ProtoManager.Instance:ReqServer("GameRequest", "TutorialOnClickBoardGirl", function(data)
    Logger.Info("========== TutorialOnClickBoardGirl Successful ==========\n", table.tostring(data or {}))
    if callback then
      callback()
    end
  end, function(data)
    Logger.Info("========== TutorialOnClickBoardGirl Failed ==========\n", table.tostring(data or {}))
  end)
end

function TutorialDataUtils.ReqTutorialData(callback)
  Logger.Debug("TutorialDataUtils.TutorialOnOpen")
  EventMgr.Instance.OpenReqMask:Dispatch()
  ProtoManager.Instance:ReqServer("GameRequest", "TutorialOnOpen", function(data)
    Logger.Info("========== TutorialOnOpen Successful ==========\n", table.tostring(data or {}))
    TutorialDataUtils.InitByCfgData()
    TutorialDataUtils.InitBySvrData(data)
    if callback then
      callback()
    end
  end, function(data)
    Logger.Info("========== TutorialOnOpen Failed ==========\n", table.tostring(data or {}))
  end)
end

function TutorialDataUtils.ReqTutorialFinishRead(tid, callback)
  local tutorialData = TutorialDataUtils.GetTutorialItemDataByTid(tid)
  if not tutorialData or tutorialData.state ~= TutorialItemState.Receive then
    if callback then
      callback()
    end
    return
  end
  Logger.Debug("TutorialDataUtils.ReqTutorialFinishRead tid ", tid)
  tutorialData.state = TutorialItemState.Done
  EventMgr.Instance.OpenReqMask:Dispatch()
  ProtoManager.Instance:ReqServer("GameRequest", "TutorialOnFinishRead", function(data)
    Logger.Info("========== ReqTutorialFinishRead Successful ==========\n", table.tostring(data or {}))
    if callback then
      callback()
    end
  end, function(data)
    Logger.Info("========== ReqTutorialFinishRead Failed ==========\n", table.tostring(data or {}))
  end, tid)
end

function TutorialDataUtils.ReqTutorialFinishAllRead(callback)
  Logger.Debug("TutorialDataUtils.ReqTutorialFinishAllRead ")
  local tutorialItemMap = TutorialDataUtils.GetTutorialItemMap()
  for _, tutorialData in pairs(tutorialItemMap) do
    tutorialData.state = TutorialItemState.Done
  end
  ProtoManager.Instance:ReqServer("GameRequest", "TutorialOnFinishAllRead", function(data)
    Logger.Info("========== ReqTutorialFinishAllRead Successful ==========\n", table.tostring(data or {}))
    if callback then
      callback()
    end
  end, function(data)
    Logger.Info("========== ReqTutorialFinishAllRead Failed ==========\n", table.tostring(data or {}))
  end)
end

function TutorialDataUtils.SetHaveClickMainPanelAwaker(boolVal)
  if nil == boolVal then
    return
  end
  TutorialData.haveClickMainPanelAwaker = boolVal
end

function TutorialDataUtils.GetTutorialMaxPageByTid(tid)
  local rst = 1
  local tutorialCfg = TutorialDataUtils.GetConfigByTid(tid)
  if not tutorialCfg then
    return rst
  end
  return #tutorialCfg.data_list
end

function TutorialDataUtils.GetHaveClickMainPanelAwaker()
  return TutorialData.haveClickMainPanelAwaker
end

function TutorialDataUtils.GetTutorialItemMap()
  return TutorialData.tutorialItemMap
end

function TutorialDataUtils.GetTutorialItemDataByTid(tid)
  return TutorialData.tutorialItemMap[tid]
end

function TutorialDataUtils.GetConfigByTid(tid)
  if not tid then
    return nil
  end
  local cfg = DT.Tutorial[tid]
  if not cfg then
    return nil
  end
  local mt = {
    __index = function(tbl, key)
      if not rawget(tbl, key) then
        return rawget(tbl, "data_list")[1][key]
      end
      do return rawget, tbl end
      return rawget, tbl, key
    end
  }
  setmetatable(cfg, mt)
  return cfg
end

function TutorialDataUtils.CheckTutorialHaveState(state)
  local rst = false
  local tutorialItemMap = TutorialDataUtils.GetTutorialItemMap()
  for _, tutorialData in pairs(tutorialItemMap) do
    if tutorialData.state == state then
      rst = true
      break
    end
  end
  return rst
end

return TutorialDataUtils
