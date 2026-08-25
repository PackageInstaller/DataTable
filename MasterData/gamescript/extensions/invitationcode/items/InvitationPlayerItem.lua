local InvitationPlayerItem, Super = NewClass("InvitationPlayerItem", ViewComponent)

function InvitationPlayerItem:ctor(uiNode, view, taskData)
  Super.ctor(self, uiNode, view)
  self.ui = UI_InvitationCode_Item_PlayerResource(uiNode)
  self.taskData = taskData
end

function InvitationPlayerItem:RegisterNotifications()
end

function InvitationPlayerItem:RegisterEvents()
  self:AddButtonClickListener(self.ui.Button_Get, System.fn(self, self.OnBtnGet))
end

function InvitationPlayerItem:OnBuildComponent()
  Super.OnBuildComponent(self)
end

function InvitationPlayerItem:OnEnterComponent()
  Super.OnEnterComponent(self.ui.Text_PlayerName)
  self:LoadAllLangFont(self.ui.Text_PlayerName)
  self:SetPlayerData(self.taskData.facadeData)
  self:SetTaskData(self.taskData.taskList)
end

function InvitationPlayerItem:OnExitComponent()
  Super.OnExitComponent(self)
end

function InvitationPlayerItem:SetPlayerData(playerData)
  self:SetText(self.ui.Text_Uid, string.format("UID:%s", playerData.uid))
  self:SetText(self.ui.Text_PlayerName, playerData.name)
  self:AddViewComponentOnce(self.ui.UI_Common_Head, CompHeadItem, {
    headIcon = ItemDataUtils.GetAvatarIcon(playerData.icon),
    frameIcon = ItemDataUtils.GetItemIcon(playerData.avatarFrame),
    clickCb = System.fn(self, self._OnAvatarClick)
  })
end

function InvitationPlayerItem:SetTaskData(taskList)
  local showTaskInfo = self:GetShowTaskInfo(taskList)
  local taskTid = showTaskInfo.taskTid
  local isGot = showTaskInfo.reward
  local taskCfg = TaskDataUtils.GetTaskConfigByTid(taskTid)
  local finishLevel = taskCfg.CompleteCondPara[1]
  local taskDesc = string.format("%s(%s/%s)", LT.Text(taskCfg.Desc), showTaskInfo.count, finishLevel)
  self:SetText(self.ui.Text_Condition, taskDesc)
  local rewardTid, itemCount = table.unpack(taskCfg.CompleteAward or {})
  if not rewardTid then
    self:SetActive(self.ui.UI_Common_Item_WuPin_Type2, false)
  else
    self:SetActive(self.ui.UI_Common_Item_WuPin_Type2, true)
    local viewData = {
      itemTid = rewardTid,
      itemCount = itemCount,
      isGot = isGot
    }
    self:AddViewComponentOnce(self.ui.UI_Common_Item_WuPin_Type2, CompPublicIconItemType2, viewData)
  end
  self:SetActive(self.ui.Image_Finish, isGot)
  self:SetActive(self.ui.Button_Get, showTaskInfo.taskState == cd.InviteTaskState.Completed and not isGot)
end

function InvitationPlayerItem:GetShowTaskInfo(taskList)
  for index, taskInfo in ipairs(taskList) do
    local taskState, reward = taskInfo.taskState, taskInfo.reward
    if taskState ~= cd.InviteTaskState.Completed or not reward then
      return taskInfo
    end
    if index == #taskList then
      return taskInfo
    end
  end
end

function InvitationPlayerItem:OnBtnGet()
  local showTaskInfo = self:GetShowTaskInfo(self.taskData.taskList)
  local isCanReward = showTaskInfo.taskState == cd.InviteTaskState.Completed and not showTaskInfo.reward
  if not isCanReward then
    return
  end
  local playerUid = self.taskData.facadeData.uid
  InvitationCodeController.Instance:ReqTakeInviteReward(playerUid, showTaskInfo.taskTid)
end

function InvitationPlayerItem:_OnAvatarClick()
  local playerUid = self.taskData.facadeData.uid
  SocialDataUtils.OpenPlayerInfoPanel(SocialDefine.PlayerInfoPage.Overview, playerUid)
end

return InvitationPlayerItem
