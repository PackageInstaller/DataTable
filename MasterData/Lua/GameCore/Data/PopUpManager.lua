local PopUpManager = {}
local ClientManager = CS.ClientManager.Instance
local LocalData = require("GameCore.Data.LocalData")
local RapidJson = require("rapidjson")
local ModuleManager = require("GameCore.Module.ModuleManager")
local popUpPanelConfig = {}
local _tbPopUpQueue = {}
local _tbPopUpCache = {}
local _popUpCallback
local _bInPopUpQueue = false
local _bInterruptPopUp = false
local _tbSpecifyPopUp = {}
local _tempPopUpMapData = {}
local _interruptPopUpIndex = 0
local _bPauseAfterCurrent = false

function PopUpManager.Init()
  local function foreachPopupSeq(mapData)
    local data = {
      nPanelId = mapData.PanelId,
      
      nSortId = mapData.SortId,
      bLocalSave = mapData.bLocalSave
    }
    popUpPanelConfig[mapData.Type] = data
  end
  
  ForEachTableLine(ConfigTable.Get("PopUpSequence"), foreachPopupSeq)
end

function PopUpManager.InitLoginQueue()
  local sTime = LocalData.GetPlayerLocalData("LoginPanelTime")
  local nTime = tonumber(sTime) or 0
  local nNextTime = ClientManager:GetNextRefreshTime(ClientManager.serverTimeStamp)
  if nTime < nNextTime then
    _tbPopUpQueue = {}
    PopUpManager.SaveLocalData()
  else
    local sJson = LocalData.GetPlayerLocalData("LoginPanelQueue")
    local tb = decodeJson(sJson)
    if type(tb) == "table" then
      _tbPopUpQueue = tb
    end
  end
end

function PopUpManager.SaveLocalData()
  local nNextTime = ClientManager:GetNextRefreshTime(ClientManager.serverTimeStamp)
  local tbLocalSave = {}
  for _, v in ipairs(_tbPopUpQueue) do
    local mapConfig = popUpPanelConfig[v.nType]
    if mapConfig and mapConfig.bLocalSave then
      table.insert(tbLocalSave, v)
    end
  end
  LocalData.SetPlayerLocalData("LoginPanelQueue", RapidJson.encode(tbLocalSave))
  LocalData.SetPlayerLocalData("LoginPanelTime", tostring(nNextTime))
end

function PopUpManager.StartShowPopUp(callback)
  _popUpCallback = callback
  _bInPopUpQueue = true
  PopUpManager.PopUpDeQueue()
end

function PopUpManager.PopUpEnQueue(nType, mapData, bSilent)
  if EditorSettings and EditorSettings.bSkipPopup then
    return
  end
  local bAdded = false
  for nIndex, mapPopUp in ipairs(_tbPopUpQueue) do
    if mapPopUp.nType == nType then
      _tbPopUpQueue[nIndex].mapData = mapData
      bAdded = true
      break
    end
  end
  if not bAdded then
    table.insert(_tbPopUpQueue, {nType = nType, mapData = mapData})
  end
  table.sort(_tbPopUpQueue, function(a, b)
    local cfgA = popUpPanelConfig[a.nType]
    local cfgB = popUpPanelConfig[b.nType]
    local nSortA = cfgA and cfgA.nSortId or 999
    local nSortB = cfgB and cfgB.nSortId or 999
    return nSortA < nSortB
  end)
  if nType == GameEnum.PopUpSeqType.MonthlyCard and PlayerData.Mall:CheckOrderProcess() then
    return
  end
  if not bSilent then
    EventManager.Hit("MainViewCheckOpenPanel")
  end
end

function PopUpManager.PopUpDeQueue()
  local function exitPopUpQueue()
    if _popUpCallback ~= nil then
      _popUpCallback()
    end
    _tbPopUpCache = {}
    _bInPopUpQueue = false
    _bInterruptPopUp = false
    _interruptPopUpIndex = 0
    _bPauseAfterCurrent = false
    EventManager.Hit("Event_MainViewPopUpEnd")
  end
  
  if _bPauseAfterCurrent then
    _bPauseAfterCurrent = false
    _bInterruptPopUp = false
    _interruptPopUpIndex = 0
    _tempPopUpMapData = table.remove(_tbPopUpQueue, 1)
    if _tempPopUpMapData == nil then
      exitPopUpQueue()
      return
    end
  elseif not _bInterruptPopUp and _interruptPopUpIndex == 0 then
    if #_tbPopUpQueue == 0 then
      exitPopUpQueue()
      return
    end
    _tempPopUpMapData = table.remove(_tbPopUpQueue, 1)
  else
    local mapData = _tempPopUpMapData and _tempPopUpMapData.mapData
    if type(mapData) ~= "table" then
      exitPopUpQueue()
      return
    end
    for i = 1, _interruptPopUpIndex do
      table.remove(mapData, 1)
    end
    if #mapData == 0 then
      exitPopUpQueue()
      return
    else
      _tempPopUpMapData.mapData = mapData
    end
  end
  _bInterruptPopUp = false
  _interruptPopUpIndex = 0
  local mapNext = _tempPopUpMapData
  _tbPopUpCache[mapNext.nType] = true
  
  local function callback(funcCall)
    PopUpManager.PopUpDeQueue()
    if nil ~= funcCall then
      funcCall()
    end
  end
  
  local mapConfig = popUpPanelConfig[mapNext.nType]
  if mapConfig == nil then
    printError("PopUpSequence 缺少类型配置:" .. tostring(mapNext.nType))
    callback()
    return
  end
  if mapNext.nType == GameEnum.PopUpSeqType.MessageBox then
    local msg = {
      nType = AllEnum.MessageBox.Alert,
      sContent = mapNext.mapData,
      callbackConfirm = callback
    }
    EventManager.Hit(EventId.OpenMessageBox, msg)
  elseif mapNext.nType == GameEnum.PopUpSeqType.ReengagementAvg then
    PlayerData.Reengagement:PlayReturnAvg(callback)
  elseif mapNext.nType == GameEnum.PopUpSeqType.StarTowerBuildSave then
    PlayerData.State:OpenStarTowerBuildSave(callback)
  elseif mapNext.nType == GameEnum.PopUpSeqType.MainViewGuide then
    EventManager.Hit("UnlockMainViewInput")
    PlayerData.Guide:RunLoginGuide(callback)
  elseif mapNext.nType == GameEnum.PopUpSeqType.NewChat then
    EventManager.Hit(EventId.OpenPanel, mapConfig.nPanelId, mapNext.mapData, false, callback)
  else
    local mapData = {}
    if mapNext.nType == GameEnum.PopUpSeqType.ActivityFaceAnnounce then
      for k, v in pairs(mapNext.mapData) do
        table.insert(mapData, v)
      end
    else
      mapData = mapNext.mapData
    end
    EventManager.Hit(EventId.OpenPanel, mapConfig.nPanelId, mapData, callback)
  end
  if mapConfig.bLocalSave then
    PopUpManager.SaveLocalData()
  end
end

function PopUpManager.InterruptPopUp(index)
  _bInterruptPopUp = true
  _interruptPopUpIndex = index
end

function PopUpManager.PauseAfterCurrent()
  _bInterruptPopUp = true
  _interruptPopUpIndex = 0
  _bPauseAfterCurrent = true
  _tempPopUpMapData = nil
end

function PopUpManager.IsQueueOccupied()
  return _bInPopUpQueue
end

function PopUpManager.ResetInterruptPopUp()
  _bInterruptPopUp = false
  _interruptPopUpIndex = 0
  _bPauseAfterCurrent = false
  _tbPopUpCache = {}
  _bInPopUpQueue = false
end

function PopUpManager.OpenPopUpPanelByType(nType, callback)
  local nRemoveIdx = 0
  for nIdx, data in ipairs(_tbPopUpQueue) do
    if data.nType == nType then
      nRemoveIdx = nIdx
      break
    end
  end
  if nRemoveIdx ~= 0 then
    local mapNext = table.remove(_tbPopUpQueue, nRemoveIdx)
    local mapConfig = popUpPanelConfig[mapNext.nType]
    if mapConfig ~= nil then
      EventManager.Hit(EventId.OpenPanel, mapConfig.nPanelId, mapNext.mapData, callback)
      if mapConfig.bLocalSave then
        PopUpManager.SaveLocalData()
      end
    end
  elseif callback ~= nil then
    callback()
  end
end

function PopUpManager.OpenPopUpPanel(tbType, callback)
  local bInPopUp = PopUpManager.CheckInPopUpQueue()
  if bInPopUp then
    return
  end
  _tbSpecifyPopUp = tbType
  
  local function popUp()
    if #_tbSpecifyPopUp == 0 then
      if callback ~= nil then
        callback()
      end
      return
    end
    local nType = table.remove(_tbSpecifyPopUp, 1)
    PopUpManager.OpenPopUpPanelByType(nType, popUp)
  end
  
  popUp()
end

function PopUpManager.CheckInPopUpQueue()
  return _bInPopUpQueue and not _bInterruptPopUp
end

return PopUpManager
