local TimerManager = require("GameCore.Timer.TimerManager")
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
local ClientMgr = CS.ClientManager
local AdventureModuleHelper = CS.AdventureModuleHelper
local PanelManager = {}
local mapUIRootTransform, mapDefinePanel, objCurPanel, objNextPanel, tbBackHistory, tbDisposablePanel, trSnapshotParent, tbTemplateSnapshot, nThresholdHistoryPanelCount, objTransitionPanel, bMainViewSkipAnimIn
local nInputRC = 0
local tbGoSnapShot, objPlayerInfoPanel

local function OnClearRequiredLua(listener, strPath)
  printLog("[Lua重载] 清除了：" .. strPath)
  package.loaded[strPath] = nil
end

local function TakeSnapshot(nType)
  local goSnapshotIns
  if nType <= 0 or tbTemplateSnapshot == nil then
    return goSnapshotIns
  end
  local goT = tbTemplateSnapshot[nType]
  if goT ~= nil and goT:IsNull() == false then
    goSnapshotIns = instantiate(goT, trSnapshotParent)
    goSnapshotIns:SetActive(true)
    local goUIEffectSnapshot
    if nType == 1 or nType == 3 or nType == 4 then
      goUIEffectSnapshot = goSnapshotIns.transform:GetChild(0).gameObject
    else
      goUIEffectSnapshot = goSnapshotIns
    end
    NovaAPI.UIEffectSnapShotCapture(goUIEffectSnapshot)
  end
  return goSnapshotIns
end

local function GetPanelName(nPanelId)
  for k, v in pairs(PanelId) do
    if v == nPanelId then
      return k
    end
  end
end

local function AddTbGoSnapShot(panel, goIns)
  if Settings.bDestroyHistoryUIInstance then
    if tbGoSnapShot == nil then
      tbGoSnapShot = {}
    end
    if goIns ~= nil then
      local nInstanceId = goIns:GetInstanceID()
      panel._nGoBlurInsId = nInstanceId
      if tbGoSnapShot[panel._nPanelId] == nil then
        tbGoSnapShot[panel._nPanelId] = {}
      end
      tbGoSnapShot[panel._nPanelId][nInstanceId] = {goIns = goIns, bMove = false}
    end
  end
end

local function MoveSnapShot(panel)
  if panel == nil then
    return
  end
  local nPanelId = panel._nPanelId
  local goInsId = panel._nGoBlurInsId
  if Settings.bDestroyHistoryUIInstance and tbGoSnapShot[nPanelId] ~= nil and tbGoSnapShot[nPanelId][goInsId] ~= nil then
    tbGoSnapShot[nPanelId][goInsId].bMove = true
    tbGoSnapShot[nPanelId][goInsId].goIns.gameObject.transform:SetParent(trSnapshotParent)
  end
end

local function GetSnapShot(panel)
  if panel == nil then
    return
  end
  local nPanelId = panel._nPanelId
  local goInsId = panel._nGoBlurInsId
  if Settings.bDestroyHistoryUIInstance and tbGoSnapShot[nPanelId] ~= nil and tbGoSnapShot[nPanelId][goInsId] ~= nil then
    tbGoSnapShot[nPanelId][goInsId].bMove = false
    tbGoSnapShot[nPanelId][goInsId].goIns.gameObject:SetActive(true)
    return tbGoSnapShot[nPanelId][goInsId].goIns
  end
end

local function HideMoveSnapshot()
  if Settings.bDestroyHistoryUIInstance and tbGoSnapShot ~= nil then
    for _, v in pairs(tbGoSnapShot) do
      for insId, data in pairs(v) do
        if data.bMove and data.goIns ~= nil then
          data.goIns.gameObject:SetActive(false)
        end
      end
    end
  end
end

local function RemoveTbSnapShot(panel)
  if panel == nil then
    return
  end
  local nPanelId = panel._nPanelId
  local goInsId = panel._nGoBlurInsId
  if Settings.bDestroyHistoryUIInstance and tbGoSnapShot[nPanelId] ~= nil and tbGoSnapShot[nPanelId][goInsId] ~= nil then
    local goIns = tbGoSnapShot[nPanelId][goInsId].goIns
    if goIns ~= nil then
      destroy(goIns)
    end
    tbGoSnapShot[nPanelId][goInsId] = nil
  end
end

local function CheckThresholdCount()
  if nThresholdHistoryPanelCount == nil then
    nThresholdHistoryPanelCount = ConfigTable.GetConfigNumber("MaxHistoryPanel")
  end
  local nCurCount = #tbBackHistory
  if nCurCount > nThresholdHistoryPanelCount then
    local nDelCount = nCurCount - nThresholdHistoryPanelCount
    local tbNeedRemovePanelIndex = {}
    for i = 1, nCurCount do
      if tbBackHistory[i]._nPanelId ~= PanelId.MainView then
        table.insert(tbNeedRemovePanelIndex, i)
        nDelCount = nDelCount - 1
        if nDelCount <= 0 then
          break
        end
      end
    end
    nDelCount = #tbNeedRemovePanelIndex
    if nDelCount == nCurCount - nThresholdHistoryPanelCount then
      for i = nDelCount, 1, -1 do
        local nPanelIndex = tbNeedRemovePanelIndex[i]
        RemoveTbSnapShot(tbBackHistory[nPanelIndex])
        tbBackHistory[nPanelIndex]:_Exit()
        tbBackHistory[nPanelIndex]:_Destroy()
        table.remove(tbBackHistory, nPanelIndex)
      end
    end
  end
end

local function DoBackToTarget(nTargetIndex)
  if type(nTargetIndex) ~= "number" then
    nTargetIndex = 1
  end
  local nCount = #tbBackHistory
  if nTargetIndex < nCount and objCurPanel ~= nil then
    local function func_PreExitDone()
      if objCurPanel._bAddToBackHistory == true then
        table.remove(tbBackHistory, nCount)
      end
      nCount = #tbBackHistory
      for i = nCount, nTargetIndex + 1, -1 do
        local objPanel = tbBackHistory[i]
        RemoveTbSnapShot(objPanel)
        objPanel:_PreExit()
        objPanel:_Exit()
        objPanel:_Destroy()
        table.remove(tbBackHistory, i)
      end
      local objBackPanel = tbBackHistory[nTargetIndex]
      if type(objBackPanel.Awake) == "function" then
        objBackPanel:Awake()
      end
      local goSnapshot = GetSnapShot(objBackPanel)
      objBackPanel:_PreEnter(nil, goSnapshot)
      objCurPanel:_Exit()
      objBackPanel:_Enter()
      objCurPanel:_Destroy()
      objCurPanel = objBackPanel
      printLog("[界面切换] 已返回至历史队列指定的索引：" .. tostring(nTargetIndex) .. "，界面：" .. GetPanelName(objCurPanel._nPanelId))
    end
    
    objCurPanel:_PreExit(func_PreExitDone, true)
  end
  PanelManager.CloseAllDisposablePanel()
end

local function CloseCurPanel()
  local nLastIndex = #tbBackHistory
  if objCurPanel == nil then
    return
  end
  if objCurPanel._bAddToBackHistory ~= true or objCurPanel._bAddToBackHistory == true and 1 < nLastIndex then
    local function func_DoBack()
      if objCurPanel._bAddToBackHistory == true then
        table.remove(tbBackHistory, nLastIndex)
      end
      nLastIndex = #tbBackHistory
      local objBackPanel = tbBackHistory[nLastIndex]
      local goSnapshot = GetSnapShot(objBackPanel)
      objBackPanel:_PreEnter(nil, goSnapshot)
      objCurPanel:_Exit()
      objBackPanel:_Enter()
      objCurPanel:_Destroy()
      objCurPanel = objBackPanel
      objCurPanel:_AfterEnter()
      printLog("[界面切换] 已完成：关闭当前并打开历史队列的最后一个， 当前打开的界面：" .. GetPanelName(objCurPanel._nPanelId))
    end
    
    RemoveTbSnapShot(objCurPanel)
    objCurPanel:_PreExit(func_DoBack, true)
  end
end

local function ClosePanel(nPanelId)
  if objCurPanel ~= nil then
    if objCurPanel._nPanelId == nPanelId then
      CloseCurPanel()
    else
      local nCount = #tbBackHistory
      for i = nCount, 1, -1 do
        local objPanel = tbBackHistory[i]
        if objPanel._nPanelId == nPanelId then
          table.remove(tbBackHistory, i)
          objPanel:_Destroy()
          RemoveTbSnapShot(objPanel)
          objPanel = nil
          printLog("[界面切换] 仅关闭指定的界面：" .. GetPanelName(nPanelId))
          break
        end
      end
    end
  end
end

local function OnClosePanel(listener, nPanelId)
  if objNextPanel ~= nil then
    printError("[界面切换] 关闭界面：" .. GetPanelName(nPanelId) .. " 失败，上一次界面切换流程尚未完成，正在处理：" .. GetPanelName(objNextPanel._nPanelId))
    return
  end
  if type(nPanelId) == "number" then
    local bIsMainPanel = true
    if type(tbDisposablePanel) == "table" then
      local nCount = #tbDisposablePanel
      for i = nCount, 1, -1 do
        local objPanel = tbDisposablePanel[i]
        if objPanel._nPanelId == nPanelId then
          EventManager.Hit("Guide_CloseDisposablePanel", nPanelId)
          objPanel:_PreExit()
          objPanel:_Exit()
          objPanel:_Destroy()
          table.remove(tbDisposablePanel, i)
          RemoveTbSnapShot(objPanel)
          bIsMainPanel = false
          printLog("[界面切换] 关闭了非主 Panel 界面：" .. GetPanelName(nPanelId))
          break
        end
      end
    end
    if bIsMainPanel == true then
      ClosePanel(nPanelId)
    end
  end
end

local function OnCloseCurPanel(listener)
  if objCurPanel ~= nil and objCurPanel._bIsMainPanel == true then
    CloseCurPanel()
  end
end

local function EnterNext()
  objNextPanel:_Enter(true)
  if objCurPanel ~= nil then
    if objCurPanel._bAddToBackHistory == true then
      objCurPanel:_SetPrefabInstance(Settings.bDestroyHistoryUIInstance)
    else
      objCurPanel:_Destroy()
    end
  end
  objCurPanel = objNextPanel
  objNextPanel = nil
  objCurPanel:_AfterEnter()
  printLog("[界面切换] 完成，当前界面：" .. tostring(objCurPanel._nPanelId) .. ", " .. GetPanelName(objCurPanel._nPanelId))
end

local function ExitCurrent()
  if objCurPanel == nil then
    EnterNext()
  else
    objCurPanel:_Exit()
    EnterNext()
  end
end

local function PreEnterNext()
  local goSnapshot = TakeSnapshot(objNextPanel._nSnapshotPrePanel)
  AddTbGoSnapShot(objNextPanel, goSnapshot)
  cs_coroutine.start(function()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    objNextPanel:_PreEnter(ExitCurrent, goSnapshot)
    HideMoveSnapshot()
  end)
end

local function PreExitCurrent()
  if objCurPanel == nil then
    PreEnterNext()
  else
    MoveSnapShot(objCurPanel)
    objCurPanel:_PreExit(PreEnterNext, true)
  end
end

local function OpenPanel(nPanelId, mapOpenContext, ...)
  if objNextPanel ~= nil then
    printError("[界面切换] 打开界面：" .. GetPanelName(nPanelId) .. " 失败，上一次界面切换流程尚未完成，正在处理：" .. GetPanelName(objNextPanel._nPanelId))
    return
  end
  if nPanelId == PanelId.MainView and 0 < #tbBackHistory then
    EventManager.Hit(EventId.CloesCurPanel)
    return
  end
  if objCurPanel ~= nil and objCurPanel._nPanelId == nPanelId then
    return
  end
  local luaClass = require(mapDefinePanel[nPanelId])
  local tbParameter = {}
  for i = 1, select("#", ...) do
    local param = select(i, ...)
    table.insert(tbParameter, param)
  end
  local nIndex = 1
  if objCurPanel ~= nil then
    nIndex = objCurPanel._nIndex + 1
  end
  local objTempPanel = luaClass.new(nIndex, nPanelId, tbParameter)
  if mapOpenContext ~= nil then
    objTempPanel._nSortingOrderBase = mapOpenContext.nSortingOrderBase
  end
  if objTempPanel._bIsMainPanel == true then
    objNextPanel = objTempPanel
    if objNextPanel._bAddToBackHistory == true then
      table.insert(tbBackHistory, objNextPanel)
    end
    PreExitCurrent()
  else
    local _bHasOpenTips = false
    for i, v in ipairs(tbDisposablePanel) do
      if _bHasOpenTips == false then
        _bHasOpenTips = UTILS.CheckIsTipsPanel(v._nPanelId)
      end
      if v._nPanelId == nPanelId and nPanelId ~= PanelId.ReceivePropsTips then
        MoveSnapShot(v)
        objTempPanel:_PreExit()
        objTempPanel:_Exit()
        objTempPanel:_Destroy()
        objTempPanel = nil
        printWarn("[界面切换] 打开非主 Panel：" .. GetPanelName(nPanelId) .. " 失败，不能重复打开。")
        return
      end
    end
    objTempPanel._nIndex = objTempPanel._nIndex + #tbDisposablePanel
    objTempPanel._bIsExtraTips = _bHasOpenTips
    local goSnapshot = TakeSnapshot(objTempPanel._nSnapshotPrePanel)
    objTempPanel:_PreEnter(nil, goSnapshot)
    objTempPanel:_Enter()
    table.insert(tbDisposablePanel, objTempPanel)
    printLog("[界面切换] 打开非主 Panel：" .. GetPanelName(nPanelId) .. "成功。")
  end
  CheckThresholdCount()
end

local function OnOpenPanel(listener, nPanelId, ...)
  OpenPanel(nPanelId, nil, ...)
end

function PanelManager.OpenPanelWithContext(nPanelId, mapOpenContext, ...)
  OpenPanel(nPanelId, mapOpenContext, ...)
end

local function OnOpenLoading(listener, objTarget, callbackUpdate, callbackDone)
  if objTarget == nil or type(callbackUpdate) == "function" then
  else
  end
end

local function OnBlockInput(listener, bEnable)
  if bEnable == true then
    ClientMgr.Instance:EnableInputBlock()
  else
    ClientMgr.Instance:DisableInputBlock()
  end
end

local function OnTemporaryBlockInput(listener, nDuration, callback)
  if 0 < nDuration then
    local function timerCallback()
      OnBlockInput(PanelManager, false)
      
      if type(callback) == "function" then
        callback()
      end
    end
    
    OnBlockInput(PanelManager, true)
    TimerManager.Add(1, nDuration, PanelManager, timerCallback, true, true, true)
  end
end

local function OnMarkCurCanvasFullRectWH()
  if trSnapshotParent ~= nil and trSnapshotParent:IsNull() == false then
    local rt = trSnapshotParent:GetComponent("RectTransform")
    Settings.CURRENT_CANVAS_FULL_RECT_WIDTH = rt.rect.width
    Settings.CURRENT_CANVAS_FULL_RECT_HEIGHT = rt.rect.height
    Settings.CANVAS_SCALE = rt.localScale.x
  end
end

local function OnCSLuaManagerShutdown()
  if objCurPanel ~= nil then
    objCurPanel:_PreExit()
    objCurPanel:_Exit()
    objCurPanel:_Destroy()
  end
  EventManager.Remove(EventId.CSLuaManagerShutdown, PanelManager, OnCSLuaManagerShutdown)
  EventManager.Remove(EventId.OpenPanel, PanelManager, OnOpenPanel)
  EventManager.Remove(EventId.ClosePanel, PanelManager, OnClosePanel)
  EventManager.Remove(EventId.CloesCurPanel, PanelManager, OnCloseCurPanel)
  EventManager.Remove(EventId.OpenLoading, PanelManager, OnOpenLoading)
  EventManager.Remove(EventId.BlockInput, PanelManager, OnBlockInput)
  EventManager.Remove(EventId.TemporaryBlockInput, PanelManager, OnTemporaryBlockInput)
  EventManager.Remove("ReEnterLogin", PanelManager, PanelManager.OnConfirmBackToLogIn)
  EventManager.Remove("OnSdkLogout", PanelManager, PanelManager.OnConfirmBackToLogIn)
  EventManager.Remove(EventId.MarkFullRectWH, PanelManager, OnMarkCurCanvasFullRectWH)
  EventManager.Remove("ClearRequiredLua", PanelManager, OnClearRequiredLua)
end

local function AddEventCallback()
  EventManager.Add(EventId.CSLuaManagerShutdown, PanelManager, OnCSLuaManagerShutdown)
  EventManager.Add(EventId.OpenPanel, PanelManager, OnOpenPanel)
  EventManager.Add(EventId.ClosePanel, PanelManager, OnClosePanel)
  EventManager.Add(EventId.CloesCurPanel, PanelManager, OnCloseCurPanel)
  EventManager.Add(EventId.OpenLoading, PanelManager, OnOpenLoading)
  EventManager.Add(EventId.BlockInput, PanelManager, OnBlockInput)
  EventManager.Add(EventId.TemporaryBlockInput, PanelManager, OnTemporaryBlockInput)
  EventManager.Add("ReEnterLogin", PanelManager, PanelManager.OnConfirmBackToLogIn)
  EventManager.Add("OnSdkLogout", PanelManager, PanelManager.OnConfirmBackToLogIn)
  EventManager.Add(EventId.MarkFullRectWH, PanelManager, OnMarkCurCanvasFullRectWH)
  EventManager.Add("ClearRequiredLua", PanelManager, OnClearRequiredLua)
  EventManager.Add("Test_SwitchAllUI", PanelManager, PanelManager.SwitchAllUI)
end

local function InitGuidePanel()
  if AVG_EDITOR == true then
    return
  end
  local GuidePanel = require("Game.UI.Guide.GuidePanel")
  local objGuidePanel = GuidePanel.new(AllEnum.UI_SORTING_ORDER.Guide, PanelId.Guide, {})
  objGuidePanel:_PreEnter()
  objGuidePanel:_Enter()
end

local function InitTransitionPanel()
  local TransitionPanel = require("Game.UI.TransitionEx.TransitionPanel")
  objTransitionPanel = TransitionPanel.new(AllEnum.UI_SORTING_ORDER.Transition, PanelId.Transition, {})
  objTransitionPanel:_PreEnter()
  objTransitionPanel:_Enter()
end

local function CreateCBTTips()
  if EXE_EDITOR == true then
    return
  end
  local GameResourceLoader = require("Game.Common.Resource.GameResourceLoader")
  local ResType = GameResourceLoader.ResType
  local prefab = GameResourceLoader.LoadAsset(ResType.Any, Settings.AB_ROOT_PATH .. "UI/CBT_Tips/CBT_TipsPanel.prefab", typeof(Object), "UI", -999)
  local trParent = PanelManager.GetUIRoot(AllEnum.SortingLayerName.UI_Top)
  local goPrefabInstance = instantiate(prefab, trParent)
  goPrefabInstance.name = prefab.name
  goPrefabInstance.transform:SetAsLastSibling()
  local _canvasCBTTips = goPrefabInstance:GetComponent("Canvas")
  NovaAPI.SetCanvasWorldCamera(_canvasCBTTips, CS.GameCameraStackManager.Instance.uiCamera)
end

local function CreatePlayerInfoTips()
  if EXE_EDITOR == true then
    return
  end
  local PlayerInfoPanel = require("Game.UI.PlayerInfo.PlayerInfoPanel")
  objPlayerInfoPanel = PlayerInfoPanel.new(AllEnum.UI_SORTING_ORDER.Player_Info, PanelId.PlayerInfo, {})
  objPlayerInfoPanel:_PreEnter()
  objPlayerInfoPanel:_Enter()
end

local function ResetTouchEffect()
  local GameResourceLoader = require("Game.Common.Resource.GameResourceLoader")
  local ResType = GameResourceLoader.ResType
  local objMain, objSlide
  local sPathFormat = Settings.AB_ROOT_PATH .. "UI/CommonEx/TouchEffect/%s.prefab"
  local sValue_Main = ConfigTable.GetConfigValue("TouchEffect_Main")
  if type(sValue_Main) == "string" and sValue_Main ~= "" then
    objMain = GameResourceLoader.LoadAsset(ResType.Any, string.format(sPathFormat, sValue_Main), typeof(GameObject))
  end
  local sValue_Slide = ConfigTable.GetConfigValue("TouchEffect_Slide")
  if type(sValue_Slide) == "string" and sValue_Main ~= "" then
    objSlide = GameResourceLoader.LoadAsset(ResType.Any, string.format(sPathFormat, sValue_Slide), typeof(GameObject))
  end
  if objMain ~= nil or objSlide ~= nil then
    local trNode = mapUIRootTransform[AllEnum.SortingLayerName.Overlay]
    NovaAPI.ResetTouchEffect(trNode:Find("TouchEffectUI/fxContainer"), objMain, objSlide)
  end
end

local function RegisterTextGetContentFun()
  CS.TextMeshProWrap.GetTextFunc = ConfigTable.GetUIText
end

function PanelManager.Init()
  PanelManager.IGNORE_CS_TRANS_EVENT = false
  local goUIRoot = GameObject.Find("==== UI ROOT ====")
  if goUIRoot ~= nil then
    mapUIRootTransform = {}
    mapUIRootTransform[0] = goUIRoot.transform
    
    local function func_CacheRootTransform(sSortingLayerName, sNodeName)
      local trNode = goUIRoot.transform:Find(sNodeName)
      mapUIRootTransform[sSortingLayerName] = trNode
    end
    
    func_CacheRootTransform(AllEnum.SortingLayerName.HUD, "---- HUD ----")
    func_CacheRootTransform(AllEnum.SortingLayerName.UI, "---- UI ----")
    func_CacheRootTransform(AllEnum.SortingLayerName.UI_Top, "---- UI TOP ----")
    func_CacheRootTransform(AllEnum.SortingLayerName.Overlay, "---- UI OVERLAY ----")
    trSnapshotParent = mapUIRootTransform[0]:Find("---- UI ----/Snapshot")
    tbTemplateSnapshot = {}
    tbTemplateSnapshot[1] = trSnapshotParent:GetChild(0).gameObject
    tbTemplateSnapshot[2] = trSnapshotParent:GetChild(1).gameObject
    tbTemplateSnapshot[3] = trSnapshotParent:GetChild(2).gameObject
    tbTemplateSnapshot[4] = trSnapshotParent:GetChild(3).gameObject
    OnMarkCurCanvasFullRectWH()
  end
  objCurPanel = nil
  objNextPanel = nil
  tbBackHistory = {}
  tbDisposablePanel = {}
  mapDefinePanel = require("GameCore.UI.PanelDefine")
  RegisterTextGetContentFun()
  AddEventCallback()
  InitGuidePanel()
  InitTransitionPanel()
  local goBootstrapUI = GameObject.Find("==== Builtin UI ====/BootstrapUI")
  GameObject.Destroy(goBootstrapUI)
  local goLaunchUI = GameObject.Find("==== Builtin UI ====/LaunchUI")
  NovaAPI.CloseLaunchLoading(goLaunchUI)
  CreatePlayerInfoTips()
  ResetTouchEffect()
end

function PanelManager.GetUIRoot(sSortingLayerName)
  if sSortingLayerName == nil then
    sSortingLayerName = 0
  end
  return mapUIRootTransform[sSortingLayerName]
end

function PanelManager.Home()
  local nBackToIdx = 1
  for nIndex, objPanel in ipairs(tbBackHistory) do
    if objPanel._nPanelId == PanelId.MainMenu then
      nBackToIdx = nIndex
      break
    end
  end
  DoBackToTarget(nBackToIdx)
end

function PanelManager.OnConfirmBackToLogIn()
  EventManager.Hit("ForceCloseAllBeforeBackLogin")
  PanelManager.CloseAllDisposablePanel()
  if objCurPanel ~= nil and objCurPanel._bAddToBackHistory ~= true then
    objCurPanel:_PreExit()
    objCurPanel:_Exit()
    objCurPanel:_Destroy()
    objCurPanel = nil
  end
  local nCount = #tbBackHistory
  for i = nCount, 1, -1 do
    local objPanel = tbBackHistory[i]
    objPanel:_PreExit()
    objPanel:_Exit()
    objPanel:_Destroy()
    table.remove(tbBackHistory, i)
    RemoveTbSnapShot(objPanel)
    if objCurPanel ~= nil and objCurPanel == objPanel then
      objCurPanel = nil
    end
    objPanel = nil
  end
  PlayerData.UnInit()
  PlayerData.Init()
  NovaAPI.ExitGame()
end

function PanelManager.Release()
  if type(tbBackHistory) == "table" then
    for i, objPanel in ipairs(tbBackHistory) do
      objPanel:_Release()
    end
  end
end

function PanelManager.GetCurPanelId()
  if objCurPanel ~= nil then
    return objCurPanel._nPanelId
  end
  return 0
end

function PanelManager.CheckPanelOpen(nPanelId)
  if type(tbBackHistory) == "table" then
    for i, objPanel in ipairs(tbBackHistory) do
      if objPanel._nPanelId == nPanelId then
        return true, objPanel._bIsActive
      end
    end
  end
  if type(tbDisposablePanel) == "table" then
    for i, v in ipairs(tbDisposablePanel) do
      if v._nPanelId == nPanelId then
        return true, v._bIsActive
      end
    end
  end
  return false, false
end

function PanelManager.CheckNextPanelOpening()
  return objNextPanel ~= nil
end

function PanelManager.SetMainViewSkipAnimIn(bIn)
  bMainViewSkipAnimIn = bIn
end

function PanelManager.GetMainViewSkipAnimIn()
  return bMainViewSkipAnimIn
end

function PanelManager.InputEnable(bAudioStop, bDisActiveUICombat)
  print("PanelManager.InputEnable")
  
  local function resume()
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      
      NovaAPI.InputEnable()
      AdventureModuleHelper.ResumeLogic()
      if bAudioStop then
        WwiseAudioMgr:PostEvent("char_common_all_stop")
        WwiseAudioMgr:PostEvent("mon_common_all_stop")
      else
        WwiseAudioMgr:PostEvent("char_common_all_resume")
        WwiseAudioMgr:PostEvent("mon_common_all_resume")
      end
      if not bDisActiveUICombat then
        WwiseAudioMgr:PostEvent("ui_loading_combatSFX_active", nil, false)
      end
    end
    
    cs_coroutine.start(wait)
  end
  
  nInputRC = nInputRC - 1
  if nInputRC == 0 then
    resume()
  end
  if nInputRC < 0 then
    nInputRC = 0
    printError("InputEnable与InputDisable使用不匹配，请成对使用")
    resume()
  end
end

function PanelManager.InputDisable()
  print("PanelManager.InputDisable")
  if nInputRC == 0 then
    NovaAPI.InputDisable()
    AdventureModuleHelper.PauseLogic()
    WwiseAudioMgr:PostEvent("ui_loading_combatSFX_mute", nil, false)
    WwiseAudioMgr:PostEvent("char_common_all_pause")
    WwiseAudioMgr:PostEvent("mon_common_all_pause")
  end
  nInputRC = nInputRC + 1
end

function PanelManager.ClearInputState()
  nInputRC = 0
end

local goDiscSkillActive, goSelect1, goSelect2, goSelect3, goDashboard, trSupportRole, trMainRole, trSkillHint, trJoystick, goTransition, goPlayerInfo

function PanelManager.SwitchUI()
  if mapUIRootTransform == nil then
    return
  end
  local trUIRoot
  trUIRoot = mapUIRootTransform[AllEnum.SortingLayerName.UI]
  if trUIRoot ~= nil then
    if goDiscSkillActive == nil or goDiscSkillActive ~= nil and goDiscSkillActive:IsNull() == true then
      goDiscSkillActive = trUIRoot:Find("DiscSkillActivePanel")
      if goDiscSkillActive ~= nil and goDiscSkillActive:IsNull() == false then
        goDiscSkillActive:SetParent(mapUIRootTransform[0])
      end
    end
    if goSelect1 == nil or goSelect1 ~= nil and goSelect1:IsNull() == true then
      goSelect1 = trUIRoot:Find("FateCardSelectPanel")
      if goSelect1 ~= nil and goSelect1:IsNull() == false then
        goSelect1:SetParent(mapUIRootTransform[0])
      end
    end
    if goSelect2 == nil or goSelect2 ~= nil and goSelect2:IsNull() == true then
      goSelect2 = trUIRoot:Find("NoteSelectPanel")
      if goSelect2 ~= nil and goSelect2:IsNull() == false then
        goSelect2:SetParent(mapUIRootTransform[0])
      end
    end
    if goSelect3 == nil or goSelect3 ~= nil and goSelect3:IsNull() == true then
      goSelect3 = trUIRoot:Find("PotentialSelectPanel")
      if goSelect3 ~= nil and goSelect3:IsNull() == false then
        goSelect3:SetParent(mapUIRootTransform[0])
      end
    end
    if goDashboard == nil or goDashboard ~= nil and goDashboard:IsNull() == true then
      goDashboard = trUIRoot:Find("BattleDashboard")
      if goDashboard ~= nil and goDashboard:IsNull() == false then
        goDashboard:SetParent(mapUIRootTransform[0])
        trSupportRole = goDashboard:Find("--safe_area--/--support_role--")
        trMainRole = goDashboard:Find("--safe_area--/--main_role--")
        trSkillHint = goDashboard:Find("--safe_area--/--skill_hint--")
        trJoystick = goDashboard:Find("--safe_area--/--joystick--")
      end
    end
    if 0 < trUIRoot.localScale.x then
      trUIRoot.localScale = Vector3.zero
      trJoystick.localScale = Vector3.zero
    else
      trUIRoot.localScale = Vector3.one
      trJoystick.localScale = Vector3.one
    end
  end
  trUIRoot = mapUIRootTransform[AllEnum.SortingLayerName.UI_Top]
  if trUIRoot ~= nil then
    if goTransition == nil or goTransition ~= nil and goTransition:IsNull() == true then
      goTransition = trUIRoot:Find("TransitionPanel")
      if goTransition ~= nil and goTransition:IsNull() == false then
        goTransition:SetParent(mapUIRootTransform[0])
      end
    end
    if 0 < trUIRoot.localScale.x then
      trUIRoot.localScale = Vector3.zero
    else
      trUIRoot.localScale = Vector3.one
    end
  end
  trUIRoot = mapUIRootTransform[AllEnum.SortingLayerName.Overlay]
  if trUIRoot ~= nil then
    if goPlayerInfo == nil or goPlayerInfo ~= nil and goPlayerInfo:IsNull() == true then
      goPlayerInfo = trUIRoot:Find("PlayerInfoPanel/----AdaptedArea----")
    end
    if 0 < goPlayerInfo.localScale.x then
      goPlayerInfo.localScale = Vector3.zero
    else
      goPlayerInfo.localScale = Vector3.one
    end
  end
end

function PanelManager.SwitchSkillBtn()
  if mapUIRootTransform == nil then
    return
  end
  if goDashboard == nil or goDashboard ~= nil and goDashboard:IsNull() == true then
    local trUIRoot = mapUIRootTransform[AllEnum.SortingLayerName.UI]
    goDashboard = trUIRoot:Find("BattleDashboard")
    if goDashboard ~= nil and goDashboard:IsNull() == false then
      goDashboard:SetParent(mapUIRootTransform[0])
      trSupportRole = goDashboard:Find("--safe_area--/--support_role--")
      trMainRole = goDashboard:Find("--safe_area--/--main_role--")
      trSkillHint = goDashboard:Find("--safe_area--/--skill_hint--")
      trJoystick = goDashboard:Find("--safe_area--/--joystick--")
    end
  end
  if 0 < trSupportRole.localScale.x then
    trSupportRole.localScale = Vector3.zero
    trMainRole.localScale = Vector3.zero
    trSkillHint.localScale = Vector3.zero
  else
    trSupportRole.localScale = Vector3.one
    trMainRole.localScale = Vector3.one
    trSkillHint.localScale = Vector3.one
  end
end

local bAllUIVisible = true

function PanelManager.SwitchAllUI()
  if bAllUIVisible == true then
    bAllUIVisible = false
  else
    bAllUIVisible = true
  end
  
  local function SetVisible(trRoot)
    local n = trRoot.childCount - 1
    for i = 0, n do
      local canvas = trRoot:GetChild(i):GetComponent("Canvas")
      if canvas ~= nil and canvas:IsNull() == false then
        canvas.enabled = bAllUIVisible
      end
    end
  end
  
  SetVisible(mapUIRootTransform[AllEnum.SortingLayerName.HUD])
  SetVisible(mapUIRootTransform[AllEnum.SortingLayerName.UI])
  SetVisible(mapUIRootTransform[AllEnum.SortingLayerName.UI_Top])
  SetVisible(mapUIRootTransform[AllEnum.SortingLayerName.Overlay])
end

function PanelManager.CloseAllDisposablePanel()
  if type(tbDisposablePanel) == "table" then
    local n = #tbDisposablePanel
    for i = n, 1, -1 do
      local objTempPanel = tbDisposablePanel[i]
      objTempPanel:_PreExit()
      objTempPanel:_Exit()
      objTempPanel:_Destroy()
      objTempPanel = nil
      table.remove(tbDisposablePanel, i)
    end
    if 0 < n then
      printLog("[界面切换] 同时关闭所有非主 Panel 界面")
    end
  end
end

function PanelManager.CheckInTransition()
  if objTransitionPanel ~= nil then
    local nStatus = objTransitionPanel:GetTransitionStatus()
    if nStatus ~= AllEnum.TransitionStatus.OutAnimDone then
      return true
    end
  end
  return false
end

return PanelManager
