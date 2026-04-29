_class("UISideEnterCenterController", UIController)
UISideEnterCenterController = UISideEnterCenterController

function UISideEnterCenterController:_SetCommonTopButton()
  local helpKey = self._tabPages[self._tabIndex]:GetHelpIntrKey()
  local helpCb
  if helpKey then
    function helpCb()
      UIActivityHelper.ShowActivityIntro(helpKey)
    end
  end
  local obj = UIWidgetHelper.SpawnObject(self, "_backBtns", "UINewCommonTopButton")
  obj:SetData(function()
    self:_BackFunc()
  end, helpCb, nil, true)
end

function UISideEnterCenterController:_BackFunc()
  if self:Manager():CurUIStateType() == UIStateType.UISideEnterCenter then
    self:SwitchState(UIStateType.UIMain)
  else
    self:_Shot(function()
      UIWidgetHelper.PlayAnimation(self, "_anim", "uieff_UISideEnterCenterController_out", 333, function()
        UIBgmHelper.PlayMainBgm()
        GameGlobal.EventDispatcher():Dispatch(GameEventType.SideEnterRefresh)
        self:CloseDialog()
      end)
    end)
  end
end

function UISideEnterCenterController:LoadDataOnEnter(TT, res, uiParams)
  self:_LoadData(TT, res, uiParams)
end

function UISideEnterCenterController:OnShow(uiParams)
  self:AttachEvent(GameEventType.OpenContentByCampaignType, self.OpenContentByCampaignType)
  self:ManualSetUnderLayerUIVisble(false)
  self._active = true
  self:AddListener()
  local gridTransform = self:GetUIComponent("RectTransform", "_tabBtns")
  UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(gridTransform)
  self.viewPortWidth = self:GetUIComponent("RectTransform", "Viewport").rect.width
  self.contentRect = self:GetUIComponent("RectTransform", "_tabBtns")
  self._shot = self:GetUIComponent("H3DUIBlurHelper", "shot")
  self:_SetTabSelect_OnShow(self._firstPageIndex, self._firstPageParams)
  self._BottomCanvasGroup = self:GetUIComponent("CanvasGroup", "FullScreenArea")
  self._BackCanvasGroup = self:GetUIComponent("CanvasGroup", "_backBtns")
  local tipsPool = self:GetUIComponent("UISelectObjectPath", "tipsPool")
  self._tipsInfo = tipsPool:SpawnObject("UISelectInfo")
end

function UISideEnterCenterController:OnHide()
  self:DetachListener()
  if self._playerTweener then
    self._playerTweener:Kill()
    self._playerTweener = nil
  end
  if self._contentTweener then
    self._contentTweener:Kill()
    self._contentTweener = nil
  end
  self._active = false
  if self._shot then
    self._shot:CleanRenderTexture()
  end
  self:ManualSetUnderLayerUIVisble(true)
end

function UISideEnterCenterController:OnUpdate(deltaTimeMS)
  local content
  local tabPage = self._tabPages[self._tabIndex]
  if tabPage ~= nil then
    content = tabPage:GetContent()
  end
  if content and content:IsEnableUpdate() then
    content:DoUpdate(deltaTimeMS)
  end
end

function UISideEnterCenterController:_CalcCenterParams(uiParams)
  local tb = uiParams and uiParams[1] or {}
  self._singleMode = tb.single_mode or false
end

function UISideEnterCenterController:_CalcFirstTab(uiParams)
  local tb = uiParams and uiParams[1] or {}
  for i, v in ipairs(self._showTb) do
    local cfg = v._mainCfg
    local contentParams = cfg and cfg.ContentParams
    if tb.campaign_id then
      if tb.campaign_id == contentParams.campaign_id then
        return i, tb.params
      end
    elseif tb.campaign_type and tb.campaign_type == contentParams.campaign_type then
      return i, tb.params
    end
  end
end

function UISideEnterCenterController:_CalcPreLoadPages()
  return {
    self._firstPageIndex
  }
end

function UISideEnterCenterController:_LoadData(TT, res, uiParams)
  local lockName = "UISideEnterCenterController_LoadData"
  GameGlobal.UIStateManager():Lock(lockName)
  local campModule = self:GetModule(CampaignModule)
  campModule:LoadCampaignInfoListTask(TT)
  self:_LoadTabBtnData(TT)
  self:_CalcCenterParams(uiParams)
  self._firstPageIndex, self._firstPageParams = self:_CalcFirstTab(uiParams)
  if self._singleMode and self._firstPageIndex == nil then
    res:SetSucc(false)
    ToastManager.ShowToast(StringTable.Get("str_activity_error_109"))
    Log.error("UISideEnterCenterController:_LoadData() single mode and first page is nil, 活动中心 单窗口模式 传入参数找不到要显示的页签")
    GameGlobal.UIStateManager():UnLock(lockName)
    UIWidgetHelper.ClearWidgets(self, "_centerLoaderPool")
    return false
  end
  self._firstPageIndex = self._firstPageIndex or 1
  self:_SetSingleMode(self._singleMode)
  self:_SetTabBtns(self._showTb)
  self:_SetTabPages(self._showTb)
  if #self._showTb == 0 then
    Log.error("UISideEnterCenterController:_LoadData() tab count == 0, 活动中心没有可显示的内容")
    if res then
      res:SetSucc(false)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.SideEnterRefresh)
      ToastManager.ShowToast(StringTable.Get("str_activity_error_109"))
    else
      self:_BackFunc()
    end
    GameGlobal.UIStateManager():UnLock(lockName)
    return false
  end
  local preLoadPages = self:_CalcPreLoadPages()
  for _, v in ipairs(preLoadPages) do
    self:_LoadTabPageData(TT, v)
  end
  GameGlobal.UIStateManager():UnLock(lockName)
  return true
end

function UISideEnterCenterController:_LoadDataAndRefresh()
  if self._refreshTaskId and self._refreshTaskId ~= -1 then
    return
  end
  if self._transitionMask == nil then
    self._transitionMask = self:GetUIComponent("CanvasGroup", "transitionMask")
  end
  local lockName = "UISideEnterCenterController:_LoadDataAndRefresh()"
  GameGlobal.UIStateManager():Lock(lockName)
  self._refreshTaskId = TaskManager:GetInstance():StartTask(function(TT)
    self:_TransitionMask(TT, 0, 1, true, 100)
    self:_SwitchTabPage(TT, 0)
    if not self:_LoadData(TT) then
      GameGlobal.UIStateManager():UnLock(lockName)
      self._refreshTaskId = nil
      return
    end
    local index = 1
    self:_SwitchTabPage(TT, index)
    self:_SwitchTabBtn(index)
    self:_TransitionMask(TT, 1, 0, false, 100)
    GameGlobal.UIStateManager():UnLock(lockName)
    self._refreshTaskId = nil
  end)
end

function UISideEnterCenterController:_TransitionMask(TT, alphaBegin, alphaEnd, visibleEnd, transLen)
  local transTick = 0
  local transAlpha = alphaBegin
  local speed = (alphaEnd - alphaBegin) / transLen
  local instGameGlobal = GameGlobal:GetInstance()
  self._transitionMask.gameObject:SetActive(true)
  self._transitionMask.alpha = transAlpha
  while transLen > transTick do
    local deltaTime = instGameGlobal:GetDeltaTime()
    transTick = transTick + deltaTime
    transAlpha = transAlpha + deltaTime * speed
    transAlpha = math.max(transAlpha, 0)
    transAlpha = math.min(transAlpha, 1)
    self._transitionMask.alpha = transAlpha
    YIELD(TT)
  end
  self._transitionMask.gameObject:SetActive(visibleEnd)
end

function UISideEnterCenterController:_LoadTabBtnData(TT)
  local cfgList = UISideEnterConst.GetCfgList_SideEnterCenter()
  self._showTb = UISideEnterConst.SpawnSideEnterLoader(TT, self, "_centerLoaderPool", cfgList, function()
    self:_LoadDataAndRefresh()
  end, function()
  end)
end

function UISideEnterCenterController:_LoadTabPageData(TT, index)
  if index and self._tabPages[index] then
    return self._tabPages[index]:LoadData(TT)
  end
  return true
end

function UISideEnterCenterController:_SetSingleMode(singleMode)
  self:GetGameObject("ScrollView"):SetActive(not singleMode)
end

function UISideEnterCenterController:_SetHideUIMode(hide)
  self:GetGameObject("_backBtns"):SetActive(not hide)
  if not self._singleMode then
    self:GetGameObject("ScrollView"):SetActive(not hide)
  end
end

function UISideEnterCenterController:_SetTabBtns(showTb)
  self._tabBtns = UIWidgetHelper.SpawnObjects(self, "_tabBtns", "UIActivityCommonTextTabBtn", #showTb)
  for i, v in ipairs(self._tabBtns) do
    v:SetData(i, {
      indexWidgets = {},
      onoffWidgets = {
        {"OnBtn"},
        {"OffBtn"}
      },
      lockWidgets = {},
      titleWidgets = {},
      titleText = "",
      callback = function(index, isOffBtnClick)
        if isOffBtnClick then
          self:_SetTabSelect(index)
        end
      end
    })
  end
end

function UISideEnterCenterController:_SetTabPages(showTb)
  self._tabPages = UIWidgetHelper.SpawnObjects(self, "_tabPages", "UISideEnterCenterTabPage", #showTb)
  for i, v in ipairs(self._tabPages) do
    v:SetData(ESideEnterContentType.Center, function()
    end, function(hide)
      self:_SetHideUIMode(hide)
    end, showTb[i]._mainCfg)
  end
end

function UISideEnterCenterController:_SetTabSelect_OnShow(index, params)
  self._tabIndex = index
  self._tabPages[index]:OnSelect(params)
  if index and self._tabBtns[index] then
    self._tabPages[index]:GetGameObject():SetActive(true)
  end
  self:_SwitchTabBtn(index)
end

function UISideEnterCenterController:GetCurContentWigetObject()
  if self._tabPages and self._tabIndex then
    local tab = self._tabPages[self._tabIndex]
    if tab then
      return tab:GetGameObject(), tab
    end
  end
end

function UISideEnterCenterController:_SetTabSelect(index, params)
  if self._tabIndex == index then
    return
  end
  if self._switchTaskId and self._switchTaskId ~= -1 then
    return
  end
  if index == nil then
    return
  end
  local lockName = "UISideEnterCenterController:_SetTabSelect_" .. index
  GameGlobal.UIStateManager():Lock(lockName)
  self._switchTaskId = TaskManager:GetInstance():StartTask(function(TT)
    local res = self:_LoadTabPageData(TT, index)
    if not res then
      GameGlobal.UIStateManager():UnLock(lockName)
      self._switchTaskId = nil
      return
    end
    self:_RefreshOtherShowTbBtns()
    self:_SwitchTabPage(TT, index, params)
    self:_SwitchTabBtn(index)
    GameGlobal.UIStateManager():UnLock(lockName)
    self._switchTaskId = nil
  end)
end

function UISideEnterCenterController:_RefreshOtherShowTbBtns()
  local changed = false
  for i = 1, #self._showTb do
    local cfg = self._showTb[i]:GetCfg()
    local btnKey = cfg.BtnKey
    local btnCfg = UISideEnterConst.GetCfg_SideEnterBtn(btnKey)
    if self._showTb[i]:IsEnable() and not UISideEnterBtnConst.CheckOpen(nil, btnCfg) then
      self._showTb[i]:Enable(false)
      self._tabBtns[i]:Enable(false)
      changed = true
    end
  end
  if changed then
    UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.contentRect)
  end
end

function UISideEnterCenterController:_IsTabEnable(tabIndex)
  if tabIndex > #self._showTb or tabIndex < 1 then
    return false
  end
  return self._showTb[tabIndex]:IsEnable()
end

function UISideEnterCenterController:_SwitchTabPage(TT, index, params)
  local preIndex = self._tabIndex
  self._tabIndex = index
  if preIndex and self._tabPages[preIndex] then
    self._tabPages[preIndex]:OnDeselect()
  end
  if index and self._tabPages[index] then
    self._tabPages[index]:OnSelect(params)
  end
  if preIndex and self._tabPages[preIndex] then
    self._tabPages[preIndex]:GetGameObject():SetActive(false)
  end
  if index and self._tabPages[index] then
    self._tabPages[index]:GetGameObject():SetActive(true)
  end
end

function UISideEnterCenterController:_SwitchTabBtn(index)
  for i = 1, #self._tabBtns do
    self._tabBtns[i]:SetSelected(i == index)
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.SideEnterTabRefresh)
  self:_SetTabBtnPosition(index)
  self:_SetTabBtnEffect(index)
  self:_SetCommonTopButton()
end

function UISideEnterCenterController:_SetTabBtnPosition(index)
  local btnTrans = self._tabBtns[index]:GetGameObject():GetComponent(typeof(UnityEngine.RectTransform))
  local posX = btnTrans.anchoredPosition.x
  local curPos = self.contentRect.anchoredPosition.x
  local width = self.contentRect.rect.width
  local areaWidth = 120
  local targetPos
  local min = math.min(areaWidth - posX, 0)
  local max = math.max(self.viewPortWidth - (posX + areaWidth), self.viewPortWidth - width)
  if curPos < min then
    targetPos = min
  elseif curPos > max then
    targetPos = max
  end
  if targetPos then
    if self._contentTweener and self._contentTweener:IsPlaying() then
      self._contentTweener:Kill()
    end
    self._contentTweener = self.contentRect:DOAnchorPosX(targetPos, 0.4):SetEase(DG.Tweening.Ease.OutQuint)
  end
end

function UISideEnterCenterController:_SetTabBtnEffect(index)
  if index and self._tabBtns[index] then
    local target = self._tabBtns[index]:GetGameObject().transform
    local trans = self:GetUIComponent("RectTransform", "_selectBg")
    local duration = 0.3
    local tx = target.localPosition.x
    if self._playerTweener and self._playerTweener:IsPlaying() then
      self._playerTweener:Kill()
    end
    self._playerTweener = trans:DOLocalMoveX(tx, duration, true):SetEase(DG.Tweening.Ease.OutQuint)
  end
end

function UISideEnterCenterController:_Shot(callback)
  local shot = self:GetScreenShot()
  shot.gameObject:SetActive(true)
  shot.OwnerCamera = GameGlobal.UIStateManager():GetControllerCamera(self:GetName())
  local rt = shot:RefreshBlurTexture()
  local cache_rt = UnityEngine.RenderTexture:New(UnityEngine.Screen.width, UnityEngine.Screen.height, 16)
  cache_rt.format = UnityEngine.RenderTextureFormat.RGB111110Float
  GameGlobal.TaskManager():StartTask(function(TT)
    YIELD(TT)
    if not self._active then
      return
    end
    UnityEngine.Graphics.Blit(rt, cache_rt)
    local a = self:GetUIComponent("RawImage", "rt")
    a.texture = cache_rt
    self:_HideUi()
    callback()
  end)
end

function UISideEnterCenterController:_HideUi()
  self:GetGameObject("rt"):SetActive(true)
  self:GetGameObject("shot"):SetActive(false)
  self:GetGameObject("ScrollView"):SetActive(false)
  self:GetGameObject("_tabPages"):SetActive(false)
  self:GetGameObject("_backBtns"):SetActive(false)
end

function UISideEnterCenterController:LastBtnOnClick(go)
  local cur = self._tabIndex or 1
  for i = cur - 1, 1, -1 do
    if self:_IsTabEnable(i) then
      self:_SetTabSelect(i)
      return
    end
  end
end

function UISideEnterCenterController:NextBtnOnClick(go)
  local cur = self._tabIndex or 1
  for i = cur + 1, #self._showTb do
    if self:_IsTabEnable(i) then
      self:_SetTabSelect(i)
      return
    end
  end
end

function UISideEnterCenterController:AddListener()
  self:AttachEvent(GameEventType.OnCampaignCenterShowItemTips, self.ShowItemTips)
end

function UISideEnterCenterController:ShowItemTips(id, pos)
  if self._tipsInfo then
    self._tipsInfo:SetData(id, pos)
  end
end

function UISideEnterCenterController:DetachListener()
  self:DetachEvent(GameEventType.OnCampaignCenterShowItemTips, self.ShowItemTips)
end

function UISideEnterCenterController:OnActivityCloseEvent(id)
end

function UISideEnterCenterController:GetScreenShot()
  return self._shot
end

function UISideEnterCenterController:OpenContentByCampaignType(param)
  local uiParams = {}
  uiParams[1] = param
  local i, p = self:_CalcFirstTab(uiParams)
  self:_SetTabSelect(i, p)
end

function UISideEnterCenterController:HideEntry(withAnim)
  self._BottomCanvasGroup.blocksRaycasts = false
  self._BackCanvasGroup.blocksRaycasts = false
  if withAnim then
    UIWidgetHelper.PlayAnimation(self, "_anim", "uieff_UISideEnterCenterController_hide", 366)
  else
    self._BottomCanvasGroup.alpha = 0
    self._BackCanvasGroup.alpha = 0
  end
end

function UISideEnterCenterController:ShowEntry(withAnim)
  if withAnim then
    UIWidgetHelper.PlayAnimation(self, "_anim", "uieff_UISideEnterCenterController_back", 627, function()
      self._BottomCanvasGroup.blocksRaycasts = true
      self._BackCanvasGroup.blocksRaycasts = true
    end)
  else
    self._BottomCanvasGroup.blocksRaycasts = true
    self._BackCanvasGroup.blocksRaycasts = true
    self._BottomCanvasGroup.alpha = 1
    self._BackCanvasGroup.alpha = 1
  end
end
