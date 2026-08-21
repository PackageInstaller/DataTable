_class("UIMainLobbyRole", UICustomWidget)
UIMainLobbyRole = UIMainLobbyRole

function UIMainLobbyRole:OnShow()
  self._isShow = true
  self._roleModule = GameGlobal.GetModule(RoleModule)
  self._loginModule = GameGlobal.GetModule(LoginModule)
  self._signInModule = GameGlobal.GetModule(SignInModule)
  self._playerInfoAnim = self:GetUIComponent("Animation", "UIMainLobbyRole")
  self._head_bg = self:GetUIComponent("UICircleMaskLoader", "headbg")
  self._head_icon = self:GetUIComponent("RawImageLoader", "head")
  self._head_icon_rect = self:GetUIComponent("RectTransform", "head")
  self._head_frame_rect = self:GetUIComponent("RectTransform", "headFrame")
  self._head_frame = self:GetUIComponent("RawImageLoader", "headFrame")
  self._head_bg_rect = self:GetUIComponent("RectTransform", "headbg")
  self._head_root_rect = self:GetUIComponent("RectTransform", "headRoot")
  self._head_bg_mask_rect = self:GetUIComponent("RectTransform", "mask")
  self._head_dan_badge_gen = self:GetUIComponent("UISelectObjectPath", "DanBadgeSimpleGen")
  self._head_dan_badge_gen_go = self:GetGameObject("DanBadgeSimpleGen")
  self._head_dan_badge_gen_rect = self:GetUIComponent("RectTransform", "DanBadgeSimpleGen")
  self._playerNameText = self:GetUIComponent("UILocalizationText", "name")
  self._playerIDText1 = self:GetUIComponent("UILocalizationText", "id1")
  self._playerIDText2 = self:GetUIComponent("UILocalizationText", "id2")
  self._levelText = self:GetUIComponent("UILocalizationText", "Level")
  self._artFont = self:GetUIComponent("ArtFont", "Level")
  self._redGo = self:GetGameObject("red")
  self._playerIDText1Outline = self:GetUIComponent("H3D.UGUI.CircleOutline", "id1")
  self._playerIDText2Outline = self:GetUIComponent("H3D.UGUI.CircleOutline", "id2")
  self._playerNameTextOutline = self:GetUIComponent("H3D.UGUI.CircleOutline", "name")
  self:AttachEvent(GameEventType.RolePropertyChanged, self.OnItemCountChange)
  self:AttachEvent(GameEventType.OnChapcterInfoChanged, self.PlayerInfo)
  self:AttachEvent(GameEventType.AfterUILayerChanged, self.OnAfterUILayerChanged)
  self:AttachEvent(GameEventType.OnPlayerHeadInfoChanged, self.PlayerInfo)
  self:AttachEvent(GameEventType.OnPlayerChangeHeadBadgeClick, self.PlayerInfo)
  self:AttachEvent(GameEventType.ModuleFriendNotifyNewMsg, self._RefreshFriendRedStatus)
  self:AttachEvent(GameEventType.UpdateFriendInvitation, self._RefreshFriendRedStatus)
  self:OnItemCountChange()
end

function UIMainLobbyRole:OnHide()
  self._isShow = false
end

function UIMainLobbyRole:OnAfterUILayerChanged()
  local topui = GameGlobal.UIStateManager():IsTopUI(self.uiOwner:GetName())
  if topui then
    self:CheckRed()
  end
end

function UIMainLobbyRole:OnItemCountChange()
  self:PlayerInfo()
  self:CheckRed()
end

function UIMainLobbyRole:CheckRed()
  TaskManager:GetInstance():StartTask(self.Task_RoleImageInfo, self)
end

function UIMainLobbyRole:InfoBtnOnClick()
  GameGlobal.UAReportForceGuideEvent("UIMainClick", {
    "Click_PlayerInfoController"
  }, true)
  local module = GameGlobal.GetModule(RoleModule)
  local isLock = not module:CheckModuleUnlock(GameModuleID.MD_Role)
  if isLock then
    ToastManager.ShowToast(StringTable.Get("str_function_lock_unlock"))
    return
  end
  GameGlobal.GetModule(RoleModule):OnHomePageEnter(CLICKENTRANCE.CE_PLAYER_INFO)
  self:ShowDialog("UIPlayerInfoController", PlayerInfoFrom.MainLobby)
end

function UIMainLobbyRole:PlayerInfo()
  local nPlayerExp = self._roleModule:GetRoleExp()
  local nPlayerLevel = HelperProxy:GetInstance():GetLvByExp(nPlayerExp)
  self._levelText:SetText(tostring(nPlayerLevel))
  local expPercent = 0
  if nPlayerLevel == HelperProxy:GetInstance():GetMaxLevel() then
    expPercent = 1
  else
    local curLvExp = HelperProxy:GetInstance():GetLevelExp(nPlayerLevel)
    local nextLvExp = HelperProxy:GetInstance():GetLevelExp(nPlayerLevel + 1)
    local deltaExp = nextLvExp - curLvExp
    if 0 < deltaExp then
      expPercent = (nPlayerExp - curLvExp) / deltaExp
    end
  end
  local txtFilling = self._levelText.gameObject:GetComponent("ArtFont")
  txtFilling.Division = expPercent
  self._playerNameText:SetText(self._roleModule:GetName())
  self._playerIDText1:SetText(StringTable.Get("str_player_info_id"))
  self._playerIDText2:SetText(self._loginModule:GetRoleShowID())
  self:PlayerHeader()
end

function UIMainLobbyRole:PlayerHeader()
  local playerInfo = self._roleModule:UI_GetPlayerInfo()
  local headIcon = playerInfo.m_nHeadImageID
  local cfg_header = Cfg.cfg_role_head_image[headIcon]
  if cfg_header then
    self._head_icon:LoadImage(cfg_header.Icon)
    HelperProxy:GetInstance():GetHeadIconSizeWithTag(self._head_icon_rect, cfg_header.Tag)
  else
    Log.fatal("###main - cfg_header is nil ! id - ", headIcon)
  end
  local headFrame = playerInfo.m_nHeadFrameID
  if not headFrame or headFrame == 0 then
    headFrame = HelperProxy:GetInstance():GetHeadFrameDefaultID()
  end
  local cfg_head_frame = Cfg.cfg_role_head_frame[headFrame]
  self._head_frame:LoadImage(cfg_head_frame.Icon)
  HelperProxy:GetInstance():GetHeadBgSizeWithTag(self._head_bg_rect)
  HelperProxy:GetInstance():GetHeadBgMaskSizeWithTag(self._head_bg_mask_rect)
  HelperProxy:GetInstance():GetHeadFrameSizeWithTag(self._head_frame_rect)
  HelperProxy:GetInstance():GetHeadRootSizeWithTag(self._head_root_rect, RoleHeadFrameSizeType.Size2)
  local headBg = playerInfo.m_nHeadColorID
  local cfg_head_bg = Cfg.cfg_player_head_bg[headBg]
  cfg_head_bg = cfg_head_bg or Cfg.cfg_player_head_bg[1]
  self._head_bg:LoadImage(cfg_head_bg.Icon)
  UIWorldBossHelper.InitSelfDanBadgeSimple(self._head_dan_badge_gen, self._head_dan_badge_gen_go, self._head_dan_badge_gen_rect)
end

function UIMainLobbyRole:UI_GetHeadFrameList()
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

function UIMainLobbyRole:CheckHeadRedPoint()
  local showRed = self._signInModule:HaveTotalLoginReward()
  showRed = showRed or self._signInModule:IsReSignInToday()
  if showRed then
    return true
  end
  local socialModule = GameGlobal.GetModule(SocialModule)
  if socialModule:HaveNewMsg() or socialModule:HaveNewInvitation() then
    return true
  end
  self._itemModule = self:GetModule(ItemModule)
  local headRed = self._itemModule:HasNewSubTypeItem(ItemSubType.ItemSubType_Head, true)
  headRed = self._roleModule:CheckLimitedShowRed(ItemSubType.ItemSubType_Head) or headRed
  local headFrameRed = self._itemModule:HasNewSubTypeItem(ItemSubType.ItemSubType_HeadFrame, true)
  headFrameRed = self._roleModule:CheckLimitedShowRed(ItemSubType.ItemSubType_HeadFrame) or headFrameRed
  self._tmpheadList = self._roleModule:UI_GetHeadImageListByTag(0)
  for i = 1, #self._tmpheadList do
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
        Log.debug(lockInfo, canUnLock)
      end
    end
    if not isOpen and canUnLock then
      headRed = true
    end
  end
  self._tmpHeadFrameList = self:UI_GetHeadFrameList()
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
    if not isOpen and canUnLock then
      headFrameRed = true
    end
  end
  if headRed or headFrameRed then
    return true
  end
  local titleRed = self._itemModule:HasNewSubTypeItem(ItemSubType.ItemSubType_Title, true)
  titleRed = self._roleModule:CheckLimitedShowRed(ItemSubType.ItemSubType_Title) or titleRed
  if titleRed then
    return true
  end
  local emblazonryRed = self._itemModule:HasNewSubTypeItem(ItemSubType.ItemSubType_Fifure, true)
  emblazonryRed = self._roleModule:CheckLimitedShowRed(ItemSubType.ItemSubType_Title) or emblazonryRed
  if emblazonryRed then
    return true
  end
  self.chessCfg = Cfg.cfg_item_chess({})
  self.itemModule = GameGlobal.GetModule(ItemModule)
  for _, v in pairs(self.chessCfg) do
    local items = self.itemModule:GetItemByTempId(v.ID)
    for _, vitem in pairs(items) do
      self.item = vitem
    end
    if self.item and self.item:IsNewOverlay() then
      return true
    end
  end
  local roleModule = GameGlobal.GetModule(RoleModule)
  if not LocalDB.HasKey("FirstAutoFightRecord" .. roleModule:GetPstId()) then
    return true
  end
  return false
end

function UIMainLobbyRole:Task_RoleImageInfo(TT)
  local res = self._roleModule:Request_RoleImageInfo(TT)
  if res:GetSucc() and self._isShow then
    local red = self:CheckHeadRedPoint()
    local friendRed = self:_GetFriendRedStatus()
    self._redGo:SetActive(red or friendRed)
  end
end

function UIMainLobbyRole:_GetFriendRedStatus()
  local socialModule = GameGlobal.GetModule(SocialModule)
  if socialModule:HaveNewMsg() or socialModule:HaveNewInvitation() then
    return true
  else
    return false
  end
end

function UIMainLobbyRole:_RefreshFriendRedStatus()
  TaskManager:GetInstance():StartTask(self.Task_RoleImageInfo, self)
end

function UIMainLobbyRole:SetRoleCanvasGroup(value)
  if self._artFont then
    local upColor = self._artFont.UpColor
    local downColor = self._artFont.DownColor
    self._artFont.UpColor = Color(upColor.r, upColor.g, upColor.b, value)
    self._artFont.DownColor = Color(downColor.r, downColor.g, downColor.b, value)
    local outline1 = self._playerIDText1Outline.effectColor
    local outline2 = self._playerIDText2Outline.effectColor
    local outline3 = self._playerNameTextOutline.effectColor
    self._playerIDText1Outline.effectColor = Color(outline1.r, outline1.g, outline1.b, value)
    self._playerIDText2Outline.effectColor = Color(outline2.r, outline2.g, outline2.b, value)
    self._playerNameTextOutline.effectColor = Color(outline3.r, outline3.g, outline3.b, value)
  end
end
