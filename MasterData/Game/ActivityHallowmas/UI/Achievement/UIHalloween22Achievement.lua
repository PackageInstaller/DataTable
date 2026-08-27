local UIHalloween22Achievement = class("UIHalloween22Achievement", UIBaseWindow)
local base = UIBaseWindow
local UINHalloweenAchievementStar = require("Game.ActivityHallowmas.UI.Achievement.UINHalloweenAchievementStar")
local UINHalloweenAchievementItem = require("Game.ActivityHallowmas.UI.Achievement.UINHalloweenAchievementItem")

function UIHalloween22Achievement:OnInit()
  UIUtil.SetTopStatus(self, self.OnCloseAchievement, nil, nil, nil, true)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.OnClickCloseBtn)
  self._starNumPool = UIItemPool.New(UINHalloweenAchievementStar, self.ui.item_star)
  self.ui.item_star:SetActive(false)
  self.ui.main.onInstantiateItem = BindCallback(self, self.__OnInstantiateItem)
  self.ui.main.onChangeItem = BindCallback(self, self.__OnChangeItem)
  self._gameobjectDic = {}
  self.__PickedTaskCallback = BindCallback(self, self.__PickedTask)
  self.__OnTaskChangeCallback = BindCallback(self, self.__OnTaskChange)
  MsgCenter:AddListener(eMsgEventId.TaskUpdate, self.__OnTaskChangeCallback)
end

function UIHalloween22Achievement:InitHalloween22Achievement(hallowmasData, callback)
  self._data = hallowmasData
  self._callback = callback
  self._achievementCfg = self._data:GetHallowmasAchievementCfg()
  self._starMax = ConfigData.activity_hallowmas_achievement.starMax[self._data:GetActId()]
  self:__Refresh()
end

function UIHalloween22Achievement:__Refresh()
  self:__FindShowTaskDatas()
  table.sort(self._taskDataList, function(a, b)
    local aComplete = a:CheckComplete()
    local bComplete = b:CheckComplete()
    if aComplete ~= bComplete then
      return aComplete
    end
    local aIsPicked = a.isPicked or false
    local bIsPicked = b.isPicked or false
    if aIsPicked ~= bIsPicked then
      return not aIsPicked
    end
    if a.stcData.order ~= b.stcData.order then
      return a.stcData.order < b.stcData.order
    end
    return a.id < b.id
  end)
  self._starNumPool:HideAll()
  for i = self._starMax, 1, -1 do
    local star = self._starNumPool:GetOne()
    star:InitStarNum(i, self._taskStarNumDic[i] or 0)
  end
  local count = #self._taskDataList
  self.ui.tex_Num:SetIndex(0, tostring(self._finishCount), tostring(self._showAllCount))
  self.ui.main.totalCount = count
  self.ui.main:RefillCells()
end

function UIHalloween22Achievement:__FindShowTaskDatas()
  if self._taskDataList == nil then
    self._taskDataList = {}
    self._taskStarNumDic = {}
    self._tempFixShowCount = 0
    self._tempTaskInitList = {}
    for taskId, achievementCfg in pairs(self._achievementCfg) do
      local taskCfg = ConfigData.task[taskId]
      if taskCfg ~= nil and (taskCfg.show_pre or 0) == 0 then
        table.insert(self._tempTaskInitList, taskId)
      end
      if not achievementCfg.achievement_hide then
        self._tempFixShowCount = self._tempFixShowCount + 1
      end
    end
  else
    table.removeall(self._taskDataList)
    table.clearmap(self._taskStarNumDic)
  end
  self._showAllCount = self._tempFixShowCount
  self._finishCount = 0
  local Local_TryAddListFunc
  
  function Local_TryAddListFunc(taskId)
    local taskData = PlayerDataCenter.allTaskData:GetTaskDataById(taskId, true)
    local achievementCfg = self._achievementCfg[taskId]
    if achievementCfg == nil then
      error(" hallowmas achievementCfg is nil  " .. tostring(taskId))
      return
    end
    if achievementCfg.achievement_hide then
      if taskData.isPicked or taskData:CheckComplete() then
        table.insert(self._taskDataList, taskData)
        self._showAllCount = self._showAllCount + 1
      end
    else
      table.insert(self._taskDataList, taskData)
    end
    if taskData.isPicked then
      local star = achievementCfg.achievement_stars
      local count = self._taskStarNumDic[star] or 0
      self._taskStarNumDic[star] = count + 1
      self._finishCount = self._finishCount + 1
      for i, nextTaskid in ipairs(taskData.stcData.show_next) do
        Local_TryAddListFunc(nextTaskid)
      end
    end
  end
  
  for i, v in ipairs(self._tempTaskInitList) do
    Local_TryAddListFunc(v)
  end
end

function UIHalloween22Achievement:__OnInstantiateItem(go)
  self._gameobjectDic[go] = UINHalloweenAchievementItem.New()
  self._gameobjectDic[go]:Init(go)
end

function UIHalloween22Achievement:__OnChangeItem(go, index)
  local taskData = self._taskDataList[index + 1]
  local item = self._gameobjectDic[go]
  local star = self._achievementCfg[taskData.id].achievement_stars
  item:InitAchieventItem(taskData, star, self.__PickedTaskCallback)
end

function UIHalloween22Achievement:__PickedTask(taskData)
  if not taskData:CheckComplete() then
    return
  end
  self._data:ReqHallowmasCommitTask(taskData.id, function()
    self:__Refresh()
  end)
end

function UIHalloween22Achievement:__OnTaskChange(taskData)
  if self._achievementCfg[taskData.id] == nil then
    return
  end
  if taskData:CheckComplete() then
    self:__Refresh()
    return
  end
  for k, v in pairs(self._gameobjectDic) do
    if v:GetHallowAchieveTask() == taskData then
      v:RefreshTaskUI()
      return
    end
  end
end

function UIHalloween22Achievement:OnClickCloseBtn()
  UIUtil.OnClickBackByUiTab(self)
end

function UIHalloween22Achievement:OnCloseAchievement()
  self:Delete()
  if self._callback ~= nil then
    self._callback()
  end
end

function UIHalloween22Achievement:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.TaskUpdate, self.__OnTaskChangeCallback)
  base.OnDelete(self)
end

return UIHalloween22Achievement
