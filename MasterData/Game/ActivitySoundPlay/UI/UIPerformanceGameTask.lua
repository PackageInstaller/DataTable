local base = require("Game.Sector.SectorTask.UISectorTask")
local UIPerformanceGameTask = class("UIPerformanceGameTask", base)
local TaskEnum = require("Game.Task.TaskEnum")
UIPerformanceGameTask.ETaskUIType = {Performance = 1}

function UIPerformanceGameTask:OnPerformanceChange()
  self:__RefreshAchivTaskUI()
  self:__RefreshSectorAchivUI()
end

function UIPerformanceGameTask:AddTaskMsgListener()
  base.AddTaskMsgListener(self)
  self.__OnPerformanceChange = BindCallback(self, self.OnPerformanceChange)
  MsgCenter:AddListener(eMsgEventId.TinyGameDataChange, self.__OnPerformanceChange)
end

function UIPerformanceGameTask:RemoveTaskMsgListener()
  base.RemoveTaskMsgListener(self)
  MsgCenter:RemoveListener(eMsgEventId.TinyGameDataChange, self.__OnPerformanceChange)
end

function UIPerformanceGameTask:__RefreshAchivTaskUI()
  if self.taskUIType == self.ETaskUIType.Performance then
    local taskDataDic = PlayerDataCenter.allTaskData:GetTaskDataDicByType(self.taskType)
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

function UIPerformanceGameTask:__RefillTaskList()
  local oldNum = table.count(self.sectorTaskDatas)
  if self.taskUIType == self.ETaskUIType.Performance then
    local taskDataDic = PlayerDataCenter.allTaskData:GetTaskDataDicByType(self.taskType)
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

function UIPerformanceGameTask:__RefreshSectorAchivUI()
  self.starId = nil
  local starCount, starTotalCount, starCountList
  if self.taskUIType == self.ETaskUIType.Performance then
    self.sectorAchivDatas = self.tinyGameSoundPlayData:GetAchieveData()
    if not table.IsEmptyTable(self.sectorAchivDatas) then
      self.starId = self.sectorAchivDatas[1].stcData.activeId
    end
    starCount = self.tinyGameSoundPlayData:GetTinyGameRewardLevelPoint()
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

function UIPerformanceGameTask:OnClickPeriodItem(item, index)
  local data = self.sectorAchivDatas[index]
  if self.taskUIType == self.ETaskUIType.Performance then
    if data.stateType == TaskEnum.eTaskState.Completed then
      local actFrameId = self.tinyGameSoundPlayData:GetActivityFrameId()
      if actFrameId ~= 0 then
        local miniGameNet = NetworkManager:GetNetwork(NetworkTypeID.TinyGame)
        local cat = self.tinyGameSoundPlayData._cat
        miniGameNet:CS_TinyGame_Reward(actFrameId, index, cat)
      end
    else
      self:__ShowAchivRewardsFloatWin(item, data.stcData.rewardIds, data.stcData.rewardNums)
    end
  end
end

function UIPerformanceGameTask:__OnItemUpdate(itemIdList)
  if self.starId == nil or itemIdList[self.starId] == nil then
    return
  end
  if self.taskUIType == self.ETaskUIType.Performance then
    self:__RefreshSectorAchivUI()
  end
end

function UIPerformanceGameTask:InitPerformanceTask(tinyGameSoundPlayData, closeCallback)
  self.taskUIType = self.ETaskUIType.Performance
  self.tinyGameSoundPlayData = tinyGameSoundPlayData
  self.taskType = self.tinyGameSoundPlayData:GetTaskType()
  self.closeCallback = closeCallback
  self.initTween = true
  self:__RefreshSectorTaskHead()
  self:__RefreshAchivTaskUI()
  self:__RefreshSectorAchivUI()
  self.ui.img_Icon:SetIndex(self.taskUIType - 1)
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

return UIPerformanceGameTask
