_class("UIChangeHeadController", UIController)
UIChangeHeadController = UIChangeHeadController

function UIChangeHeadController:OnShow(uiParams)
  self._playerInfo = uiParams[1]
  self._closeCB = uiParams[2]
  self._roleModule = self:GetModule(RoleModule)
  self._roleHeadID = self._playerInfo.m_nHeadImageID
  self._currHeadID = self._roleHeadID
  self._roleHeadBgID = self._playerInfo.m_nHeadColorID
  self._currHeadBgID = self._roleHeadBgID
  self._roleHeadFrameID = self._roleModule:GetHeadFrameID()
  if not self._roleHeadFrameID or self._roleHeadFrameID == 0 then
    self._roleHeadFrameID = HelperProxy:GetInstance():GetHeadFrameDefaultID()
    self._currHeadFrameID = HelperProxy:GetInstance():GetHeadFrameDefaultID()
  else
    self._currHeadFrameID = self._roleHeadFrameID
  end
  self._headLock = false
  self._headFrameLock = false
  self._error2str = {
    [ROLE_RESULT_CODE.ROLE_ERROR_HEAD_FRAME_LOCK] = "str_player_info_ROLE_ERROR_HEAD_FRAME_LOCK",
    [ROLE_RESULT_CODE.ROLE_ERROR_HEAD_FRAME_LOCK_CONDITION] = "str_player_info_ROLE_ERROR_HEAD_FRAME_LOCK_CONDITION",
    [ROLE_RESULT_CODE.ROLE_ERROR_HEAD_IMAGE_LOCK] = "str_player_info_ROLE_ERROR_HEAD_IMAGE_LOCK",
    [ROLE_RESULT_CODE.ROLE_ERROR_HEAD_IMAGE_LOCK_CONDITION] = "str_player_info_ROLE_ERROR_HEAD_IMAGE_LOCK_CONDITION",
    [ROLE_RESULT_CODE.ROLE_ERROR_INVALID_DATA] = "str_player_info_ROLE_ERROR_INVALID_DATA"
  }
  self:_GetComponents()
  self._atlas = self:GetAsset("UIPlayerInfo.spriteatlas", LoadType.SpriteAtlas)
  self._cfg_tag = Cfg.cfg_player_head_filter({})
  self._cfg_count = table.count(self._cfg_tag)
  self._itemCountPerRow = 5
  self._currTag = 0
  self._selectHead = UIChangeHeadControllerState.Head
  self:_OnValue()
  self:InitToggleShowDan()
  self:AttachEvent(GameEventType.OnPlayerHeadInfoChanged, self.OnPlayerHeadInfoChanged)
end

function UIChangeHeadController:ShowCurrentHeadInfo()
  self:ShowCurrHead()
  self:ShowCurrHeadBg()
  self:ShowCurrHeadFrame()
  self:ShowDesc()
  self:ShowUnLockConditions()
  self:CheckOKBtnState()
end

function UIChangeHeadController:ShowDesc()
  local desc = ""
  if self._selectHead == UIChangeHeadControllerState.Head then
    local cfg_head = Cfg.cfg_role_head_image[self._currHeadID]
    if cfg_head then
      desc = StringTable.Get(cfg_head.Desc)
    end
  elseif self._selectHead == UIChangeHeadControllerState.Frame then
    local cfg_head = Cfg.cfg_role_head_frame[self._currHeadFrameID]
    if cfg_head then
      desc = StringTable.Get(cfg_head.Desc)
    end
  elseif self._selectHead == UIChangeHeadControllerState.Bg then
    desc = StringTable.Get("str_player_info_head_bg_desc")
  end
  self._currHeadDesc:SetText(desc)
end

function UIChangeHeadController:ShowCurrHeadFrame()
  local cfg_head_frame = Cfg.cfg_role_head_frame[self._currHeadFrameID]
  if cfg_head_frame == nil then
    local fid = HelperProxy:GetInstance():GetHeadFrameDefaultID()
    Log.fatal("###playerinfo - cfg_role_head_frame is nil ! id ", self._currHeadFrameID)
    cfg_head_frame = Cfg.cfg_role_head_frame[fid]
  end
  if cfg_head_frame then
    self._currFrame:LoadImage(cfg_head_frame.Icon)
  end
end

function UIChangeHeadController:OnPlayerHeadInfoChanged()
  self._playerInfo = self._roleModule:UI_GetPlayerInfo()
  self._roleHeadID = self._playerInfo.m_nHeadImageID
  self._currHeadID = self._roleHeadID
  self._roleHeadBgID = self._playerInfo.m_nHeadColorID
  self._currHeadBgID = self._roleHeadBgID
  self._roleHeadFrameID = self._roleModule:GetHeadFrameID()
  self._currHeadFrameID = self._roleHeadFrameID
  self:CheckOKBtnState()
end

function UIChangeHeadController:OnHide()
  if self._unLockTween then
    GameGlobal.Timer():CancelEvent(self._unLockTween)
    self._unLockTween = nil
  end
end

function UIChangeHeadController:_GetComponents()
  self._headTagGroup = self:GetUIComponent("UISelectObjectPath", "headTagGroup")
  self._currHeadBg = self:GetUIComponent("UICircleMaskLoader", "headBg")
  self._currHeadIcon = self:GetUIComponent("RawImageLoader", "headIcon")
  self._currHeadIconRect = self:GetUIComponent("RectTransform", "headIcon")
  self._currFrame = self:GetUIComponent("RawImageLoader", "frame")
  self._currHeadDesc = self:GetUIComponent("UILocalizationText", "headDesc")
  self._changeBtn = self:GetUIComponent("Button", "changeBtn")
  self._changeBtnShow = self:GetGameObject("changeBtnShow")
  self._conditions = self:GetUIComponent("UISelectObjectPath", "conditions")
  self._headScrollViewGo = self:GetGameObject("headScrollView")
  self._headBgScrollViewGo = self:GetGameObject("headBgScrollView")
  self._headFrameScrollViewGo = self:GetGameObject("headFrameScrollView")
  self._headScrollView = self:GetUIComponent("UIDynamicScrollView", "headScrollView")
  self._headBgScrollView = self:GetUIComponent("UIDynamicScrollView", "headBgScrollView")
  self._headFrameScrollView = self:GetUIComponent("UIDynamicScrollView", "headFrameScrollView")
  self._goNoCondition = self:GetGameObject("noCondition")
  self._headGroup = self:GetGameObject("headGroup")
  self._conditionGroup = self:GetGameObject("conditionGroup")
  self._changeBtnAnim = self:GetUIComponent("Animation", "changeBtn")
  self._selectFrameImg = self:GetGameObject("selectChangeFrame")
  self._selectBgImg = self:GetGameObject("selectChangeBg")
  self._danBadgeGen = self:GetUIComponent("UISelectObjectPath", "DanBadgeSimpleGen")
  self._danBadgeGenGo = self:GetGameObject("DanBadgeSimpleGen")
  self._danBadgeGenRect = self:GetUIComponent("RectTransform", "DanBadgeSimpleGen")
  self._ChangeFrameRedObj = self:GetGameObject("ChangeFrameRed")
  self._ChangeFrameRedObj:SetActive(false)
end

function UIChangeHeadController:ShowBtn()
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._changeBtn.gameObject), UIEvent.Hovered, function(go)
    if self._isDown and self._changeBtn.interactable then
      self._changeBtnShow:SetActive(true)
    end
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._changeBtn.gameObject), UIEvent.Press, function(go)
    self._isDown = true
    if self._changeBtn.interactable then
      self._changeBtnShow:SetActive(true)
    end
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._changeBtn.gameObject), UIEvent.Release, function(go)
    self._isDown = false
    self._changeBtnShow:SetActive(false)
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._changeBtn.gameObject), UIEvent.Unhovered, function(go)
    self._changeBtnShow:SetActive(false)
  end)
end

function UIChangeHeadController:UI_GetHeadFrameList()
  local cfg = Cfg.cfg_role_head_frame({})
  local frameList = {}
  for i, v in HelperProxy:GetInstance():pairsByKeys(cfg) do
    local headFrame = {}
    headFrame.ID = v[1]
    headFrame.Icon = v[3]
    table.insert(frameList, headFrame)
  end
  return frameList
end

function UIChangeHeadController:_OnValue()
  self:ShowBtn()
  self._tmpheadList = self._roleModule:UI_GetHeadImageListByTag(self._currTag)
  self:CheckHeadActive()
  self._headCount = table.count(self._headList)
  self._headBgList = self._roleModule:UI_GetHeadBgList()
  self._headBgCount = table.count(self._headBgList)
  self._tmpHeadFrameList = self:UI_GetHeadFrameList()
  self:CheckHeadFrameActive()
  self._headFrameCount = table.count(self._headFrameList)
  self._headTagGroup:SpawnObjects("UIHeadTagItem", self._cfg_count)
  self._tagItems = self._headTagGroup:GetAllSpawnList()
  for i = 1, self._cfg_count do
    self._tagItems[i]:SetData(self._cfg_tag[i], self._currTag, function(tag)
      self:FilterHeadByTag(tag)
    end)
  end
  self:CheckHeadTagRedActive()
  self:_InitHeadBgScrollView()
  self:_InitHeadSrollView()
  self:_InitHeadFrameScrollView()
  self:ShowHeadAndBgPanel()
  self:ShowCurrentHeadInfo()
end

function UIChangeHeadController:CheckHeadActive()
  self._headList = {}
  local cfg_head = Cfg.cfg_role_head_image({})
  for i = 1, #self._tmpheadList do
    local hide = false
    local headitem = self._tmpheadList[i] or nil
    local isOpen = false
    local canUnLock = false
    if headitem then
      local lockInfo = self._roleModule:UI_GetHeadImageLockInfo(headitem.m_nImageID)
      if not lockInfo.m_bLock or table.count(lockInfo.m_lockConditionList) == 0 then
        isOpen = true
      end
      if not isOpen then
        canUnLock = self._roleModule:UI_CheckLockConditionNew(lockInfo)
      end
    end
    if headitem and not isOpen and not canUnLock then
      local cfg_head_item = cfg_head[headitem.m_nImageID]
      if cfg_head_item.LockHide and cfg_head_item.LockHide == 1 then
        hide = true
      end
    end
    if headitem and not hide then
      table.insert(self._headList, headitem)
    end
  end
end

function UIChangeHeadController:CheckHeadTagRedActive()
  self._tagItems = self._headTagGroup:GetAllSpawnList()
  for i = 1, #self._tagItems do
    local item = self._tagItems[i]
    local tag = item._tag
    local headRed = false
    local tmpheadList = self._roleModule:UI_GetHeadImageListByTag(tag)
    for i = 1, #tmpheadList do
      local headitem = tmpheadList[i] or nil
      local isOpen = false
      local canUnLock = false
      if headitem then
        local lockInfo = self._roleModule:UI_GetHeadImageLockInfo(headitem.m_nImageID)
        if not lockInfo.m_bLock or table.count(lockInfo.m_lockConditionList) == 0 then
          isOpen = true
        end
        if not isOpen then
          canUnLock = self._roleModule:UI_CheckLockConditionNew(lockInfo)
        end
      end
      if not isOpen and canUnLock then
        headRed = true
      end
    end
    item:ShowRed(headRed)
  end
end

function UIChangeHeadController:CheckHeadFrameActive()
  self._headFrameList = {}
  local cfg_head_frame = Cfg.cfg_role_head_frame({})
  local showFrameRed = false
  for i = 1, #self._tmpHeadFrameList do
    local hide = false
    local frame = self._tmpHeadFrameList[i] or nil
    local canUnLock = false
    local isOpen = false
    if frame then
      local lockInfo = self._roleModule:UI_GetHeadFrameLockInfo(frame.ID)
      if not lockInfo.m_bLock or table.count(lockInfo.m_lockConditionList) == 0 then
        isOpen = true
      end
      if not isOpen then
        canUnLock = self._roleModule:UI_CheckLockConditionNew(lockInfo)
      end
    end
    if frame and not isOpen and not canUnLock then
      local cfg_head_frame_item = cfg_head_frame[frame.ID]
      if cfg_head_frame_item.LockHide and cfg_head_frame_item.LockHide == 1 then
        hide = true
      end
    end
    if frame and not hide then
      table.insert(self._headFrameList, frame)
    end
    if not isOpen and canUnLock then
      showFrameRed = true
    end
  end
  self._ChangeFrameRedObj:SetActive(showFrameRed)
end

function UIChangeHeadController:backOnClick()
  if self._closeCB then
    self._closeCB()
    self._closeCB = nil
  end
  self:CloseDialog()
end

function UIChangeHeadController:FilterHeadByTag(tag)
  if self._currTag ~= tag then
    self._currTag = tag
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnChangeHeadTagBtnClick, tag)
    self._selectHead = UIChangeHeadControllerState.Head
    self:ShowHeadAndBgPanel()
    self:CheckOKBtnState()
    self:RefreshHeadList()
    self:ShowUnLockConditions()
    self:ShowDesc()
  end
end

function UIChangeHeadController:RefreshHeadList()
  self._tmpheadList = self._roleModule:UI_GetHeadImageListByTag(self._currTag)
  self:CheckHeadActive()
  self._headCount = table.count(self._headList)
  self._headScrollView:SetListItemCount(self:GetRowCount())
  self:CheckCurrHeadInner()
end

function UIChangeHeadController:_InitHeadSrollView()
  self._headScrollView:InitListView(self:GetRowCount(), function(scrollView, index)
    return self:InitHeadList(scrollView, index)
  end)
  self:CheckCurrHeadInner()
end

function UIChangeHeadController:GetRowCount()
  local row = math.ceil(self._headCount / self._itemCountPerRow)
  return row
end

function UIChangeHeadController:InitHeadList(scrollView, index)
  if index < 0 then
    return nil
  end
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UIHeadItem", self._itemCountPerRow)
  end
  local rowList = rowPool:GetAllSpawnList()
  for i = 1, self._itemCountPerRow do
    local heartItem = rowList[i]
    local itemIndex = index * self._itemCountPerRow + i
    self:ShowHeadItem(heartItem, itemIndex)
  end
  return item
end

function UIChangeHeadController:ShowHeadItem(item, index)
  local headitem = self._headList[index] or nil
  local isOpen = false
  local canUnLock = false
  if headitem then
    local lockInfo = self._roleModule:UI_GetHeadImageLockInfo(headitem.m_nImageID)
    if not lockInfo.m_bLock or table.count(lockInfo.m_lockConditionList) == 0 then
      isOpen = true
    end
    if not isOpen then
      canUnLock = self._roleModule:UI_CheckLockConditionNew(lockInfo)
    end
  end
  if GameSingle then
    isOpen = true
    canUnLock = true
  end
  item:GetGameObject():SetActive(true)
  item:SetData(index, headitem, isOpen, canUnLock, self._currHeadID, function(tIndex)
    self:HeadItemClick(tIndex)
  end)
end

function UIChangeHeadController:ChangeHeadTween()
  self:Lock("ChangeHeadTween")
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnPlayerChangeHeadItemClick, self._currHeadID)
  self:ShowCurrHead()
  self:CheckOKBtnState()
  self:ShowUnLockConditions()
  self:ShowDesc()
  self._headGroup:SetActive(false)
  self._conditionGroup:SetActive(false)
  self._tweener1 = GameGlobal.Timer():AddEvent(50, function()
    self._headGroup:SetActive(true)
    self._conditionGroup:SetActive(true)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnPlayerChangeHeadItemClick, 0)
    self._tweener2 = GameGlobal.Timer():AddEvent(50, function()
      GameGlobal.EventDispatcher():Dispatch(GameEventType.OnPlayerChangeHeadItemClick, self._currHeadID)
      self:UnLock("ChangeHeadTween")
      self:CheckHeadTagRedActive()
    end)
  end)
end

function UIChangeHeadController:HeadItemClick(idx)
  local headiitem = self._headList[idx]
  local headid = headiitem.m_nImageID
  if headid and self._currHeadID ~= headid then
    local lockInfo = self._roleModule:UI_GetHeadImageLockInfo(headid)
    local isOpen = false
    if not lockInfo.m_bLock or table.count(lockInfo.m_lockConditionList) == 0 then
      isOpen = true
    end
    local canUnLock = false
    if isOpen then
      self._headLock = false
    else
      self._headLock = true
      canUnLock = self._roleModule:UI_CheckLockConditionNew(lockInfo)
    end
    if isOpen then
      self._currHeadID = headid
      self:ChangeHeadTween()
    elseif canUnLock then
      self:Lock("lockHeadReq")
      self:StartTask(function(TT)
        local res = self._roleModule:Request_ClearHeadImageLock(TT, headid)
        self:UnLock("lockHeadReq")
        if res:GetSucc() then
          self._headLock = false
          self._currHeadID = headid
          self:ChangeHeadTween()
          GameGlobal.EventDispatcher():Dispatch(GameEventType.HideHeadRedPoint, self._currHeadID)
        else
          local result = res:GetResult()
          Log.debug("###[UIChangeHeadController]player info - roleModule:Request_ClearHeadImageLock result - ", result)
          local tips = ""
          if self._error2str[result] then
            tips = StringTable.Get(self._error2str[result])
          end
          ToastManager.ShowToast(tips)
        end
      end, self)
    else
      self._currHeadID = headid
      self:ChangeHeadTween()
    end
  end
end

function UIChangeHeadController:ShowCurrHead()
  local cfg_head = Cfg.cfg_role_head_image[self._currHeadID]
  if cfg_head then
    self._currHeadIcon:LoadImage(cfg_head.Icon)
    HelperProxy:GetInstance():GetHeadIconSizeWithTag(self._currHeadIconRect, cfg_head.Tag)
  else
    Log.error("###[UIChangeHeadController]playerinfo - cfg_role_head_image is nil ! id ", self._currHeadID)
  end
  UIWorldBossHelper.InitSelfDanBadgeSimple(self._danBadgeGen, self._danBadgeGenGo, self._danBadgeGenRect)
end

function UIChangeHeadController:InitToggleShowDan()
  self.tgl = self:GetUIComponent("Toggle", "toggle")
  local l_role_module = GameGlobal.GetModule(RoleModule)
  local curSwitch = l_role_module:GetBadgeSwitch()
  self:ToggleOnClick(curSwitch, true)
end

function UIChangeHeadController:ToggleOnClick(curSwitch, first)
  if first then
    self.danSwitch = curSwitch
  end
  self.tgl.isOn = self.danSwitch
  if not first then
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundDefaultClick)
    if self.danSwitch then
      ToastManager.ShowToast(StringTable.Get("str_role_head_image_dan_setting_open"))
    else
      ToastManager.ShowToast(StringTable.Get("str_role_head_image_dan_setting_close"))
    end
    local l_role_module = GameGlobal.GetModule(RoleModule)
    l_role_module:PushBadgeSwitchSetting(self.danSwitch)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnPlayerChangeHeadBadgeClick)
  end
  if self.danSwitch then
    UIWorldBossHelper.InitSelfDanBadgeSimple(self._danBadgeGen, self._danBadgeGenGo, self._danBadgeGenRect)
    self._danBadgeGenGo:SetActive(true)
  else
    self._danBadgeGenGo:SetActive(false)
  end
  self.danSwitch = not self.danSwitch
end

function UIChangeHeadController:_InitHeadBgScrollView()
  self._headBgScrollView:InitListView(self:GetBgRowCount(), function(scrollView, index)
    return self:InitHeadBgList(scrollView, index)
  end)
  self:CheckCurrHeadBgInner()
end

function UIChangeHeadController:GetBgRowCount()
  local row = math.ceil(self._headBgCount / self._itemCountPerRow)
  return row
end

function UIChangeHeadController:InitHeadBgList(scrollView, index)
  if index < 0 then
    return nil
  end
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UIHeadBgItem", self._itemCountPerRow)
  end
  local rowList = rowPool:GetAllSpawnList()
  for i = 1, self._itemCountPerRow do
    local heartItem = rowList[i]
    local itemIndex = index * self._itemCountPerRow + i
    self:ShowHeadBgItem(heartItem, itemIndex)
  end
  return item
end

function UIChangeHeadController:ShowHeadBgItem(item, index)
  local headbgid = self._headBgList[index] or nil
  item:GetGameObject():SetActive(true)
  item:SetData(index, headbgid, self._currHeadBgID, function(tIndex)
    self:HeadBgItemClick(tIndex)
  end)
end

function UIChangeHeadController:HeadBgItemClick(idx)
  local headbgid = self._headBgList[idx]
  if headbgid and self._currHeadBgID ~= headbgid then
    self._currHeadBgID = headbgid
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnPlayerChangeHeadBgItemClick, headbgid)
    self:ShowCurrHeadBg()
    self:ShowDesc()
    self:ShowUnLockConditions()
    self:CheckOKBtnState()
  end
end

function UIChangeHeadController:ShowCurrHeadBg()
  local cfg_head_bg = Cfg.cfg_player_head_bg[self._currHeadBgID]
  if cfg_head_bg == nil then
    Log.error("###[UIChangeHeadController]playerinfo - cfg_player_head_bg is nil ! id ", self._currHeadBgID)
    local bid = HelperProxy:GetInstance():GetHeadBgDefaultID()
    cfg_head_bg = Cfg.cfg_player_head_bg[bid]
  end
  if cfg_head_bg then
    self._currHeadBg:LoadImage(cfg_head_bg.Icon)
  end
end

function UIChangeHeadController:GetFrameRowCount()
  local row = math.ceil(self._headFrameCount / self._itemCountPerRow)
  return row
end

function UIChangeHeadController:_InitHeadFrameScrollView()
  self._headFrameScrollView:InitListView(self:GetFrameRowCount(), function(scrollView, index)
    return self:_InitHeadFrameList(scrollView, index)
  end)
  self:CheckCurrHeadFrameInner()
end

function UIChangeHeadController:_InitHeadFrameList(scrollView, index)
  if index < 0 then
    return nil
  end
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UIHeadFrameItem", self._itemCountPerRow)
  end
  local rowList = rowPool:GetAllSpawnList()
  for i = 1, self._itemCountPerRow do
    local heartItem = rowList[i]
    local itemIndex = index * self._itemCountPerRow + i
    self:ShowHeadFrameItem(heartItem, itemIndex)
  end
  return item
end

function UIChangeHeadController:ShowHeadFrameItem(item, index)
  local frame = self._headFrameList[index] or nil
  local canUnLock = false
  local isOpen = false
  if frame then
    local lockInfo = self._roleModule:UI_GetHeadFrameLockInfo(frame.ID)
    if not lockInfo.m_bLock or table.count(lockInfo.m_lockConditionList) == 0 then
      isOpen = true
    end
    if not isOpen then
      canUnLock = self._roleModule:UI_CheckLockConditionNew(lockInfo)
    end
  end
  if GameSingle then
    isOpen = true
    canUnLock = true
  end
  item:GetGameObject():SetActive(true)
  item:SetData(index, frame, isOpen, canUnLock, self._currHeadFrameID, function(idx)
    self:HeadFrameItemClick(idx)
  end)
end

function UIChangeHeadController:HeadFrameItemClick(idx)
  local headFrameId = self._headFrameList[idx].ID
  if headFrameId and self._currHeadFrameID ~= headFrameId then
    local lockInfo = self._roleModule:UI_GetHeadFrameLockInfo(headFrameId)
    local isOpen = false
    if not lockInfo.m_bLock or table.count(lockInfo.m_lockConditionList) == 0 then
      isOpen = true
    end
    local canUnLock = false
    if isOpen then
      self._headFrameLock = false
    else
      self._headFrameLock = true
      canUnLock = self._roleModule:UI_CheckLockConditionNew(lockInfo)
    end
    if isOpen then
      self._currHeadFrameID = headFrameId
      self:ChangeHeadFrameTween()
    elseif canUnLock then
      self:Lock("lockHeadFrameReq")
      self:StartTask(function(TT)
        local res = self._roleModule:Request_ClearHeadFrameLock(TT, headFrameId)
        self:UnLock("lockHeadFrameReq")
        if res:GetSucc() then
          self._headFrameLock = false
          self._currHeadFrameID = headFrameId
          self:ChangeHeadFrameTween()
          GameGlobal.EventDispatcher():Dispatch(GameEventType.HideHeadFrameRedPoint, self._currHeadFrameID)
          self:CheckHeadFrameActive()
          self:CheckHeadTagRedActive()
        else
          local result = res:GetResult()
          Log.debug("###[UIChangeHeadController]player info - roleModule:Request_ClearHeadImageLock result - ", result)
          local tips = ""
          if self._error2str[result] then
            tips = StringTable.Get(self._error2str[result])
          end
          ToastManager.ShowToast(tips)
        end
      end, self)
    else
      self._currHeadFrameID = headFrameId
      self:ChangeHeadFrameTween()
    end
  end
end

function UIChangeHeadController:ChangeHeadFrameTween()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnPlayerChangeHeadFrameItemClick, self._currHeadFrameID)
  self:ShowCurrHeadFrame()
  self:ShowUnLockConditions()
  self:CheckOKBtnState()
  self:ShowDesc()
end

function UIChangeHeadController:CheckOKBtnState()
  if self._currHeadID == self._roleHeadID and self._currHeadFrameID == self._roleHeadFrameID and self._currHeadBgID == self._roleHeadBgID then
    self._changeBtn.interactable = false
  else
    self._changeBtn.interactable = true
  end
end

function UIChangeHeadController:ShowUnLockConditions()
  local conditions = {}
  local haveCondition = false
  if self._selectHead == UIChangeHeadControllerState.Head then
    local lockCondition = self._roleModule:UI_GetHeadImageLockInfo(self._currHeadID)
    if lockCondition and lockCondition.m_lockConditionList and table.count(lockCondition.m_lockConditionList) > 0 then
      conditions = lockCondition.m_lockConditionList
      haveCondition = true
    end
  elseif self._selectHead == UIChangeHeadControllerState.Frame then
    local lockCondition = self._roleModule:UI_GetHeadFrameLockInfo(self._currHeadFrameID)
    if lockCondition and lockCondition.m_lockConditionList and table.count(lockCondition.m_lockConditionList) > 0 then
      conditions = lockCondition.m_lockConditionList
      haveCondition = true
    end
  elseif self._selectHead == UIChangeHeadControllerState.Bg then
  end
  self._goNoCondition:SetActive(not haveCondition)
  if haveCondition then
    local count = table.count(conditions)
    self._conditions:SpawnObjects("UIHeadUnLockConditionItem", count)
    local items = self._conditions:GetAllSpawnList()
    for i = 1, count do
      local con = conditions[i]
      items[i]:SetData(con)
    end
  else
    local count = table.count(conditions)
    self._conditions:SpawnObjects("UIHeadUnLockConditionItem", count)
  end
end

function UIChangeHeadController:changeBtnOnClick()
  if self._currHeadID == self._roleHeadID and self._currHeadFrameID == self._roleHeadFrameID and self._currHeadBgID == self._roleHeadBgID then
    return
  end
  local tips
  if self._headLock and self._headFrameLock then
    tips = "str_player_info_head_icon_and_head_frame_unlock"
  elseif self._headLock then
    tips = "str_player_info_head_icon_unlock"
  elseif self._headFrameLock then
    tips = "str_player_info_head_frame_unlock"
  end
  if tips then
    ToastManager.ShowToast(StringTable.Get(tips))
  else
    self:Lock("self:StartTask(self.OnchangeBtnOnClick")
    self:StartTask(self.OnchangeBtnOnClick, self)
  end
end

function UIChangeHeadController:OnchangeBtnOnClick(TT)
  local res = self._roleModule:Request_AmendHeadImage(TT, self._currHeadID, self._currHeadBgID, self._currHeadFrameID)
  self:UnLock("self:StartTask(self.OnchangeBtnOnClick")
  if res:GetSucc() then
    ToastManager.ShowToast(StringTable.Get("str_player_info_change_head_succ"))
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnPlayerHeadInfoChanged)
  else
    local result = res:GetResult()
    Log.debug("###[UIChangeHeadController]player info - roleModule:Request_AmendHeadImage result - ", result)
    local tips = ""
    if self._error2str[result] then
      tips = StringTable.Get(self._error2str[result])
    end
    ToastManager.ShowToast(tips)
  end
end

function UIChangeHeadController:headBgBtnOnClick()
  if self._selectHead ~= UIChangeHeadControllerState.Bg then
    self._selectHead = UIChangeHeadControllerState.Bg
    self:ShowHeadAndBgPanel()
    self:CheckOKBtnState()
    self:ShowUnLockConditions()
    self:ShowDesc()
    self._currTag = -1
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnChangeHeadTagBtnClick, self._currTag)
  end
end

function UIChangeHeadController:headFrameBtnOnClick()
  if self._selectHead ~= UIChangeHeadControllerState.Frame then
    self._selectHead = UIChangeHeadControllerState.Frame
    self:ShowHeadAndBgPanel()
    self:CheckOKBtnState()
    self:ShowUnLockConditions()
    self:ShowDesc()
    self._currTag = -1
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnChangeHeadTagBtnClick, self._currTag)
  end
end

function UIChangeHeadController:ShowHeadAndBgPanel()
  self._headScrollView.gameObject:SetActive(self._selectHead == UIChangeHeadControllerState.Head)
  self._headBgScrollView.gameObject:SetActive(self._selectHead == UIChangeHeadControllerState.Bg)
  self._headFrameScrollView.gameObject:SetActive(self._selectHead == UIChangeHeadControllerState.Frame)
  self._selectBgImg:SetActive(self._selectHead == UIChangeHeadControllerState.Bg)
  self._selectFrameImg:SetActive(self._selectHead == UIChangeHeadControllerState.Frame)
end

function UIChangeHeadController:CheckCurrHeadInner()
  local idx = 0
  for i = 1, #self._headList do
    if self._headList[i] == self._currHeadID then
      idx = i
      break
    end
  end
  local row = self:GetRowByIdx(idx)
  self._headScrollView:MovePanelToItemIndex(row, 0)
end

function UIChangeHeadController:CheckCurrHeadBgInner()
  local idx = 0
  for i = 1, #self._headBgList do
    if self._headBgList[i] == self._currHeadBgID then
      idx = i
      break
    end
  end
  local row = self:GetRowByIdx(idx)
  self._headBgScrollView:MovePanelToItemIndex(row, 0)
end

function UIChangeHeadController:CheckCurrHeadFrameInner()
  local idx = 0
  for i = 1, #self._headFrameList do
    if self._headFrameList[i].ID == self._currHeadFrameID then
      idx = i
      break
    end
  end
  local row = self:GetRowByIdx(idx)
  self._headFrameScrollView:MovePanelToItemIndex(row, 0)
end

function UIChangeHeadController:GetRowByIdx(idx)
  local row = math.ceil(idx / self._itemCountPerRow)
  if 0 < row then
    row = row - 1
  end
  return row
end

local UIChangeHeadControllerState = {
  Head = 1,
  Bg = 2,
  Frame = 3
}
_enum("UIChangeHeadControllerState", UIChangeHeadControllerState)
