local InvitationCodeController = NewClass("InvitationCodeController", BaseController)

function InvitationCodeController:OnInit()
  self:OnReset()
end

function InvitationCodeController:OnReset()
end

function InvitationCodeController:ReqGetInviteCode(callback)
  local inviteCode = InvitationCodeModel.Instance:GetInviteCode()
  if inviteCode and "" ~= inviteCode then
    if callback then
      callback(inviteCode)
    end
    return
  end
  ProtoManager.Instance:ReqServer("GameRequest", "GetInviteCode", function(data, err)
    Logger.Proto("GetInviteCode", table.tostring(data), table.tostring(err))
    InvitationCodeModel.Instance:SetInviteCode(data)
    if callback then
      callback(data)
    end
  end, function()
  end)
end

function InvitationCodeController:ReqBindInviteCode(code)
  ProtoManager.Instance:ReqServer("GameRequest", "UseInviteCode", function(invitorName, err)
    Logger.Proto("UseInviteCode", table.tostring(invitorName), table.tostring(err))
    if invitorName then
      local myPlayer = SocialDataUtils.GetMyPlayer()
      if myPlayer then
        myPlayer.invitor = {name = invitorName}
        self:LocalNotify(NotifyId.OnInvitorChanged)
      end
    end
  end, function()
  end, code)
end

function InvitationCodeController:ReqGetInviteTaskList()
  ProtoManager.Instance:ReqServer("GameRequest", "GetInviteTaskList", function(data, err)
    Logger.Proto("GetInviteTaskList", table.tostring(data), table.tostring(err))
    local taskMap = data
    InvitationCodeModel.Instance:SetInviteeFinishTaskList(taskMap)
    self:SetRewardRed()
    self:LocalNotify(NotifyId.OnInvitationTaskDataChanged)
  end, function()
  end)
end

function InvitationCodeController:ReqTakeInviteReward(inviteeUid, taskTid)
  Logger.Proto("TakeInviteReward", table.tostring(inviteeUid), table.tostring(taskTid))
  ProtoManager.Instance:ReqServer("GameRequest", "TakeInviteReward", function(svrData, err)
    Logger.Proto("TakeInviteReward", table.tostring(svrData), table.tostring(err))
    for playerUid, taskMap in pairs(svrData) do
      self:UpdateInviteFinishTask(playerUid, taskMap, false)
    end
    InvitationCodeModel.Instance:SortFinishTaskList()
    self:LocalNotify(NotifyId.OnInvitationTaskDataChanged)
  end, function()
  end, inviteeUid, taskTid)
end

function InvitationCodeController:UpdateInviteFinishTask(inviteeUid, updateTaskMap, isNotify)
  local curTaskList = InvitationCodeModel.Instance:GetPlayerFinishTaskList(inviteeUid)
  if not curTaskList then
    self:ReqGetInviteTaskList()
    return
  end
  for taskTid, taskData in pairs(updateTaskMap) do
    for _, taskInfo in ipairs(curTaskList) do
      if taskTid == taskInfo.taskTid then
        taskInfo.taskState = taskData.state
        taskInfo.reward = taskData.reward
        taskInfo.count = taskData.count
        break
      end
    end
  end
  self:SetRewardRed()
  InvitationCodeModel.Instance:SortFinishTaskList()
  if isNotify then
    self:LocalNotify(NotifyId.OnInvitationTaskDataChanged)
  end
end

function InvitationCodeController:SetRewardRed()
  local isHaveReward = InvitationCodeModel.Instance:IsHaveReward()
  if isHaveReward then
    RedPointDataUtils.SetRedData(RedPointDataUtils.RedType.InvitationCode, 0, RedPointDataUtils.RedAttrType.Red)
  else
    RedPointDataUtils.SetRedData(RedPointDataUtils.RedType.InvitationCode, 0, nil)
  end
end

return InvitationCodeController
