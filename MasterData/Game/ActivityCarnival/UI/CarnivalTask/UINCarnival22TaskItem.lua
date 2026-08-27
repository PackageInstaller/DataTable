local UINCarnival22TaskItem = class("UINCarnival22TaskItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
local TaskEnum = require("Game.Task.TaskEnum")
local ActivityCarnivalEnum = require("Game.ActivityCarnival.ActivityCarnivalEnum")
local cs_DoTween = CS.DG.Tweening.DOTween
local cs_Ease = CS.DG.Tweening.Ease

function UINCarnival22TaskItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self._itemPool = UIItemPool.New(UINBaseItemWithCount, self.ui.uINBaseItemWithCount)
  self.ui.uINBaseItemWithCount:SetActive(false)
  UIUtil.AddButtonListener(self.ui.btn_ChangeTask, self, self.OnClickChange)
  UIUtil.AddButtonListener(self.ui.btn_GetReward, self, self.OnClickGetReward)
  self._normalBgColor = self.ui.img_ItemBg.color
end

function UINCarnival22TaskItem:BindCarnivalTaskCallback(changeFunc, comleteFunc, jumpFunc)
  self._changeFunc = changeFunc
  self._comleteFunc = comleteFunc
  self._jumpFunc = jumpFunc
end

function UINCarnival22TaskItem:InitCarnivalTaskItem(carnivalData, taskData)
  self._carnivalData = carnivalData
  self._taskData = taskData
  self._taskId = self._taskData.id
  local quality = self._carnivalData:GetCarnivalTaskQuality(self._taskId)
  self.ui.tex_Level:SetIndex(quality - 1)
  self.ui.tex_TaskDescrption.text = self._taskData:GetTaskFirstStepIntro()
  local itemIds, itemCounts = self._taskData:GetTaskCfgRewards()
  self._itemPool:HideAll()
  for i, itemId in ipairs(itemIds) do
    local itemCfg = ConfigData.item[itemId]
    local count = itemCounts[i]
    local item = self._itemPool:GetOne()
    item:InitItemWithCount(itemCfg, count)
  end
  self:UpdateCarnivalTaskProcess()
end

function UINCarnival22TaskItem:ChangeCarnivalTaskItem(taskData)
  self.ui.image.rotation = Quaternion.Euler(0, 0, 0)
  self.ui.image:DOLocalRotateQuaternion(Quaternion.Euler(0, 0, -179), 0.5):SetEase(cs_Ease.InOutQuad)
  self.ui.ani_taskItem:Play("UI_Carnival22TaskItemOut")
  local clip = self.ui.ani_taskItem:GetClip("UI_Carnival22TaskItemOut")
  TimerManager:StartTimer(clip.length, function()
    if not IsNull(self.transform) then
      self:InitCarnivalTaskItem(self._carnivalData, taskData)
      self.ui.ani_taskItem:Play("UI_Carnival22TaskItemIn")
    end
  end, nil, true)
end

function UINCarnival22TaskItem:UpdateCarnivalTaskProcess()
  self._taskData = PlayerDataCenter.allTaskData:GetTaskDataById(self._taskId, true)
  local schedule, aim = self._taskData:GetTaskProcess()
  self.ui.taskSlider.value = schedule / aim
  self.ui.tex_ProgressDes.text = tostring(schedule) .. "/" .. tostring(aim)
  self.ui.btn_GetReward.gameObject:SetActive(true)
  self.ui.obj_Received:SetActive(false)
  self.ui.btn_ChangeTask.gameObject:SetActive(true)
  if self._taskData.state == TaskEnum.eTaskState.Picked then
    self.ui.obj_Received:SetActive(true)
    self.ui.btn_GetReward.gameObject:SetActive(false)
    self.ui.btn_ChangeTask.gameObject:SetActive(false)
    self.ui.img_ItemBg.color = self._normalBgColor
  elseif self._taskData:CheckComplete() then
    self.ui.tex_GetReward:SetIndex(2)
    self.ui.img_ItemBg.color = self.ui.color_s
    self.ui.btn_ChangeTask.gameObject:SetActive(false)
  elseif self._taskData.stcData.jump_id > 0 then
    self.ui.tex_GetReward:SetIndex(0)
    self.ui.img_ItemBg.color = self._normalBgColor
  else
    self.ui.btn_GetReward.gameObject:SetActive(false)
  end
end

function UINCarnival22TaskItem:OnClickChange()
  if self._changeFunc ~= nil then
    self._changeFunc(self._taskId, self)
  end
end

function UINCarnival22TaskItem:OnClickGetReward()
  if self._taskData.state == TaskEnum.eTaskState.Picked then
    return
  elseif self._taskData:CheckComplete() then
    if self._comleteFunc ~= nil then
      self._comleteFunc(self._taskId)
    end
  elseif self._taskData.stcData.jump_id > 0 and self._jumpFunc ~= nil then
    self._jumpFunc(self._taskId)
  end
end

function UINCarnival22TaskItem:GetCarnivalTaskData()
  return self._taskData
end

return UINCarnival22TaskItem
