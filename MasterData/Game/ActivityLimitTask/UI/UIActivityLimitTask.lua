local base = UIBaseWindow
local UIActivityLimitTask = class("UIActivityLimitTask", base)
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local UINActivityStarUpTask = require("Game.ActivityStarUp.UI.UINActivityStarUpTask")
local JumpManager = require("Game.Jump.JumpManager")
local cs_Resloader = CS.ResLoader

function UIActivityLimitTask:OnInit()
  self._resloader = cs_Resloader.Create()
  self.ui.scrollRect.onInstantiateItem = BindCallback(self, self.__OnNewItem)
  self.ui.scrollRect.onChangeItem = BindCallback(self, self.__OnChangeItem)
  UIUtil.AddButtonListener(self.ui.btn_Shop, self, self.OnClickBtnShop)
  self.taskItemDic = {}
end

function UIActivityLimitTask:InitActivityLimitTask(actId)
  local actFrameCtr = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  local activityFrameData = actFrameCtr:GetActivityFrameDataByTypeAndId(ActivityFrameEnum.eActivityType.ActvtLimitTask, actId)
  local actLimitTaskCtrl = ControllerManager:GetController(ControllerTypeId.ActivityTaskLimit)
  if actLimitTaskCtrl == nil then
    error("No actLimitTaskCtrl")
    return
  end
  local actLimiTaskData = actLimitTaskCtrl:GetCurActLimitTaskData()
  if actLimiTaskData:GetActLimitTaskFrameData() ~= activityFrameData then
    error("actLimiTaskData:GetActLimitTaskFrameData() ~= activityFrameData")
    return
  end
  self._actLimiTaskData = actLimiTaskData
  self._activityFrameData = activityFrameData
  local actTaskLimitCfg = actLimiTaskData.actTaskLimitCfg
  self.ui.tex_Title.text = LanguageUtil.GetLocaleText(activityFrameData.name)
  self.ui.btn_Shop.gameObject:SetActive(actTaskLimitCfg.jumpId ~= 0)
  self.ui.tex_BtnShop.text = LanguageUtil.GetLocaleText(actTaskLimitCfg.extra_jump_name)
  local endTs = activityFrameData:GetActivityEndTime()
  local date = TimeUtil:TimestampToDate(endTs)
  self.ui.tex_EndTime.text = string.format("%02d/%02d/%02d %02d:%02d", date.year, date.month, date.day, date.hour, date.min)
  local remainTs = endTs - PlayerDataCenter.timestamp
  local remainDay = math.ceil(remainTs / 60 / 60 / 24)
  self.ui.tex_LastTime:SetIndex(0, tostring(remainDay))
  self.ui.tex_Des.text = LanguageUtil.GetLocaleText(actTaskLimitCfg.description)
  local heroPath = PathConsts:GetActLimitTaskPic(actTaskLimitCfg.img_hero_path)
  self.ui.img_Hero.enabled = false
  self._resloader:LoadABAssetAsync(heroPath, function(texture)
    if IsNull(texture) then
      return
    end
    self.ui.img_Hero.texture = texture
    self.ui.img_Hero.enabled = true
  end)
  if actTaskLimitCfg.theme_color ~= nil and 0 < #actTaskLimitCfg.theme_color then
    local colorCfg = actTaskLimitCfg.theme_color
    if colorCfg[3] == nil then
      error("plz checkout activityTaskLimit colorCfg")
    else
      local color = Color.New(colorCfg[1] / 255, colorCfg[2] / 255, colorCfg[3] / 255, (colorCfg[4] or 255) / 255)
      self.ui.img_bg.color = color
      self.ui.img_mask.color = color
    end
  end
  self:_InitTaskData()
end

function UIActivityLimitTask:_InitTaskData()
  self._taskDataList = self._actLimiTaskData:GetActLimitTaskDataList()
  self:_SortTaskData()
  self.ui.scrollRect.totalCount = #self._taskDataList
  self.ui.scrollRect:RefillCells()
  self:_UpdHeadUI()
end

function UIActivityLimitTask:_SortTaskData()
  table.sort(self._taskDataList, function(a, b)
    if a.state ~= b.state then
      if a:IsPickedTaskReward() then
        return false
      elseif b:IsPickedTaskReward() then
        return true
      end
    end
    local aComplect = a:CheckComplete()
    local bComplect = b:CheckComplete()
    if aComplect ~= bComplect then
      return aComplect
    end
    if a.stcData.order ~= b.stcData.order then
      return a.stcData.order < b.stcData.order
    end
    return a.id < b.id
  end)
end

function UIActivityLimitTask:__OnNewItem(go)
  local item = UINActivityStarUpTask.New()
  item:Init(go)
  item:SetActLimitTaskShowCommonReward()
  self.taskItemDic[go] = item
end

function UIActivityLimitTask:__OnChangeItem(go, index)
  local item = self.taskItemDic[go]
  if item == nil then
    error("Can't find item by gameObject")
    return
  end
  local taskData = self._taskDataList[index + 1]
  item:InitItem(nil, taskData)
  local isNew = self._actLimiTaskData:IsActLimitTaskShowNew(taskData)
  item:UpdActLimitTaskIsNew(isNew)
end

function UIActivityLimitTask:OnUIActLimitTaskUpdate(taskData, isNewTask)
  if not self._actLimiTaskData:IsActLimitTask(taskData.stcData.type) then
    return
  end
  if isNewTask then
    table.insert(self._taskDataList, taskData)
    self.ui.scrollRect.totalCount = #self._taskDataList
  end
  self:_SortTaskData()
  if self._updTimer == nil then
    self._updTimer = TimerManager:StartTimer(1, self._UpdScrollRect, self, true, true)
  end
end

function UIActivityLimitTask:OnUIActLimitTaskRemove(taskId)
  for k, taskData in ipairs(self._taskDataList) do
    if taskData.id == taskId then
      table.remove(self._taskDataList, k)
      break
    end
  end
  self.ui.scrollRect.totalCount = #self._taskDataList
  if self._updTimer == nil then
    self._updTimer = TimerManager:StartTimer(1, self._UpdScrollRect, self, true, true)
  end
end

function UIActivityLimitTask:_UpdScrollRect()
  self:_UpdHeadUI()
  self.ui.scrollRect:RefreshCells()
  self._updTimer = nil
end

function UIActivityLimitTask:_UpdHeadUI()
  local compolectCount = 0
  local hasNew = false
  local newTaskDic
  for k, taskData in ipairs(self._taskDataList) do
    if self._actLimiTaskData:IsActLimitTaskShowNew(taskData) then
      hasNew = true
      newTaskDic = newTaskDic or {}
      newTaskDic[taskData.id] = taskData
    end
    if taskData:IsPickedTaskReward() then
      compolectCount = compolectCount + 1
    end
  end
  self:_UpdNewTaskRead()
  self._lastNewTaskDic = newTaskDic
  self.ui.obj_New:SetActive(hasNew)
  self.ui.obj_Head:SetActive(not hasNew)
  self.ui.tex_TaskNum:SetIndex(0, tostring(compolectCount), tostring(#self._taskDataList))
end

function UIActivityLimitTask:_UpdNewTaskRead()
  if self._lastNewTaskDic ~= nil then
    local ctrl = ControllerManager:GetController(ControllerTypeId.ActivityTaskLimit)
    if ctrl ~= nil then
      ctrl:UpdActLimitTaskRedDot()
    end
  end
end

function UIActivityLimitTask:OnClickBtnShop()
  local cfg = self._actLimiTaskData.actTaskLimitCfg
  JumpManager:Jump(cfg.jumpId, nil, nil, cfg.jumpArgs)
end

function UIActivityLimitTask:OnDelete()
  if self._resloader ~= nil then
    self._resloader:Put2Pool()
    self._resloader = nil
  end
  TimerManager:StopTimer(self._updTimer)
  if self._lastNewTaskDic ~= nil then
    for k, taskData in pairs(self._lastNewTaskDic) do
      local userData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
      userData:SetActLimitNewTaskReddot(taskData.id)
    end
  end
  self:_UpdNewTaskRead()
  PersistentManager:SaveModelData(PersistentConfig.ePackage.UserData)
  base.OnDelete(self)
end

return UIActivityLimitTask
