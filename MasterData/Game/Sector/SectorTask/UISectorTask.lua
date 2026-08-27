local UISectorTask = class("UISectorTask", UIBaseWindow)
local base = UIBaseWindow
local UINSectorTaskItem = require("Game.Sector.SectorTask.UINSectorTaskItem")
local UINSectorTaskAchiveItem = require("Game.Sector.SectorTask.UINSectorTaskAchiveItem")
local UInSectorTaskRewardFloat = require("Game.Sector.SectorTask.UInSectorTaskRewardFloat")
local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
local HAType = FloatAlignEnum.HAType
local VAType = FloatAlignEnum.VAType
local TaskEnum = require("Game.Task.TaskEnum")
UISectorTask.ETaskUIType = {Sector = 1, WeeklyChallenge = 2}

function UISectorTask:OnInit()
  self.curSectorId = nil
  self.sectorTaskDatas = nil
  self.itemDic = {}
  self.ui.loop_taskScroll.onInstantiateItem = BindCallback(self, self.__OnNewItem)
  self.ui.loop_taskScroll.onChangeItem = BindCallback(self, self.__OnChangeItem)
  self.viewReward = UInSectorTaskRewardFloat.New()
  self.viewReward:Init(self.ui.viewReward)
  self.SectorTaskController = ControllerManager:GetController(ControllerTypeId.SectorTaskCtrl, true)
  self.achivParentWidth = self.ui.achivParent.rect.width
  UIUtil.SetTopStatus(self, self.__OnClickReturn)
  self.rewardItemPool = UIItemPool.New(UINSectorTaskAchiveItem, self.ui.obj_rewardItem)
  self.ui.obj_rewardItem:SetActive(false)
  self:AddTaskMsgListener()
  self.__OnClickPeriodFunc = BindCallback(self, self.OnClickPeriodItem)
  self.resloader = CS.ResLoader.Create()
end

function UISectorTask:AddTaskMsgListener()
  self.__refillTaskList = BindCallback(self, self.__RefillTaskList)
  MsgCenter:AddListener(eMsgEventId.TaskUpdate, self.__refillTaskList)
  MsgCenter:AddListener(eMsgEventId.TaskDelete, self.__refillTaskList)
  MsgCenter:AddListener(eMsgEventId.TaskCommitComplete, self.__refillTaskList)
  self.__refreshSectorAchivUI = BindCallback(self, self.__RefreshSectorAchivUI)
  MsgCenter:AddListener(eMsgEventId.SectorPickReward, self.__refreshSectorAchivUI)
  MsgCenter:AddListener(eMsgEventId.PeroidUpdate, self.__refreshSectorAchivUI)
  self.__onItemUpdate = BindCallback(self, self.__OnItemUpdate)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__onItemUpdate)
end

function UISectorTask:RemoveTaskMsgListener()
  MsgCenter:RemoveListener(eMsgEventId.TaskUpdate, self.__refillTaskList)
  MsgCenter:RemoveListener(eMsgEventId.TaskDelete, self.__refillTaskList)
  MsgCenter:RemoveListener(eMsgEventId.TaskCommitComplete, self.__refillTaskList)
  MsgCenter:RemoveListener(eMsgEventId.SectorPickReward, self.__refreshSectorAchivUI)
  MsgCenter:RemoveListener(eMsgEventId.PeroidUpdate, self.__refreshSectorAchivUI)
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__onItemUpdate)
end

function UISectorTask:InitSectorTask(curSectorId, closeCallback)
  self.taskUIType = self.ETaskUIType.Sector
  self.curSectorId = curSectorId
  self.closeCallback = closeCallback
  self.initTween = true
  self:__RefreshSectorTaskHead()
  self:__RefreshAchivTaskUI()
  self:__RefreshSectorAchivUI()
  self.ui.img_Icon:SetIndex(0)
end

function UISectorTask:InitWeeklyChallengeTask(closeCallback)
  self.taskUIType = self.ETaskUIType.WeeklyChallenge
  self.closeCallback = closeCallback
  self.initTween = true
  self:__RefreshSectorTaskHead()
  self:__RefreshAchivTaskUI()
  self:__RefreshSectorAchivUI()
  self.ui.img_Icon:SetIndex(1)
  if self.timerId ~= nil then
    TimerManager:StopTimer(self.timerId)
    self.timerId = nil
  end
  local counterElem = PlayerDataCenter.allWeeklyChallengeData:GetCounterElem()
  if counterElem ~= nil then
    self.nextRefreshTimeStamp = counterElem.nextExpiredTm
    if self.nextRefreshTimeStamp ~= nil and self.nextRefreshTimeStamp > PlayerDataCenter.timestamp then
      self.timerId = TimerManager:StartTimer(1, self.CutDownTime, self, false, false, false)
      self:CutDownTime()
    end
  end
end

function UISectorTask:__RefreshSectorTaskHead()
  self.ui.img_SectorPic.gameObject:SetActive(self.taskUIType == self.ETaskUIType.Sector)
  self.ui.tex_IsPeriodic.gameObject:SetActive(self.taskUIType == self.ETaskUIType.WeeklyChallenge)
  self.ui.bg_weeklyChallenge.gameObject:SetActive(self.taskUIType == self.ETaskUIType.WeeklyChallenge)
  self.ui.taskCount:SetActive(self.taskUIType == self.ETaskUIType.Sector)
  self.ui.taskTime:SetActive(self.taskUIType == self.ETaskUIType.WeeklyChallenge)
  if self.taskUIType == self.ETaskUIType.Sector then
    if self.curSectorId ~= nil then
      local sectorCfg = ConfigData.sector[self.curSectorId]
      self.ui.tex_name:SetIndex(1, LanguageUtil.GetLocaleText(sectorCfg.name))
      self.ui.tex_typeName:SetIndex(0, LanguageUtil.GetLocaleText(sectorCfg.type_name))
    end
    self.ui.img_SectorPic.texture = ExplorationManager:GetSectorHeadTexture(self.curSectorId, nil, nil, self.resloader)
  else
    self.ui.tex_name:SetIndex(0)
    self.ui.tex_typeName:SetIndex(1)
  end
end

function UISectorTask:CutDownTime()
  local timestamp = PlayerDataCenter.timestamp
  local remaindTime = math.max(math.floor(self.nextRefreshTimeStamp - timestamp), 0)
  local d, h, m, s = TimeUtil:TimestampToTimeInter(remaindTime, false, true)
  local hStr = 10 <= h and tostring(h) or "0" .. tostring(h)
  local mStr = 10 <= m and tostring(m) or "0" .. tostring(m)
  local sStr = 10 <= s and tostring(s) or "0" .. tostring(s)
  if 0 < d then
    self.ui.tex_TaskTime:SetIndex(0, tostring(d), hStr, mStr, sStr)
  else
    self.ui.tex_TaskTime:SetIndex(1, hStr, mStr, sStr)
  end
  if remaindTime <= 0 and self.timerId ~= nil then
    TimerManager:StopTimer(self.timerId)
    self.timerId = nil
  end
  for _, taskItem in pairs(self.itemDic) do
    taskItem:RefreshRemainingTime(timestamp)
  end
end

function UISectorTask:__RefreshTaskCount()
  local totalCount = #self.sectorTaskDatas
  local pickCount = 0
  for _, data in ipairs(self.sectorTaskDatas) do
    if data.state == TaskEnum.eTaskState.Picked then
      pickCount = pickCount + 1
    end
  end
  local strPick = 9 < pickCount and tostring(pickCount) or "0" .. tostring(pickCount)
  local strTotal = 9 < totalCount and tostring(totalCount) or "0" .. tostring(totalCount)
  self.ui.tex_TaskCount.text = strPick .. "/" .. strTotal
end

function UISectorTask:__RefreshAchivTaskUI()
  if self.taskUIType == self.ETaskUIType.Sector then
    self.sectorTaskDatas = self.SectorTaskController:GetSectorTaskDatas(self.curSectorId)
    self:__RefreshTaskCount()
  else
    local taskCtrl = ControllerManager:GetController(ControllerTypeId.Task)
    local taskDataDic, _ = taskCtrl:GetDatas4Task(TaskEnum.eTaskType.WeeklyChallengeTask)
    self.sectorTaskDatas = {}
    for _, data in pairs(taskDataDic) do
      table.insert(self.sectorTaskDatas, data)
    end
    self:SortTaskData()
  end
  local num = #self.sectorTaskDatas
  self.ui.loop_taskScroll.totalCount = num
  self.ui.loop_taskScroll:RefreshCells()
end

function UISectorTask:__OnNewItem(go)
  local taskItem = UINSectorTaskItem.New()
  taskItem:Init(go)
  self.itemDic[go] = taskItem
end

function UISectorTask:__OnChangeItem(go, index)
  local taskItem = self.itemDic[go]
  if taskItem == nil then
    error("Can't find goodItem by gameObject")
    return
  end
  local taskData = self.sectorTaskDatas[index + 1]
  taskItem:RefreshSectorTaskItem(taskData, self.taskUIType - 1, BindCallback(self, self.ItemClicked))
end

function UISectorTask:ItemClicked(taskData)
  if taskData:CheckComplete() and not self.isPicking then
    self.isPicking = true
    NetworkManager:GetNetwork(NetworkTypeID.Task):SendCommitQuest(taskData, function()
      AudioManager:PlayAudioById(1120)
      self.isPicking = false
    end)
  end
end

function UISectorTask:__RefillTaskList()
  local oldNum = table.count(self.sectorTaskDatas)
  if self.taskUIType == self.ETaskUIType.Sector then
    self.sectorTaskDatas = self.SectorTaskController:GetSectorTaskDatas(self.curSectorId)
    self:__RefreshTaskCount()
  else
    local taskCtrl = ControllerManager:GetController(ControllerTypeId.Task)
    local taskDataDic, _ = taskCtrl:GetDatas4Task(TaskEnum.eTaskType.WeeklyChallengeTask)
    self.sectorTaskDatas = {}
    for _, data in pairs(taskDataDic) do
      table.insert(self.sectorTaskDatas, data)
    end
    self:SortTaskData()
  end
  local num = #self.sectorTaskDatas
  if oldNum <= num then
    self.ui.loop_taskScroll.totalCount = num
    self.ui.loop_taskScroll:RefillCells()
  else
    self.ui.loop_taskScroll.totalCount = num
    self.ui.loop_taskScroll:RefreshCells()
  end
end

function UISectorTask:SortTaskData()
  if self.sectorTaskDatas == nil then
    return
  end
  table.sort(self.sectorTaskDatas, function(a, b)
    local aState = a:CheckComplete() and 0 or a.state or TaskEnum.eTaskState.Picked
    local bState = b:CheckComplete() and 0 or b.state or TaskEnum.eTaskState.Picked
    if aState ~= bState then
      return aState < bState
    end
    local orderA = a:GetTaskOrder()
    local orderB = b:GetTaskOrder()
    if orderA ~= orderB then
      return orderA < orderB
    end
    return a.id < b.id
  end)
end

function UISectorTask:__RefreshSectorAchivUI()
  self.starId = nil
  local starCount, starTotalCount, sectorAchivDatas, starCountList
  if self.taskUIType == self.ETaskUIType.Sector then
    self.starId, starCount, _ = self.SectorTaskController:GetSectorAchievementScore(self.curSectorId)
    starTotalCount = self.SectorTaskController:GetSectorTaskTotalCount(self.starId, self.curSectorId)
    self.sectorAchivDatas = self.SectorTaskController:GetSectorAchievementDatas(self.curSectorId)
    starCountList = {}
    for i, data in ipairs(self.sectorAchivDatas) do
      starCountList[i] = data.achiveCfg.conditionNums[1]
    end
  else
    local taskCtr = ControllerManager:GetController(ControllerTypeId.Task)
    self.sectorAchivDatas = taskCtr:GetDatas4Peroid(TaskEnum.eTaskPeriodType.WeeklyChallengeTask)
    self.starId = self.sectorAchivDatas[1].stcData.activeId
    starCount = PlayerDataCenter:GetItemCount(self.starId)
    starTotalCount = 0
    starCountList = {}
    for i, data in ipairs(self.sectorAchivDatas) do
      starTotalCount = data.stcData.activeNum
      starCountList[i] = starTotalCount
    end
  end
  
  local function numPlaceFunc(num)
    if num < 0 then
      num = -num
    end
    local res = 0
    while 1 <= num do
      num = num / 10
      res = res + 1
    end
    return res
  end
  
  local totalCountPlace = numPlaceFunc(starTotalCount < 10 and 10 or starTotalCount)
  local starCountPlace = numPlaceFunc(starCount)
  if starCountPlace == totalCountPlace then
    self.ui.tex_Trim.text = ""
  else
    local placeDiff = totalCountPlace - starCountPlace
    local str = ""
    for i = 1, placeDiff do
      str = str .. "0"
    end
    self.ui.tex_Trim.text = str
  end
  self.ui.tex_Point.text = tostring(starCount)
  local fillAmount = 0
  if starTotalCount ~= 0 then
    fillAmount = starCount / starTotalCount
  end
  if not self.initTween then
    self.ui.img_Process:DOKill(true)
    self.ui.img_Process:DOFillAmount(fillAmount, 0.35)
  else
    self.ui.img_Process.fillAmount = fillAmount
    self.initTween = false
  end
  self.rewardItemPool:HideAll()
  for index, achivData in ipairs(self.sectorAchivDatas) do
    local item = self.rewardItemPool:GetOne()
    local state, pointCount
    if self.taskUIType == self.ETaskUIType.Sector then
      state = achivData.state
      pointCount = starCountList[index]
    else
      state = achivData.stateType
      pointCount = starCountList[index]
    end
    item:InitSectorTaskAchiveItem(index, state, self.taskUIType - 1, pointCount, self.__OnClickPeriodFunc)
    local pos = Vector3.zero
    if starTotalCount ~= 0 then
      pos = Vector3.New(pointCount / starTotalCount * self.achivParentWidth, 0, 0)
    end
    item.transform.localPosition = pos
  end
end

function UISectorTask:__OnItemUpdate(itemIdList)
  if self.starId == nil or itemIdList[self.starId] == nil then
    return
  end
  if self.taskUIType == self.ETaskUIType.Sector then
    PlayerDataCenter.sectorAchievementDatas:UpdateSectorAchivRedDot(self.curSectorId)
    self:__RefreshSectorAchivUI()
  end
end

function UISectorTask:__ShowAchivRewardsFloatWin(rewardItem, achivRewardIds, achivRewardNums)
  self.viewReward:FloatTo(rewardItem.transform, HAType.autoCenter, VAType.up)
  self.viewReward:RefreshItems(achivRewardIds, achivRewardNums, function()
    rewardItem:SetViewState(false)
  end)
  self.viewReward:Show()
  rewardItem:SetViewState(true)
  AudioManager:PlayAudioById(1055)
end

function UISectorTask:OnClickPeriodItem(item, index)
  local data = self.sectorAchivDatas[index]
  if self.taskUIType == self.ETaskUIType.Sector then
    if data.state == TaskEnum.eTaskState.Completed then
      item:SetPicking(true)
      self._heroIdSnapShoot = PlayerDataCenter:GetHeroIdSnapShoot()
      NetworkManager:GetNetwork(NetworkTypeID.Sector):SendPickReward(self.curSectorId, data.achiveCfg.id, function()
        item:SetPicking(false)
        AudioManager:PlayAudioById(1120)
        UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
          if window == nil then
            return
          end
          local rewardIds = data.achiveCfg.achivRewardIds
          local rewardNums = data.achiveCfg.achivRewardNums
          local CommonRewardData = require("Game.CommonUI.CommonRewardData")
          local CRData = CommonRewardData.CreateCRDataUseList(rewardIds, rewardNums):SetCRHeroSnapshoot(self._heroIdSnapShoot)
          window:AddAndTryShowReward(CRData)
        end)
      end)
    else
      self:__ShowAchivRewardsFloatWin(item, data.achiveCfg.achivRewardIds, data.achiveCfg.achivRewardNums)
    end
  elseif data.stateType == TaskEnum.eTaskState.Completed then
    local taskCtr = ControllerManager:GetController(ControllerTypeId.Task)
    taskCtr:SendCommitTaskPeriod(index, TaskEnum.eTaskPeriodType.WeeklyChallengeTask)
  else
    self:__ShowAchivRewardsFloatWin(item, data.stcData.rewardIds, data.stcData.rewardNums)
  end
end

function UISectorTask:__OnClickReturn()
  if self.closeCallback ~= nil then
    self.closeCallback()
  end
  self:Delete()
end

function UISectorTask:OnDelete()
  self:RemoveTaskMsgListener()
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  if self.timerId ~= nil then
    TimerManager:StopTimer(self.timerId)
    self.timerId = nil
  end
  base.OnDelete(self)
end

return UISectorTask
