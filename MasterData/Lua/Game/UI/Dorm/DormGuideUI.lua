local TimerManager = require("GameCore.Timer.TimerManager")
local PanelManager = require("GameCore.UI.PanelManager")
local DormGuideUI = {}
DormGuideUI.InputCap = {
  Pan = 1,
  Rotate = 2,
  Zoom = 4,
  Move = 8,
  PickActor = 16,
  PickFur = 32
}
DormGuideUI.DEFAULT_BLOCK = DormGuideUI.InputCap.Zoom | DormGuideUI.InputCap.PickActor | DormGuideUI.InputCap.PickFur
local nMoveBit = DormGuideUI.InputCap.Move
DormGuideUI._objDormCtrl = nil
DormGuideUI._mapOverlay = {}
DormGuideUI._bLockLeave = false
DormGuideUI._bHideChrome = false
DormGuideUI._bKeepContact = false
DormGuideUI._nInputCap = 0
DormGuideUI._bTriggerEventBound = false
DormGuideUI._bInterceptEventBound = false
DormGuideUI._bPendingRoom2Guide = false
DormGuideUI._nRoom2Timer = nil
DormGuideUI.ROOM2_ID = 701002
DormGuideUI.ROOM2_ENTER_DELAY = 1.5
DormGuideUI.GUIDE_GROUP_ID = {
  [521] = true,
  [522] = true,
  [523] = true,
  [524] = true,
  [525] = true,
  [526] = true,
  [527] = true,
  [528] = true
}

function DormGuideUI.BuildBindPath(tr, sStopName)
  if tr == nil then
    return nil
  end
  local tbName = {}
  while tr ~= nil do
    local sName = tr.name
    table.insert(tbName, 1, sName)
    if sStopName ~= nil and sName == sStopName then
      break
    end
    tr = tr.parent
  end
  if #tbName == 0 then
    return nil
  end
  return table.concat(tbName, "/")
end

function DormGuideUI.GetNodeBindPath(mapNode, sStopName)
  if mapNode == nil then
    return nil
  end
  local tr = mapNode.transform
  if tr == nil then
    return nil
  end
  return DormGuideUI.BuildBindPath(tr, sStopName or "DormPanel")
end

function DormGuideUI._EnsureTriggerEvents()
  if DormGuideUI._bTriggerEventBound then
    return
  end
  DormGuideUI._bTriggerEventBound = true
  EventManager.Add("OnEvent_DormLevelLoadComplete", DormGuideUI, DormGuideUI.OnEvent_DormLevelLoadComplete)
  EventManager.Add("DormRoomSelect_ChangeRoomResult", DormGuideUI, DormGuideUI.OnEvent_ChangeRoomResult)
  EventManager.Add("Guide_CloseDisposablePanel", DormGuideUI, DormGuideUI.OnEvent_CloseDisposablePanel)
  EventManager.Add("DormGuide_ModeApplied", DormGuideUI, DormGuideUI.OnEvent_ModeApplied)
  EventManager.Add("DORM_CS2LUA_BORN_TIMELINE_DONE", DormGuideUI, DormGuideUI.OnEvent_BornTimeline)
end

function DormGuideUI._RemoveTriggerEvents()
  if not DormGuideUI._bTriggerEventBound then
    return
  end
  DormGuideUI._bTriggerEventBound = false
  EventManager.Remove("OnEvent_DormLevelLoadComplete", DormGuideUI, DormGuideUI.OnEvent_DormLevelLoadComplete)
  EventManager.Remove("DormRoomSelect_ChangeRoomResult", DormGuideUI, DormGuideUI.OnEvent_ChangeRoomResult)
  EventManager.Remove("Guide_CloseDisposablePanel", DormGuideUI, DormGuideUI.OnEvent_CloseDisposablePanel)
  EventManager.Remove("DormGuide_ModeApplied", DormGuideUI, DormGuideUI.OnEvent_ModeApplied)
  EventManager.Remove("DORM_CS2LUA_BORN_TIMELINE_DONE", DormGuideUI, DormGuideUI.OnEvent_BornTimeline)
end

function DormGuideUI._EnsureInterceptEvents()
  if DormGuideUI._bInterceptEventBound then
    return
  end
  DormGuideUI._bInterceptEventBound = true
  EventManager.Add("DORM_CS_SET_FUR_HUD", DormGuideUI, DormGuideUI._ApplyExtraBtns)
  EventManager.Add("DORM_CS_SWITCH_FURNITURE", DormGuideUI, DormGuideUI._ApplyExtraBtns)
end

function DormGuideUI._RemoveInterceptEvents()
  if not DormGuideUI._bInterceptEventBound then
    return
  end
  DormGuideUI._bInterceptEventBound = false
  EventManager.Remove("DORM_CS_SET_FUR_HUD", DormGuideUI, DormGuideUI._ApplyExtraBtns)
  EventManager.Remove("DORM_CS_SWITCH_FURNITURE", DormGuideUI, DormGuideUI._ApplyExtraBtns)
end

function DormGuideUI._ApplyInterceptUI()
  if not DormGuideUI._bLockLeave then
    return
  end
  DormGuideUI._EnsureInterceptEvents()
  if DormGuideUI._bHideChrome then
    DormGuideUI._ApplyChrome(true)
  end
  DormGuideUI._ApplyInputCap()
  DormGuideUI._ApplyExtraBtns()
  DormGuideUI._ApplyLeaveBtns()
end

function DormGuideUI._NeedGuide()
  if DormGuideUI._bLockLeave or DormGuideUI._bHideChrome then
    return true
  end
  local objGuide = PlayerData.Guide
  if objGuide ~= nil and objGuide.isProcessing then
    local nRunId = tonumber(objGuide.runGroupId)
    if nRunId ~= nil and DormGuideUI.GUIDE_GROUP_ID[nRunId] then
      return true
    end
  end
  if EditorSettings ~= nil and EditorSettings.bJumpGuide then
    return false
  end
  if objGuide == nil then
    return false
  end
  for nId, _ in pairs(DormGuideUI.GUIDE_GROUP_ID) do
    local mapData = ConfigTable.GetData("GuideGroup", nId)
    if mapData ~= nil and mapData.IsActive and not objGuide:CheckGuideFinishById(nId) then
      return true
    end
  end
  return false
end

function DormGuideUI.Bind(objCtrl)
  DormGuideUI._objDormCtrl = objCtrl
  if not DormGuideUI._NeedGuide() then
    return
  end
  DormGuideUI._EnsureTriggerEvents()
  DormGuideUI._ApplyInterceptUI()
end

function DormGuideUI.Unbind(objCtrl)
  if DormGuideUI._objDormCtrl == nil then
    return
  end
  if objCtrl ~= nil and DormGuideUI._objDormCtrl ~= objCtrl then
    return
  end
  DormGuideUI._RemoveTriggerEvents()
  DormGuideUI._objDormCtrl = nil
end

function DormGuideUI.BindOverlay(sKey, objCtrl)
  if sKey == nil then
    return
  end
  DormGuideUI._mapOverlay[sKey] = objCtrl
end

function DormGuideUI.UnbindOverlay(sKey, objCtrl)
  if sKey == nil then
    return
  end
  if objCtrl ~= nil and DormGuideUI._mapOverlay[sKey] ~= objCtrl then
    return
  end
  DormGuideUI._mapOverlay[sKey] = nil
end

function DormGuideUI._GetOverlay(sKey)
  return DormGuideUI._mapOverlay[sKey]
end

function DormGuideUI.IsLeaveLocked()
  return DormGuideUI._bLockLeave == true
end

function DormGuideUI.IsExtraBtnLocked()
  return DormGuideUI._bLockLeave == true
end

function DormGuideUI.HideChrome(bKeepContact)
  DormGuideUI._bLockLeave = true
  DormGuideUI._bHideChrome = true
  DormGuideUI._bKeepContact = bKeepContact == true
  if DormGuideUI._nInputCap == 0 then
    DormGuideUI._nInputCap = DormGuideUI.DEFAULT_BLOCK
  end
  DormGuideUI._ApplyInterceptUI()
end

function DormGuideUI.ShowAll()
  DormGuideUI._bHideChrome = false
  DormGuideUI._bKeepContact = false
  DormGuideUI._ApplyChrome(false)
  DormGuideUI._ApplyInputCap()
  DormGuideUI._ApplyExtraBtns()
  DormGuideUI._ApplyLeaveBtns()
end

function DormGuideUI.SetOwnerCap(sOwner, nMask)
  DormGuideUI._mapOwnerCap = DormGuideUI._mapOwnerCap or {}
  if nMask == nil then
    DormGuideUI._mapOwnerCap[sOwner] = nil
  else
    DormGuideUI._mapOwnerCap[sOwner] = nMask
  end
  local nCap = 0
  for _, nOne in pairs(DormGuideUI._mapOwnerCap) do
    nCap = nCap | nOne
  end
  DormGuideUI._nInputCap = nCap
  DormGuideUI._ApplyInputCap()
end

function DormGuideUI.SetInputCap(nMask)
  DormGuideUI.SetOwnerCap("guide", nMask or 0)
end

function DormGuideUI.SetQuestLock(bLock)
  DormGuideUI._bQuestLock = bLock == true
  local objQuest = DormGuideUI._GetOverlay("quest")
  if objQuest ~= nil and type(objQuest.SetGuideOperateLock) == "function" then
    objQuest:SetGuideOperateLock(DormGuideUI._bQuestLock)
  end
end

function DormGuideUI.Clear()
  DormGuideUI._bLockLeave = false
  DormGuideUI._bHideChrome = false
  DormGuideUI._bKeepContact = false
  DormGuideUI._mapShowExcept = nil
  DormGuideUI.SetOwnerCap("guide", nil)
  DormGuideUI.SetQuestLock(false)
  local DormGuideAdapter = require("Game.UI.Dorm.DormGuideAdapter")
  if not DormGuideAdapter.InContact() then
    DormGuideUI._ApplyChrome(false)
  end
  DormGuideUI._ApplyExtraBtns()
  DormGuideUI._ApplyLeaveBtns()
  DormGuideUI._RemoveInterceptEvents()
end

function DormGuideUI._CancelRoom2Timer()
  if DormGuideUI._nRoom2Timer ~= nil then
    TimerManager.Remove(DormGuideUI._nRoom2Timer)
    DormGuideUI._nRoom2Timer = nil
  end
end

function DormGuideUI.TryBroadcastEnter()
  if NovaAPI.GetCurrentModuleName() ~= "DormModuleScene" then
    return
  end
  local objCtrl = DormGuideUI._objDormCtrl
  if objCtrl == nil or objCtrl._panel == nil then
    return
  end
  local nMode = objCtrl._panel.nCurMode
  if nMode == 2 or nMode == 3 then
    return
  end
  if PanelManager.CheckPanelOpen(PanelId.DormQuestPanel) then
    return
  end
  EventManager.Hit("Guide_PassiveCheck_Msg", "Guide_DormEnter")
end

function DormGuideUI._TryBroadcastRoom2()
  if not DormGuideUI._bPendingRoom2Guide then
    return
  end
  local objCtrl = DormGuideUI._objDormCtrl
  if objCtrl == nil or objCtrl._panel == nil or objCtrl._panel.nCurRoom ~= DormGuideUI.ROOM2_ID then
    return
  end
  DormGuideUI._bPendingRoom2Guide = false
  DormGuideUI._CancelRoom2Timer()
  DormGuideUI._nRoom2Timer = TimerManager.Add(1, DormGuideUI.ROOM2_ENTER_DELAY, DormGuideUI, function()
    DormGuideUI._nRoom2Timer = nil
    EventManager.Hit("Guide_PassiveCheck_Msg", "Guide_DormEnterRoom2")
  end, true, true, true, nil)
end

function DormGuideUI.OnEvent_DormLevelLoadComplete()
  local DormGuideAdapter = require("Game.UI.Dorm.DormGuideAdapter")
  DormGuideAdapter.MarkDormLoad()
  DormGuideUI.TryBroadcastEnter()
end

function DormGuideUI.OnEvent_ModeApplied()
  DormGuideUI._ApplyInputCap()
end

function DormGuideUI.OnEvent_BornTimeline(_, bSuccess)
  local DormGuideAdapter = require("Game.UI.Dorm.DormGuideAdapter")
  DormGuideAdapter.MarkTimeline(bSuccess)
end

function DormGuideUI.OnEvent_ChangeRoomResult(bConfirm, nRoomId)
  if bConfirm and nRoomId == DormGuideUI.ROOM2_ID then
    local DormGuideAdapter = require("Game.UI.Dorm.DormGuideAdapter")
    DormGuideAdapter.NotePassive("Guide_DormEnterRoom2")
  end
end

function DormGuideUI.OnEvent_CloseDisposablePanel(_, nPanelId)
  if nPanelId ~= PanelId.DormQuestPanel then
    return
  end
  if DormGuideUI._objEnterTimer ~= nil then
    TimerManager.Remove(DormGuideUI._objEnterTimer)
    DormGuideUI._objEnterTimer = nil
  end
  DormGuideUI._objEnterTimer = TimerManager.Add(1, 0, DormGuideUI, function(_, timer)
    if timer ~= nil then
      timer:Cancel(false)
    end
    DormGuideUI._objEnterTimer = nil
    DormGuideUI.TryBroadcastEnter()
  end, true, true, true, nil)
end

function DormGuideUI._GetInteractiveNode()
  local objCtrl = DormGuideUI._objDormCtrl
  if objCtrl == nil or objCtrl._mapNode == nil then
    return nil
  end
  local objInteractive = objCtrl._mapNode.rtInteractiveRoot
  if objInteractive == nil or objInteractive._mapNode == nil then
    return nil
  end
  return objInteractive
end

function DormGuideUI._GetEditorNode()
  local objCtrl = DormGuideUI._objDormCtrl
  if objCtrl == nil or objCtrl._mapNode == nil then
    return nil
  end
  local objEditor = objCtrl._mapNode.rtEditorRoot
  if objEditor == nil or objEditor._mapNode == nil then
    return nil
  end
  return objEditor
end

local function SetNodeActive(node, bOn)
  if node == nil then
    return
  end
  local go = node.gameObject
  if go ~= nil then
    go:SetActive(bOn)
  end
end

function DormGuideUI._GetCharSelectCtrl()
  local objCtrl = DormGuideUI._objDormCtrl
  if objCtrl == nil or objCtrl._mapNode == nil then
    return nil
  end
  return objCtrl._mapNode.CharListRoot
end

function DormGuideUI.PrepareCharSelect(nCharId)
  local objSelect = DormGuideUI._GetCharSelectCtrl()
  if objSelect == nil or not objSelect.bOpen then
    return false
  end
  PlayerData.Filter:Reset({
    AllEnum.ChooseOption.Char_Element,
    AllEnum.ChooseOption.Char_Rarity,
    AllEnum.ChooseOption.Char_PowerStyle,
    AllEnum.ChooseOption.Char_TacticalStyle,
    AllEnum.ChooseOption.Char_AffiliatedForces
  })
  objSelect.tbFilterCfg = {}
  objSelect.bInFavorite = false
  if type(objSelect.RefreshFavoriteTopState) == "function" then
    objSelect:RefreshFavoriteTopState()
  end
  objSelect:Refresh()
  EventManager.Hit("Guide_PositionCharPos", nCharId)
  return true
end

function DormGuideUI.IsCharSelected(nCharId)
  local objSelect = DormGuideUI._GetCharSelectCtrl()
  if objSelect == nil or objSelect.curChar == nil then
    return false
  end
  return table.indexof(objSelect.curChar, nCharId) > 0
end

function DormGuideUI.GetCharGridBindIcon(nCharId)
  local objSelect = DormGuideUI._GetCharSelectCtrl()
  if objSelect == nil or objSelect.mapGridCtrl == nil then
    return nil
  end
  for _, mapCtrl in pairs(objSelect.mapGridCtrl) do
    if mapCtrl.nCharId == nCharId and mapCtrl._mapNode ~= nil and mapCtrl._mapNode.btnGrid ~= nil then
      return DormGuideUI.BuildBindPath(mapCtrl._mapNode.btnGrid.transform, "DormPanel")
    end
  end
  return nil
end

function DormGuideUI.GetCharSelectConfirmBindIcon()
  local objSelect = DormGuideUI._GetCharSelectCtrl()
  if objSelect == nil then
    return nil
  end
  return DormGuideUI.GetNodeBindPath(objSelect._mapNode.btnConfirm, "DormPanel")
end

function DormGuideUI.GetInteractiveBtnPath(sNodeName)
  local objInteractive = DormGuideUI._GetInteractiveNode()
  if objInteractive == nil then
    return nil
  end
  return DormGuideUI.GetNodeBindPath(objInteractive._mapNode[sNodeName], "DormPanel")
end

function DormGuideUI._GetFurnitureCtrl(nFurnitureId)
  local objEditor = DormGuideUI._GetEditorNode()
  if objEditor == nil or objEditor.mapFurnitureCtrl == nil then
    return nil, nil
  end
  for _, mapCtrl in pairs(objEditor.mapFurnitureCtrl) do
    if mapCtrl.nFurnitureId == nFurnitureId and mapCtrl.gameObject ~= nil then
      return objEditor, mapCtrl
    end
  end
  return objEditor, nil
end

function DormGuideUI.GetFurnitureListIndex(nFurnitureId)
  local objEditor = DormGuideUI._GetEditorNode()
  if objEditor == nil or objEditor.nCurMainTab == 3 or objEditor.mapFurnitureType == nil then
    return nil
  end
  local nCurTabIdx = objEditor.nCurMainTab == 1 and objEditor.tbFurTab1[objEditor.nCurFurniturTab1] or objEditor.tbFurTab2[objEditor.nCurFurniturTab2]
  local tbCurTab = objEditor.mapFurnitureType[nCurTabIdx]
  if tbCurTab == nil then
    return nil
  end
  local nIdx = table.indexof(tbCurTab, nFurnitureId)
  if nIdx == nil or nIdx <= 0 then
    return nil
  end
  return nIdx
end

function DormGuideUI.PositionFurniture(nFurnitureId)
  local objEditor = DormGuideUI._GetEditorNode()
  if objEditor == nil or objEditor._mapNode == nil or objEditor._mapNode.svFurniture == nil then
    return false
  end
  local nIdx = DormGuideUI.GetFurnitureListIndex(nFurnitureId)
  if nIdx == nil then
    return false
  end
  objEditor._mapNode.svFurniture:SetScrollGridPos(nIdx - 1, 0, 0)
  return true
end

function DormGuideUI.ClickFurniture(nFurnitureId)
  local objEditor, mapCtrl = DormGuideUI._GetFurnitureCtrl(nFurnitureId)
  local nIdx = DormGuideUI.GetFurnitureListIndex(nFurnitureId)
  if objEditor == nil or mapCtrl == nil or nIdx == nil then
    return false
  end
  objEditor:OnFurnitureBtnClickGrid(mapCtrl.gameObject, nIdx - 1)
  return true
end

function DormGuideUI.GetFurnitureBindIcon(nFurnitureId)
  local _, mapCtrl = DormGuideUI._GetFurnitureCtrl(nFurnitureId)
  if mapCtrl == nil then
    return nil
  end
  local tr
  if mapCtrl._mapNode ~= nil and mapCtrl._mapNode.rtContent ~= nil then
    tr = mapCtrl._mapNode.rtContent.transform
  elseif mapCtrl.gameObject ~= nil then
    tr = mapCtrl.gameObject.transform
  end
  if tr == nil then
    return nil
  end
  return DormGuideUI.BuildBindPath(tr, "DormPanel")
end

function DormGuideUI.GetSaveBindIcon()
  local objEditor = DormGuideUI._GetEditorNode()
  if objEditor == nil then
    return nil
  end
  return DormGuideUI.GetNodeBindPath(objEditor._mapNode.btnSaveRoom, "DormPanel")
end

function DormGuideUI.GetHudConfirmBindIcon()
  local objEditor = DormGuideUI._GetEditorNode()
  if objEditor == nil or objEditor._mapNode == nil then
    return nil
  end
  local node = objEditor._mapNode.btnHudCancel or objEditor._mapNode.btnHudConfirm
  return DormGuideUI.GetNodeBindPath(node, "DormPanel")
end

function DormGuideUI.ClickHudConfirm()
  local objEditor = DormGuideUI._GetEditorNode()
  if objEditor == nil or type(objEditor.OnBtnClick_ExitEditor) ~= "function" then
    return false
  end
  objEditor:OnBtnClick_ExitEditor()
  return true
end

function DormGuideUI.GetRewardHudBindIcon(nFurId)
  local objInteractive = DormGuideUI._GetInteractiveNode()
  if objInteractive == nil or objInteractive.mapHudCtrls == nil then
    return nil
  end
  for _, mapCtrl in pairs(objInteractive.mapHudCtrls) do
    if mapCtrl.nFurId == nFurId and mapCtrl._mapNode ~= nil and mapCtrl._mapNode.btnFurnitureIcon ~= nil then
      return DormGuideUI.BuildBindPath(mapCtrl._mapNode.btnFurnitureIcon.transform, "DormPanel")
    end
  end
  return nil
end

function DormGuideUI.IsTargetCharInteractive(nRoleId)
  local objInteractive = DormGuideUI._GetInteractiveNode()
  if objInteractive == nil or objInteractive._mapNode == nil or objInteractive._mapNode.rtContact == nil then
    return false
  end
  local mapInfo = objInteractive._mapNode.rtContact.mapCurCharInfo
  if mapInfo == nil then
    return false
  end
  return tonumber(mapInfo.nDataId) == nRoleId
end

function DormGuideUI.GetCharCaressBindIcon(nRoleId)
  if not DormGuideUI.IsTargetCharInteractive(nRoleId) then
    return nil
  end
  local objContact = DormGuideUI._GetInteractiveNode()._mapNode.rtContact
  if objContact._mapNode == nil or objContact._mapNode.btnInteractive1 == nil then
    return nil
  end
  return DormGuideUI.GetNodeBindPath(objContact._mapNode.btnInteractive1, "DormPanel")
end

function DormGuideUI.ClickCharCaress()
  local objInteractive = DormGuideUI._GetInteractiveNode()
  if objInteractive == nil or objInteractive._mapNode == nil or objInteractive._mapNode.rtContact == nil then
    return false
  end
  local objContact = objInteractive._mapNode.rtContact
  if type(objContact.OnBtnClick_Interactive1) ~= "function" then
    return false
  end
  objContact:OnBtnClick_Interactive1()
  return true
end

function DormGuideUI.GetCharTalkBindIcon(nRoleId)
  local objInteractive = DormGuideUI._GetInteractiveNode()
  if objInteractive == nil or objInteractive._mapNode.rtContact == nil then
    return nil
  end
  local objContact = objInteractive._mapNode.rtContact
  if objContact.mapListBtn == nil then
    return nil
  end
  for _, mapBtn in pairs(objContact.mapListBtn) do
    if mapBtn.nDataId == nRoleId and mapBtn.nType ~= 1 and mapBtn.goItem ~= nil then
      local tr = mapBtn.goItem.transform
      if tr ~= nil then
        return DormGuideUI.BuildBindPath(tr, "DormPanel")
      end
    end
  end
  return nil
end

function DormGuideUI.GetReceiveBindIcon(nQuestId)
  local objInst = DormGuideUI._GetOverlay("quest")
  if objInst == nil or objInst._mapCtrl == nil then
    return nil
  end
  for _, objCtrl in pairs(objInst._mapCtrl) do
    if objCtrl.mapDormQuest ~= nil and objCtrl.mapDormQuest.nTid == nQuestId and objCtrl._mapNode ~= nil and objCtrl._mapNode.btnReceive ~= nil then
      return DormGuideUI.BuildBindPath(objCtrl._mapNode.btnReceive.transform, "DormQuestPanel")
    end
  end
  return nil
end

function DormGuideUI.HasRoom(nRoomId)
  local objCtrl = DormGuideUI._objDormCtrl
  if objCtrl ~= nil and objCtrl._panel ~= nil and objCtrl._panel.mapDormRoomInfo ~= nil then
    return objCtrl._panel.mapDormRoomInfo[nRoomId] ~= nil
  end
  local mapInfo = PlayerData.PlayerDormData.mapDormRoomInfo
  return mapInfo ~= nil and mapInfo[nRoomId] ~= nil
end

function DormGuideUI.GetRoomGoBindIcon(nRoomId)
  local objInst = DormGuideUI._GetOverlay("roomSelect")
  if objInst == nil or objInst.mapGridCtrl == nil then
    return nil
  end
  for _, objCtrl in pairs(objInst.mapGridCtrl) do
    if objCtrl.nRoomId == nRoomId and objCtrl._mapNode ~= nil and objCtrl._mapNode.btnGo ~= nil and objCtrl._mapNode.btnGo.gameObject.activeInHierarchy then
      return DormGuideUI.BuildBindPath(objCtrl._mapNode.btnGo.transform, "DormRoomSelectPanel")
    end
  end
  return nil
end

function DormGuideUI.IsObserveMode()
  local objInteractive = DormGuideUI._GetInteractiveNode()
  if objInteractive == nil then
    return false
  end
  return objInteractive.nCurState == 1
end

function DormGuideUI.GetFurnitureCount(nFurnitureId)
  local objCtrl = DormGuideUI._objDormCtrl
  if objCtrl == nil or objCtrl._panel == nil then
    return 0
  end
  if type(objCtrl._panel.GetFurnitureCount) ~= "function" then
    return 0
  end
  return objCtrl._panel:GetFurnitureCount(nFurnitureId) or 0
end

function DormGuideUI.GetEditorBtnPath(sNodeName, nIdx)
  local objEditor = DormGuideUI._GetEditorNode()
  if objEditor == nil or objEditor._mapNode == nil then
    return nil
  end
  local node = objEditor._mapNode[sNodeName]
  if node == nil then
    return nil
  end
  if nIdx ~= nil then
    node = node[nIdx]
  end
  return DormGuideUI.GetNodeBindPath(node, "DormPanel")
end

function DormGuideUI.ResolveFurnitureTab(nFurnitureId)
  local objEditor = DormGuideUI._GetEditorNode()
  if objEditor == nil then
    return nil, nil
  end
  local nMainTab = 1
  local nSubIdx = 1
  local mapCfg = ConfigTable.GetData("DormFurniture", nFurnitureId)
  local nType = mapCfg ~= nil and mapCfg.Tab or nil
  
  local function FindIn(tb)
    if tb == nil or nType == nil then
      return nil
    end
    for i, nTab in ipairs(tb) do
      if nTab == nType then
        return i
      end
    end
    return nil
  end
  
  local nIdx = FindIn(objEditor.tbFurTab1)
  if nIdx ~= nil then
    return 1, nIdx
  end
  nIdx = FindIn(objEditor.tbFurTab2)
  if nIdx ~= nil then
    return 2, nIdx
  end
  return nMainTab, nSubIdx
end

function DormGuideUI.EnsureFurnitureTab(nFurnitureId)
  local nMainTab, nSubIdx = DormGuideUI.ResolveFurnitureTab(nFurnitureId)
  local objEditor = DormGuideUI._GetEditorNode()
  if objEditor == nil or nMainTab == nil then
    return false
  end
  if objEditor.nCurMainTab ~= nMainTab then
    objEditor:OnBtnClick_MainTabTog(nil, nMainTab)
  end
  if nMainTab == 1 and objEditor.nCurFurniturTab1 ~= nSubIdx then
    objEditor:OnBtnClick_FurnitureTabTog(nil, nSubIdx)
  elseif nMainTab == 2 and objEditor.nCurFurniturTab2 ~= nSubIdx then
    objEditor:OnBtnClick_FurnitureTabTog(nil, nSubIdx)
  end
  return true
end

function DormGuideUI._ApplyChrome(bHide)
  local objInteractive = DormGuideUI._GetInteractiveNode()
  if objInteractive == nil then
    return
  end
  local mapNode = objInteractive._mapNode
  if mapNode.rtListHideRoot ~= nil then
    mapNode.rtListHideRoot:SetActive(true)
  end
  if mapNode.rtInteractiveHide ~= nil then
    mapNode.rtInteractiveHide:SetActive(not bHide)
  end
  if bHide then
    SetNodeActive(mapNode.rtQuest, false)
    local bGiftExcept = DormGuideUI._mapShowExcept ~= nil and DormGuideUI._mapShowExcept.rtGiftHint == true
    local bGiftOn = false
    if bGiftExcept and objInteractive._panel ~= nil and type(objInteractive._panel.GetDormRewardId) == "function" then
      local tbRewardIds = objInteractive._panel:GetDormRewardId()
      bGiftOn = tbRewardIds ~= nil and 0 < #tbRewardIds
    end
    SetNodeActive(mapNode.rtGiftHint, bGiftOn)
    SetNodeActive(mapNode.rtGiftNumHint, bGiftOn)
    SetNodeActive(mapNode.rtDormName, false)
    if mapNode.rtContact ~= nil then
      mapNode.rtContact.gameObject:SetActive(DormGuideUI._bKeepContact == true)
    end
  else
    if type(objInteractive.SetQuestInfo) == "function" then
      objInteractive:SetQuestInfo()
    end
    local bGiftExcept = DormGuideUI._mapShowExcept ~= nil and DormGuideUI._mapShowExcept.rtGiftHint == true
    local bGiftOn = false
    if (not DormGuideUI._bLockLeave or bGiftExcept) and objInteractive._panel ~= nil and type(objInteractive._panel.GetDormRewardId) == "function" then
      local tbRewardIds = objInteractive._panel:GetDormRewardId()
      bGiftOn = tbRewardIds ~= nil and 0 < #tbRewardIds
    end
    SetNodeActive(mapNode.rtGiftHint, bGiftOn)
    SetNodeActive(mapNode.rtGiftNumHint, bGiftOn)
    SetNodeActive(mapNode.rtDormName, not DormGuideUI._bLockLeave)
    if mapNode.rtContact ~= nil then
      mapNode.rtContact.gameObject:SetActive(true)
    end
  end
end

function DormGuideUI._ApplyInputCap()
  NovaAPI.DispatchEventWithData("DORM_LUA_SET_UI_HIDDEN", nil, {
    DormGuideUI._nInputCap
  })
  local objInteractive = DormGuideUI._GetInteractiveNode()
  if objInteractive == nil then
    return
  end
  local goJoystick = objInteractive._mapNode.goJoystick
  if goJoystick == nil then
    return
  end
  local bMoveBlocked = DormGuideUI._nInputCap & nMoveBit ~= 0
  if DormGuideUI._bHideChrome then
    goJoystick:SetActive(not bMoveBlocked)
  else
    goJoystick:SetActive(true)
  end
end

function DormGuideUI._ApplyExtraBtns()
  local bShow = not DormGuideUI.IsExtraBtnLocked()
  local objInteractive = DormGuideUI._GetInteractiveNode()
  if objInteractive ~= nil then
    local mapNode = objInteractive._mapNode
    SetNodeActive(mapNode.btnHideUI, bShow)
    SetNodeActive(mapNode.btnInteractive, bShow)
  end
  local objEditor = DormGuideUI._GetEditorNode()
  if objEditor ~= nil then
    local mapNode = objEditor._mapNode
    SetNodeActive(mapNode.btnHudRotation, bShow)
    SetNodeActive(mapNode.btnHudDelete, bShow)
  end
end

function DormGuideUI._ApplyLeaveBtns()
  local objCtrl = DormGuideUI._objDormCtrl
  if objCtrl == nil or objCtrl._mapNode == nil then
    return
  end
  local bOn = not DormGuideUI.IsLeaveLocked()
  local btnBack = objCtrl._mapNode.btnBackMain
  if btnBack ~= nil then
    btnBack.interactable = bOn
    if btnBack.gameObject ~= nil then
      btnBack.gameObject:SetActive(bOn)
    end
  end
  local btnHome = objCtrl._mapNode.btnHomeMain
  if btnHome ~= nil then
    btnHome.interactable = bOn
    if btnHome.gameObject ~= nil then
      btnHome.gameObject:SetActive(bOn)
    end
  end
end

return DormGuideUI
