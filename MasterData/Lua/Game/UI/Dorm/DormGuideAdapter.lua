local TimerManager = require("GameCore.Timer.TimerManager")
local DormGuideUI = require("Game.UI.Dorm.DormGuideUI")
local DormGuideAdapter = {}
DormGuideAdapter.APPROACH_AVG_ID = "BBm_DormApproach"
DormGuideAdapter.APPROACH_AVG_GROUP = "1"
DormGuideAdapter.ROOM2_ID = 701002
DormGuideAdapter.CHAR_ID = 103
local nAbortCooldown = 3

function DormGuideAdapter._Ctrl()
  return DormGuideUI._objDormCtrl
end

function DormGuideAdapter._Panel()
  local objCtrl = DormGuideAdapter._Ctrl()
  if objCtrl == nil then
    return nil
  end
  return objCtrl._panel
end

function DormGuideAdapter._Editor()
  return DormGuideUI._GetEditorNode()
end

function DormGuideAdapter._Interactive()
  return DormGuideUI._GetInteractiveNode()
end

function DormGuideAdapter._Select()
  return DormGuideUI._GetCharSelectCtrl()
end

function DormGuideAdapter.NodeTr(node)
  if node == nil then
    return nil
  end
  local tr = node.transform
  if tr == nil and node.gameObject ~= nil then
    tr = node.gameObject.transform
  end
  return tr
end

function DormGuideAdapter.GetQuestCardTransform()
  local obj = DormGuideAdapter._Interactive()
  if obj == nil or obj._mapNode == nil then
    return nil
  end
  local mapNode = obj._mapNode
  local btn = mapNode.btnQuestInteractiveSide
  if btn ~= nil then
    local trBtn = DormGuideAdapter.NodeTr(btn)
    if trBtn ~= nil then
      return trBtn
    end
  end
  local rtQuest = mapNode.rtQuest
  if rtQuest == nil then
    return nil
  end
  local trRoot = rtQuest.transform
  if trRoot == nil and rtQuest.gameObject ~= nil then
    trRoot = rtQuest.gameObject.transform
  end
  if trRoot == nil then
    return nil
  end
  local trChild = trRoot:Find("btnQuestInteractiveSide")
  if trChild ~= nil then
    return trChild
  end
  return trRoot
end

function DormGuideAdapter.FindChild(trRoot, sPath)
  if trRoot == nil or sPath == nil then
    return nil
  end
  return trRoot:Find(sPath)
end

function DormGuideAdapter.QuestStatus(nQuestId)
  local mapQuest = PlayerData.Quest:GetDormQuestDataById(nQuestId)
  if mapQuest ~= nil then
    return mapQuest.nStatus
  end
  local objDorm = PlayerData.PlayerDormData
  if objDorm == nil or objDorm.bHasRoomData ~= true or objDorm.mapDromBaseInfo == nil or objDorm.mapDromBaseInfo.TaskGroup == nil then
    return nil
  end
  local nCurGroup = objDorm.mapDromBaseInfo.TaskGroup.Version
  if nCurGroup == nil then
    return nil
  end
  if nCurGroup == 0 then
    return 2
  end
  local mapCfg = ConfigTable.GetData("DormQuest", nQuestId)
  if mapCfg == nil then
    return nil
  end
  if nCurGroup > mapCfg.DormQuestGroup then
    return 2
  end
  if nCurGroup < mapCfg.DormQuestGroup then
    return 0
  end
  return 2
end

function DormGuideAdapter.AnimatorSettled(anim, sStateName)
  if anim == nil or sStateName == nil or anim.GetCurrentAnimatorStateInfo == nil then
    return true
  end
  local ok, bDone = pcall(function()
    if anim:IsInTransition(0) then
      local nextInfo = anim:GetNextAnimatorStateInfo(0)
      if nextInfo:IsName(sStateName) then
        return false
      end
    end
    local info = anim:GetCurrentAnimatorStateInfo(0)
    if info:IsName(sStateName) then
      return info.normalizedTime >= 1 and not anim:IsInTransition(0)
    end
    return true
  end)
  if not ok then
    return true
  end
  return bDone == true
end

function DormGuideAdapter.Mode()
  local objPanel = DormGuideAdapter._Panel()
  if objPanel == nil or objPanel.nCurMode == nil then
    return nil
  end
  return objPanel.nCurMode
end

function DormGuideAdapter.ObserveState()
  local objInteractive = DormGuideAdapter._Interactive()
  if objInteractive == nil or objInteractive.nCurState == nil then
    return nil
  end
  return objInteractive.nCurState
end

function DormGuideAdapter.IsOwnRoom(nRoomId)
  local objPanel = DormGuideAdapter._Panel()
  if objPanel == nil or objPanel.nCurRoom == nil then
    return nil
  end
  if objPanel.nCurMode == 3 then
    return false
  end
  return objPanel.nCurRoom == nRoomId
end

function DormGuideAdapter.RoomKnown(nRoomId)
  local objPanel = DormGuideAdapter._Panel()
  if objPanel == nil or objPanel.mapDormRoomInfo == nil then
    local mapInfo = PlayerData.PlayerDormData.mapDormRoomInfo
    if mapInfo == nil then
      return nil
    end
    return mapInfo[nRoomId] ~= nil
  end
  return objPanel.mapDormRoomInfo[nRoomId] ~= nil
end

function DormGuideAdapter.RoleInRoom(nRoleId)
  local objPanel = DormGuideAdapter._Panel()
  if objPanel == nil or objPanel.mapDormRoomInfo == nil or objPanel.nCurRoom == nil then
    return nil
  end
  local mapRoom = objPanel.mapDormRoomInfo[objPanel.nCurRoom]
  if mapRoom == nil or mapRoom.RoleList == nil then
    return nil
  end
  for _, mapRole in ipairs(mapRoom.RoleList) do
    if mapRole.RoleId == nRoleId then
      return true
    end
  end
  return false
end

function DormGuideAdapter.FurnitureState(nFurnitureId)
  local objPanel = DormGuideAdapter._Panel()
  if objPanel == nil or objPanel.mapDormRoomInfo == nil or objPanel.mapFurnitureBag == nil or objPanel.mapFurnitureUsedCount == nil or objPanel.nCurRoom == nil then
    return "unknown"
  end
  local mapRoom = objPanel.mapDormRoomInfo[objPanel.nCurRoom]
  if mapRoom == nil or mapRoom.FurnitureList == nil then
    return "unknown"
  end
  local bSaved = false
  for _, mapFur in ipairs(mapRoom.FurnitureList) do
    if mapFur.FurnitureId == nFurnitureId then
      bSaved = true
      break
    end
  end
  local nEdit = objPanel.tempEditCount[nFurnitureId]
  if nEdit ~= nil and nEdit ~= 0 then
    return "editing"
  end
  local objEditor = DormGuideAdapter._Editor()
  if objEditor ~= nil and objEditor.nCurEditFurniture == nFurnitureId then
    return "editing"
  end
  if bSaved then
    return "saved"
  end
  return "none"
end

function DormGuideAdapter.CanPlace(nFurnitureId)
  local objPanel = DormGuideAdapter._Panel()
  if objPanel == nil or objPanel.mapFurnitureBag == nil or objPanel.mapFurnitureUsedCount == nil then
    return nil
  end
  if type(objPanel.GetFurnitureCount) ~= "function" then
    return nil
  end
  return 0 < (objPanel:GetFurnitureCount(nFurnitureId) or 0)
end

function DormGuideAdapter.ResolveTab(nFurnitureId)
  local objEditor = DormGuideAdapter._Editor()
  if objEditor == nil or objEditor.tbFurTab1 == nil or objEditor.tbFurTab2 == nil or objEditor.nGuideEditorVer == nil then
    return "unknown", nil, nil
  end
  local mapCfg = ConfigTable.GetData("DormFurniture", nFurnitureId)
  if mapCfg == nil or mapCfg.Tab == nil then
    return "missing", nil, nil
  end
  for i, nTab in ipairs(objEditor.tbFurTab1) do
    if nTab == mapCfg.Tab then
      return "ok", 1, i
    end
  end
  for i, nTab in ipairs(objEditor.tbFurTab2) do
    if nTab == mapCfg.Tab then
      return "ok", 2, i
    end
  end
  return "missing", nil, nil
end

function DormGuideAdapter.EditorReady(nFurnitureId)
  local objEditor = DormGuideAdapter._Editor()
  local nMode = DormGuideAdapter.Mode()
  if nMode ~= 2 or objEditor == nil or objEditor.nGuideEditorVer == nil then
    return false
  end
  local objPanel = DormGuideAdapter._Panel()
  if objPanel ~= nil and objEditor.nGuideEditorRoom ~= nil and objEditor.nGuideEditorRoom ~= objPanel.nCurRoom then
    return false
  end
  local sState = DormGuideAdapter.FurnitureState(nFurnitureId)
  if sState == "unknown" then
    return false
  end
  local sTab = DormGuideAdapter.ResolveTab(nFurnitureId)
  if sTab == "unknown" then
    return false
  end
  return true
end

function DormGuideAdapter.HasPendingSave()
  local objEditor = DormGuideAdapter._Editor()
  if objEditor == nil or objEditor._mapNode == nil or objEditor._mapNode.btnSaveRoom == nil then
    return nil
  end
  local go = objEditor._mapNode.btnSaveRoom.gameObject
  if go == nil then
    return nil
  end
  return go.activeSelf == true
end

function DormGuideAdapter.GiftState()
  local objPanel = DormGuideAdapter._Panel()
  if objPanel == nil or objPanel.mapDormBaseData == nil or type(objPanel.GetDormRewardId) ~= "function" then
    return nil
  end
  local tbReward = objPanel:GetDormRewardId()
  if tbReward == nil then
    return nil
  end
  return 0 < #tbReward
end

function DormGuideAdapter.InContact()
  local objInteractive = DormGuideAdapter._Interactive()
  if objInteractive == nil or objInteractive._mapNode == nil or objInteractive._mapNode.rtContact == nil then
    return false
  end
  return objInteractive._mapNode.rtContact.mapCurCharInfo ~= nil
end

function DormGuideAdapter.ContactRole()
  local objInteractive = DormGuideAdapter._Interactive()
  if objInteractive == nil or objInteractive._mapNode == nil or objInteractive._mapNode.rtContact == nil then
    return nil
  end
  local mapInfo = objInteractive._mapNode.rtContact.mapCurCharInfo
  if mapInfo == nil then
    return nil
  end
  return tonumber(mapInfo.nDataId)
end

function DormGuideAdapter.BeginDormEnter()
  DormGuideAdapter._nEnterGen = (DormGuideAdapter._nEnterGen or 0) + 1
  DormGuideAdapter._mapEnter = {
    nGen = DormGuideAdapter._nEnterGen,
    bLoad = false,
    bTimeline = nil
  }
  return DormGuideAdapter._nEnterGen
end

function DormGuideAdapter.MarkDormLoad()
  if DormGuideAdapter._mapEnter ~= nil then
    DormGuideAdapter._mapEnter.bLoad = true
  end
  DormGuideAdapter.MarkRoomLoaded()
end

function DormGuideAdapter.MarkTimeline(bSuccess)
  if DormGuideAdapter._mapEnter ~= nil and DormGuideAdapter._mapEnter.bTimeline == nil then
    DormGuideAdapter._mapEnter.bTimeline = bSuccess == true
  end
end

function DormGuideAdapter.EnterLoadReady(nGen)
  local mapEnter = DormGuideAdapter._mapEnter
  return mapEnter ~= nil and mapEnter.nGen == nGen and mapEnter.bLoad == true
end

function DormGuideAdapter.TimelineState(nGen)
  local mapEnter = DormGuideAdapter._mapEnter
  if mapEnter == nil or mapEnter.nGen ~= nGen or mapEnter.bLoad ~= true then
    return nil
  end
  return mapEnter.bTimeline
end

function DormGuideAdapter._EnsureSave()
  if DormGuideAdapter._bSaveListen then
    return
  end
  DormGuideAdapter._bSaveListen = true
  EventManager.Add("DormGuide_SaveResult", DormGuideAdapter, DormGuideAdapter._OnSaveResult)
  EventManager.Add("DormGuide_SaveCutsceneEnd", DormGuideAdapter, DormGuideAdapter._OnSaveCutscene)
end

function DormGuideAdapter.BeginSave()
  DormGuideAdapter._EnsureSave()
  local mapCur = DormGuideAdapter._mapSave
  if mapCur ~= nil and mapCur.sPhase == "pending" then
    return mapCur.nId, false
  end
  DormGuideAdapter._nSaveGen = (DormGuideAdapter._nSaveGen or 0) + 1
  DormGuideAdapter._mapSave = {
    nId = DormGuideAdapter._nSaveGen,
    sPhase = "pending",
    bCutscene = false
  }
  return DormGuideAdapter._nSaveGen, true
end

function DormGuideAdapter._OnSaveResult(_, bOk, sKind)
  local mapSave = DormGuideAdapter._mapSave
  if mapSave == nil or mapSave.sPhase ~= "pending" then
    return
  end
  if bOk == true then
    mapSave.sPhase = "done"
    mapSave.sKind = sKind or "done"
    mapSave.bCutscene = true
  else
    mapSave.sPhase = "rejected"
    mapSave.sKind = sKind or "rejected"
  end
end

function DormGuideAdapter._OnSaveCutscene()
  local mapSave = DormGuideAdapter._mapSave
  if mapSave ~= nil then
    mapSave.bCutscene = false
    mapSave.bCutsceneDone = true
  end
end

function DormGuideAdapter.SavePhase(nId)
  local mapSave = DormGuideAdapter._mapSave
  if mapSave == nil or nId ~= nil and mapSave.nId ~= nId then
    return nil
  end
  return mapSave.sPhase
end

function DormGuideAdapter.SaveCutscenePlaying(nId)
  local mapSave = DormGuideAdapter._mapSave
  if mapSave == nil or nId ~= nil and mapSave.nId ~= nId then
    return false
  end
  return mapSave.bCutscene == true and mapSave.bCutsceneDone ~= true
end

function DormGuideAdapter.SaveSettled(nId)
  local mapSave = DormGuideAdapter._mapSave
  if mapSave == nil or mapSave.nId ~= nId then
    return false
  end
  if mapSave.sPhase ~= "done" then
    return false
  end
  if DormGuideAdapter.SaveCutscenePlaying(nId) then
    return false
  end
  local nMode = DormGuideAdapter.Mode()
  return nMode == 0 or nMode == 1
end

function DormGuideAdapter.QuestCardSettled()
  local objCtrl = DormGuideAdapter._Ctrl()
  if objCtrl == nil then
    return false
  end
  return DormGuideAdapter.AnimatorSettled(objCtrl.animator, "DormPanel_in")
end

function DormGuideAdapter.BeginQuest(nQuestId)
  local mapCur = DormGuideAdapter._mapQuest
  if mapCur ~= nil and mapCur.sPhase == "pending" then
    return mapCur.nId, false
  end
  DormGuideAdapter._nQuestGen = (DormGuideAdapter._nQuestGen or 0) + 1
  DormGuideAdapter._mapQuest = {
    nId = DormGuideAdapter._nQuestGen,
    nQuestId = nQuestId,
    sPhase = "pending"
  }
  return DormGuideAdapter._nQuestGen, true
end

function DormGuideAdapter.NoteQuest(nQuestId, bOk)
  local mapQuest = DormGuideAdapter._mapQuest
  if mapQuest == nil or mapQuest.sPhase ~= "pending" then
    return
  end
  if nQuestId ~= nil and mapQuest.nQuestId ~= nil and mapQuest.nQuestId ~= nQuestId then
    return
  end
  mapQuest.sPhase = bOk and "done" or "rejected"
  EventManager.Hit("DormGuide_QuestReceive", mapQuest.nId, mapQuest.nQuestId, bOk == true)
end

function DormGuideAdapter.QuestPhase(nId)
  local mapQuest = DormGuideAdapter._mapQuest
  if mapQuest == nil or nId ~= nil and mapQuest.nId ~= nId then
    return nil
  end
  return mapQuest.sPhase
end

function DormGuideAdapter.BeginCharConfirm()
  local mapCur = DormGuideAdapter._mapChar
  if mapCur ~= nil and mapCur.sPhase == "pending" then
    return mapCur.nId, false
  end
  DormGuideAdapter._nCharGen = (DormGuideAdapter._nCharGen or 0) + 1
  DormGuideAdapter._mapChar = {
    nId = DormGuideAdapter._nCharGen,
    sPhase = "pending",
    bClosed = false
  }
  return DormGuideAdapter._nCharGen, true
end

function DormGuideAdapter.NoteCharResult(bOk)
  local mapChar = DormGuideAdapter._mapChar
  if mapChar == nil or mapChar.sPhase == "done" or mapChar.sPhase == "rejected" then
    return
  end
  mapChar.sPhase = bOk and "accepted" or "rejected"
end

function DormGuideAdapter.NoteCharClosed()
  local mapChar = DormGuideAdapter._mapChar
  if mapChar ~= nil then
    mapChar.bClosed = true
  end
end

function DormGuideAdapter.CharConfirmReady(nId, nRoleId)
  local mapChar = DormGuideAdapter._mapChar
  if mapChar == nil or mapChar.nId ~= nId then
    return false
  end
  if mapChar.sPhase ~= "accepted" then
    return false
  end
  if DormGuideAdapter.RoleInRoom(nRoleId) ~= true then
    return false
  end
  local objSelect = DormGuideAdapter._Select()
  if objSelect ~= nil and objSelect.bOpen == true then
    return false
  end
  local nMode = DormGuideAdapter.Mode()
  return nMode == 0 or nMode == 1
end

function DormGuideAdapter.BeginCaress()
  local mapCur = DormGuideAdapter._mapCaress
  if mapCur ~= nil and (mapCur.sPhase == "accepted" or mapCur.sPhase == "performing" or mapCur.sPhase == "reward" or mapCur.sPhase == "level") then
    return mapCur.nId, false
  end
  DormGuideAdapter._nCaressGen = (DormGuideAdapter._nCaressGen or 0) + 1
  DormGuideAdapter._mapCaress = {
    nId = DormGuideAdapter._nCaressGen,
    sPhase = "opened"
  }
  DormGuideAdapter._nFocusRole = nil
  DormGuideAdapter._nFocusAt = nil
  return DormGuideAdapter._nCaressGen, true
end

function DormGuideAdapter.NoteCaressRejected()
  local mapCaress = DormGuideAdapter._mapCaress
  if mapCaress ~= nil and mapCaress.sPhase == "opened" then
    mapCaress.sPhase = "rejected"
  end
end

function DormGuideAdapter.NoteCaressPhase(sPhase)
  local mapCaress = DormGuideAdapter._mapCaress
  if mapCaress == nil or mapCaress.sPhase == "done" or mapCaress.sPhase == "rejected" then
    return
  end
  mapCaress.sPhase = sPhase
end

function DormGuideAdapter.NoteCaressDone()
  local mapCaress = DormGuideAdapter._mapCaress
  if mapCaress == nil or mapCaress.sPhase == "rejected" then
    return
  end
  mapCaress.sPhase = "done"
  EventManager.Hit("DormGuide_CaressDone", mapCaress.nId)
end

function DormGuideAdapter.WatchPanel(nPanelId)
  local mapCaress = DormGuideAdapter._mapCaress
  if mapCaress == nil then
    return
  end
  mapCaress.nWatchPanel = nPanelId
  if not DormGuideAdapter._bPanelListen then
    DormGuideAdapter._bPanelListen = true
    EventManager.Add("Guide_CloseDisposablePanel", DormGuideAdapter, DormGuideAdapter._OnPanelClose)
  end
end

function DormGuideAdapter._OnPanelClose(_, nPanelId)
  local mapCaress = DormGuideAdapter._mapCaress
  if mapCaress == nil or mapCaress.nWatchPanel ~= nPanelId then
    return
  end
  mapCaress.nWatchPanel = nil
  if mapCaress.sPhase == "level" or mapCaress.sPhase == "reward" then
    DormGuideAdapter.NoteCaressDone()
  end
end

function DormGuideAdapter.CaressPhase(nId)
  local mapCaress = DormGuideAdapter._mapCaress
  if mapCaress == nil or nId ~= nil and mapCaress.nId ~= nId then
    return nil
  end
  return mapCaress.sPhase
end

function DormGuideAdapter.MarkFocus(nRoleId)
  if DormGuideAdapter.ContactRole() ~= nRoleId then
    DormGuideAdapter._nFocusRole = nil
    DormGuideAdapter._nFocusAt = nil
    return false
  end
  if DormGuideAdapter._nFocusRole ~= nRoleId then
    DormGuideAdapter._nFocusRole = nRoleId
    DormGuideAdapter._nFocusAt = TimerManager.GetUnscaledTime()
    return false
  end
  return TimerManager.GetUnscaledTime() - (DormGuideAdapter._nFocusAt or 0) >= 0.7
end

function DormGuideAdapter.BeginRoomEnter(nRoomId, bElevator)
  DormGuideAdapter._nRoomGen = (DormGuideAdapter._nRoomGen or 0) + 1
  DormGuideAdapter._mapRoomEnter = {
    nId = DormGuideAdapter._nRoomGen,
    nRoomId = nRoomId,
    bElevator = bElevator == true,
    bLoaded = false,
    bWalkout = false,
    bConfirm = false
  }
  return DormGuideAdapter._nRoomGen
end

function DormGuideAdapter.NoteRoomConfirm(bOk, nRoomId, bElevator)
  if bOk ~= true then
    local mapEnter = DormGuideAdapter._mapRoomEnter
    if mapEnter ~= nil and mapEnter.bLoaded ~= true then
      mapEnter.sPhase = "rejected"
    end
    return
  end
  if DormGuideAdapter._mapRoomEnter == nil or DormGuideAdapter._mapRoomEnter.bLoaded == true then
    DormGuideAdapter.BeginRoomEnter(nRoomId, bElevator)
  end
  DormGuideAdapter._mapRoomEnter.bConfirm = true
  DormGuideAdapter._mapRoomEnter.nRoomId = nRoomId
  DormGuideAdapter._mapRoomEnter.bElevator = bElevator == true
  DormGuideAdapter._mapRoomEnter.sPhase = "accepted"
end

function DormGuideAdapter.MarkRoomLoaded()
  local mapEnter = DormGuideAdapter._mapRoomEnter
  local objPanel = DormGuideAdapter._Panel()
  if mapEnter == nil or objPanel == nil then
    return
  end
  if objPanel.nCurRoom == mapEnter.nRoomId and objPanel.nCurMode ~= 3 then
    mapEnter.bLoaded = true
  end
  DormGuideAdapter.FlushPassive()
end

function DormGuideAdapter.MarkWalkout()
  if DormGuideAdapter._mapRoomEnter ~= nil then
    DormGuideAdapter._mapRoomEnter.bWalkout = true
  end
  DormGuideAdapter.FlushPassive()
end

function DormGuideAdapter.RoomArrived(nRoomId)
  if DormGuideAdapter.IsOwnRoom(nRoomId) ~= true then
    return false
  end
  local mapEnter = DormGuideAdapter._mapRoomEnter
  if mapEnter == nil or mapEnter.nRoomId ~= nRoomId or mapEnter.sPhase == "rejected" then
    return false
  end
  return mapEnter.bLoaded == true
end

function DormGuideAdapter.RoomEnterReady(nRoomId)
  if DormGuideAdapter.IsOwnRoom(nRoomId) ~= true then
    return false
  end
  local mapEnter = DormGuideAdapter._mapRoomEnter
  if mapEnter == nil or mapEnter.nRoomId ~= nRoomId or mapEnter.bLoaded ~= true then
    return false
  end
  if mapEnter.bElevator and mapEnter.bWalkout ~= true then
    return false
  end
  return true
end

function DormGuideAdapter.NotePassive(sMsg)
  DormGuideAdapter._mapPending = DormGuideAdapter._mapPending or {}
  DormGuideAdapter._nSession = DormGuideAdapter._nSession or 1
  DormGuideAdapter._mapPending[sMsg] = {
    nSession = DormGuideAdapter._nSession
  }
end

function DormGuideAdapter.ClearPending()
  DormGuideAdapter._nSession = (DormGuideAdapter._nSession or 1) + 1
  DormGuideAdapter._mapPending = {}
  if DormGuideAdapter._objFlush ~= nil then
    TimerManager.Remove(DormGuideAdapter._objFlush)
    DormGuideAdapter._objFlush = nil
  end
end

function DormGuideAdapter._PendingValid(sMsg)
  if NovaAPI.GetCurrentModuleName() ~= "DormModuleScene" then
    return false
  end
  if sMsg == "Guide_DormEnterRoom2" then
    return DormGuideAdapter.RoomEnterReady(DormGuideAdapter.ROOM2_ID)
  end
  local nMode = DormGuideAdapter.Mode()
  if nMode == nil or nMode == 2 or nMode == 3 then
    return false
  end
  local PanelManager = require("GameCore.UI.PanelManager")
  if PanelManager.CheckPanelOpen(PanelId.DormQuestPanel) then
    return false
  end
  return true
end

function DormGuideAdapter.FlushPassive()
  if DormGuideAdapter._objFlush ~= nil then
    return
  end
  local nSession = DormGuideAdapter._nSession or 1
  DormGuideAdapter._objFlush = TimerManager.Add(1, 0, DormGuideAdapter, function()
    DormGuideAdapter._objFlush = nil
    if nSession ~= (DormGuideAdapter._nSession or 1) then
      return
    end
    if PlayerData.Guide ~= nil and PlayerData.Guide.isProcessing then
      return
    end
    local mapPending = DormGuideAdapter._mapPending
    if mapPending == nil then
      return
    end
    for sMsg, mapInfo in pairs(mapPending) do
      if mapInfo.nSession ~= nSession or not DormGuideAdapter._PendingValid(sMsg) then
        if mapInfo.nSession ~= nSession then
          mapPending[sMsg] = nil
        end
      else
        mapPending[sMsg] = nil
        EventManager.Hit("Guide_PassiveCheck_Msg", sMsg)
        if PlayerData.Guide ~= nil and PlayerData.Guide.isProcessing then
          break
        end
      end
    end
  end, true, true, true, nil)
end

function DormGuideAdapter.OnGuideReleased()
  DormGuideUI.TryBroadcastEnter()
  DormGuideAdapter.FlushPassive()
end

function DormGuideAdapter.ApplyPolicy(mapPolicy)
  if mapPolicy == nil then
    return
  end
  DormGuideUI._mapShowExcept = mapPolicy.tbShowExcept
  if mapPolicy.bHideChrome then
    DormGuideUI.HideChrome(mapPolicy.bKeepContact == true)
  elseif mapPolicy.bLockLeave then
    DormGuideUI._bLockLeave = true
    DormGuideUI._bHideChrome = false
    DormGuideUI._bKeepContact = mapPolicy.bKeepContact == true
    DormGuideUI._ApplyChrome(false)
    DormGuideUI._ApplyLeaveBtns()
    DormGuideUI._ApplyExtraBtns()
  else
    DormGuideUI._bLockLeave = false
    DormGuideUI._bHideChrome = false
    DormGuideUI._bKeepContact = false
    if not DormGuideAdapter.InContact() then
      DormGuideUI._ApplyChrome(false)
      DormGuideUI._ApplyLeaveBtns()
      DormGuideUI._ApplyExtraBtns()
    end
  end
  if mapPolicy.nSceneCap ~= nil then
    DormGuideUI.SetOwnerCap("guide", mapPolicy.nSceneCap)
  end
  DormGuideUI.SetQuestLock(mapPolicy.bLockQuest == true)
  if DormGuideUI._objParentBarrier ~= nil then
    DormGuideUI._objParentBarrier(mapPolicy.bUiBarrier == true)
  end
end

function DormGuideAdapter.HandOffDormUi()
  DormGuideUI._mapShowExcept = nil
  DormGuideUI._bLockLeave = false
  DormGuideUI._bHideChrome = false
  DormGuideUI._bKeepContact = false
  DormGuideUI.SetOwnerCap("guide", nil)
  DormGuideUI.SetQuestLock(false)
  DormGuideUI._ApplyChrome(false)
  DormGuideUI._ApplyLeaveBtns()
  DormGuideUI._ApplyExtraBtns()
  local objCtrl = DormGuideAdapter._Ctrl()
  if objCtrl ~= nil and objCtrl.bHide ~= true and objCtrl._mapNode ~= nil and objCtrl._mapNode.rtMenu ~= nil then
    objCtrl._mapNode.rtMenu:SetActive(true)
  end
  if DormGuideAdapter.InContact() then
    EventManager.Hit("DormShowInteractiveBtns", false)
  end
end

function DormGuideAdapter.ReleaseGuide()
  DormGuideUI._mapShowExcept = nil
  DormGuideUI._bLockLeave = false
  DormGuideUI._bHideChrome = false
  DormGuideUI._bKeepContact = false
  DormGuideUI.SetOwnerCap("guide", nil)
  DormGuideUI.SetQuestLock(false)
  
  local function RestoreMenu()
    local objCtrl = DormGuideAdapter._Ctrl()
    if objCtrl == nil or objCtrl.bHide == true or objCtrl._mapNode == nil or objCtrl._mapNode.rtMenu == nil then
      return
    end
    objCtrl._mapNode.rtMenu:SetActive(true)
  end
  
  if DormGuideAdapter.InContact() then
    DormGuideAdapter.HandOffDormUi()
    return
  end
  local bShow = DormGuideUI._bBusinessShowBtns ~= false
  local objInteractive = DormGuideAdapter._Interactive()
  if objInteractive ~= nil and objInteractive._mapNode ~= nil and objInteractive._mapNode.rtListHideRoot ~= nil then
    objInteractive._mapNode.rtListHideRoot:SetActive(bShow)
  end
  DormGuideUI._ApplyChrome(false)
  DormGuideUI._ApplyLeaveBtns()
  DormGuideUI._ApplyExtraBtns()
  RestoreMenu()
end

function DormGuideAdapter.ExitEditorOnce()
  if DormGuideAdapter.Mode() ~= 2 then
    return true
  end
  if DormGuideAdapter.HasPendingSave() ~= false then
    return false
  end
  local objCtrl = DormGuideAdapter._Ctrl()
  if objCtrl == nil or type(objCtrl.OnEvent_InteractiveMode) ~= "function" then
    return false
  end
  if not DormGuideAdapter._bExitEditor then
    DormGuideAdapter._bExitEditor = true
    objCtrl:OnEvent_InteractiveMode(true)
  end
  return DormGuideAdapter.Mode() ~= 2
end

function DormGuideAdapter.ResetExitEditor()
  DormGuideAdapter._bExitEditor = false
end

return DormGuideAdapter
