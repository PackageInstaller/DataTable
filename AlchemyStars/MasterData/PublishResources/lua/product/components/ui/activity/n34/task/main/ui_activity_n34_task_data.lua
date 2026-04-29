_class("UIActivityN34DelegateTaskData", Object)
UIActivityN34DelegateTaskData = UIActivityN34DelegateTaskData

function UIActivityN34DelegateTaskData:Constructor(personData, quest)
  self._personData = personData
  self._quest = quest
  local questInfo = self._quest:QuestInfo()
  self._name = StringTable.Get(questInfo.QuestName) or ""
  self._des = StringTable.Get(questInfo.QuestDesc) or ""
  self._rewards = questInfo.rewards
  self._icon = questInfo.Icon
  local trustItemId = self._personData:GetTrustItemId()
  for i = 1, #self._rewards do
    if self._rewards[i].assetid == trustItemId then
      self._trustValue = self._rewards[i].count
      break
    end
  end
  self._questId = questInfo.quest_id
  local cfgs = Cfg.cfg_component_quest({
    QuestID = self._questId
  })
  self._cost = cfgs[1].CostItems[1][2]
  self._complete = false
end

function UIActivityN34DelegateTaskData:Refresh()
  self._complete = false
  local state = self._quest:Status()
  if state == QuestStatus.QUEST_Taken then
    self._complete = true
  end
end

function UIActivityN34DelegateTaskData:GetQuestId()
  return self._questId
end

function UIActivityN34DelegateTaskData:GetName()
  return self._name
end

function UIActivityN34DelegateTaskData:GetIcon()
  return self._icon
end

function UIActivityN34DelegateTaskData:GetCost()
  return self._cost
end

function UIActivityN34DelegateTaskData:GetTrustValue()
  return self._trustValue
end

function UIActivityN34DelegateTaskData:GetRewards()
  return self._rewards
end

function UIActivityN34DelegateTaskData:IsComplete()
  return self._complete
end

function UIActivityN34DelegateTaskData:GetDes()
  return self._des
end

_class("UIActivityN34DelegateProgressData", Object)
UIActivityN34DelegateProgressData = UIActivityN34DelegateProgressData

function UIActivityN34DelegateProgressData:Constructor(personData, quest)
  self._personData = personData
  self._quest = quest
  local questInfo = self._quest:QuestInfo()
  self._des = StringTable.Get(questInfo.QuestDesc) or ""
  self._rewards = questInfo.rewards
  self._questId = questInfo.quest_id
  self._status = 0
end

function UIActivityN34DelegateProgressData:Refresh()
  local state = self._quest:Status()
  if state == QuestStatus.QUEST_Completed then
    self._status = 1
  elseif state == QuestStatus.QUEST_Taken then
    self._status = 2
  else
    self._status = 0
  end
end

function UIActivityN34DelegateProgressData:GetQuestId()
  return self._questId
end

function UIActivityN34DelegateProgressData:GetDes()
  return self._des
end

function UIActivityN34DelegateProgressData:GetRewards()
  return self._rewards
end

function UIActivityN34DelegateProgressData:GetStatus()
  return self._status
end

_class("UIActivityN34DelegatePersonTips", Object)
UIActivityN34DelegatePersonTips = UIActivityN34DelegatePersonTips

function UIActivityN34DelegatePersonTips:Constructor(id, content, length, interval)
  self._tips = content
  self._length = length
  self._interval = interval
  self._id = id
end

function UIActivityN34DelegatePersonTips:GetId()
  return self._id
end

function UIActivityN34DelegatePersonTips:GetTips()
  return self._tips
end

function UIActivityN34DelegatePersonTips:GetLength()
  return self._length
end

function UIActivityN34DelegatePersonTips:GetInterval()
  return self._interval
end

_class("UIActivityN34DelegatePersonData", Object)
UIActivityN34DelegatePersonData = UIActivityN34DelegatePersonData

function UIActivityN34DelegatePersonData:Constructor(taskData, cfg)
  self._taskData = taskData
  self._campaign = self._taskData:GetCampaign()
  self._surveyComponent = self._taskData:GetSurveyComponent()
  self._surveyComponentInfo = self._taskData:GetSurveyComponentInfo()
  self._questComponent = self._taskData:GetQuestComponent()
  self._questComponentInfo = self._taskData:GetQuestComponentInfo()
  self._personId = cfg.PetID
  self._name = StringTable.Get(cfg.Name)
  self._des = StringTable.Get(cfg.Des)
  self._spine = cfg.Spine
  self._trustItemId = cfg.TrustItem
  self._nextPetId = cfg.NextPetID
  self._tips = {}
  local tipsCfgs = Cfg.cfg_n34_delegate_person_tips({
    PersonId = self._personId
  })
  for k, v in pairs(tipsCfgs) do
    local tips = {}
    for i = 1, #v.Tips do
      local content = StringTable.Get(v.Tips[i])
      local length = v.Length[i]
      local interval = v.Interval[i]
      tips[#tips + 1] = UIActivityN34DelegatePersonTips:New(v.ID * 100 + i, content, length, interval)
    end
    self._tips[#self._tips + 1] = {
      min = v.Min / 1000,
      max = v.Max / 1000,
      tips = tips
    }
  end
  self._totalTrust = cfg.TrustTotal
  self._finalRewardIcon = cfg.FinalRewardIcon
  self._finalRewardDes = cfg.FinalRewardDes
  self._progress = {}
  local questModule = GameGlobal.GetModule(QuestModule)
  local progressTasks = cfg.RewardTaskList
  for i = 1, #progressTasks do
    local quest = questModule:GetQuest(progressTasks[i])
    self._progress[#self._progress + 1] = UIActivityN34DelegateProgressData:New(self, quest)
  end
  self._tasks = {}
  local tasks = cfg.TaskList
  for i = 1, #tasks do
    local quest = questModule:GetQuest(tasks[i])
    self._tasks[#self._tasks + 1] = UIActivityN34DelegateTaskData:New(self, quest)
  end
  self:Refresh()
end

function UIActivityN34DelegatePersonData:Refresh()
  local itemModule = GameGlobal.GetModule(ItemModule)
  self._trustValue = itemModule:GetItemCount(self._trustItemId)
  local unlockPets = self._surveyComponentInfo.info.pet_unlock
  self._paste = false
  for i = 1, #unlockPets do
    if self._personId == unlockPets[i] then
      self._paste = true
      break
    end
  end
  for i = 1, #self._progress do
    self._progress[i]:Refresh()
  end
  for i = 1, #self._tasks do
    self._tasks[i]:Refresh()
  end
  self._complete = true
  for i = 1, #self._tasks do
    if self._tasks[i]:IsComplete() == false then
      self._complete = false
      break
    end
  end
  self._finalRewardStatus = 0
  if self._paste then
    self._finalRewardStatus = 2
  elseif self._complete then
    if self:CanGetFinalReward() then
      self._finalRewardStatus = 1
    else
      self._finalRewardStatus = 2
    end
  else
    self._finalRewardStatus = 0
  end
end

function UIActivityN34DelegatePersonData:GetNextPetId()
  return self._nextPetId
end

function UIActivityN34DelegatePersonData:HasCanGetProgressReward()
  for i = 1, #self._progress do
    if self._progress[i]:GetStatus() == 1 then
      return true
    end
  end
  return false
end

function UIActivityN34DelegatePersonData:ShowAcceptAllRed()
  local tasks = self:GetShowTask(3)
  if #tasks <= 0 then
    return false
  end
  local totalCost = 0
  for i = 1, #tasks do
    local cost = tasks[i]:GetCost()
    totalCost = totalCost + cost
  end
  local itemModule = GameGlobal.GetModule(ItemModule)
  local num = itemModule:GetItemCount(self._taskData:GetItemId())
  if totalCost > num then
    return false
  end
  return true
end

function UIActivityN34DelegatePersonData:ShowAcceptOneRed()
  local tasks = self:GetShowTask(3)
  if #tasks <= 0 then
    return false
  end
  local itemModule = GameGlobal.GetModule(ItemModule)
  local num = itemModule:GetItemCount(self._taskData:GetItemId())
  for i = 1, #tasks do
    local cost = tasks[i]:GetCost()
    if num >= cost then
      return true
    end
  end
  return false
end

function UIActivityN34DelegatePersonData:GetPersonId()
  return self._personId
end

function UIActivityN34DelegatePersonData:GetTrustItemId()
  return self._trustItemId
end

function UIActivityN34DelegatePersonData:GetTaskData()
  return self._taskData
end

function UIActivityN34DelegatePersonData:GetDes()
  return self._des
end

function UIActivityN34DelegatePersonData:GetProgress()
  return self._progress
end

function UIActivityN34DelegatePersonData:GetFinaleRewardIcon()
  return self._finalRewardIcon
end

function UIActivityN34DelegatePersonData:GetFinaleRewardDes()
  return self._finalRewardDes
end

function UIActivityN34DelegatePersonData:GetFinaleRewardStatus()
  return self._finalRewardStatus
end

function UIActivityN34DelegatePersonData:GetAllTask()
  return self._tasks
end

function UIActivityN34DelegatePersonData:GetAllTaskCount()
  return #self._tasks
end

function UIActivityN34DelegatePersonData:GetCompleteTaskCount()
  local count = 0
  for i = 1, #self._tasks do
    if self._tasks[i]:IsComplete() then
      count = count + 1
    end
  end
  return count
end

function UIActivityN34DelegatePersonData:GetShowTask(count)
  local result = {}
  for i = 1, #self._tasks do
    if count <= 0 then
      break
    end
    if self._tasks[i]:IsComplete() == false then
      count = count - 1
      result[#result + 1] = self._tasks[i]
    end
  end
  return result
end

function UIActivityN34DelegatePersonData:IsPaste()
  return self._paste
end

function UIActivityN34DelegatePersonData:IsComplete()
  return self._complete
end

function UIActivityN34DelegatePersonData:GetTips()
  return self._tips
end

function UIActivityN34DelegatePersonData:GetTrustValue()
  return self._trustValue
end

function UIActivityN34DelegatePersonData:GetTotalTrust()
  return self._totalTrust
end

function UIActivityN34DelegatePersonData:GetName()
  return self._name
end

function UIActivityN34DelegatePersonData:GetSpine()
  return self._spine
end

function UIActivityN34DelegatePersonData:CanGetFinalReward()
  local key = self:GetCustomFlagKey("N34_TASK_FINAL_REWARD" .. self._personId)
  if not UnityEngine.PlayerPrefs.HasKey(key) then
    return true
  end
  local value = UnityEngine.PlayerPrefs.GetInt(key)
  return value == 0
end

function UIActivityN34DelegatePersonData:GetFinalReward()
  local key = self:GetCustomFlagKey("N34_TASK_FINAL_REWARD" .. self._personId)
  UnityEngine.PlayerPrefs.SetInt(key, 1)
end

function UIActivityN34DelegatePersonData:GetCustomFlagKey(id)
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = roleModule:GetPstId()
  local key = pstId .. id
  return key
end

_class("UIActivityN34TaskData", Object)
UIActivityN34TaskData = UIActivityN34TaskData

function UIActivityN34TaskData:Constructor(campaign, surveyComponent, surveyComponentInfo, questComponent, camQuestComponentInfo)
  self._campaign = campaign
  self._surveyComponent = surveyComponent
  self._surveyComponentInfo = surveyComponentInfo
  self._questComponent = questComponent
  self._questComponentInfo = camQuestComponentInfo
  self._timeModule = GameGlobal.GetModule(SvrTimeModule)
  self._plotId = self._surveyComponentInfo.m_first_story_id
  local str = Cfg.cfg_global.survey_tokens_item.StrValue
  local a, b = string.match(str, "(.*)%|(.*)")
  self._itemId = tonumber(a)
  self._rewardCount = tonumber(b)
  self._spineName = Cfg.cfg_global.survey_boss_spine_name.StrValue
  self._idleAnim = Cfg.cfg_global.survey_boss_idle_animation.StrValue
  self._randomAnim = Cfg.cfg_global.survey_boss_random_animation.StrValue
  self._idleAnimLength = Cfg.cfg_global.survey_boss_idle_length.IntValue
  self._randomAnimLength = Cfg.cfg_global.survey_boss_random_length.IntValue
  self._delegatePersons = {}
  local cfgs = Cfg.cfg_component_survey({
    ComponentID = self._surveyComponent:GetComponentCfgId()
  })
  for k, cfg in pairs(cfgs) do
    self._delegatePersons[#self._delegatePersons + 1] = UIActivityN34DelegatePersonData:New(self, cfg)
  end
  self._currentDelegatePerson = nil
  self:RefreshRewardInfo()
  self:RefreshPersonInfo()
  self:RefreshCurrentPerson()
end

function UIActivityN34TaskData:Refresh()
  self:RefreshRewardInfo()
  self:RefreshPersonInfo()
  self:RefreshCurrentPerson()
end

function UIActivityN34TaskData:RefreshPersonInfo()
  for i = 1, #self._delegatePersons do
    self._delegatePersons[i]:Refresh()
  end
end

function UIActivityN34TaskData:RefreshCurrentPerson()
  local curId = self._surveyComponentInfo.info.cur_pet_id
  if curId == nil or curId <= 0 then
    self._currentDelegatePerson = nil
  else
    for i = 1, #self._delegatePersons do
      if self._delegatePersons[i]:GetPersonId() == curId then
        self._currentDelegatePerson = self._delegatePersons[i]
        break
      end
    end
  end
  if self._currentDelegatePerson then
    self._currentDelegatePerson:Refresh()
    if self._currentDelegatePerson:IsPaste() and self._currentDelegatePerson:HasCanGetProgressReward() == false then
      local nextPetId = self._currentDelegatePerson:GetNextPetId()
      if nextPetId == nil or nextPetId <= 0 then
        self._currentDelegatePerson = nil
      end
    end
  end
end

function UIActivityN34TaskData:RefreshRewardInfo()
  local maxCount = Cfg.cfg_global.survey_tokens_MaxNum.IntValue
  self._remainRewardCount = maxCount - self._surveyComponentInfo.info.tokens_get_num
  local timeLength = Cfg.cfg_global.survey_tokens_time.IntValue
  self._rewardRemainTime = self._surveyComponentInfo.info.tokens_get_time + timeLength
end

function UIActivityN34TaskData:GetCampaign()
  return self._campaign
end

function UIActivityN34TaskData:GetSurveyComponent()
  return self._surveyComponent
end

function UIActivityN34TaskData:GetSurveyComponentInfo()
  return self._surveyComponentInfo
end

function UIActivityN34TaskData:GetQuestComponent()
  return self._questComponent
end

function UIActivityN34TaskData:GetQuestComponentInfo()
  return self._questComponentInfo
end

function UIActivityN34TaskData:GetDelegatePersons()
  return self._delegatePersons
end

function UIActivityN34TaskData:GetCurrentDelegatePerson()
  return self._currentDelegatePerson
end

function UIActivityN34TaskData:GetSpineName()
  return self._spineName
end

function UIActivityN34TaskData:GetIdleAnim()
  return self._idleAnim
end

function UIActivityN34TaskData:GetRandomAnim()
  return self._randomAnim
end

function UIActivityN34TaskData:GetIdleAnimLength()
  return self._idleAnimLength
end

function UIActivityN34TaskData:GetRandomAnimLenth()
  return self._randomAnimLength
end

function UIActivityN34TaskData:GetItemId()
  return self._itemId
end

function UIActivityN34TaskData:GetRemainRewardCount()
  return self._remainRewardCount
end

function UIActivityN34TaskData:GetRewardCount()
  return self._rewardCount
end

function UIActivityN34TaskData:GetRewardRemainTime()
  local nowTime = self._timeModule:GetServerTime() / 1000
  local time = self._rewardRemainTime - nowTime
  if time < 0 then
    time = 0
  end
  return time
end

function UIActivityN34TaskData:CanPlayPlot()
  local key = self:GetCustomFlagKey("N34_TASK_PLOT_PLAY")
  if not UnityEngine.PlayerPrefs.HasKey(key) then
    return true
  end
  local value = UnityEngine.PlayerPrefs.GetInt(key)
  return value == 0
end

function UIActivityN34TaskData:PlayPlot()
  local key = self:GetCustomFlagKey("N34_TASK_PLOT_PLAY")
  UnityEngine.PlayerPrefs.SetInt(key, 1)
end

function UIActivityN34TaskData:GetPlotId()
  return self._plotId
end

function UIActivityN34TaskData:GetCustomFlagKey(id)
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = roleModule:GetPstId()
  local key = pstId .. id
  return key
end

function UIActivityN34TaskData:CanPlayCompleteAnimation(index)
  local key = self:GetCustomFlagKey("N34_COMPLETE_ANIMATION" .. index)
  if not UnityEngine.PlayerPrefs.HasKey(key) then
    return true
  end
  local value = UnityEngine.PlayerPrefs.GetInt(key)
  return value == 0
end

function UIActivityN34TaskData:PlayCompleteAnimation(index)
  local key = self:GetCustomFlagKey("N34_COMPLETE_ANIMATION" .. index)
  UnityEngine.PlayerPrefs.SetInt(key, 1)
end
