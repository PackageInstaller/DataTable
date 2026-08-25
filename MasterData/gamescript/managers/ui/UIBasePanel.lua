local CS = _ENV.CS
local typeof = _ENV.typeof
local T_UIExport = typeof(CS.FrameWork.UIExport)
local T_Button = typeof(CS.UnityEngine.UI.Button)
local T_Z1Button = typeof(CS.Z1Client.Z1Button)
local T_Image = typeof(CS.UnityEngine.UI.Image)
local Canvas = CS.UnityEngine.Canvas
local T_CanvasGroup = typeof(CS.UnityEngine.CanvasGroup)
local Vector3 = CS.UnityEngine.Vector3
local Vector3_Zero = CS.UnityEngine.Vector3.zero
local TypeUIGrabPassRawImage = typeof(CS.UIGrabPassRawImage)
local TypeRawImage = typeof(CS.UnityEngine.UI.RawImage)
local DestroyImmediate = _ENV.DestroyImmediate
local UIBasePanel, _ = System.NewClass("UIBasePanel", UIMvvmComponent)

function UIBasePanel:Setup(binder)
  self.viewCompsMgr = UIViewComponentsMgr(self)
  self.binder = binder
  self.loadEnd = false
  self.binder:SetAssetTarget(self)
  self:LoadUI(function(ui, uiNode)
    self.ui = ui
    self:InitUI(uiNode)
    binder:onDestroy(function()
      if AudioManager.Instance and self.audioStop then
        AudioManager.Instance:PostSoundEvent(self.audioStop)
      end
      if self.viewCompsMgr then
        self.viewCompsMgr:Dispose()
        self.viewCompsMgr = nil
      end
      self:OnUnbind()
      if binder.OnDispose then
        binder:OnDispose()
      end
    end)
    CS.Framework.UIUtilTool.ClearAllTextInPrefab(uiNode)
    self:_BindDefaultUI()
  end)
  if not CommonDefine.BackCommandBlacklist[self.url] then
    self:PushBackCommand()
  end
end

function UIBasePanel:OnAddToStage()
  self:UpdateLocalize()
  self:OnBind(self.binder)
  self:OnEnterUI()
  self:HandleGrabRawImage(self.binder, self.root)
  self:HandleBtnMaskEvent(self.binder)
  self.binder:BindEvent(EventMgr.Instance.OpenFullScreenPanel, function()
    self:_OnOpenOtherFullScreenPanel()
  end)
  self:SetIgnorePushBackCommand()
  self.binder:BindTimer(0.2, 0, nil, function()
    self:ReSetIgnorePushBackCommand()
  end)
end

function UIBasePanel:UpdateLocalize()
  self.binder:UpdateLocalizedTextAndResouce(self.root)
end

function UIBasePanel:_GetChildDepth(tf, rootTf, depth)
  if tf ~= rootTf then
    depth = depth + 1
    do return self._GetChildDepth, self, tf.parent, rootTf end
    return self._GetChildDepth, self, tf.parent, rootTf, depth
  end
  return depth
end

function UIBasePanel:PushBackCommand()
  UIBackCommandStack.Push({
    uiPanel = self,
    Execute = function()
      self:Close()
    end
  })
end

function UIBasePanel:IgnorePushBackCommand()
  return self.isIgnorePushBackCommand or false
end

function UIBasePanel:SetIgnorePushBackCommand()
  self.isIgnorePushBackCommand = true
end

function UIBasePanel:ReSetIgnorePushBackCommand()
  self.isIgnorePushBackCommand = nil
end

function UIBasePanel:OnEnterUI()
  self:SetLayer(true)
  if self.audioOpen then
    AudioManager.Instance:PostSoundEvent(self.audioOpen)
  end
  self.loadEnd = true
  
  local function loadEndFunc()
    if self.loadEndCloseCallback then
      self.loadEndCloseCallback()
    end
    self:OnUIOpenAnimFinish()
  end
  
  self:PlayUIAnim(loadEndFunc, true)
end

function UIBasePanel:OnUIOpenAnimFinish()
end

function UIBasePanel:_OnOpenOtherFullScreenPanel()
  self:LoadHideLowerLayerPanelCb(nil)
end

function UIBasePanel:HandleGrabRawImage(binder, uiNode)
  local grabPassRawImage = uiNode:GetComponentInChildren(TypeUIGrabPassRawImage)
  if grabPassRawImage then
    local gameObj = grabPassRawImage.gameObject
    binder:BindTimer(0.5, 0, nil, function()
      if IsNil(gameObj) then
        return
      end
      local rawImage = gameObj:GetComponent(TypeRawImage)
      if rawImage and rawImage.enabled == false then
        grabPassRawImage.enabled = false
        grabPassRawImage.enabled = true
      end
    end)
  end
end

function UIBasePanel:HandleBtnMaskEvent(binder)
  binder:BindEvent(EventMgr.Instance.PopupTipsBtnMaskClick, function()
  end)
end

function UIBasePanel:LoadEndClosePanelCallback(callback)
  self.loadEndCloseCallback = callback
end

function UIBasePanel:OpenAnimCallback()
  if self.hideLowerLayerPanelCb then
    self.hideLowerLayerPanelCb()
  end
end

function UIBasePanel:LoadHideLowerLayerPanelCb(callback)
  self.hideLowerLayerPanelCb = callback
end

function UIBasePanel:CloseAnimCallback()
end

function UIBasePanel:InitUI(uiNode)
  self.root = uiNode
  self.isRendering = true
  self.animator = self.ui.uiNode:GetComponent(typeof(CS.UnityEngine.Animator))
  local uiExport = self.ui.uiNode:GetComponent(T_UIExport)
  if uiExport then
    self.audio = {}
    self.panelCfg = {}
    local audioEventList = uiExport.audioEventList
    for i = 0, audioEventList.Count - 1 do
      self.audio[i + 1] = audioEventList[i]
    end
    self.audioStop = uiExport.stopEvent
    self.audioOpen = uiExport.openEvent
    self.panelCfg.layer = UIDefine.LayerEnum2Layer[uiExport.Layer]
  end
  if not ViewSettings[self.url] or not ViewSettings[self.url].viewType then
    Logger.Error("Please set the panel type in ViewSettings for the url: %s", self.url)
    return
  end
  self.panelCfg.viewType = ViewSettings[self.url].viewType
end

function UIBasePanel:LoadUI(callback)
  if DataCenter.gameData.OpenAsynUI then
    return
  else
    local uiGo
    local panel = UIAsyncLoadMgr.Instance:GetPanel(self.url)
    if panel then
      uiGo = panel:GetGameObject()
      panel:SetVisible(true)
    end
    local ui
    local uiResCls = self:_GetUIResCls()
    if not uiGo then
      ui = PoolManager.Instance:GetUIResource(uiResCls)
      uiGo = ui.uiNode
    else
      ui = uiResCls(uiGo)
    end
    if callback then
      callback(ui, uiGo)
    end
  end
end

function UIBasePanel:_GetUIResCls()
  do return UIManager.GetUIResObj end
  return UIManager.GetUIResObj, self.uiResCls
end

function UIBasePanel:ResetPanel()
end

function UIBasePanel:OnBind(_)
end

function UIBasePanel:OnUnbind(_)
end

function UIBasePanel:SetOpenEndCallback(callback)
  self.openCallback = callback
end

function UIBasePanel:Close(destroyStack)
  if not UIManager.Instance then
    return
  end
  if destroyStack then
    UIManager.Instance:CloseByWindowId(self.windowUid, {destroyStack = true})
  else
    UIManager.Instance:CloseByWindowId(self.windowUid)
  end
end

function UIBasePanel:PlayUIAnim(callback, isOpen)
  self.isInUiAnim = true
  local finalCallback
  local isPlayed = false
  
  function finalCallback()
    if isPlayed then
      return
    end
    isPlayed = true
    self.isInUiAnim = false
    if isOpen and self.OpenAnimCallback then
      self.OpenAnimCallback(self)
    end
    if not isOpen and self.CloseAnimCallback then
      self.CloseAnimCallback(self)
    end
    if callback then
      callback()
    end
  end
  
  if not self.ui.uiNode.activeInHierarchy then
    finalCallback()
    return
  end
  self:PlayUIExportAnimation(self.ui.uiNode, isOpen, finalCallback)
end

function UIBasePanel:IsInUiAnim()
  return self.isInUiAnim
end

function UIBasePanel:PlayUIExportAnimation(gameObject, isOpen, callback, isForce)
  local animPlayTbl = {}
  local longestAnimTime = 0
  local protectTimer
  
  local function finalCallback()
    if protectTimer then
      TimerManager.Instance:StopTimer(protectTimer)
    end
    if callback then
      callback()
    end
  end
  
  local rootUIExport = gameObject:GetComponent(T_UIExport)
  local UIExportList = gameObject:GetComponentsInChildren(T_UIExport, false)
  for i = 0, UIExportList.Length - 1 do
    local uiExport = UIExportList[i]
    if uiExport and uiExport.animController then
      local animClip
      if isOpen then
        animClip = uiExport.openAnim
      else
        animClip = uiExport.closeAnim
      end
      if animClip and (uiExport.isAutoPlayAnim or isForce) then
        local animLength = animClip.length
        longestAnimTime = longestAnimTime < animLength and animLength or longestAnimTime
        table.insert(animPlayTbl, {
          animController = uiExport.animController,
          animName = animClip.name,
          animLength = animLength,
          isRoot = uiExport == rootUIExport
        })
      end
    end
  end
  if 0 ~= #animPlayTbl then
    for _, tbl in pairs(animPlayTbl) do
      if longestAnimTime <= tbl.animLength then
        tbl.animController:PlayState(tbl.animName, function()
          pcall(finalCallback)
        end)
      else
        tbl.animController:PlayState(tbl.animName)
      end
    end
    if not isOpen then
      self:_DisableAllCanvasGroupInteractable()
    end
    protectTimer = TimerManager.Instance:CreateTimer(longestAnimTime + 0.2, 0, nil, function()
      finalCallback()
    end)
  else
    finalCallback()
  end
end

function UIBasePanel:DestroyUI()
  self:_ResumeAllCanvasGroupInteractable()
  self._canvasGroupCfg = nil
  EventMgr.Instance.BeforeClosePanelEvent:Dispatch(self.url)
  
  local function destroyFunc()
    if not self.ui then
      return
    end
    self:_ResumeAllCanvasGroupInteractable()
    if self.viewCompsMgr then
      self.viewCompsMgr:Dispose()
      self.viewCompsMgr = nil
    end
    self.binder:teardown()
    DOTweenUtils.KillAllTweensByTarget(self)
    local uiExport = self.ui.uiNode:GetComponent(typeof(CS.FrameWork.UIExport))
    if not Main.isAppDestroyed then
      pcall(uiExport.ResetObjActive, uiExport)
      local panel = UIAsyncLoadMgr.Instance:GetPanel(self.url)
      if not panel then
        PoolManager.Instance:FreeUI(self.ui)
      else
        panel:Close()
      end
    end
    self.ui = nil
    self.root = nil
    self.animator = nil
    ResLoadMgr.UnloadAssetByTarget(self)
    local onDestroyCallback = self.onDestroyCallback
    self.onDestroyCallback = nil
    if onDestroyCallback then
      onDestroyCallback()
    end
  end
  
  if not self.closeWithoutAnim then
    self:PlayUIAnim(destroyFunc, false)
  else
    destroyFunc()
  end
  UIBackCommandStack.Remove(self)
  EventMgr.Instance.ClosePanelEvent:Dispatch(self.url)
end

function UIBasePanel:_DisableAllCanvasGroupInteractable()
  if self._canvasGroupCfg then
    return
  end
  self._canvasGroupCfg = {}
  local canvasGroups = self.ui.uiNode:GetComponentsInChildren(T_CanvasGroup, true)
  if not canvasGroups or 0 == canvasGroups.Length then
    local tempCanvasGroup = self.ui.uiNode:AddComponent(T_CanvasGroup)
    self._canvasGroupCfg.tempCanvasGroup = tempCanvasGroup
    tempCanvasGroup.interactable = false
    tempCanvasGroup.blocksRaycasts = false
    return
  end
  self._canvasGroupCfg.groups = {}
  for i = 0, canvasGroups.Length - 1 do
    local groupCfg = {}
    groupCfg.canvasGroup = canvasGroups[i]
    groupCfg.interactable = canvasGroups[i].interactable
    groupCfg.blocksRaycasts = canvasGroups[i].blocksRaycasts
    canvasGroups[i].interactable = false
    canvasGroups[i].blocksRaycasts = false
    table.insert(self._canvasGroupCfg.groups, groupCfg)
  end
end

function UIBasePanel:_ResumeAllCanvasGroupInteractable()
  if not self._canvasGroupCfg then
    return
  end
  if self._canvasGroupCfg.tempCanvasGroup then
    DestroyImmediate(self._canvasGroupCfg.tempCanvasGroup, true)
  end
  if self._canvasGroupCfg.groups then
    for i = 1, #self._canvasGroupCfg.groups do
      local groupCfg = self._canvasGroupCfg.groups[i]
      if not IsNil(groupCfg.canvasGroup) then
        groupCfg.canvasGroup.interactable = groupCfg.interactable
        groupCfg.canvasGroup.blocksRaycasts = groupCfg.blocksRaycasts
      end
    end
  end
  self._canvasGroupCfg = nil
end

function UIBasePanel:SetCloseEndCallback(callback)
  self.endCallback = callback
end

function UIBasePanel:SetOnDestroyCallback(callback)
  self.onDestroyCallback = callback
end

function UIBasePanel:PlayAnimator(animName, val, endCallback)
  local animInfo = self:GetAnimNameInfo(animName)
  if not animInfo then
    return false
  end
  AnimatorUtils.PlayBlendParams(self.animator, animInfo.name, animInfo.argType, val)
  AnimatorUtils.SetStateEndInBehavior(self.animator, animName, function()
    if endCallback then
      endCallback()
    end
  end)
  return true
end

function UIBasePanel:GetAnimNameInfo(animName)
  if not (self.animator and self.panelCfg and self.panelCfg.otherAnimName) or not self.panelCfg.otherAnimName[animName] then
    return nil
  end
  return self.panelCfg.otherAnimName[animName]
end

function UIBasePanel:SetRendered(isRendering)
  if not self.binder then
    return
  end
  self.isRendering = isRendering
  self.binder:SetCanvasGroup(self.root, isRendering and 1 or 0)
  if not isRendering then
    self.ui.uiNode.transform.anchoredPosition3D = Vector3(9999, 9999, 0)
  else
    self.ui.uiNode.transform.anchoredPosition3D = Vector3_Zero
  end
end

function UIBasePanel:IsRendering()
  return self.isRendering
end

function UIBasePanel:AfterSetRenderTrue()
end

function UIBasePanel:SetLayer(show)
  if self.root then
    self.binder:SetCanvasGroup(self.root, show and 1 or 0)
    self.binder:SetCanvasGroupBlocksRaycasts(self.root, show)
    self.hidePanel = not show
    if self.hidePanel then
      UIRootMgr.SetLayerRecursively(self.root, "OutUI")
    else
      UIRootMgr.SetLayerRecursively(self.root, "UI")
    end
  end
end

function UIBasePanel:IsHide()
  return self.hidePanel
end

function UIBasePanel:SetCanvasSortLayer(sortId)
  if not self.ui then
    return
  end
  local canvas = self.ui.uiNode:GetComponent(typeof(Canvas))
  if not canvas then
    return
  end
  canvas.overrideSorting = true
  canvas.sortingOrder = sortId
end

function UIBasePanel:_BindDefaultUI()
  self:_InitUIBothSidesAdaptation()
end

function UIBasePanel:_InitUIBothSidesAdaptation()
  if not (self.ui.Adap_Group_Left and self.ui.Adap_Group_Right) or not self.ui.Adap_Spacing then
    return
  end
  local leftUIGroup = {
    [self.ui.Adap_Group_Left] = 0
  }
  local rightUIGroup = {
    [self.ui.Adap_Group_Right] = 0
  }
  leftUIGroup, rightUIGroup = UIManager.Instance:InitBothSidesUIOriPos(leftUIGroup, rightUIGroup)
  UIManager.Instance:UIBothSidesAdaptation(leftUIGroup, rightUIGroup, self.ui.Adap_Spacing.transform.sizeDelta.x)
end

function UIBasePanel:ReserveChildren(transform, num)
  local ct_transform = transform
  local cnt = ct_transform.childCount
  while num > cnt do
    local uiNode = Instantiate(ct_transform:GetChild(0).gameObject, ct_transform)
    cnt = cnt + 1
  end
  return cnt
end

function UIBasePanel:RemoveViewComponentOnce(gameObject, viewComponentCls)
  if not self.viewCompsMgr then
    return
  end
  do return self.viewCompsMgr.RemoveViewComponentOnce, self.viewCompsMgr, gameObject end
  return self.viewCompsMgr.RemoveViewComponentOnce, self.viewCompsMgr, gameObject, viewComponentCls
end

function UIBasePanel:GetViewComponent(gameObject, viewComponentCls)
  if not self.viewCompsMgr then
    return
  end
  do return self.viewCompsMgr.GetViewComponent, self.viewCompsMgr, gameObject end
  return self.viewCompsMgr.GetViewComponent, self.viewCompsMgr, gameObject, viewComponentCls
end

function UIBasePanel:AddViewComponent(gameObject, viewComponentCls, ...)
  if not self.viewCompsMgr then
    return
  end
  do return self.viewCompsMgr.AddViewComponent, self.viewCompsMgr, gameObject, viewComponentCls, ... end
  return self.viewCompsMgr.AddViewComponent, self.viewCompsMgr, gameObject, viewComponentCls, ...
end

function UIBasePanel:AddViewComponentOnce(gameObject, viewComponentCls, ...)
  if not self.viewCompsMgr then
    return
  end
  do return self.viewCompsMgr.AddViewComponentOnce, self.viewCompsMgr, gameObject, viewComponentCls, ... end
  return self.viewCompsMgr.AddViewComponentOnce, self.viewCompsMgr, gameObject, viewComponentCls, ...
end

function UIBasePanel:AddRedPoint(gameObject, redPointID, redArgs)
  if not redPointID then
    error("AddRedPoint redPointID is nil")
  end
  local redPointComp = self:GetViewComponent(gameObject, UICompRedDotNew)
  if not redPointComp then
    redPointComp = self:AddViewComponentOnce(gameObject, UICompRedDotNew, redPointID, redArgs)
  else
    redPointComp:InitRedData(redPointID, redArgs)
  end
end

function UIBasePanel:RemoveRedPoint(gameObject)
  self:RemoveViewComponentOnce(gameObject, UICompRedDotNew)
end

function UIBasePanel:SetActive(owner, isActive)
  if owner.activeSelf ~= isActive then
    owner:SetActive(isActive)
  end
end

function UIBasePanel:FindChild(go, childName)
  local trs = go.transform:Find(childName)
  if trs then
    return trs.gameObject
  end
  return nil
end

function UIBasePanel:GetButton(owner)
  local buttonComp = owner:GetComponent(T_Z1Button)
  if nil == buttonComp then
    buttonComp = owner:GetComponent(T_Button)
  end
  return buttonComp
end

function UIBasePanel:SetImageColorByHtml(owner, colorStr)
  local image = owner:GetComponent(T_Image)
  if not image then
    Logger.Error("BaseView.SetImageColorByHtml中owner参数无效，缺少Image组件")
    return
  end
  local color = ColorUtils.ParseHtmlStringToUnityColor(colorStr, image.color.a)
  image.color = color
end

function UIBasePanel:CenterTableviewContentIfNeeded(scrollView, tableView, itemCount, cellWidth)
  if nil == scrollView or IsNil(tableView) then
    return
  end
  if not (itemCount and not (itemCount <= 0) and cellWidth) or cellWidth <= 0 then
    return
  end
  local viewportWidth = 0
  local viewportTf = scrollView.transform:Find("Viewport")
  if viewportTf then
    local rect = viewportTf:GetComponent(typeof(CS.UnityEngine.RectTransform))
    if rect then
      viewportWidth = rect.rect.width
    end
  end
  if viewportWidth <= 0 then
    local scrollRect = scrollView.transform:GetComponent(typeof(CS.UnityEngine.RectTransform))
    if scrollRect then
      viewportWidth = scrollRect.rect.width
    end
  end
  if viewportWidth <= 0 then
    return
  end
  local tableViewComp = scrollView:GetComponent(typeof(CS.UITableview))
  local spacing = tableViewComp.cellSpacing.x
  local totalContentWidth = itemCount * cellWidth + math.max(0, itemCount - 1) * spacing
  local cellOffset = tableViewComp.cellOffset
  if viewportWidth > totalContentWidth then
    cellOffset.x = (viewportWidth - totalContentWidth) / 2
  else
    cellOffset.x = 0
  end
  tableViewComp.cellOffset = cellOffset
  tableView:Refresh()
end

return UIBasePanel
