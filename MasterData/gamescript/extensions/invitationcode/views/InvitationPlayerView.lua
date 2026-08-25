local InvitationPlayerView, Super = NewClass("InvitationPlayerView", BaseView)
InvitationPlayerView.uiResCls = UI_InvitationCode_Popup_PlayerListResource

function InvitationPlayerView:ctor()
  Super.ctor(self)
  self._invitationMode = InvitationCodeModel.Instance
end

function InvitationPlayerView:RegisterNotifications()
  self:RegisterLocalNotify(NotifyId.OnInvitationTaskDataChanged, self.OnTaskStateChanged, self)
end

function InvitationPlayerView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_OneKey, System.fn(self, self.OnBtnOneKey))
  self:AddButtonClickListener(self.ui.UI_Common_Btn_Question, System.fn(self, self.OnBtnHelp))
  self:AddButtonClickListener(self.ui.UI_Common_Btn_Back1, System.fn(self, self.Close))
end

function InvitationPlayerView:OnBuildView()
  Super.OnBuildView(self)
  self:CreateTaskTableView()
end

function InvitationPlayerView:OnEnterView()
  Super.OnEnterView(self)
  self:RefreshTaskTableView()
end

function InvitationPlayerView:OnExitView()
  Super.OnExitView(self)
end

function InvitationPlayerView:CreateTaskTableView()
  local rewardItemGo = self.ui.UI_InvitationCode_Item_Player
  local sizeDelta = rewardItemGo.transform.sizeDelta
  local w, h = sizeDelta.x, sizeDelta.y
  self.taskTable = self:CreateTableview(self.ui.ScrollView_Popup_Award, function()
    return #self._invitationMode:GetInviteeFinishTaskList()
  end, function(view, index)
    local cell = self:DequeueCell(view, rewardItemGo)
    local taskList = self._invitationMode:GetInviteeFinishTaskList()
    local taskData = taskList[index]
    self:AddViewComponentOnce(cell.gameObject, InvitationPlayerItem, taskData)
    return cell
  end, function()
    return w, h
  end)
end

function InvitationPlayerView:OnTaskStateChanged()
  self:RefreshTaskTableView()
end

function InvitationPlayerView:RefreshTaskTableView()
  if self.taskTable then
    self.taskTable:ReloadData()
  end
  self:SetActive(self.ui.Group_Null, 0 == #self._invitationMode:GetInviteeFinishTaskList())
  self:SetActive(self.ui.Btn_OneKey, self:IsShowOneKey())
end

function InvitationPlayerView:IsShowOneKey()
  do return InvitationCodeModel.Instance.IsHaveReward end
  return InvitationCodeModel.Instance.IsHaveReward, InvitationCodeModel.Instance
end

function InvitationPlayerView:OnBtnHelp()
  PlayerDataUtils.OpenIllustrate(nil, LT.Text("FriendInvitationRule"))
end

function InvitationPlayerView:OnBtnOneKey()
  InvitationCodeController.Instance:ReqTakeInviteReward(0, 0)
end

return InvitationPlayerView
