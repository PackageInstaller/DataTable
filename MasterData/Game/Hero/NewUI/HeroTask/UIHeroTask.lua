local UIHeroTask = class("UIHeroTask", UIBaseWindow)
local base = UIBaseWindow
local UINHeroTaskItem = require("Game.Hero.NewUI.HeroTask.UINHeroTaskItem")
local TaskData = require("Game.Task.Data.TaskData")
local TaskEnum = require("Game.Task.TaskEnum")
local cs_ResLoader = CS.ResLoader

function UIHeroTask:OnInit()
  self.itemDic = {}
  self.heroTaskDataDic = {}
  self.ui.loop_scroll.onInstantiateItem = BindCallback(self, self.__OnNewItem)
  self.ui.loop_scroll.onChangeItem = BindCallback(self, self.__OnChangeItem)
  UIUtil.AddButtonListenerWithArg(self.ui.btn_background, self, self.__OnClickReturn)
  UIUtil.AddButtonListenerWithArg(self.ui.btn_Close, self, self.__OnClickReturn)
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.BackAction):SetTopStatusVisible(true):PushTopStatusDataToBackStack()
  UIUtil.HideTopStatus()
  self._b__RefreshHeroTask = BindCallback(self, self.__RefreshHeroTask)
  MsgCenter:AddListener(eMsgEventId.OnHeroTaskChange, self._b__RefreshHeroTask)
  self.idxs = {}
  self.offsetMin = self.ui.loop_scroll.gameObject.transform.offsetMin
  UIUtil.AddButtonListener(self.ui.btn_ReceiveAll, self, self.OnClickReceiveAll)
end

function UIHeroTask:InitHeroTask(heroData, resloader, bigImgResloader, closeCallback)
  self.closeCallback = closeCallback
  if heroData == nil then
    error("heroData is nill")
    return
  end
  self.heroData = heroData
  self.heroTaskIds = ConfigData.training_task[self.heroData.dataId]
  self:__RefreshHeroTask()
end

function UIHeroTask:SetHeroTaskName(titleName)
  self.ui.tex_SkillName.text = titleName
end

function UIHeroTask:__RefreshHeroTask()
  local taskNum = #self.heroTaskIds
  local finishedTaskNum = 0
  table.sort(self.heroTaskIds, function(a, b)
    return a.param < b.param
  end)
  for index, task in ipairs(self.heroTaskIds) do
    if task.param <= self.heroData.level then
      finishedTaskNum = finishedTaskNum + 1
      task.isComplect = true
      self.heroTaskDataDic[index] = task
    else
      task.isComplect = false
      self.heroTaskDataDic[index] = task
    end
  end
  self.idxs = {}
  for k, v in pairs(self.heroTaskIds) do
    if v.isComplect and not self.heroData:HasGetQuestReward(v.indx) then
      self.idxs[v.indx] = true
    end
  end
  if 0 < table.count(self.idxs) then
    self.ui.btn_ReceiveAll.gameObject:SetActive(true)
    local size = self.ui.btn_ReceiveAll.gameObject.transform.sizeDelta
    self.ui.loop_scroll.gameObject.transform.offsetMin = Vector2.New(self.offsetMin.x, self.offsetMin.y + size.y)
  else
    self.ui.btn_ReceiveAll.gameObject:SetActive(false)
    self.ui.loop_scroll.gameObject.transform.offsetMin = Vector2.New(self.offsetMin.x, self.offsetMin.y)
  end
  self.ui.tex_taskCount:SetIndex(0, tostring(finishedTaskNum), tostring(taskNum))
  self.ui.loop_scroll.totalCount = taskNum
  self.ui.loop_scroll:RefreshCells()
end

function UIHeroTask:OnClickReceiveAll()
  NetworkManager:GetNetwork(NetworkTypeID.Hero):CS_QUEST_HeroOneKeyPick(self.heroData.dataId, self.idxs, function()
    for k, v in pairs(self.idxs) do
      self.heroData:SetQuestGeted(k)
    end
    self.idxs = {}
    MsgCenter:Broadcast(eMsgEventId.OnHeroTaskChange, self.heroData)
  end)
  return
end

function UIHeroTask:__OnNewItem(go)
  local taskItem = UINHeroTaskItem.New()
  taskItem:Init(go)
  self.itemDic[go] = taskItem
end

function UIHeroTask:__OnChangeItem(go, index)
  local taskItem = self.itemDic[go]
  if taskItem == nil then
    error("Can't find goodItem by gameObject")
    return
  end
  local taskData = self.heroTaskDataDic[index + 1]
  taskItem:InitHeroTaskItem(taskData, self.heroData)
end

function UIHeroTask:BackAction()
  if self.closeCallback ~= nil then
    self.closeCallback()
  end
  self:Delete()
end

function UIHeroTask:__OnClickReturn()
  UIUtil.OnClickBackByUiTab(self)
end

function UIHeroTask:OnHide()
  UIUtil.ReShowTopStatus()
end

function UIHeroTask:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.OnHeroTaskChange, self._b__RefreshHeroTask)
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  if self.bigImgResloader ~= nil then
    self.bigImgResloader:Put2Pool()
    self.bigImgResloader = nil
  end
  base.OnDelete(self)
end

return UIHeroTask
