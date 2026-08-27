local UIAchievementSystem = class("UIAchievementSystem", UIBaseWindow)
local base = UIBaseWindow
local CommonRewardData = require("Game.CommonUI.CommonRewardData")
local JumpManager = require("Game.Jump.JumpManager")
local TaskEnum = require("Game.Task.TaskEnum")
local cs_ResLoader = CS.ResLoader
local UINAchievementTog = require("Game.Achievement.UI.UINAchievementTog")
local UINAchievementItem = require("Game.Achievement.UI.UINAchievementItem")
local UINAchievementLevelNode = require("Game.Achievement.UI.AchieveLevelUI.UINAchievementLevelNode")
local defaultTogType = 1

function UIAchievementSystem:OnInit()
  self.achieveItemDic = {}
  self.achieveDataList = {}
  self.resloader = cs_ResLoader.Create()
  self.taskNetworkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Task)
  self.currAchievementType = nil
  self.achievementLevelNode = UINAchievementLevelNode.New()
  self.achievementLevelNode:Init(self.ui.achievementLevelNode)
  UIUtil.SetTopStatus(self, self.OnReturnClick)
  self.typeTogPool = UIItemPool.New(UINAchievementTog, self.ui.obj_achivTypeTogHolder)
  self.ui.obj_achivTypeTogHolder:SetActive(false)
  self.ui.loopList_achieveListNode.onInstantiateItem = BindCallback(self, self.m_OnNewItem)
  self.ui.loopList_achieveListNode.onChangeItem = BindCallback(self, self.m_OnChangeItem)
  self._JumpToTarget = BindCallback(self, self.JumpToTarget)
  self._GetReward = BindCallback(self, self.GetReward)
  self.__OnTaskUpdate = BindCallback(self, self.OnTaskUpdate)
  self.__OnTaskDelete = BindCallback(self, self.OnTaskDelete)
  self.__OnTaskCommit = BindCallback(self, self.OnTaskCommit)
  self.__onTaskPicked = BindCallback(self, self.OnTaskPicked)
  MsgCenter:AddListener(eMsgEventId.TaskUpdate, self.__OnTaskUpdate)
  MsgCenter:AddListener(eMsgEventId.TaskDelete, self.__OnTaskDelete)
  MsgCenter:AddListener(eMsgEventId.TaskCommitComplete, self.__OnTaskCommit)
  MsgCenter:AddListener(eMsgEventId.UpdatePickedAchivTask, self.__onTaskPicked)
  self.offsetMin = self.ui.loopList_achieveListNode.gameObject.transform.offsetMin
  UIUtil.AddButtonListener(self.ui.btn_ReceiveAll, self, self.OnClickReceiveAll)
end

function UIAchievementSystem:InitAchievement(openTagType)
  self:GenSubPageTogs()
  self:m_HandaySelectSubpage(openTagType)
  self:InitRedDotEvent()
  self.achievementLevelNode:RefreshPlayerLevel(false)
  local cur = PlayerDataCenter.achivLevelData:GetPickedAchNum()
  local total = PlayerDataCenter.achivLevelData:GetTotalAchNum()
  self.achievementLevelNode:RefreshAchFinishedNum(cur, total)
  NoticeManager:DeleteNoticeByType(NoticeManager.eNoticeType.AchievementAchieved)
end

function UIAchievementSystem:GenSubPageTogs()
  local openPageCallback = BindCallback(self, self.ShowSubPage)
  self.typeTogPool:HideAll()
  for _, achieveTypeCfg in ipairs(ConfigData.achievement) do
    local toggle = self.typeTogPool:GetOne()
    toggle:InitAchieveTog(achieveTypeCfg, openPageCallback)
  end
end

function UIAchievementSystem:m_HandaySelectSubpage(achievementType)
  achievementType = achievementType or defaultTogType
  for _, toggle in pairs(self.typeTogPool.listItem) do
    if toggle.type == achievementType then
      toggle:SetSelected(true)
      break
    end
  end
end

function UIAchievementSystem:InitRedDotEvent()
  for _, item in ipairs(self.typeTogPool.listItem) do
    local ok, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.AchivLevel, RedDotStaticTypeId.AchivLevelPage, item.task_type)
    item:SetRedDot(ok and node:GetRedDotCount() > 0)
  end
  
  function self.__onAchievTogRedDotEvent(node)
    local taskType = node.nodeId
    for _, item in ipairs(self.typeTogPool.listItem) do
      if item.task_type == taskType then
        item:SetRedDot(node:GetRedDotCount() > 0)
        break
      end
    end
  end
  
  RedDotController:AddListener(RedDotDynPath.AchivTaskPagePath, self.__onAchievTogRedDotEvent)
end

function UIAchievementSystem:OnClickReceiveAll()
  local taskctl = ControllerManager:GetController(ControllerTypeId.Task, true)
  taskctl:SendOneKeyPick(self.ids, BindCallback(self, self.ChangeBtnReceiveAll))
end

function UIAchievementSystem:RemoveRedDotEvent()
  RedDotController:RemoveListener(RedDotDynPath.AchivTaskPagePath, self.__onAchievTogRedDotEvent)
end

function UIAchievementSystem:ShowSubPage(achievementType)
  self.currAchievementType = achievementType
  local taskTypeId = ConfigData.achievement[achievementType].task_type
  local achivDatas = PlayerDataCenter.allTaskData.achievementDatas[taskTypeId]
  local pickedAchivs = PlayerDataCenter.achivLevelData.pickedRewardAchivs[taskTypeId]
  if achivDatas == nil then
    error("Can't find achivDatas, taskTypeId=" .. tostring(taskTypeId))
    return
  end
  self.achieveDataList = {}
  for _, data in pairs(achivDatas) do
    local state = TaskEnum.eTaskState.InProgress
    if data:CheckComplete() then
      state = TaskEnum.eTaskState.Completed
    end
    table.insert(self.achieveDataList, {
      taskData = data,
      state = state,
      stcData = data.stcData
    })
  end
  for _, pickedAchivData in pairs(pickedAchivs) do
    table.insert(self.achieveDataList, {
      taskData = nil,
      state = TaskEnum.eTaskState.Picked,
      stcData = ConfigData.task[pickedAchivData.taskId],
      completedTimestamp = pickedAchivData.completedTimestamp
    })
  end
  table.sort(self.achieveDataList, function(a, b)
    if a.state == b.state then
      return a.stcData.id < b.stcData.id
    elseif a.state == TaskEnum.eTaskState.Completed then
      return true
    elseif b.state == TaskEnum.eTaskState.Completed then
      return false
    elseif a.state == TaskEnum.eTaskState.InProgress then
      return true
    elseif b.state == TaskEnum.eTaskState.InProgress then
      return false
    end
  end)
  self:ChangeBtnReceiveAll()
  self.ui.loopList_achieveListNode.totalCount = #self.achieveDataList
  self.ui.loopList_achieveListNode:RefillCells()
end

function UIAchievementSystem:ChangeBtnReceiveAll()
  self.ids = {}
  local curPageTaskType = ConfigData.achievement[self.currAchievementType].task_type
  local isThisTypeHasTask = false
  for type, taskDataDic in pairs(PlayerDataCenter.allTaskData.achievementDatas) do
    for taskId, taskData in pairs(taskDataDic) do
      if taskData:CheckComplete() then
        self.ids[taskId] = true
        if type == curPageTaskType then
          isThisTypeHasTask = true
        end
      end
    end
  end
  if table.count(self.ids) > 0 and isThisTypeHasTask then
    self.ui.btn_ReceiveAll.gameObject:SetActive(true)
    local size = self.ui.btn_ReceiveAll.gameObject.transform.sizeDelta
    self.ui.loopList_achieveListNode.gameObject.transform.offsetMin = Vector2.New(self.offsetMin.x, self.offsetMin.y + size.y)
  else
    self.ui.btn_ReceiveAll.gameObject:SetActive(false)
    self.ui.loopList_achieveListNode.gameObject.transform.offsetMin = Vector2.New(self.offsetMin.x, self.offsetMin.y)
  end
end

function UIAchievementSystem:m_OnNewItem(go)
  local achieveItem = UINAchievementItem.New()
  achieveItem:Init(go)
  achieveItem:InitAchieveItem(self.resloader, self._GetReward, self._JumpToTarget)
  self.achieveItemDic[go] = achieveItem
end

function UIAchievementSystem:m_OnChangeItem(go, index)
  local achieveItem = self.achieveItemDic[go]
  if achieveItem == nil then
    error("Can't find achieveItem by gameObject")
    return
  end
  local achieveData = self.achieveDataList[index + 1]
  if achieveData == nil then
    error("Can't find achieveData by index, index = " .. tonumber(index))
  end
  achieveItem:RefreshAchieveItem(achieveData)
end

function UIAchievementSystem:m_GetItemGoByIndex(index)
  local go = self.ui.loopList_achieveListNode:GetCellByIndex(index)
  if go ~= nil then
    return self.achieveItemDic[go]
  end
  return nil
end

function UIAchievementSystem:m_GetItemByTaskId(taskId)
  for i, achieveData in ipairs(self.achieveDataList) do
    if achieveData.stcData.id == taskId then
      local index = i - 1
      return self:m_GetItemGoByIndex(index), i
    end
  end
end

function UIAchievementSystem:GetReward(achieveData)
  if achieveData.state == TaskEnum.eTaskState.Completed then
    self._heroIdSnapShoot = PlayerDataCenter:GetHeroIdSnapShoot()
    self.taskNetworkCtrl:SendCommitQuest(achieveData.taskData)
  elseif achieveData.state == TaskEnum.eTaskState.Picked then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(TipContent.achievement_taskCompleted))
  else
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(TipContent.achievement_taskNotComplete))
  end
end

function UIAchievementSystem:JumpToTarget(taskCfg)
  local jumpId = taskCfg.jump_id
  local jumpArgs = taskCfg.jumpArgs
  if jumpId ~= nil and jumpId ~= 0 then
    JumpManager:Jump(jumpId, function(jumpCallback)
      if jumpCallback ~= nil then
        jumpCallback()
      end
    end, nil, jumpArgs)
  end
end

function UIAchievementSystem:OnTaskUpdate(taskData)
  if taskData.stcData.type ~= ConfigData.achievement[self.currAchievementType].task_type then
    return
  end
  local achieveItem, index = self:m_GetItemByTaskId(taskData.stcData.id)
  if index ~= nil then
    local achieveData = self.achieveDataList[index]
    local state = TaskEnum.eTaskState.InProgress
    if taskData:CheckComplete() then
      state = TaskEnum.eTaskState.Completed
    end
    achieveData.taskData = taskData
    achieveData.state = state
    if achieveItem ~= nil then
      achieveItem:RefreshUI()
    end
  end
  self:ChangeBtnReceiveAll()
end

function UIAchievementSystem:OnTaskDelete(id)
  local _, index = self:m_GetItemByTaskId(id)
  if index ~= nil then
    table.remove(self.achieveDataList, index)
    self.ui.loopList_achieveListNode.totalCount = #self.achieveDataList
    self.ui.loopList_achieveListNode:RefillCells()
  end
end

function UIAchievementSystem:OnTaskCommit(taskStcData)
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
    if window == nil then
      return
    end
    local CRData = CommonRewardData.CreateCRDataUseList(taskStcData.rewardIds, taskStcData.rewardNums):SetCRHeroSnapshoot(self._heroIdSnapShoot):SetCRShowOverFunc(self.achievementLevelNode.__NeedRefreshPlayerLevel)
    window:AddAndTryShowReward(CRData)
  end)
end

function UIAchievementSystem:OnTaskPicked()
  self:ShowSubPage(self.currAchievementType)
  local cur = PlayerDataCenter.achivLevelData:GetPickedAchNum()
  local total = PlayerDataCenter.achivLevelData:GetTotalAchNum()
  self.achievementLevelNode:RefreshAchFinishedNum(cur, total)
end

function UIAchievementSystem:OpenAchievementInfo()
end

function UIAchievementSystem:SetOnAchievementSystemCloseCallback(action)
  self._onCloseCallback = action
end

function UIAchievementSystem:OnReturnClick()
  self:OnCloseWin()
  if self._onCloseCallback ~= nil then
    self._onCloseCallback()
  end
  self:Delete()
end

function UIAchievementSystem:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.TaskUpdate, self.__OnTaskUpdate)
  MsgCenter:RemoveListener(eMsgEventId.TaskDelete, self.__OnTaskDelete)
  MsgCenter:RemoveListener(eMsgEventId.TaskCommitComplete, self.__OnTaskCommit)
  MsgCenter:RemoveListener(eMsgEventId.UpdatePickedAchivTask, self.__onTaskPicked)
  self:RemoveRedDotEvent()
  DestroyUnityObject(self.ui.loopList_achieveListNode)
  self.achievementLevelNode:Delete()
  if self.achieveItemDic ~= nil then
    for go, achieveItem in pairs(self.achieveItemDic) do
      achieveItem:Delete()
    end
  end
  base.OnDelete(self)
end

function UIAchievementSystem:OnDeleteEntity()
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  base.OnDeleteEntity(self)
end

return UIAchievementSystem
