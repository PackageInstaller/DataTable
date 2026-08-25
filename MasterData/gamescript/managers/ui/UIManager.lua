local GameObjectUtil = CS.Framework.GameObjectUtil
local Input = CS.UnityEngine.Input
local KC_Escape = CS.UnityEngine.KeyCode.Escape
local Application = CS.UnityEngine.Application
local RP_Android = CS.UnityEngine.RuntimePlatform.Android
local RP_WindowsEditor = CS.UnityEngine.RuntimePlatform.WindowsEditor
local RP_WindowsPlayer = CS.UnityEngine.RuntimePlatform.WindowsPlayer
local typeof = _ENV.typeof
local T_RectTransform = typeof(CS.UnityEngine.RectTransform)
local Vector3_Zero = CS.UnityEngine.Vector3.zero
local tempList = {}
local cacheFullScreenConfig = {}
local supportGoBack = Application.platform == RP_Android or Application.platform == RP_WindowsEditor or Application.platform == RP_WindowsPlayer
local UIManager, Super = System.NewClass("UIManager", Manager, IUpdater)
local UIResCls = {}

function UIManager:Awake(binder)
  self.panelList = {}
  self.binder = binder
  self.uid = 0
  self.layerRoots = {}
  self.bothSidesUIOriPosMap = {}
  self.backExpandFunc = nil
  for _, layerCfg in pairs(UIDefine.LayerCfg) do
    local goName = layerCfg.goName
    self.layerRoots[layerCfg.name] = UIRootMgr.FindChild(UIRootMgr.GetUIRoot().transform, goName)
  end
  binder:BindOnceEvent(EventMgr.Instance.OnSdkInitSuccess, System.fn(self, self._ResolutionAdaption))
  binder:BindEvent(EventMgr.Instance.TopUIAudioEvent, System.fn(self, self._StackTopUIAudioProcess))
  binder:BindEvent(EventMgr.Instance.TopUIChangeEvent, System.fn(self, self._SetPlayerState))
end

function UIManager:OnDestroy()
  self:_StopHideLowerLayerPanelTimer()
  self:CloseAll()
  UIAsyncLoadMgr.Instance:ClearAll()
  UIBlackScreenMgr.Instance:Dispose()
  WaitingView.Instance:Dispose()
  Super.OnDestroy(self)
end

function UIManager.GetUIResObj(uiResCls)
  if type(uiResCls) == "table" then
    return uiResCls
  end
  if UIResCls[uiResCls] then
    return UIResCls[uiResCls]
  end
  local cls = System.NewClass(uiResCls, UIBaseResource)
  cls.assetPath = uiResCls
  UIResCls[uiResCls] = cls
  return cls
end

function UIManager.InitUIPos(parent, trans)
  local rect = trans:GetComponent(T_RectTransform)
  if rect then
    local offsetMax = rect.offsetMax
    local offsetMin = rect.offsetMin
    local scale = rect.localScale
    trans.transform:SetParent(parent.transform)
    rect.anchoredPosition3D = Vector3_Zero
    rect.localScale = scale
    rect.offsetMin = offsetMin
    rect.offsetMax = offsetMax
  else
    trans.transform:SetParent(parent.transform)
    trans.transform.localPosition = Vector3_Zero
  end
end

function UIManager:Reopen(url, ...)
  Logger.ReportApusInfo("OpenPanel:{url}", url)
  if UIAsyncLoadMgr.Instance:IsAsyncLoaded(url) then
    if UIAsyncLoadMgr.Instance:IsOpened(url) then
      local panel = self:GetWindow(url)
      if panel then
        panel.closeWithoutAnim = true
      end
      self:_CloseByUrl(url, {bandStack = true})
    end
    do return UIAsyncLoadMgr.Instance.ReopenPanel, UIAsyncLoadMgr.Instance, url, ... end
    return UIAsyncLoadMgr.Instance.ReopenPanel, UIAsyncLoadMgr.Instance, url, ...
  else
    do return self.ReopenSync, self, url, ... end
    return self.ReopenSync, self, url, ...
  end
end

function UIManager:ReopenSync(url, ...)
  local panel = self:GetWindow(url)
  if panel then
    panel.closeWithoutAnim = true
  end
  self:_CloseByUrl(url, {bandStack = true})
  do return self._Open, self, url, ... end
  return self._Open, self, url, ...
end

function UIManager:Show(url, ...)
  Logger.ReportApusInfo("OpenPanel:{url}", url)
  if UIAsyncLoadMgr.Instance:IsAsyncLoaded(url) then
    do return UIAsyncLoadMgr.Instance.OpenPanel, UIAsyncLoadMgr.Instance, url, ... end
    return UIAsyncLoadMgr.Instance.OpenPanel, UIAsyncLoadMgr.Instance, url, ...
  else
    do return self.ShowSync, self, url, ... end
    return self.ShowSync, self, url, ...
  end
end

function UIManager:ShowSync(url, ...)
  do return self._Open, self, url, ... end
  return self._Open, self, url, ...
end

function UIManager:ReShowBehindPanel(panel)
  self:TryStopHideLowerLayerPanelTimer(panel.url)
  local behindPanelList = self:_GetBehindPanelList(panel)
  local forwardPanelList = self:_GetForwardPanelList(panel)
  for _, forwardPanel in ipairs(forwardPanelList) do
    if forwardPanel.isFullScreen then
      table.insert(behindPanelList, forwardPanel)
    end
  end
  table.sort(behindPanelList, function(a, b)
    if a.layerIndex == b.layerIndex then
      return a.windowUid > b.windowUid
    end
    return a.layerIndex > b.layerIndex
  end)
  for _, behindPanel in ipairs(behindPanelList) do
    if ViewSettings.IsChildTabView(behindPanel.url) then
    else
      behindPanel:SetRendered(true)
      behindPanel:AfterSetRenderTrue()
      if behindPanel.childTapViewKey and behindPanel.childrenTapViews then
        local cfg = behindPanel.childrenTapViews[behindPanel.childTapViewKey]
        if cfg and cfg.viewInstance and not cfg.viewInstance.isRendering then
          cfg.viewInstance:SetRendered(true)
        end
      end
      if behindPanel.isFullScreen then
        return
      end
    end
  end
end

function UIManager:GetUICountByLayer(layer)
  local count = 0
  local layerIndex = layer.index
  for _, panel in pairs(self.panelList) do
    if panel.layerIndex == layerIndex then
      count = count + 1
    end
  end
  return count
end

function UIManager:RegisterPanelClose(url, callback)
  if not callback then
    return
  end
  self.urlCloseCbMap = self.urlCloseCbMap or {}
  local cbList = self.urlCloseCbMap[url] or {}
  table.insert(cbList, callback)
  self.urlCloseCbMap[url] = cbList
end

function UIManager:RemovePanelCloseCb(url, callback)
  if not (url and callback) or not self.urlCloseCbMap then
    return
  end
  local cbList = self.urlCloseCbMap[url] or {}
  for index, cb in ipairs(cbList) do
    if callback == cb then
      table.remove(cbList, index)
      break
    end
  end
end

function UIManager:ClearAllPanelCloseCb()
  self.urlCloseCbMap = nil
end

function UIManager:OpenSceneUI(sceneType, url, ...)
  Logger.Info("OpenSceneUI", sceneType, url, debug.traceback())
  self.sceneOpenUI = self.sceneOpenUI or {}
  self.sceneOpenUI[sceneType] = self.sceneOpenUI[sceneType] or {}
  table.insert(self.sceneOpenUI[sceneType], {
    url = url,
    args = {
      ...
    }
  })
  EventMgr.Instance.SceneUIChange:Dispatch(sceneType)
end

function UIManager:OpenCopySceneUI(url, ...)
  self:OpenSceneUI(CommonDefine.SceneType.Copies, url, ...)
end

function UIManager:GetSceneUI(sceneType)
  return self.sceneOpenUI and self.sceneOpenUI[sceneType] or {}
end

function UIManager:ClearSceneUI(sceneType)
  if self.sceneOpenUI then
    self.sceneOpenUI[sceneType] = nil
  end
end

function UIManager:InsertUIQueue(sceneType, isReopen, url, ...)
  Logger.Info("InsertUIQueue", sceneType, isReopen, url, debug.traceback())
  self.sceneUIQueue = self.sceneUIQueue or {}
  self.sceneUIQueue[sceneType] = self.sceneUIQueue[sceneType] or {}
  table.insert(self.sceneUIQueue[sceneType], {
    url = url,
    args = {
      ...
    },
    isReopen = isReopen
  })
  EventMgr.Instance.SceneUIQueueChange:Dispatch(sceneType)
end

function UIManager:GetSceneUIOpenQueue(sceneType)
  return self.sceneUIQueue and self.sceneUIQueue[sceneType] or {}
end

function UIManager:ClearSceneOpenUIQueue(sceneType)
  if self.sceneUIQueue then
    self.sceneUIQueue[sceneType] = nil
  end
end

function UIManager:ClearAllSceneOpenUIQueue()
  if self.sceneUIQueue then
    for sceneType, _ in pairs(self.sceneUIQueue) do
      self.sceneUIQueue[sceneType] = nil
    end
  end
end

function UIManager:InsertCopyUIReopenQueue(url, ...)
  self:InsertUIQueue(CommonDefine.SceneType.Copies, true, url, ...)
end

function UIManager:InsertCopyUIShowQueue(url, ...)
  self:InsertUIQueue(CommonDefine.SceneType.Copies, false, url, ...)
end

function UIManager:GetWindow(url)
  if not self.panelList then
    return nil
  end
  table.clear(tempList)
  for _, value in pairs(self.panelList) do
    if value.url == url then
      table.insert(tempList, value)
    end
  end
  if #tempList > 1 then
    Logger.Debug("已经打开了多个名为 %s 的窗口", url)
  end
  if #tempList <= 0 then
    return nil
  end
  return tempList[#tempList]
end

function UIManager:_GetPanelById(id)
  if not self.panelList then
    return
  end
  for _, panel in pairs(self.panelList) do
    if panel.windowUid == id then
      return panel
    end
  end
end

function UIManager:_GenerateWindowId()
  self.uid = self.uid + 1
  return self.uid
end

function UIManager:_Open(url, ...)
  Logger.Info("#打开界面:", url, ...)
  if ApplicationUtils.is_debug_mode() and not UIDefine.IgnoreTraceBack[url] then
    Logger.Info("#打开界面stack:", url, debug.traceback())
  end
  local panel = self:_CreateUIPanel(url, ...)
  if nil == panel then
    Logger.Error("创建界面失败: %s", url)
    return
  end
  self:_AddPanel(panel)
  panel:OnAddToStage()
  GlobalDispatcher:Dispatch(NotifyId.OnPanelOpened, panel.url, panel.windowUid, panel.isFullScreen)
  EventMgr.Instance.OnPanelOpened:Dispatch(panel.url, panel.windowUid, panel.isFullScreen)
  return panel
end

function UIManager:_AddPanel(panel)
  local layerName = self:GetLayerName(panel)
  local layerCfg = UIDefine.LayerCfg[layerName]
  assert(layerCfg, "invalid layerName = " .. layerName)
  panel.layerIndex = layerCfg.index
  local layerRoot = self.layerRoots[layerName]
  if layerRoot then
    GameObjectUtil.UIInitPos(layerRoot, panel.root)
    panel.ui.uiNode.transform:SetAsLastSibling()
  end
  table.insert(self.panelList, panel)
  panel:SetRendered(true)
  local isFullScreen = panel.isFullScreen
  if isFullScreen then
    EventMgr.Instance.InsertFullScreenPanel:Dispatch()
    panel:LoadHideLowerLayerPanelCb(function()
    end)
  end
  self:_EnsureHideLowerLayerPanel(panel)
  EventMgr.Instance.AfterAddUIPanel:Dispatch(panel.url, panel)
end

function UIManager:_EnsureHideLowerLayerPanel(panel)
  if not panel.isFullScreen then
    return
  end
  if panel.url == Urls.MainPanel then
    return
  end
  self:_StopHideLowerLayerPanelTimer()
  if panel.assumedOpenAnimTime and 0 == panel.assumedOpenAnimTime then
    self:_HideLowerLayerPanel(panel)
  else
    self.hideLowerLayerPanel = panel.url
    self.hideLowerLayerPanelTimer = self.binder:BindTimer(panel.assumedOpenAnimTime or 1, 0, nil, function()
      self:_TryHideLowerLayerPanel(panel)
      self:_StopHideLowerLayerPanelTimer()
    end)
  end
end

function UIManager:_StopHideLowerLayerPanelTimer()
  self.hideLowerLayerPanel = nil
  if self.hideLowerLayerPanelTimer then
    self.binder:StopTimer(self.hideLowerLayerPanelTimer)
    self.hideLowerLayerPanelTimer = nil
  end
end

function UIManager:TryStopHideLowerLayerPanelTimer(url)
  if self.hideLowerLayerPanel == url then
    self:_StopHideLowerLayerPanelTimer()
  end
end

function UIManager:SetHideLowerLayerPanel(url)
  if not url then
    return
  end
  self.hideLowerLayerPanel = url
end

function UIManager:ResetHideLowerLayerPanel()
  self.hideLowerLayerPanel = nil
end

function UIManager:_TryHideLowerLayerPanel(panel)
  if not self:GetWindow(panel.url) or self.hideLowerLayerPanel ~= panel.url then
    return
  end
  self:_HideLowerLayerPanel(panel)
end

function UIManager:_HideLowerLayerPanel(panel)
  local lowerWindows = self:_GetBehindPanelList(panel)
  local higherWindows = self:_GetForwardPanelList(panel)
  for _, wInfo in ipairs(lowerWindows) do
    if ViewSettings.IsChildTabView(wInfo.url) then
    else
      self:_HidePanel(wInfo)
    end
  end
  for _, wInfo in ipairs(higherWindows) do
    if wInfo.isFullScreen then
      self:_HidePanel(wInfo)
    end
  end
end

function UIManager:_ClosePanel(panel)
  self:TryStopHideLowerLayerPanelTimer(panel.url)
  EventMgr.Instance.BeginCloseUIPanel:Dispatch(panel.url, panel.windowUid, panel.isFullScreen)
  GlobalDispatcher:Dispatch(NotifyId.OnPanelClosing, panel.url, panel.windowUid, panel.isFullScreen)
  self:ReShowBehindPanel(panel)
  for i, wInfo in ipairs(self.panelList) do
    if wInfo.windowUid == panel.windowUid then
      table.remove(self.panelList, i)
      if panel.isFullScreen then
        EventMgr.Instance.RemoveFullScreenPanel:Dispatch()
      end
      break
    end
  end
  if panel then
    if panel.viewCompsMgr then
      panel.viewCompsMgr:Dispose()
    end
    panel:DestroyUI()
  end
  EventMgr.Instance.AfterCloseUIPanel:Dispatch(panel.url, panel)
end

function UIManager:_HidePanel(panel)
  if panel then
    panel:SetRendered(false)
  end
end

function UIManager:_ReShowPanel(panel)
  if panel then
    panel:SetRendered(true)
  end
end

function UIManager:_GetBehindPanelList(panel)
  local lowerList = {}
  for _, _panel in ipairs(self.panelList) do
    if _panel.layerIndex < panel.layerIndex then
      table.insert(lowerList, _panel)
    elseif _panel.layerIndex == panel.layerIndex and _panel.windowUid < panel.windowUid then
      table.insert(lowerList, _panel)
    end
  end
  return lowerList
end

function UIManager:_GetForwardPanelList(panel)
  local higherList = {}
  for _, _panel in ipairs(self.panelList) do
    if _panel.layerIndex > panel.layerIndex then
      table.insert(higherList, _panel)
    elseif _panel.layerIndex == panel.layerIndex and _panel.windowUid > panel.windowUid then
      table.insert(higherList, _panel)
    end
  end
  return higherList
end

function UIManager:HaveForwardPanel(panel)
  local panels = self:_GetForwardPanelList(panel)
  if #panels > 0 then
    local realCount = #panels
    local exceptPanels = UIDefine.ExceptUrls
    local ignoreCountUrls = UIDefine.IgnoreCountUrls
    for i = 1, #panels do
      if table.contains(exceptPanels, panels[i].url) then
        realCount = realCount - 1
      elseif table.contains(ignoreCountUrls, panels[i].url) then
        realCount = realCount - 1
      end
    end
    if realCount > 0 then
      return true
    end
  end
end

function UIManager:_CreateUIPanel(url, ...)
  local uiCls = require("GameScript." .. url)
  local panel = uiCls(...)
  panel.url = url
  panel.windowUid = self:_GenerateWindowId()
  local binder = self.binder:createChild()
  panel.binder = binder
  binder:onDestroy(function()
    EventMgr.Instance.CloseUIPanel:Dispatch(panel.url, panel.windowUid, panel.isFullScreen)
    if ApplicationUtils.is_debug_mode() then
      if self._silentDestroyStack then
        Logger.Info("销毁界面: %s", panel.url)
      else
        Logger.Info("销毁界面: %s -> %s %s", panel.url, panel.url, debug.traceback())
      end
    end
    if self.urlCloseCbMap and self.urlCloseCbMap[url] then
      local cbList = self.urlCloseCbMap[url]
      self.urlCloseCbMap[url] = nil
      for _, cb in ipairs(cbList) do
        cb()
      end
    end
  end)
  panel:Setup(binder)
  panel.isFullScreen = panel.panelCfg.viewType == UIDefine.ViewType.FullScreenView
  cacheFullScreenConfig[url] = panel.isFullScreen
  EventMgr.Instance.OpenUIPanel:Dispatch(panel.url, panel.windowUid, panel.isFullScreen)
  if panel.isFullScreen then
    EventMgr.Instance.OpenFullScreenPanel:Dispatch(panel.url)
  end
  return panel
end

function UIManager:CloseByUrl(url, args)
  UIAsyncLoadMgr.Instance:ClosePanel(url)
  self:_CloseByUrl(url, args)
end

function UIManager:CloseByWindowId(windowId, args)
  self:_CloseById(windowId, args)
end

function UIManager:CloseLayerWindows(layerCfg)
  local layerIndex = layerCfg.index
  for i = #self.panelList, 1, -1 do
    local panel = self.panelList[i]
    if panel.layerIndex == layerIndex then
      self:_ClosePanel(panel)
      table.remove(self.panelList, i)
    end
  end
end

function UIManager:CloseAll()
  if ApplicationUtils.is_debug_mode() then
    Logger.Info("关闭所有界面CloseAll", debug.traceback())
  else
    Logger.Info("关闭所有界面CloseAll")
  end
  self:ClearAllPanelCloseCb()
  if self.panelList then
    local temp = {}
    table.mergeWithoutGc(temp, self.panelList)
    for _, value in pairs(temp) do
      value.closeWithoutAnim = true
      self:CloseByUrl(value.url)
    end
    self.panelList = nil
  end
end

function UIManager:CloseAllExcept(exceptUrls)
  self:ClearAllPanelCloseCb()
  local defaultExceptUrls = table.clone(UIDefine.ExceptUrls)
  exceptUrls = exceptUrls or {}
  for _, url in ipairs(defaultExceptUrls) do
    table.insert(exceptUrls, url)
  end
  UIAudioManager.Instance:SetChangeUIProcess(false)
  if ApplicationUtils.is_debug_mode() then
    Logger.Info("关闭所有界面CloseAllExcept", debug.traceback())
  else
    Logger.Info("关闭所有界面CloseAllExcept")
  end
  self._silentDestroyStack = true
  local cloneList = table.clone(self.panelList)
  for _, panel in ipairs(cloneList) do
    if not table.contains(exceptUrls, panel.url) and self:GetWindow(panel.url) then
      panel.closeWithoutAnim = true
      self:_ClosePanel(panel)
    end
  end
  self._silentDestroyStack = false
  UIAudioManager.Instance:SetChangeUIProcess(true)
end

function UIManager:_CloseByUrl(url, _)
  self:TryStopHideLowerLayerPanelTimer(url)
  LuaProfiler.Begin("CloseWindow")
  local windowInfo = self:GetWindow(url)
  if not windowInfo then
    return
  end
  if ApplicationUtils.is_debug_mode() and not UIDefine.IgnoreTraceBack[url] then
    Logger.Info("关闭界面", url, debug.traceback())
  end
  Logger.ReportApusInfo("ClosePanel:{url}", url)
  self:_ClosePanel(windowInfo)
  LuaProfiler.End()
end

function UIManager:_CloseById(id, _)
  LuaProfiler.Begin("CloseWindow")
  local panel = self:_GetPanelById(id)
  if not panel then
    return
  end
  if panel and not panel.loadEnd then
    panel:LoadEndClosePanelCallback(function()
    end)
    return
  end
  self:_ClosePanel(panel)
  LuaProfiler.End()
end

function UIManager:GetTopPanelThatNotChildView()
  if not self.panelList or not table.next(self.panelList) then
    return nil
  end
  local fullScreenPanels = {}
  for _, panel in pairs(self.panelList) do
    if panel.isFullScreen then
      table.insert(fullScreenPanels, panel)
    end
  end
  if not table.next(fullScreenPanels) then
    return nil
  end
  table.sort(fullScreenPanels, function(a, b)
    if a.layerIndex == b.layerIndex then
      return a.windowUid > b.windowUid
    end
    return a.layerIndex > b.layerIndex
  end)
  return fullScreenPanels[1].url, fullScreenPanels
end

function UIManager:GetTopFullScreenPanel()
  if not self.panelList or not table.next(self.panelList) then
    return nil
  end
  local fullScreenPanels = {}
  for _, panel in pairs(self.panelList) do
    if panel.isFullScreen then
      table.insert(fullScreenPanels, panel)
    end
  end
  if not table.next(fullScreenPanels) then
    return nil
  end
  table.sort(fullScreenPanels, function(a, b)
    if a.layerIndex == b.layerIndex then
      return a.windowUid > b.windowUid
    end
    return a.layerIndex > b.layerIndex
  end)
  return fullScreenPanels[1].url, fullScreenPanels
end

function UIManager:GetLayerIndex(layer)
  local layerCfg = UIDefine.LayerCfg[layer]
  if not layerCfg then
    return
  end
  return layerCfg.index
end

function UIManager.GetTipPopRoot()
  do return UIManager.Instance.GetLayerNode, UIManager.Instance end
  return UIManager.Instance.GetLayerNode, UIManager.Instance, UIDefine.LayerCfg.TipPopRoot
end

function UIManager.GetTopRoot()
  do return UIManager.Instance.GetLayerNode, UIManager.Instance end
  return UIManager.Instance.GetLayerNode, UIManager.Instance, UIDefine.LayerCfg.TopRoot
end

function UIManager:GetLayerNode(layerCfg)
  return self.layerRoots[layerCfg.name]
end

function UIManager:GetAllShowWindowIdsByLayer(layer)
  local layerIndex = self:GetLayerIndex(layer)
  local ids = {}
  for _, panel in ipairs(self.panelList) do
    if panel.layerIndex == layerIndex then
      table.insert(ids, panel.windowUid)
    end
  end
  return ids
end

function UIManager:HideWindowById(id)
  local panel = self:_GetPanelById(id)
  if panel then
    panel:SetRendered(false)
  end
end

function UIManager:OpenWindowById(id)
  local panel = self:_GetPanelById(id)
  if panel then
    panel:SetRendered(true)
  end
end

function UIManager:_StackTopUIAudioProcess(curUI, lastCloseUI)
  local openEventName = UIChangeAudioUtils.GetOpenEventByUrl(curUI)
  local closeIsFullPanel = false
  if lastCloseUI and "" ~= lastCloseUI then
    closeIsFullPanel = cacheFullScreenConfig[lastCloseUI]
  end
  if openEventName and (closeIsFullPanel or not AudioManager.Instance:CheckIsPlayingBGM()) then
    AudioManager.Instance:PostSoundEvent(openEventName)
  end
  local curUIPanel = UIManager.Instance:GetWindow(curUI)
  if curUIPanel and curUIPanel.ReShowInTop then
    curUIPanel:ReShowInTop()
  end
end

function UIManager:_ResolutionAdaption()
  local notchInfo = SdkMgr.GetNotchInfo()
  if not notchInfo then
    return
  end
  local safeArea = notchInfo.safe_inset
  local curOrientation = CS.UnityEngine.Screen.orientation
  local enumLandscapeRight = CS.UnityEngine.ScreenOrientation.LandscapeRight
  local top, bottom, left, right
  local sideLength = safeArea.left > safeArea.right and safeArea.left or safeArea.right
  if curOrientation == enumLandscapeRight then
    top = safeArea.top
    bottom = safeArea.bottom
    left = sideLength
    right = sideLength
  else
    top = safeArea.bottom
    bottom = safeArea.top
    left = sideLength
    right = sideLength
  end
  local safeAreaComp = CS.UnityEngine.GameObject.Find("SafeArea")
  local adaptationScript = safeAreaComp:GetComponent(typeof(CS.UIResolutionAdaptation))
  adaptationScript.leftNotchLenth = left
  adaptationScript.rightNotchLenth = right
  adaptationScript.topNotchLenth = top
  adaptationScript.bottomNotchLenth = bottom
  adaptationScript:DoAdaptation("special")
end

function UIManager.GetCurScreenProportion()
  return CS.UnityEngine.Screen.width / CS.UnityEngine.Screen.height
end

function UIManager:IsPanelRendering(url)
  local panel = self:GetWindow(url)
  return panel and panel.isRendering
end

function UIManager:ForbidBack()
  UIBackCommandStack.Clear()
  self.forbidenBack = true
end

function UIManager:Update()
  UIAsyncLoadMgr.Instance:Update()
  WaitingView.Instance:Update()
  UIBlackScreenMgr.Instance:Update()
  self:UpdateBack()
end

function UIManager:UpdateBack()
  if self.forbidenBack then
    return
  end
  if NewbieGuideManager.Instance:IsInForceGuide() then
    return
  end
  if supportGoBack and Input.GetKeyDown(KC_Escape) then
    if self.backExpandFunc then
      self:BackExpandFunc()
      return
    end
    local topEle = UIBackCommandStack.GetTopElement()
    if not topEle then
      return
    end
    local panel = self:GetWindow(topEle.uiPanel.url)
    if panel and panel:IgnorePushBackCommand() then
      return
    end
    local cmd = UIBackCommandStack.Pop()
    if cmd then
      if cmd.uiPanel.url == Urls.LoginPanel or cmd.uiPanel.url == Urls.MainPanel then
        if not self:IsPanelRendering(cmd.uiPanel.url) then
          UIBackCommandStack.Push(cmd)
          return
        end
        
        local function restoreBackCmd()
          UIBackCommandStack.Push(cmd)
        end
        
        Alert.ShowEx(CommonDefine.ExitGameConfirmTipTid, {
          cancelFunc = restoreBackCmd,
          closeCb = restoreBackCmd,
          confirmFunc = function()
            ApplicationUtils.ExitGame()
          end
        })
      else
        cmd.Execute()
      end
    end
  end
end

function UIManager:UpdateBackExpandFunc(func)
  self.backExpandFunc = func
end

function UIManager:BackExpandFunc()
  if self.backExpandFunc then
    self.backExpandFunc()
  end
end

function UIManager:ClearBackExpandFuc()
  self.backExpandFunc = nil
end

function UIManager:InitBothSidesUIOriPos(leftUIGroup, rightUIGroup)
  for obj, _ in pairs(leftUIGroup) do
    if not self.bothSidesUIOriPosMap[obj] then
      local oriPos = obj:GetComponent(typeof(CS.UnityEngine.RectTransform)).anchoredPosition.x
      leftUIGroup[obj] = oriPos
      self.bothSidesUIOriPosMap[obj] = oriPos
    else
      leftUIGroup[obj] = self.bothSidesUIOriPosMap[obj]
    end
  end
  for obj, _ in pairs(rightUIGroup) do
    if not self.bothSidesUIOriPosMap[obj] then
      local oriPos = obj:GetComponent(typeof(CS.UnityEngine.RectTransform)).anchoredPosition.x
      rightUIGroup[obj] = oriPos
      self.bothSidesUIOriPosMap[obj] = oriPos
    else
      rightUIGroup[obj] = self.bothSidesUIOriPosMap[obj]
    end
  end
  return leftUIGroup, rightUIGroup
end

function UIManager:SetTempPanelLayer(url, layerName)
  self._tempPanelLayer = self._tempPanelLayer or {}
  self._tempPanelLayer[url] = layerName
end

function UIManager:GetTempPanelLayer(url)
  local tempLayer = self._tempPanelLayer and self._tempPanelLayer[url]
  if tempLayer then
    self._tempPanelLayer[url] = nil
    return tempLayer
  end
end

function UIManager:GetLayerName(panel)
  if panel.layerName then
    return panel.layerName
  end
  local layerName = self:GetTempPanelLayer(panel.url) or panel.panelCfg.layer
  if self:GetWindow(Urls.WorldStageMainPanel) and "FixedRoot" == layerName and panel.isFullScreen then
    layerName = "PopUpRoot"
  end
  panel.layerName = layerName
  return layerName
end

function UIManager:UIBothSidesAdaptation(leftUIGroup, rightUIGroup, deltaLen)
  local notchInfo = SdkMgr.GetNotchInfo()
  if notchInfo and notchInfo.safe_inset then
    local safeInset = notchInfo.safe_inset
    local sideLength = safeInset.left > safeInset.right and safeInset.left or safeInset.right
    deltaLen = sideLength > 0 and 0 or deltaLen
  end
  local UISize = CS.UnityEngine.GameObject.Find("SafeArea"):GetComponent(typeof(CS.UnityEngine.RectTransform)).rect
  local UIwidth = UISize.width
  local canvasScaler = CS.UnityEngine.GameObject.Find("UIRoot"):GetComponent(typeof(CS.UnityEngine.UI.CanvasScaler))
  local standardWidth = canvasScaler.referenceResolution.x
  local sideDeltaLen = (UIwidth - standardWidth) / 2
  local moveLen = math.max(0, sideDeltaLen - deltaLen)
  for obj, oriPos in pairs(leftUIGroup) do
    local objRectTransform = obj:GetComponent(typeof(CS.UnityEngine.RectTransform))
    local pos = objRectTransform.anchoredPosition
    objRectTransform.anchoredPosition = CS.UnityEngine.Vector2(oriPos - moveLen, pos.y)
  end
  for obj, oriPos in pairs(rightUIGroup) do
    local objRectTransform = obj:GetComponent(typeof(CS.UnityEngine.RectTransform))
    local pos = objRectTransform.anchoredPosition
    objRectTransform.anchoredPosition = CS.UnityEngine.Vector2(oriPos + moveLen, pos.y)
  end
end

function UIManager:_SetPlayerState(topUI)
  SocialStateUtils.SetPlayerStateByUI(topUI)
end

return UIManager
