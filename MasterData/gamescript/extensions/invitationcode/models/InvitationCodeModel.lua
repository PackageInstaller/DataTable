local InvitationCodeModel = NewClass("InvitationCodeModel", BaseModel)

function InvitationCodeModel:OnInit()
  self:OnReset()
end

function InvitationCodeModel:OnReset()
  self._inviteCode = nil
  self.inviteeFinishTaskList = {}
end

function InvitationCodeModel:UpdateData(svrData)
  self._bindingExpiredTs = svrData.bindingExpiredTs
  self._inviteCode = svrData.invitationCode
end

function InvitationCodeModel:IsEnableBinding()
  return self:GetBindingCodeLeftTime() > 0
end

function InvitationCodeModel:SetTestLeftTime(time)
  self._testLeftTime = time + TimeUtils.GetServerTime()
end

function InvitationCodeModel:GetBindingCodeLeftTime()
  if self._testLeftTime then
    local now = TimeUtils.GetServerTime()
    return self._testLeftTime - now
  end
  local now = TimeUtils.GetServerTime()
  local createTime = PlayerDataUtils.GetCreateTime()
  local invitorStartTime = SocialDataUtils.GetMyPlayerField("invitorStartTime")
  local startTime = math.max(createTime, invitorStartTime or 0)
  local validTime = DT.GetConstant("FriendInvitationCodeEndTime", 0) * 60 * 60
  return validTime - (now - startTime)
end

function InvitationCodeModel:GetInviteCode()
  return self._inviteCode
end

function InvitationCodeModel:SetInviteCode(code)
  self._inviteCode = code
end

function InvitationCodeModel:GetSkinRewardItem()
  local taskList = self:GetRewardTaskList()
  local skinItem
  local Type_Skin = cd.ItemType.SkinItem
  for _, taskTid in ipairs(taskList) do
    local taskCfg = TaskDataUtils.GetConfig(taskTid)
    local completeAward = taskCfg and taskCfg.CompleteAward
    local awardItemTid = completeAward and completeAward[1]
    local itemCfg = awardItemTid and ItemDataUtils.GetItemConfig(awardItemTid)
    if itemCfg and itemCfg.Type == Type_Skin then
      skinItem = awardItemTid
      break
    end
  end
  return skinItem
end

function InvitationCodeModel:SetInviteeFinishTaskList(taskMap)
  local list = {}
  local cfgTaskList = DT.GetOriginalConstant("InviteeTaskList", {})
  for playerUid, taskData in pairs(taskMap) do
    local taskList = {}
    for index, taskTid in ipairs(cfgTaskList) do
      local taskData = taskData.taskStateList[taskTid]
      taskList[index] = {
        taskTid = taskTid,
        taskState = taskData.state,
        reward = taskData.reward,
        count = taskData.count
      }
    end
    table.insert(list, {
      playerUid = playerUid,
      facadeData = taskData.facadeData,
      taskList = taskList,
      taskNum = table.length(taskData.taskStateList)
    })
  end
  self.inviteeFinishTaskList = list
  self:SortFinishTaskList()
end

function InvitationCodeModel:SortFinishTaskList()
  local sortInfo = {}
  for _, data in ipairs(self.inviteeFinishTaskList) do
    local taskRewardIndex = 0
    local allRewarded = true
    for index, taskInfo in ipairs(data.taskList) do
      if taskInfo.taskState == cd.InviteTaskState.Completed then
        taskRewardIndex = index
      end
      if not taskInfo.reward then
        allRewarded = false
      end
    end
    sortInfo[data.playerUid] = {taskRewardIndex = taskRewardIndex, allRewarded = allRewarded}
  end
  table.sort(self.inviteeFinishTaskList, function(a, b)
    local aInfo = sortInfo[a.playerUid]
    local bInfo = sortInfo[b.playerUid]
    if aInfo.allRewarded ~= bInfo.allRewarded then
      return not aInfo.allRewarded
    end
    if aInfo.taskRewardIndex ~= bInfo.taskRewardIndex then
      return aInfo.taskRewardIndex > bInfo.taskRewardIndex
    end
    return a.playerUid < b.playerUid
  end)
end

function InvitationCodeModel:GetInviteeFinishTaskList()
  return self.inviteeFinishTaskList
end

function InvitationCodeModel:IsHaveReward()
  for _, data in ipairs(self.inviteeFinishTaskList) do
    for _, taskInfo in ipairs(data.taskList) do
      if taskInfo.taskState == cd.InviteTaskState.Completed and not taskInfo.reward then
        return true
      end
    end
  end
end

function InvitationCodeModel:GetPlayerFinishTaskList(playerUid)
  for _, data in ipairs(self.inviteeFinishTaskList) do
    if data.playerUid == playerUid then
      return data.taskList
    end
  end
end

function InvitationCodeModel:GetInviteeCount()
  return #self:GetInviteeFinishTaskList()
end

function InvitationCodeModel:GetMaxInviteeCount()
  do return DT.GetConstant, "FriendInvitationMaxNum" end
  return DT.GetConstant, "FriendInvitationMaxNum", 0
end

function InvitationCodeModel:GetRewardTaskList()
  do return DT.GetOriginalConstant, "InviterTaskList" end
  return DT.GetOriginalConstant, "InviterTaskList", {}
end

function InvitationCodeModel:GetMyInvitorName()
  local socialMyPlayer = SocialDataUtils.GetMyPlayer()
  if not socialMyPlayer then
    return
  end
  local invitor = socialMyPlayer.invitor
  return invitor and invitor.name
end

return InvitationCodeModel
