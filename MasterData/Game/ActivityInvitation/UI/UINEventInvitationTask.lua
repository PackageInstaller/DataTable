local UINEventInvitationTask = class("UINEventInvitationTask", UIBaseNode)
local base = UIBaseNode
local UINEventInvitationTaskItem = require("Game.ActivityInvitation.UI.UINEventInvitationTaskItem")

function UINEventInvitationTask:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self._taskItemPool = UIItemPool.New(UINEventInvitationTaskItem, self.ui.obj_TaskItem, false)
  self.__OnTaskUpdateCallback = BindCallback(self, self.__RefreshInvitationTask)
  MsgCenter:AddListener(eMsgEventId.InvitationTaskChange, self.__OnTaskUpdateCallback)
end

function UINEventInvitationTask:InitInvitationTask(data)
  self._data = data
  self:__RefreshInvitationTask()
end

function UINEventInvitationTask:__RefreshInvitationTask()
  if self._data == nil then
    return
  end
  self._taskItemPool:HideAll()
  local invitationTaskDatas = self._data:GetInvitationTaskData()
  for _, taskData in ipairs(invitationTaskDatas) do
    local taskItem = self._taskItemPool:GetOne()
    taskItem:InitItem(nil, taskData)
    taskItem:SetActLimitTaskShowCommonReward()
  end
  local isShowScroll = 3 < #invitationTaskDatas
  self.ui.img_Scrollbar.enabled = isShowScroll
  self.ui.img_Handle.enabled = isShowScroll
end

function UINEventInvitationTask:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.InvitationTaskChange, self.__OnTaskUpdateCallback)
end

return UINEventInvitationTask
