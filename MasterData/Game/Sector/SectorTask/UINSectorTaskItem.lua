local UINSectorTaskItem = class("UINSectorTaskItem", UIBaseNode)
local base = UIBaseNode
local TaskEnum = require("Game.Task.TaskEnum")

function UINSectorTaskItem:OnInit()
  self.isPicking = false
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.Btn_TaskItem, self, self.__OnTaskItemClick)
  self.originSizeDelta = {
    x = self.ui.rect_Process.sizeDelta.x,
    y = self.ui.rect_Process.sizeDelta.y
  }
end

function UINSectorTaskItem:RefreshSectorTaskItem(taskData, iconIndex, onClickAction)
  self.taskData = taskData
  self.__onClickAction = onClickAction
  self.ui.img_IconItemInfo:SetIndex(iconIndex)
  self:__RefreshTaskItemUI()
  self:__RefreshColor()
end

function UINSectorTaskItem:__RefreshTaskItemUI()
  local stcData = self.taskData.stcData
  local taskStepCfg = ConfigData.taskStep[stcData.id][1]
  if taskStepCfg ~= nil then
    self.ui.tex_Intro.text = self.taskData:GetTaskFirstStepIntro()
  else
    error("can't read taskStepCfg id:" .. tostring(self.taskData.stcData.id))
  end
  if #stcData.rewardIds > 0 then
    local rewardId = stcData.rewardIds[1]
    local rewardNum = stcData.rewardNums[1]
    local itemCfg = ConfigData.item[rewardId]
    self.ui.obj_ResNode:SetActive(true)
    self.ui.tex_Count:SetIndex(0, tostring(rewardNum))
  else
    self.ui.obj_ResNode:SetActive(false)
  end
  self.ui.obj_bar:SetActive(false)
  self.ui.tex_Num.gameObject:SetActive(false)
  self.ui.obj_Completed:SetActive(false)
  self.ui.obj_Picked:SetActive(false)
  local hideProgress = self.taskData.stcData.is_hideProgress
  local cfg = ConfigData.active_level[self.taskData.id]
  if cfg ~= nil and cfg.is_daily == true then
    self.ui.obj_dailyNode:SetActive(true)
    self:RefreshRemainingTime(PlayerDataCenter.timestamp)
    self.isDailyTask = true
  else
    self.ui.obj_dailyNode:SetActive(false)
    self.isDailyTask = false
  end
  if self.taskData:CheckComplete() then
    self.ui.img_State:SetIndex(1)
    self.ui.obj_Completed:SetActive(true)
    if not hideProgress then
      self.ui.obj_bar:SetActive(true)
      local schedule, aim = self.taskData:GetTaskProcess()
      self.ui.rect_Process.sizeDelta = Vector2.New(self.originSizeDelta.x, self.originSizeDelta.y)
    end
  elseif self.taskData.state == TaskEnum.eTaskState.InProgress then
    self.ui.img_State:SetIndex(0)
    if not hideProgress then
      self.ui.obj_bar:SetActive(true)
      self.ui.tex_Num.gameObject:SetActive(true)
      local schedule, aim = self.taskData:GetTaskProcess()
      self.ui.rect_Process.sizeDelta = Vector2.New(schedule / aim * self.originSizeDelta.x, self.originSizeDelta.y)
      self.ui.tex_Num.text = tostring(math.min(schedule, aim)) .. "/" .. tostring(aim)
    end
  else
    self.ui.img_State:SetIndex(2)
    self.ui.obj_Picked:SetActive(true)
  end
end

function UINSectorTaskItem:RefreshRemainingTime(timestamp)
  if not self.isDailyTask then
    return
  end
  local nextTime = TimeUtil:TimestampToDate(math.floor(TimeUtil:TimpApplyLogicOffset(timestamp)))
  nextTime.hour = 0
  nextTime.min = 0
  nextTime.sec = 0
  local nextRefreshTimestamp = TimeUtil:DateToTimestamp(nextTime) + 86400 + 3600 * TimeUtil:GetDayPassTime()
  local remainTimestamp = math.max(math.floor(nextRefreshTimestamp - timestamp), 0)
  local d, h, m, s = TimeUtil:TimestampToTimeInter(remainTimestamp, false, true)
  local hStr = 10 <= h and tostring(h) or "0" .. tostring(h)
  local mStr = 10 <= m and tostring(m) or "0" .. tostring(m)
  local sStr = 10 <= s and tostring(s) or "0" .. tostring(s)
  self.ui.tex_refreshTime:SetIndex(0, hStr, mStr, sStr)
end

function UINSectorTaskItem:__OnTaskItemClick()
  self.__onClickAction(self.taskData)
end

function UINSectorTaskItem:__RefreshColor()
  local color = Color.white
  if self.taskData.state == TaskEnum.eTaskState.Picked then
    color = self.ui.col_picked
  elseif not self.taskData:CheckComplete() then
    color = self.ui.col_inProgress
  end
  self.ui.tex_Intro.color = color
  self.ui.img_Icon.color = color
  self.ui.tex_Count.text.color = color
end

function UINSectorTaskItem:OnDelete()
  base.OnDelete(self)
end

return UINSectorTaskItem
