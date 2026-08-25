local tableInsert = table.insert
local tableRemove = table.remove
local UIPopTipsDataUtils = {}

function UIPopTipsDataUtils.ResetAll()
  DataCenter.popTipsData.showQueue = {}
  DataCenter.popTipsData.canShowTips = true
end

function UIPopTipsDataUtils.GetTipsShowQueue()
  return DataCenter.popTipsData.showQueue
end

function UIPopTipsDataUtils.AddToTipsShowQueue(tipTid, data, cancelFunc, confirmFunc, subType)
  tableInsert(DataCenter.popTipsData.showQueue, {
    tipTid = tipTid,
    hasPop = false,
    data = data,
    cancelFunc = cancelFunc,
    confirmFunc = confirmFunc,
    subType = subType
  })
end

function UIPopTipsDataUtils.PopTipsShowQueue()
  local data = DataCenter.popTipsData.showQueue[1]
  return data
end

UIPopTipsDataUtils.SideMsgType = {
  Default = 0,
  GainTips = 1,
  CourseTips = 2
}

function UIPopTipsDataUtils.SetTipHasPop(data, hasPop)
  data.hasPop = hasPop
end

function UIPopTipsDataUtils.RemoveAtOnePop()
  if #DataCenter.popTipsData.showQueue > 0 and DataCenter.popTipsData.showQueue[1].hasPop then
    tableRemove(DataCenter.popTipsData.showQueue, 1)
  end
end

function UIPopTipsDataUtils.ClearTipsShowQueue()
  DataCenter.popTipsData.showQueue = {}
end

function UIPopTipsDataUtils.GetEnabledShowTips()
  return DataCenter.popTipsData.canShowTips
end

function UIPopTipsDataUtils.SetEnabledShowTips(bool)
  DataCenter.popTipsData.canShowTips = bool
end

local _SuspendVal = {
  [CommonDefine.TipsType.PopMsg] = 0,
  [CommonDefine.TipsType.SideMsg] = 0,
  [CommonDefine.TipsType.AlertConfirm] = 2
}

function UIPopTipsDataUtils.SetSuspend(tipsType)
  local suspendVal = _SuspendVal[tipsType] or 0
  DataCenter.popTipsData.suspendVal = suspendVal
end

function UIPopTipsDataUtils.NeedWait(tipsType)
  if 0 == DataCenter.popTipsData.suspendVal then
    return false
  end
  local suspendVal = _SuspendVal[tipsType]
  return suspendVal <= DataCenter.popTipsData.suspendVal
end

function UIPopTipsDataUtils.ClearSuspend(sourceType)
  if sourceType then
    local sourceVal = _SuspendVal[sourceType]
    if sourceVal < DataCenter.popTipsData.suspendVal then
      return
    end
  end
  DataCenter.popTipsData.suspendVal = 0
end

function UIPopTipsDataUtils.SetTipDontRemind(tipTid, funcType, dontRemindTime)
  if not tipTid then
    return
  end
  local drTable = MobileFileDataManager.Instance:GetPlayerFileValue(CommonDefine.LocalSaveKey.TipDontRemind)
  if nil == drTable then
    drTable = {}
  end
  drTable[tipTid] = {
    funcType = funcType,
    time = math.floor(dontRemindTime)
  }
  MobileFileDataManager.Instance:SetPlayerFileValue(CommonDefine.LocalSaveKey.TipDontRemind, drTable)
  MobileFileDataManager.Instance:OnSavePlayerFileInfo()
  ClientDataUtils.SetData(cd.ClientDataMainKey.TipsDontMind, tipTid, math.floor(dontRemindTime))
  if funcType then
    ClientDataUtils.SetData(cd.ClientDataMainKey.TipsDontMindFunc, tipTid, funcType)
  end
end

function UIPopTipsDataUtils.GetDontRemindSetting(tipTid)
  local remindTimeOfServer = ClientDataUtils.GetData(cd.ClientDataMainKey.TipsDontMind, tipTid)
  if remindTimeOfServer then
    local funcType = ClientDataUtils.GetData(cd.ClientDataMainKey.TipsDontMindFunc, tipTid)
    return {time = remindTimeOfServer, funcType = funcType}
  end
  local drTable = MobileFileDataManager.Instance:GetPlayerFileValue(CommonDefine.LocalSaveKey.TipDontRemind)
  if nil == drTable then
    return
  end
  return drTable and drTable[tipTid]
end

function UIPopTipsDataUtils.ShallTipRemind(tipTid)
  if not tipTid then
    return false
  end
  local dontRemind
  local tipConfig = DT.TipsType[tipTid]
  local record = UIPopTipsDataUtils.GetDontRemindSetting(tipTid)
  if record and record.time and record.time > 0 then
    local futureDay = tipConfig.DonotRemind or 0
    if futureDay > 0 then
      local refreshTime = TimeUtils.GetFutureTime(futureDay, TimeCfgUtils.ServerRefreshTime_2_Local(), record.time)
      dontRemind = refreshTime > TimeUtils.GetServerTime()
    else
      dontRemind = false
    end
  else
    dontRemind = false
  end
  return dontRemind
end

function UIPopTipsDataUtils.CheckDontRemindSetting()
  local now = TimeUtils.GetServerTime()
  local drTable = MobileFileDataManager.Instance:GetPlayerFileValue(CommonDefine.LocalSaveKey.TipDontRemind)
  if not drTable then
    return
  end
  local isDirty = false
  for tipTid, record in pairs(drTable) do
    if record.time then
      local config = DT.TipsType[tipTid]
      local futureDay = config.DonotRemind
      if futureDay and futureDay >= 1 then
        local refreshTime = TimeUtils.GetFutureTime(futureDay, TimeCfgUtils.ServerRefreshTime_2_Local(), record.time)
        if now >= refreshTime then
          drTable[tipTid] = nil
          if false == isDirty then
            isDirty = true
          end
        end
      else
        drTable[tipTid] = nil
        if false == isDirty then
          isDirty = true
        end
      end
    end
  end
  if isDirty then
    MobileFileDataManager.Instance:SetPlayerFileValue(CommonDefine.LocalSaveKey.TipDontRemind, drTable)
    MobileFileDataManager.Instance:OnSavePlayerFileInfo()
  end
end

return UIPopTipsDataUtils
