local UINShortTheatreTaskItem = class("UINSignInMiniGameDayItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")
local JumpManager = require("Game.Jump.JumpManager")

function UINShortTheatreTaskItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_recived, self, self.OnClickBtnRecived)
  UIUtil.AddButtonListener(self.ui.btn_goto, self, self.OnClickBtnGoTo)
  self.ui.obj_item:SetActive(false)
  self.rewardItemPool = UIItemPool.New(UINBaseItemWithReceived, self.ui.obj_item)
end

function UINShortTheatreTaskItem:InitTaskItem(taskId, stageId, isCurStageTask, nextRefreshTime, isComplete, revivedCallback)
  self.taskId = taskId
  self.revivedCallback = revivedCallback
  self.rewardItemPool:HideAll()
  local taskCfg = ConfigData.task[taskId]
  if 0 < nextRefreshTime then
    self.ui.obj_notComplete:SetActive(false)
    self.ui.obj_recived:SetActive(false)
    self.ui.img_bottom:SetIndex(1)
    self.ui.text_time.gameObject:SetActive(true)
    self.ui.obj_progress:SetActive(false)
    self.leftTime = math.floor(nextRefreshTime)
    self.ui.text_time.text = TimeUtil:TimestampToTime(self.leftTime, false, true, true)
    self.ui.text_des.text = ConfigData:GetTipContent(9703)
    self.ui.text_day:SetIndex(0, tostring(stageId))
  elseif isCurStageTask then
    self.ui.img_bottom:SetIndex(0)
    self.ui.text_time.gameObject:SetActive(false)
    self.ui.obj_progress:SetActive(true)
    self.ui.text_day:SetIndex(0, tostring(stageId))
    local isCanGetReward = false
    local taskData = PlayerDataCenter.allTaskData.taskDatas[taskId]
    if taskData ~= nil then
      isCanGetReward = taskData:CheckComplete()
      self.ui.tex_progress.text = tostring(taskData.schedule) .. "/" .. tostring(taskData.aim)
      self.ui.line_progress.value = taskData.schedule / taskData.aim
    end
    if taskCfg ~= nil then
      self.ui.text_des.text = LanguageUtil.GetLocaleText(taskCfg.task_intro)
      for index, id in ipairs(taskCfg.rewardIds) do
        local itemCfg = ConfigData.item[id]
        local num = taskCfg.rewardNums[index]
        local ItemWithCount = self.rewardItemPool:GetOne()
        ItemWithCount:InitItemWithCount(itemCfg, num, nil, nil)
      end
    end
    self.ui.obj_notComplete:SetActive(not isCanGetReward)
    self.ui.obj_recived:SetActive(isCanGetReward)
  else
    self.ui.obj_notComplete:SetActive(false)
    self.ui.obj_recived:SetActive(false)
    self.ui.img_bottom:SetIndex(1)
    self.ui.text_time.gameObject:SetActive(false)
    self.ui.obj_progress:SetActive(false)
    if not isComplete then
      self.ui.text_des.text = ConfigData:GetTipContent(9705)
    else
      self.ui.text_des.text = ConfigData:GetTipContent(9704)
    end
    self.ui.text_day:SetIndex(0, tostring(stageId))
  end
end

function UINShortTheatreTaskItem:RefreshLeftTime(deltTime)
  if self.leftTime ~= nil then
    self.leftTime = self.leftTime - deltTime
    self.ui.text_time.text = TimeUtil:TimestampToTime(self.leftTime, false, true, true)
  end
end

function UINShortTheatreTaskItem:OnClickBtnRecived()
  local taskData = PlayerDataCenter.allTaskData.taskDatas[self.taskId]
  if taskData == nil then
    return
  end
  if self.revivedCallback ~= nil then
    self.revivedCallback(taskData)
  end
end

function UINShortTheatreTaskItem:OnClickBtnGoTo()
  local taskCfg
  local taskData = PlayerDataCenter.allTaskData.taskDatas[self.taskId]
  if taskData ~= nil then
    taskCfg = taskData.stcData
  end
  if taskCfg ~= nil then
    local jumpId = taskCfg.jump_id
    local jumpArgs = taskCfg.jumpArgs
    if jumpId ~= nil and 0 < jumpId then
      JumpManager:Jump(jumpId, nil, nil, jumpArgs)
    end
  end
end

function UINShortTheatreTaskItem:OnDelete()
  self.rewardItemPool:DeleteAll()
  base.OnDelete(self)
end

return UINShortTheatreTaskItem
