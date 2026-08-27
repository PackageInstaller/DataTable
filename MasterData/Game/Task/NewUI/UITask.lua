local UITask = class("UITask", UIBaseWindow)
local base = UIBaseWindow
local cs_ResLoader = CS.ResLoader
local cs_DoTween = CS.DG.Tweening.DOTween
local UINTaskPageTog = require("Game.Task.NewUI.UINTaskPageTog")
local UINTaskSubPageTog = require("Game.Task.NewUI.UINTaskSubPageTog")
local UINTaskList = require("Game.Task.NewUI.UINTaskList")
local UINTaskPeroidNode = require("Game.Task.NewUI.UINTaskPeroidNode")
local UINTaskParticleNode = require("Game.Task.NewUI.ParticleNode.UINTaskParticleNode")
local TaskEnum = require("Game.Task.TaskEnum")
local UINTaskBattlePass = require("Game.Task.NewUI.UINTaskBattlePass")
local UINTimeLimitTasklimitNode = require("Game.Task.NewUI.UINTimeLimitTasklimitNode")
local OpenTaskOrder = {
  [TaskEnum.eTaskType.DailyTask] = 1,
  [TaskEnum.eTaskType.WeeklyTask] = 2,
  [TaskEnum.eTaskType.MainTask] = 3,
  [TaskEnum.eTaskType.SideTask] = 4,
  [TaskEnum.eTaskType.LargeActivityTask] = -1,
  [TaskEnum.eTaskType.HeroActivityTask] = -2
}

function UITask:OnInit()
  self.ctrl = ControllerManager:GetController(ControllerTypeId.Task)
  self.resloader = cs_ResLoader.Create()
  UIUtil.SetTopStatus(self, self.OnClickBack, {}, nil, nil)
  self._RefreshSubPages = BindCallback(self, self.RefreshSubPages)
  self._OnSelectPage = BindCallback(self, self.OnSelectPage)
  self.pageTogPool = UIItemPool.New(UINTaskPageTog, self.ui.obj_taskPageTog)
  self.subPageTogPool = UIItemPool.New(UINTaskSubPageTog, self.ui.obj_subPageTog)
  self.ui.obj_taskPageTog:SetActive(false)
  self.ui.obj_subPageTog:SetActive(false)
  self.taskListNode = UINTaskList.New()
  self.taskListNode:Init(self.ui.obj_taskListNode)
  self.peroidNode = UINTaskPeroidNode.New()
  self.peroidNode:Init(self.ui.obj_peroidListNode)
  self.taskParticleNode = UINTaskParticleNode.New()
  self.taskParticleNode:Init(self.ui.particlesNode)
  self.battlePassNode = UINTaskBattlePass.New()
  self.battlePassNode:Init(self.ui.battlePassNode)
  self.battlePassNode:Hide()
  self.timeLimitNode = UINTimeLimitTasklimitNode.New()
  self.timeLimitNode:Init(self.ui.timeLimitNode)
  self.ui.obj_emptyPage:SetActive(false)
  self.ui.obj_emptyMainPage:SetActive(false)
  self:RegistRedDot()
  self:SetTaskAllTweens()
  self.listoffsetMin = self.ui.obj_taskListNode.gameObject.transform.offsetMin
  UIUtil.AddButtonListener(self.ui.btn_ReceiveAll, self, self.OnClickReceiveAll)
  self.__onTaskCommitComplete = BindCallback(self, self.OnTaskCommitComplete)
  MsgCenter:AddListener(eMsgEventId.TaskCommitComplete, self.__onTaskCommitComplete)
end

function UITask:RefreshPages()
  self.pageGroupList = self.ctrl:GetPageGroupList()
  self.pageTogPool:HideAll()
  self.pageRealIndexDic = {}
  local isDailyTaskUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_DailyTask)
  local autoSelectPage = TaskEnum.eTaskType.MainTask
  if self.ctrl.isDailyTaskUnlock and not self.ctrl:IsCompleteAllDailyTaskOrFinshPeroid() then
    autoSelectPage = TaskEnum.eTaskType.DailyTask
  end
  local isReddotAutoSelect = false
  for _, group in ipairs(self.pageGroupList) do
    local groupIndex = group.realIndex
    if isDailyTaskUnlock or not table.contain(group, 4) then
      local pageTog = self.pageTogPool:GetOne()
      pageTog:InitPageTog(groupIndex, group, self._RefreshSubPages, self._OnSelectPage)
      self.pageRealIndexDic[groupIndex] = pageTog
      local totalRedDotCount = 0
      for index, taskTypeId in ipairs(group) do
        local OK, taskPageNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Task, taskTypeId)
        if OK then
          local RedDotCount = taskPageNode:GetRedDotCount()
          if 0 < RedDotCount and OpenTaskOrder[taskTypeId] ~= nil and OpenTaskOrder[autoSelectPage] ~= nil and (not isReddotAutoSelect or OpenTaskOrder[taskTypeId] < OpenTaskOrder[autoSelectPage]) then
            autoSelectPage = taskTypeId
            isReddotAutoSelect = true
          end
          totalRedDotCount = totalRedDotCount + RedDotCount
        end
      end
      pageTog:SetRedDotActive(0 < totalRedDotCount)
    end
  end
  self:SelectPage(autoSelectPage)
end

function UITask:ChangeBtnReceiveAll(typeId)
  local taskController = ControllerManager:GetController(ControllerTypeId.Task)
  if taskController ~= nil then
    self.taskIds = {}
    self.PeriodTaskIds = {
      extrType = nil,
      dic = {}
    }
    local taskDatas, peroidDatas = taskController:GetDatas4Task(typeId)
    for taskId, taskData in pairs(taskDatas) do
      if taskData:CheckComplete() then
        self.taskIds[taskId] = true
      end
    end
    if peroidDatas ~= nil then
      self.PeriodTaskIds.extrType = taskController:TaskType2PeriodType(typeId)
      for taskId, data in pairs(peroidDatas) do
        if data.stateType == TaskEnum.eTaskState.Completed then
          self.PeriodTaskIds.dic[taskId] = true
        end
      end
    end
  end
  if table.count(self.taskIds) > 0 or table.count(self.PeriodTaskIds.dic) > 0 then
    if typeId == TaskEnum.eTaskType.MainTask or TaskEnum.IsActivityTask(typeId) then
      self.ui.btn_ReceiveAll.gameObject.transform:SetParent(self.ui.main_receiveAllPos.transform, false)
      self.ui.btn_ReceiveAll.gameObject:SetActive(true)
      local size = self.ui.btn_ReceiveAll.gameObject.transform.sizeDelta
      self.ui.obj_taskListNode.gameObject.transform.offsetMin = Vector2.New(0, 0 + size.y + 14.5)
    else
      self.ui.btn_ReceiveAll.gameObject.transform:SetParent(self.ui.day_receiveAllPos.transform, false)
      self.ui.btn_ReceiveAll.gameObject:SetActive(true)
      local size = self.ui.btn_ReceiveAll.gameObject.transform.sizeDelta
      self.ui.obj_taskListNode.gameObject.transform.offsetMin = Vector2.New(self.listoffsetMin.x, self.listoffsetMin.y + size.y * 1.1)
    end
  else
    self.ui.obj_taskListNode.gameObject.transform.offsetMin = Vector2.New(self.listoffsetMin.x, self.listoffsetMin.y)
    self.ui.btn_ReceiveAll.gameObject:SetActive(false)
    self:SetTaskNodeParent(typeId == TaskEnum.eTaskType.MainTask or TaskEnum.IsActivityTask(typeId))
  end
end

function UITask:OnClickReceiveAll()
  if table.count(self.taskIds) > 0 then
    self.ctrl:SendOneKeyPick(self.taskIds)
    return
  end
  if 0 < table.count(self.PeriodTaskIds.dic) then
    local type = self.PeriodTaskIds.extrType
    self.PeriodTaskIds.extrType = nil
    self.ctrl:SendCommitTaskPeriodArray(self.PeriodTaskIds.dic, type)
  end
end

function UITask:OnTaskCommitComplete()
  if self._lastTypeId == nil then
    return
  end
  self:ChangeBtnReceiveAll(self._lastTypeId)
end

function UITask:RefreshSubPages(idList, nameList)
  self.subPageTogPool:HideAll()
  if idList == nil then
    self:SetTaskNodeParent(true)
    return
  else
    self:SetTaskNodeParent(false)
  end
  for i, typeId in ipairs(idList) do
    local subPageTog = self.subPageTogPool:GetOne()
    local name = nameList[i]
    local taskDatas = self.ctrl:GetDatas4Task(typeId)
    subPageTog:InitSubPageTog(typeId, name, taskDatas, self._OnSelectPage)
    if i == 1 then
      subPageTog.ui.tog_subPageTog.isOn = true
      self:OnSelectPage(typeId)
    else
      subPageTog.ui.tog_subPageTog.isOn = false
    end
    local OK, taskPageNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Task, typeId)
    subPageTog:SetRedDotActive(OK and taskPageNode:GetRedDotCount() > 0)
  end
end

function UITask:SetTaskNodeParent(isBase)
  if isBase then
    self.ui.obj_taskListNode.transform:SetParent(self.ui.basePos.transform)
  else
    self.ui.obj_taskListNode.transform:SetParent(self.ui.peroidPos.transform)
  end
  self.ui.obj_taskListNode.transform.localPosition = Vector3.zero
  self.ui.obj_taskListNode.transform.sizeDelta = Vector2.zero
end

function UITask:OnSelectPage(typeId, groupIndex)
  self.ctrl:SelectTask(typeId)
  local taskDatas, peroidDatas = self.ctrl:GetDatas4Task(typeId)
  if self.ctrl:IsPeriodTaskType(typeId) then
    local noPeroidDatas = peroidDatas == nil
    self.ui.taskPage.gameObject:SetActive(not noPeroidDatas)
    self.ui.obj_emptyPage:SetActive(noPeroidDatas)
    if groupIndex ~= nil then
      local name = self.ctrl:GetPageName(groupIndex)
      self.ui.tex_Empty:SetIndex(0, name)
    else
      self.ui.tex_Empty:SetIndex(1)
    end
  else
    self.ui.obj_emptyPage:SetActive(false)
  end
  if typeId == TaskEnum.eTaskType.MainTask and 0 >= table.count(taskDatas) then
    self.ui.obj_emptyMainPage:SetActive(true)
  else
    self.ui.obj_emptyMainPage:SetActive(false)
  end
  if peroidDatas == nil then
    self.ui.obj_peroidListNode:SetActive(false)
    self:RefreshTask(taskDatas, true, typeId)
  else
    self.ui.obj_peroidListNode:SetActive(true)
    self:RefreshTask(taskDatas, true, typeId)
    self.peroidNode:RefreshPeroid(typeId, peroidDatas, true)
    for index, togItem in ipairs(self.pageTogPool.listItem) do
      if table.contain(togItem.group, typeId) then
        for index, subTogItem in ipairs(self.subPageTogPool.listItem) do
          if subTogItem.id == typeId then
            subTogItem:SetMissionCount(taskDatas)
          else
            subTogItem:SetMissionCount(self.ctrl:GetDatas4Task(subTogItem.id))
          end
        end
      end
    end
  end
  if self.ctrl:IsChangeTaskType(typeId) and self.pageSequence ~= nil then
    self.pageSequence:Restart()
  end
  if (typeId == TaskEnum.eTaskType.DailyTask or typeId == TaskEnum.eTaskType.WeeklyTask) and PlayerDataCenter.battlepassData:GetMainBattlePass() ~= nil then
    self.battlePassNode:InitTaskBattlePass()
  else
    self.battlePassNode:Hide()
  end
  if TaskEnum.IsActivityTask(typeId) then
    self.timeLimitNode:InitWithCurTaskDatas(typeId)
    self.timeLimitNode:Show()
  else
    self.timeLimitNode:Hide()
  end
  if self._lastTypeId ~= typeId then
    self._lastTypeId = typeId
    self.taskParticleNode:HideTaskParticle()
  end
  self:ChangeBtnReceiveAll(typeId)
  if PlayerDataCenter.allTaskData:IsTimeLimitType(typeId) then
    local OK, taskPageNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Task, typeId, RedDotStaticTypeId.TaskFirstOpen)
    if OK and 0 < taskPageNode:GetRedDotCount() then
      taskPageNode:SetRedDotCount(0)
      local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
      for _, taskData in pairs(taskDatas) do
        if taskData.open_condition ~= nil then
          saveUserData:SetNewFirstOpenTaskReddot(taskData.open_condition, true)
        end
      end
    end
  end
end

function UITask:SelectPage(typeId)
  for _, pageTog in ipairs(self.pageTogPool.listItem) do
    if pageTog.isMult then
      for subIndex, subPageTypeId in ipairs(pageTog.group) do
        if typeId == subPageTypeId then
          pageTog.ui.tog_taskPageTog.group:SetAllTogglesOff()
          pageTog.ui.tog_taskPageTog.isOn = true
          local subPageTog = self.subPageTogPool.listItem[subIndex]
          subPageTog.ui.tog_subPageTog.isOn = true
          return
        end
      end
    elseif typeId == pageTog.group[1] then
      pageTog.ui.tog_taskPageTog.isOn = true
      return
    end
  end
end

function UITask:RefreshTask(taskDatas, needSort, typeId)
  local taskList = {}
  for key, value in pairs(taskDatas) do
    table.insert(taskList, value)
  end
  self.taskListNode:RefreshTaskItems(taskList, needSort, typeId)
end

function UITask:RefreshPeroid(peroidId, peroidDatas)
  self.peroidNode:RefreshPeroid(peroidId, peroidDatas)
end

function UITask:RecordTaskRewardItemPos(position)
  self._lastClickRewardPos = position
end

function UITask:OnDailyWeeklyTaskComplete()
  if self._lastClickRewardPos == nil then
    return
  end
  AudioManager:PlayAudioById(1116)
  local targetPos = self.peroidNode:GetTaskPeroidProgressPos()
  self.taskParticleNode:FlyTaskLively(self._lastClickRewardPos, targetPos)
  self._lastClickRewardPos = nil
end

function UITask:OnClickBack()
  self:OnCloseWin()
  if self.fromType == eBaseWinFromWhere.home then
    local homeWin = UIManager:GetWindow(UIWindowTypeID.Home)
    if homeWin ~= nil then
      AudioManager:RemoveAllVoice()
      homeWin:BackFromOtherWin()
    end
  end
  self.ctrl:CloseTaskUI()
end

function UITask:RegistRedDot()
  function self.__onHeroCardRedDotEvent(node)
    local OK, taskPageNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Task, node.nodeId)
    
    for _, group in ipairs(self.pageGroupList) do
      local groupIndex = group.realIndex
      if table.contain(group, node.nodeId) then
        local pageTog = self.pageRealIndexDic[groupIndex]
        if pageTog ~= nil then
          local totalRedDotCount = 0
          for index, taskTypeId in ipairs(group) do
            local OK, taskPageNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Task, taskTypeId)
            if OK then
              totalRedDotCount = totalRedDotCount + taskPageNode:GetRedDotCount()
            end
          end
          pageTog:SetRedDotActive(0 < totalRedDotCount)
        end
      end
    end
    for index, item in ipairs(self.subPageTogPool.listItem) do
      if item.id == node.nodeId then
        item:SetRedDotActive(OK and 0 < taskPageNode:GetRedDotCount())
      end
    end
  end
  
  RedDotController:AddListener(RedDotDynPath.TaskPagePath, self.__onHeroCardRedDotEvent)
end

function UITask:RemoveRedDot()
  RedDotController:RemoveListener(RedDotDynPath.TaskPagePath, self.__onHeroCardRedDotEvent)
end

function UITask:OnHide()
  base.OnHide(self)
end

function UITask:SetTaskAllTweens()
  local moveY = 20
  local pageLocalPos = self.ui.taskPage.transform.localPosition
  pageLocalPos = Vector3.New(pageLocalPos.x, pageLocalPos.y - moveY, pageLocalPos.z)
  self.ui.taskPage.transform.localPosition = pageLocalPos
  self.ui.taskPage.alpha = 0
  self.pageSequence = cs_DoTween.Sequence()
  self.pageSequence:Append(self.ui.taskPage.transform:DOLocalMoveY(moveY, 0.3):SetRelative(true))
  self.pageSequence:Join(self.ui.taskPage:DOFade(1, 0.3))
  self.pageSequence:AppendCallback(function()
  end)
  self.pageSequence:SetAutoKill(false)
end

function UITask:KillTaskAllTweens()
  if self.pageSequence ~= nil then
    self.pageSequence:Kill()
    self.pageSequence = nil
  end
end

function UITask:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.TaskCommitComplete, self.__onTaskCommitComplete)
  self:RemoveRedDot()
  self.taskListNode:Delete()
  self.peroidNode:Delete()
  self.taskParticleNode:Delete()
  self.pageTogPool:DeleteAll()
  self.battlePassNode:Delete()
  self.timeLimitNode:Delete()
  self:KillTaskAllTweens()
  base.OnDelete(self)
end

return UITask
