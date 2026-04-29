_class("UISeasonMazeRoomFleaItem", UICustomWidget)
UISeasonMazeRoomFleaItem = UISeasonMazeRoomFleaItem

function UISeasonMazeRoomFleaItem:OnShow(uiParams)
  self._atlas = self:GetAsset("SeasonMaze.spriteatlas", LoadType.SpriteAtlas)
  self:InitWidget()
end

function UISeasonMazeRoomFleaItem:InitWidget()
  self._gameObject = self.view:GetGameObject()
  self.root = self:GetUIComponent("RawImageLoader", "Root")
  self.name = self:GetUIComponent("UILocalizationText", "Name")
  self.type = self:GetUIComponent("Image", "Type")
  self.icon = self:GetUIComponent("RawImageLoader", "Icon")
  self.headBg = self:GetUIComponent("UICircleMaskLoader", "HeadBg")
  self.headIcon = self:GetUIComponent("RawImageLoader", "HeadIcon")
  self.headFrame = self:GetUIComponent("RawImageLoader", "HeadFrame")
  self.nick = self:GetUIComponent("UILocalizationText", "Nick")
  self.level = self:GetUIComponent("UILocalizationText", "Level")
  self.friend = self:GetGameObject("Friend")
  self.addBtn = self:GetGameObject("AddBtn")
  self._mask = self:GetGameObject("Mask")
  self._animation = self._gameObject:GetComponent(typeof(UnityEngine.Animation))
  self._rootCanvasGroup = self:GetUIComponent("CanvasGroup", "Root")
end

function UISeasonMazeRoomFleaItem:SetData(index, data, clickCallBack, tipsCallBack)
  self._index = index
  self._pstid = data.pstid
  self._roleInfo = data.roleInfo
  self._clickCallBack = clickCallBack
  self._tipsCallBack = tipsCallBack
  self._cfg = Cfg.cfg_component_season_maze_autobead[self._roleInfo.bead_id]
  if self._cfg then
    self.name:SetText(StringTable.Get(self._cfg.Name))
    self.type.sprite = self._atlas:GetSprite(SeasonMazeTool:GetInstance():GetBeadTypeImg(self._cfg.Type))
    self.icon:LoadImage(self._cfg.Icon)
  end
  if self._roleInfo.type == SeasonMazeMarketRoleType.SMMRT_Friend then
    self.root:LoadImage("cn14_tzsc_di02")
  else
    self.root:LoadImage("cn14_tzsc_di01")
  end
  self.friend:SetActive(self._roleInfo.type == SeasonMazeMarketRoleType.SMMRT_Friend)
  self.addBtn:SetActive(self._roleInfo.type ~= SeasonMazeMarketRoleType.SMMRT_Friend)
  self._mask:SetActive(self._roleInfo.swap_bead_id > 0)
  if self._roleInfo.type == SeasonMazeMarketRoleType.SMMRT_Bot then
    local cfg = Cfg.cfg_component_season_maze_room_market[self._pstid]
    if cfg then
      self.nick:SetText(StringTable.Get(cfg.NameKey))
      self.level:SetText("Lv." .. cfg.Lv)
      local iconName, iconTag = HelperProxy:GetInstance():GetHeadIconName(cfg.HeadID)
      self.headIcon:LoadImage(iconName)
      self.headBg:LoadImage(HelperProxy:GetInstance():GetHeadBgName(cfg.HeadBgID))
      self.headFrame:LoadImage(HelperProxy:GetInstance():GetHeadFrameName(cfg.HeadFrameID))
    end
  else
    self.nick:SetText(self._roleInfo.nick)
    self.level:SetText("Lv." .. self._roleInfo.level)
    local iconName, iconTag = HelperProxy:GetInstance():GetHeadIconName(self._roleInfo.head)
    self.headIcon:LoadImage(iconName)
    self.headBg:LoadImage(HelperProxy:GetInstance():GetHeadBgName(self._roleInfo.head_bg))
    self.headFrame:LoadImage(HelperProxy:GetInstance():GetHeadFrameName(self._roleInfo.frame_id))
  end
  self:Alpha(0)
end

function UISeasonMazeRoomFleaItem:RootOnClick(go)
  if self._roleInfo.swap_bead_id > 0 then
    return
  end
  if self._clickCallBack then
    self._clickCallBack(self._index)
  end
end

function UISeasonMazeRoomFleaItem:AddBtnOnClick(go)
  GameGlobal.TaskManager():StartTask(self._SendAddFriendMsg, self)
end

function UISeasonMazeRoomFleaItem:IntroBtnOnClick(go)
  self._tipsCallBack(go.transform.position, self._cfg.Name, self._cfg.Desc)
end

function UISeasonMazeRoomFleaItem:_SendAddFriendMsg(TT)
  self:Lock("_SendAddFriendMsg")
  local socialModule = GameGlobal.GetModule(SocialModule)
  local res, invtInfo = socialModule:InvitationFriend(TT, self._pstid)
  if not res:GetSucc() then
    local retCode = res:GetResult()
    if retCode == SocialErrorCode.SOCIAL_INVITATION_MUTUAL_SUCCESS then
      ToastManager.ShowToast(StringTable.Get("str_chat_is_your_friend"))
    elseif retCode == SocialErrorCode.SOCIAL_ERROR_IN_PEER_INV_LIST then
      ToastManager.ShowToast(StringTable.Get("str_chat_error_code_in_peer_inv_list"))
    elseif retCode == SocialErrorCode.SOCIAL_ERROR_ALREAD_PEER_FRIEND then
      ToastManager.ShowToast(StringTable.Get("str_chat_error_code_already_peeer_friend"))
    end
  else
    ToastManager.ShowToast(StringTable.Get("str_chat_send_request_add_friend_success"))
  end
  self:UnLock("_SendAddFriendMsg")
end

function UISeasonMazeRoomFleaItem:PlayAnimation()
  self._animation:Play("uianim_UISeasonMazeRoomFleaItem")
end

function UISeasonMazeRoomFleaItem:Alpha(alpha)
  self._rootCanvasGroup.alpha = alpha
end
