local PvpPasswordRoleListView, Super = NewClass("PvpPasswordRoleListView", BaseView)
PvpPasswordRoleListView.uiResCls = UI_Pvp_Popup_PasswordReadyResource

function PvpPasswordRoleListView:ctor(isOwner, roleUid, roleFacadeData)
  Super.ctor(self)
  self._isOwner = isOwner
  self._roleUid = roleUid
  self._roleFacadeData = roleFacadeData
end

function PvpPasswordRoleListView:OnBuildView()
  self:RefreshView()
end

function PvpPasswordRoleListView:RefreshView()
  self:SetText(self.ui.Text_Title, "MatchSuccessful")
  self:RefreshRoleInfo(self._roleFacadeData)
  self:RefreshIsOwner(self._isOwner)
  self:RefreshPvpType()
  self:StartCloseRoomTimer()
  self:RefreshWaitingState()
  self:RefreshLineupState()
end

function PvpPasswordRoleListView:OnEnterView()
  self:LoadAllLangFont(self.ui.Text_Name)
end

function PvpPasswordRoleListView:OnEnterViewFinished()
end

function PvpPasswordRoleListView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Cancel, System.fn(self, self._OnBtnCancel))
  self:AddButtonClickListener(self.ui.Btn_Ready, System.fn(self, self._OnBtnReady))
  self:AddButtonClickListener(self.ui.Btn_Reject, System.fn(self, self._OnBtnReject))
  self:BindEvent(EventMgr.Instance.PvpRoomSyncData, System.fn(self, self._OnSyncRoomData))
  self:BindEvent(EventMgr.Instance.PvpRoomRoleSync, System.fn(self, self._OnSyncRoomRole))
end

function PvpPasswordRoleListView:_OnSyncRoomRole(isOwner, otherPlayerUid, facadeData)
  self._isOwner = isOwner
  self._roleUid = otherPlayerUid
  self._roleFacadeData = facadeData
  self:RefreshView()
end

function PvpPasswordRoleListView:_OnSyncRoomData()
  local roomData = PvpPasswordModel.Instance:GetRoomData()
  if not roomData then
    return
  end
  self:RefreshWaitingState()
  self:RefreshLineupState()
end

function PvpPasswordRoleListView:RefreshWaitingState()
  if PvpPasswordModel.Instance:IsSelfReady() then
    self:SetActive(self.ui.Group_Button, false)
    self:SetActive(self.ui.Group_Wait, true)
  else
    self:SetActive(self.ui.Group_Button, true)
    self:SetActive(self.ui.Group_Wait, false)
  end
end

function PvpPasswordRoleListView:RefreshLineupState()
  if PvpPasswordModel.Instance:IsSelfInQueue() then
    self:SetButtonText(self.ui.Btn_Ready, LT.Text("PasswordBattleQueueButton"))
    self:SetButtonState(self.ui.Btn_Ready, cd.Z1ButtonState.Unclickable)
  else
    self:SetButtonText(self.ui.Btn_Ready, LT.PanelText("UI_Pvp_Popup_PasswordReady_Text_C_Ready"))
    self:SetButtonState(self.ui.Btn_Ready, cd.Z1ButtonState.High)
  end
end

function PvpPasswordRoleListView:_OnBtnCancel()
  Alert.ShowWithParams("PVP_PasswordBattle_QuitTips", {}, nil, function()
    PvpPasswordController.Instance:ReqCancelMatching()
  end)
end

function PvpPasswordRoleListView:_OnBtnReady()
  if PvpPasswordModel.Instance:IsSelfInQueue() then
    Logger.Warn("PvpPasswordRoleListView:_OnBtnReady in queue and return")
    return
  end
  PvpPasswordController.Instance:ReadyPasswordGame()
end

function PvpPasswordRoleListView:_OnBtnReject()
  PvpPasswordController.Instance:RejectPasswordGame(self._roleUid)
end

function PvpPasswordRoleListView:RefreshIsOwner(isOwner)
  self:SetActive(self.ui.Btn_Reject, self._isOwner)
end

function PvpPasswordRoleListView:RefreshPvpType()
  local pvpType = PvpPasswordModel.Instance:GetPvpType()
  if pvpType == PvpDefine.PvpType.PreBuilt then
    self:SetText(self.ui.Text_Ready_Mode, "PasswordBattle1")
    self:SetText(self.ui.Text_Wait_Mode, "PasswordBattle1")
  else
    self:SetText(self.ui.Text_Ready_Mode, "PasswordBattle2")
    self:SetText(self.ui.Text_Wait_Mode, "PasswordBattle2")
  end
end

function PvpPasswordRoleListView:RefreshRoleInfo(facade)
  self:AddViewComponentOnce(self.ui.UI_Common_Head, CompHeadItem, {
    clickCb = function()
    end,
    headIcon = ItemDataUtils.GetAvatarIcon(facade.icon),
    frameIcon = ItemDataUtils.GetItemIcon(facade.avatarFrame)
  })
  self:SetText(self.ui.Text_Lv, LT.Text(string.format("(Lv.%s)", facade.level)))
  self:SetText(self.ui.Text_Name, LT.Text(SocialDataUtils.GetPlayerName(facade)))
  local node = facade.note
  if not node or "" == node then
    node = LT.Text("SocialSystemIntroductionNone")
  end
  self:SetText(self.ui.Text_Synopsis, LT.Text(node))
  self:SetText(self.ui.Text_State, self:_GetPlayerStateDesc())
  if SocialDataUtils.CheckOffLineState(facade.state) then
    self:SetImage(self.ui.Image_StateIcon, SocialDefine.SocialOnlineStateIconPath.OutLineIcon)
  else
    self:SetImage(self.ui.Image_StateIcon, SocialDataUtils.GetPlayerStateIcon(facade.state))
  end
  self:SetActive(self.ui.Image_Mutual, facade.relation == SocialDefine.SocialRelationType.Cor)
  local isCorrelations = facade.relation == SocialDefine.SocialRelationType.Cor
  local isFollowers = facade.relation == SocialDefine.SocialRelationType.MyFans
  local isShowLove = not isCorrelations and isFollowers
  self:SetActive(self.ui.Image_Love, isShowLove)
end

function PvpPasswordRoleListView:_GetPlayerStateDesc()
  if PvpPasswordModel.Instance:GetPvpType() == PvpDefine.PvpType.PreBuilt then
    do return LT.Text end
    return LT.Text, "MatchingPasswordBattle"
  else
    do return LT.Text end
    return LT.Text, "MatchingPasswordBattle"
  end
end

function PvpPasswordRoleListView:StartCloseRoomTimer()
  local leftTime = PvpPasswordModel.Instance:GetRoomLeftTime()
  if PvpPasswordModel.Instance:IsRoomClosed() then
    self:Close()
    return
  end
  if not leftTime then
    self:SetText(self.ui.Text_Ready_Time, "")
    self:SetText(self.ui.Text_Wait_Time, "")
    self:BindTimer(0.5, 0, nil, System.fn(self, self.StartCloseRoomTimer))
  else
    self:SetText(self.ui.Text_Ready_Time, leftTime .. "s")
    self:SetText(self.ui.Text_Wait_Time, leftTime .. "s")
    if leftTime > 0 then
      self:BindTimer(0.5, 0, nil, System.fn(self, self.StartCloseRoomTimer))
    else
      Alert.ShowStr("WaitngTimeout2")
      PvpPasswordController.Instance:ReqCancelMatching()
      self:Close()
    end
  end
end

return PvpPasswordRoleListView
