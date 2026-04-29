_class("UIChatFriendInfoController", UIController)
UIChatFriendInfoController = UIChatFriendInfoController

function UIChatFriendInfoController:LoadDataOnEnter(TT, res, uiParams)
  self._friendId = uiParams[1]
  self._chatFriendManager = uiParams[2]
  self:_RequestData(TT)
end

function UIChatFriendInfoController:_RequestData(TT)
  self._chatFriendManager:RequestFriendList(TT)
  self._isMyFriend = self._chatFriendManager:IsMyFriend(self._friendId)
  self._isInBlackList = self._chatFriendManager:IsInBlackList(self._friendId)
  local roleModule = GameGlobal.GetModule(RoleModule)
  self._isSelf = self._friendId == roleModule:GetPstId()
  local socialModule = GameGlobal.GetModule(SocialModule)
  local res, tempPlayerDetailInfo = socialModule:HandleGetPlayerDetailInfo(TT, self._friendId)
  if not res:GetSucc() then
    self._chatFriendManager:HandleErrorMsgCode(res:GetResult())
    return
  end
  local playerDetailInfo = tempPlayerDetailInfo
  local simpleInfo = playerDetailInfo.simple_info
  local chatFriendData = ChatFriendData:New(simpleInfo.pstid, simpleInfo.head, simpleInfo.head_bg, simpleInfo.frame_id, simpleInfo.level, simpleInfo.nick, false, simpleInfo.is_online, simpleInfo.create_time, 0, simpleInfo.last_logout_time, simpleInfo.remark_name, simpleInfo.help_pet, simpleInfo.world_boss_info, simpleInfo.homeland_info)
  self._friendDetailData = ChatFriendDetailData:New(chatFriendData, playerDetailInfo)
  self._friendData = self._friendDetailData:GetFriendData()
end

function UIChatFriendInfoController:OnShow(uiParams)
  self:_GetComponents()
  if not self._friendData then
    Log.error("friend data is nil")
    return
  end
  self:AttachEvent(GameEventType.ChangeFriendInfoSuccess, self._Refresh)
  self:AttachEvent(GameEventType.UpdateFriendInfo, self._UpdateFriendInfo)
  self:_Init()
end

function UIChatFriendInfoController:OnHide()
  self:DetachEvent(GameEventType.ChangeFriendInfoSuccess, self._Refresh)
  self:DetachEvent(GameEventType.UpdateFriendInfo, self._UpdateFriendInfo)
end

function UIChatFriendInfoController:_GetComponents()
  self._headBg = self:GetUIComponent("UICircleMaskLoader", "headBg")
  self._head = self:GetUIComponent("RawImageLoader", "head")
  self._headRect = self:GetUIComponent("RectTransform", "head")
  self._headBgRect = self:GetUIComponent("RectTransform", "headBg")
  self._headBgMaskRect = self:GetUIComponent("RectTransform", "headBgMask")
  self._headRoot = self:GetUIComponent("RectTransform", "headRoot")
  self._frame = self:GetUIComponent("RawImageLoader", "frame")
  self._frameRect = self:GetUIComponent("RectTransform", "frame")
  self._name = self:GetUIComponent("UILocalizationText", "Name")
  self._level = self:GetUIComponent("UILocalizationText", "Level")
  self._id = self:GetUIComponent("UILocalizationText", "Id")
  self._time = self:GetUIComponent("UILocalizationText", "Time")
  self._des = self:GetUIComponent("UILocalizationText", "Des")
  self._playInfoBtnOnGo = self:GetGameObject("PlayInfoBtnOn")
  self._battleInfoBtnOnGo = self:GetGameObject("BattleInfoBtnOn")
  self._playerInfoPanelGo = self:GetGameObject("PlayerInfoPanel")
  self._battleInfoPanelGo = self:GetGameObject("BattleInfoPanel")
  self._petPanel = self:GetUIComponent("UISelectObjectPath", "PetPanel")
  self._petList = {}
  self._maxPetCount = 4
  self._petPanel:SpawnObjects("UIChatPetItem", self._maxPetCount, self._petList)
  self._missionProgress = self:GetUIComponent("UILocalizationText", "missionProgress")
  self._missionStar = self:GetUIComponent("UILocalizationText", "missionStar")
  self._petCount = self:GetUIComponent("UILocalizationText", "petCount")
  self._achievementPoint = self:GetUIComponent("UILocalizationText", "achievementPoint")
  self._towerwater = self:GetUIComponent("UILocalizationText", "towerwater")
  self._towerfire = self:GetUIComponent("UILocalizationText", "towerfire")
  self._towerwood = self:GetUIComponent("UILocalizationText", "towerwood")
  self._towerthunder = self:GetUIComponent("UILocalizationText", "towerthunder")
  self._addFriendBtnGo = self:GetGameObject("AddFriendBtn")
  self._otherPanelBtnGo = self:GetGameObject("OtherPanelBtn")
  self._deleteFriendBtnGo = self:GetGameObject("DeleteFriendBtn")
  self._addToBlackListBtnGo = self:GetGameObject("AddToBlackListBtn")
  self._removeFromBlackListBtnGo = self:GetGameObject("RemoveFromBlackListBtn")
  self._changeNameBtnGo = self:GetGameObject("ChangeNameBtn")
  self._otherBtnGo = self:GetGameObject("OtherBtn")
  self._animCmp = self:GetUIComponent("Animation", "Anim")
  self._otherBtnPanelAnim = self:GetUIComponent("Animation", "OtherBtnPanelAnim")
  self._danBadgeGen = self:GetUIComponent("UISelectObjectPath", "DanBadgeSimpleGen")
  self._danBadgeGenGo = self:GetGameObject("DanBadgeSimpleGen")
  self._danBadgeGenRect = self:GetUIComponent("RectTransform", "DanBadgeSimpleGen")
  self._rankTex = self:GetUIComponent("UILocalizationText", "rankTex")
  self._rank = self:GetGameObject("rank")
  self._visitHomeGo = self:GetGameObject("VisitHomeBtn")
end

function UIChatFriendInfoController:_Init()
  self._headBg:LoadImage(self._friendData:GetHeadBgName())
  local iconName, iconTag = self._friendData:GetHeadIconName()
  self._head:LoadImage(iconName)
  if not string.isnullorempty(iconTag) then
    HelperProxy:GetInstance():GetHeadIconSizeWithTag(self._headRect, iconTag)
  end
  self._frame:LoadImage(self._friendData:GetHeadFrameName())
  UIWorldBossHelper.InitOtherDanBadgeSimple(self._danBadgeGen, self._danBadgeGenGo, self._danBadgeGenRect, self._friendData:GetWorldBossInfo())
  HelperProxy:GetInstance():GetHeadBgSizeWithTag(self._headBgRect)
  HelperProxy:GetInstance():GetHeadBgMaskSizeWithTag(self._headBgMaskRect)
  HelperProxy:GetInstance():GetHeadFrameSizeWithTag(self._frameRect)
  HelperProxy:GetInstance():GetHeadRootSizeWithTag(self._headRoot, RoleHeadFrameSizeType.Size5)
  self._name.text = self._friendData:GetName()
  self._level.text = StringTable.Get("str_chat_level", tostring(self._friendData:GetLevel()))
  self._id.text = self._friendData:GetShowFriendId()
  self._playInfoBtnOnGo:SetActive(true)
  self._battleInfoBtnOnGo:SetActive(false)
  self._playerInfoPanelGo:SetActive(true)
  self._battleInfoPanelGo:SetActive(false)
  if self._isSelf then
    self._addFriendBtnGo:SetActive(false)
    self._changeNameBtnGo:SetActive(false)
    self._otherBtnGo:SetActive(false)
    self._visitHomeGo:SetActive(false)
  else
    self._addFriendBtnGo:SetActive(not self._isMyFriend)
    self._changeNameBtnGo:SetActive(self._isMyFriend)
    self._visitHomeGo:SetActive(self._isMyFriend and self:_CanVisit())
  end
  local petList = self._friendData:GetPetDataList()
  for i = 1, self._maxPetCount do
    if petList and petList[i] then
      self._petList[i]:Refresh(petList[i])
    else
      self._petList[i]:Refresh(nil)
    end
  end
  local des = self._friendDetailData:GetDes()
  if string.isnullorempty(des) then
    self._des.text = StringTable.Get("str_chat_self_des_is_empty")
  else
    self._des.text = des
  end
  self._time.text = self._friendData:GetCreateDateStr()
  local currMissionID = self._friendDetailData:GetCurrentMissionId()
  local cfg_mission = Cfg.cfg_mission[currMissionID]
  if cfg_mission then
    local cfgName = DiscoveryStage.GetStageIndexString(currMissionID) .. StringTable.Get(cfg_mission.Name)
    self._missionProgress:SetText(cfgName)
  end
  local star = self._friendDetailData:GetStar()
  self._missionStar.text = star
  local petCount = self._friendDetailData:GetPetCount()
  self._petCount.text = petCount
  local achievementPoint = self._friendDetailData:GetAchievementPoint()
  local achievementPointAll = self._friendDetailData:GetAllAchievementPoint()
  self._achievementPoint.text = "<color=#ffd300>" .. achievementPoint .. "</color>" .. "/" .. achievementPointAll
  local towerWater = self._friendDetailData:GetTowerWater()
  self._towerwater:SetText("【" .. StringTable.Get("str_tower_water") .. "】\n" .. string.format(StringTable.Get("str_tower_cur_layer"), "<color=#ffd300>" .. towerWater .. "</color>"))
  local towerFire = self._friendDetailData:GetTowerFire()
  self._towerfire:SetText("【" .. StringTable.Get("str_tower_fire") .. "】\n" .. string.format(StringTable.Get("str_tower_cur_layer"), "<color=#ffd300>" .. towerFire .. "</color>"))
  local towerWood = self._friendDetailData:GetTowerWood()
  self._towerwood:SetText("【" .. StringTable.Get("str_tower_wood") .. "】\n" .. string.format(StringTable.Get("str_tower_cur_layer"), "<color=#ffd300>" .. towerWood .. "</color>"))
  local towerThunder = self._friendDetailData:GetTowerThunder()
  self._towerthunder:SetText("【" .. StringTable.Get("str_tower_thunder") .. "】\n" .. string.format(StringTable.Get("str_tower_cur_layer"), "<color=#ffd300>" .. towerThunder .. "</color>"))
  self:RankValue()
end

function UIChatFriendInfoController:RankValue()
  local airModule = GameGlobal.GetModule(AircraftModule)
  local switchOpen = airModule:GetSwitchOpenState(16)
  self._rank:SetActive(switchOpen)
  if switchOpen then
    local rankValue = self._friendDetailData:GetRankValue()
    self._rankTex:SetText(rankValue)
  end
end

function UIChatFriendInfoController:_UpdateFriendInfo(type, pstid)
  if self._friendId ~= pstid then
    return
  end
  self:Lock("_Refresh")
  GameGlobal.TaskManager():StartTask(self._RefreshCoro, self)
end

function UIChatFriendInfoController:_Refresh()
  self:Lock("_Refresh")
  GameGlobal.TaskManager():StartTask(self._RefreshCoro, self)
end

function UIChatFriendInfoController:_RefreshCoro(TT)
  self:_RequestData(TT)
  if not self._friendData then
    self:UnLock("_Refresh")
    return
  end
  self._name.text = self._friendData:GetName()
  self._addFriendBtnGo:SetActive(not self._isMyFriend)
  self._changeNameBtnGo:SetActive(self._isMyFriend)
  self._visitHomeGo:SetActive(self._isMyFriend)
  self:UnLock("_Refresh")
end

function UIChatFriendInfoController:MaskOnClick(go)
  self:CloseDialog()
end

function UIChatFriendInfoController:PlayerInfoBtnOnClick(go)
  self._animCmp:Play("uieff_ChatFriendInfo_Switch2Player")
  self._playInfoBtnOnGo:SetActive(true)
  self._battleInfoBtnOnGo:SetActive(false)
  self._playerInfoPanelGo:SetActive(true)
  self._battleInfoPanelGo:SetActive(false)
end

function UIChatFriendInfoController:BattleInfoBtnOnClick(go)
  self._animCmp:Play("uieff_ChatFriendInfo_Switch2Battle")
  self._playInfoBtnOnGo:SetActive(false)
  self._battleInfoBtnOnGo:SetActive(true)
  self._playerInfoPanelGo:SetActive(false)
  self._battleInfoPanelGo:SetActive(true)
end

function UIChatFriendInfoController:OtherBtnOnClick(go)
  self._otherPanelBtnGo:SetActive(true)
  self._deleteFriendBtnGo:SetActive(self._isMyFriend)
  self._addToBlackListBtnGo:SetActive(not self._isInBlackList)
  self._removeFromBlackListBtnGo:SetActive(self._isInBlackList)
  self._otherBtnPanelAnim:Play("uieff_ChatFriendInfo_OtherPanel")
end

function UIChatFriendInfoController:OtherPanelBtnOnClick(go)
  self._otherBtnPanelAnim:Play("uieff_ChatFriendInfo_OtherPanelFade")
  self:Lock("OtherPanelBtnOnClick")
  GameGlobal.TaskManager():StartTask(self._CloseOtherBtnPanel, self)
end

function UIChatFriendInfoController:_CloseOtherBtnPanel(TT)
  YIELD(TT, 270)
  self._otherPanelBtnGo:SetActive(false)
  self:UnLock("OtherPanelBtnOnClick")
end

function UIChatFriendInfoController:DeleteFriendBtnOnClick(go)
  self:ShowDialog("UIChatDeleteFriendController", self._friendData, self._chatFriendManager)
  self._otherPanelBtnGo:SetActive(false)
end

function UIChatFriendInfoController:AddFriendBtnOnClick(go)
  self:Lock("AddFriendBtnOnClick")
  GameGlobal.TaskManager():StartTask(self._SendAddFriendMsg, self)
end

function UIChatFriendInfoController:_SendAddFriendMsg(TT)
  local socialModule = GameGlobal.GetModule(SocialModule)
  local res, invtInfo = socialModule:InvitationFriend(TT, self._friendId)
  if not res:GetSucc() then
    local retCode = res:GetResult()
    if retCode == SocialErrorCode.SOCIAL_INVITATION_MUTUAL_SUCCESS then
      ToastManager.ShowToast(StringTable.Get("str_chat_is_your_friend"))
    else
      self._chatFriendManager:HandleErrorMsgCode(retCode)
    end
  else
    ToastManager.ShowToast(StringTable.Get("str_chat_send_request_add_friend_success"))
  end
  self:UnLock("AddFriendBtnOnClick")
end

function UIChatFriendInfoController:ChangeNameBtnOnClick(go)
  if not self._friendData then
    return
  end
  self:ShowDialog("UIChatSetNoteNameController", self._friendData, self._chatFriendManager)
end

function UIChatFriendInfoController:CopyIdBtnOnClick(go)
  HelperProxy:GetInstance():CopyTextToClipboard(self._id.text)
end

function UIChatFriendInfoController:AddToBlackListBtnOnClick(go)
  if not self._friendData then
    return
  end
  self:ShowDialog("UIChatAddBlacklistController", self._friendData, self._chatFriendManager)
  self._otherPanelBtnGo:SetActive(false)
end

function UIChatFriendInfoController:RemoveFromBlackListBtnOnClick(go)
  if not self._friendData then
    return
  end
  self:ShowDialog("UIChatRemoveBlacklistController", self._friendData, self._chatFriendManager)
  self._otherPanelBtnGo:SetActive(false)
end

function UIChatFriendInfoController:VisitHomeBtnOnClick()
  if self._isMyFriend then
    if self._friendData:GetHomelandInfo().unlock then
      HomeLoading.Visit(self._friendData:GetFriendId())
    else
      ToastManager.ShowToast(StringTable.Get("str_homeland_visit_friend_not_unlock_home"))
    end
  end
end

function UIChatFriendInfoController:_CanVisit()
  local module = GameGlobal.GetModule(HomelandModule)
  return module:CheckFunctionUnlock(HomelandUnlockType.E_HOMELAND_UNLOCK_VISIT_UI)
end
