local ActivityBase = require("Game.ActivityFrame.ActivityBase")
local ActivityInvitationData = class("ActivityInvitationData", ActivityBase)
local TaskEnum = require("Game.Task.TaskEnum")
local ActivityInvitationEnum = require("Game.ActivityInvitation.Data.ActivityInvitationEnum")
local EInvitationUserType = ActivityInvitationEnum.EInvitationUserType
local EInvitationReddotType = ActivityInvitationEnum.EInvitationReddotType
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local CurActType = ActivityFrameEnum.eActivityType.Invitation
local emptyString = ""

function ActivityInvitationData:InitInvitationData(msg)
  self:SetActFrameDataByType(CurActType, msg.actId)
  self:UpdateActFrameDataSingleMsg(msg)
  self._mainCfg = ConfigData.activity_invitation[self:GetActId()]
  self._rewardCfg = ConfigData.activity_invitation_reward[self:GetActId()]
  self._taskCfg = ConfigData.activity_invitation_task_group[self:GetActId()]
  self._code = msg.invitationCode
  self._UserType = EInvitationUserType.CommonUser
  if msg.isReturnUser then
    self._UserType = EInvitationUserType.ReturnUser
  elseif msg.isNewUser then
    self._UserType = EInvitationUserType.NewUser
  end
  self:UpdataInvitationData(msg)
end

function ActivityInvitationData:UpdataInvitationData(msg)
  self._invitees = msg.invitees
  self._rewardMast = msg.rewardMask
  self._isPickReturnReward = msg.pickReward
  self:UpdateInvitationTask(msg.questIds)
  self:RefreshInvitationRed()
end

function ActivityInvitationData:OnInvitationTaskChange(taskId)
  if self.quests == nil then
    return
  end
  if self.taskDic[taskId] == nil then
    return
  end
  self:UpdateInvitationTask(self.quests)
end

function ActivityInvitationData:UpdateInvitationTask(Quests)
  if Quests == nil then
    return
  end
  self.quests = Quests
  self.taskDic = {}
  self._hasCompletedTask = false
  if self.tasks == nil then
    self.tasks = {}
  else
    table.removeall(self.tasks)
  end
  for _, taskId in ipairs(self.quests) do
    local taskData = PlayerDataCenter.allTaskData:GetTaskDataById(taskId, true)
    if taskData ~= nil then
      table.insert(self.tasks, taskData)
      self.taskDic[taskId] = taskData
      if taskData:CheckComplete() then
        self._hasCompletedTask = true
      end
    end
  end
  self:__SortTaskData(self.tasks)
  self:RefreshInvitationRed()
  MsgCenter:Broadcast(eMsgEventId.InvitationTaskChange, self:GetActId())
end

function ActivityInvitationData:__SortTaskData(taskDataList)
  table.sort(taskDataList, function(a, b)
    if a.state == TaskEnum.eTaskState.Picked then
      return false
    elseif b.state == TaskEnum.eTaskState.Picked then
      return true
    end
    local aComplete = a:CheckComplete()
    local bComplete = b:CheckComplete()
    if aComplete ~= bComplete then
      return aComplete
    end
    return a.id < b.id
  end)
end

function ActivityInvitationData:SetInvitationRegister()
  self._isPickReturnReward = true
end

function ActivityInvitationData:RefreshInvitationRed()
  self:_RefreshInvitationRedLook()
  self:_RefreshInvitationRedInvitation()
  self:_RefreshInvitationRedTask()
end

function ActivityInvitationData:_RefreshInvitationRedLook()
  local reddot = self:GetActivityReddot()
  if reddot == nil then
    return
  end
  local flag = false
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  if not saveUserData:GetInvitationLooked(self:GetActId()) then
    flag = true
  end
  local childReddot = reddot:AddChild(EInvitationReddotType.Looked)
  local redCount = flag and 1 or 0
  if childReddot:GetRedDotCount() ~= redCount then
    childReddot:SetRedDotCount(redCount)
  end
end

function ActivityInvitationData:_RefreshInvitationRedInvitation()
  local reddot = self:GetActivityReddot()
  if reddot == nil then
    return
  end
  local flag = false
  for i, _ in ipairs(self._invitees) do
    if not self:IsInvitationRewardPicked(i) then
      flag = true
      break
    end
  end
  local childReddot = reddot:AddChild(EInvitationReddotType.InviteReward)
  local redCount = flag and 1 or 0
  if childReddot:GetRedDotCount() ~= redCount then
    childReddot:SetRedDotCount(redCount)
  end
end

function ActivityInvitationData:_RefreshInvitationRedTask()
  local reddot = self:GetActivityReddot()
  if reddot == nil then
    return
  end
  local flag = false
  if self:GetHasInvitationTaskComplete() then
    flag = true
  end
  local childReddot = reddot:AddChild(EInvitationReddotType.TaskReward)
  local redCount = flag and 1 or 0
  if childReddot:GetRedDotCount() ~= redCount then
    childReddot:SetRedDotCount(redCount)
  end
end

function ActivityInvitationData:GetInvitationReddot(reddotType)
  local reddot = self:GetActivityReddot()
  if reddot == nil then
    return nil
  end
  return reddot:AddChild(reddotType)
end

function ActivityInvitationData:ReqInvitationRegister(code)
  if self._lastRegisterTime ~= nil and PlayerDataCenter.timestamp - self._lastRegisterTime < 1 then
    return
  end
  self._lastRegisterTime = PlayerDataCenter.timestamp
  local net = NetworkManager:GetNetwork(NetworkTypeID.Invitation)
  net:CS_ACTIVITY_Invitation_Register(self:GetActFrameId(), code)
end

function ActivityInvitationData:ReqInvitationPicked(index, callback)
  local net = NetworkManager:GetNetwork(NetworkTypeID.Invitation)
  net:CS_ACTIVITY_Invitation_Pick(self:GetActFrameId(), index, function()
    self._rewardMast = self._rewardMast | 1 << index
    self:RefreshInvitationRed()
    if callback ~= nil then
      callback()
    end
  end)
end

function ActivityInvitationData:GetInvitationCode()
  return self._code
end

function ActivityInvitationData:GetInvitationMainCfg()
  return self._mainCfg
end

function ActivityInvitationData:GetInvitaionRewardCfg()
  return self._rewardCfg
end

function ActivityInvitationData:GetInvitaionTaskCfg()
  return self._taskCfg
end

function ActivityInvitationData:GetInvitationReward()
  if self:IsInvitationReturnUser() then
    return self._mainCfg.return_reward_ids, self._mainCfg.return_reward_nums
  elseif self:IsInvitationNewUser() then
    return self._mainCfg.newplayer_reward_ids, self._mainCfg.newplayer_reward_nums
  end
end

function ActivityInvitationData:GetInvitationInvitees()
  return self._invitees
end

function ActivityInvitationData:GetInvitationUserType()
  return self._UserType
end

function ActivityInvitationData:GetInvitationTaskData()
  if self.tasks == nil then
    self.tasks = {}
  end
  return self.tasks
end

function ActivityInvitationData:GetHasInvitationTaskComplete()
  return self._hasCompletedTask
end

function ActivityInvitationData:GetInvitationInputName()
  if self:IsInvitationReturnUser() then
    return ConfigData:GetTipContent(7710)
  elseif self:IsInvitationNewUser() then
    return ConfigData:GetTipContent(7711)
  else
    return emptyString
  end
end

function ActivityInvitationData:IsInvitationCommonUser()
  return self._UserType == EInvitationUserType.CommonUser
end

function ActivityInvitationData:IsInvitationReturnUser()
  return self._UserType == EInvitationUserType.ReturnUser
end

function ActivityInvitationData:IsInvitationNewUser()
  return self._UserType == EInvitationUserType.NewUser
end

function ActivityInvitationData:IsInvitationReturnPicked()
  return self._isPickReturnReward
end

function ActivityInvitationData:IsInvitationRewardPicked(num)
  if num < 1 or num > #self._rewardCfg then
    return false
  end
  local flag = self._rewardMast >> num & 1
  return flag == 1
end

return ActivityInvitationData
