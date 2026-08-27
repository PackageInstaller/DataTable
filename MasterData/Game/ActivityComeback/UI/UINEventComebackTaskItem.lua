local UINEventComebackTaskItem = class("UINEventComebackTaskItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")
local TaskEnum = require("Game.Task.TaskEnum")
local JumpManager = require("Game.Jump.JumpManager")

function UINEventComebackTaskItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Received, self, self.__OnClickReceive)
  UIUtil.AddButtonListener(self.ui.btn_Jump, self, self.__OnClickJump)
  self._itemPool = UIItemPool.New(UINBaseItemWithReceived, self.ui.uINBaseItemWithReceived)
  self.ui.uINBaseItemWithReceived:SetActive(false)
end

function UINEventComebackTaskItem:InitCombackTaskItem(taskData, callback)
  self._taskId = taskData.id
  self._taskData = taskData
  self._callback = callback
  local stepCfg = self._taskData:GetStepCfg()
  self.ui.tex_Des.text = self._taskData:GetTaskFirstStepIntro()
  local itemIds, itemCounts = self._taskData:GetTaskCfgRewards()
  self._itemPool:HideAll()
  for i, itemId in ipairs(itemIds) do
    local itemCfg = ConfigData.item[itemId]
    if itemCfg.type ~= eItemType.BattlePassPoint then
      local itemCount = itemCounts[i]
      local item = self._itemPool:GetOne()
      item:InitItemWithCount(itemCfg, itemCount)
    end
  end
  self:__Refresh()
end

function UINEventComebackTaskItem:RefreshCombackTaskItem()
  self._taskData = PlayerDataCenter.allTaskData:GetTaskDataById(self._taskId, true)
  self:__Refresh()
end

function UINEventComebackTaskItem:__Refresh()
  local schedule, aim = self._taskData:GetTaskProcess()
  self.ui.slider.value = schedule / aim
  self.ui.tex_Progress.text = tostring(schedule) .. "/" .. tostring(aim)
  if self._taskData.state == TaskEnum.eTaskState.Picked then
    self.ui.obj_Completed:SetActive(true)
    self.ui.btn_Received.gameObject:SetActive(false)
    self.ui.btn_Jump.gameObject:SetActive(false)
    for i, rewardItem in ipairs(self._itemPool.listItem) do
      rewardItem:SetPickedUIActive(true)
    end
    return
  end
  for i, rewardItem in ipairs(self._itemPool.listItem) do
    rewardItem:SetPickedUIActive(false)
  end
  self.ui.obj_Completed:SetActive(false)
  local canReceive = self._taskData:CheckComplete()
  if canReceive then
    self.ui.btn_Received.gameObject:SetActive(true)
    self.ui.btn_Jump.gameObject:SetActive(false)
    return
  end
  self.ui.btn_Received.gameObject:SetActive(false)
  local canJump = 0 < (self._taskData.stcData.jump_id or 0)
  self.ui.btn_Jump.gameObject:SetActive(canJump)
end

function UINEventComebackTaskItem:__OnClickJump()
  local jumpId = self._taskData.stcData.jump_id or 0
  if 0 < jumpId then
    local args = self._taskData.stcData.jumpArgs
    JumpManager:Jump(jumpId, nil, nil, args)
  end
end

function UINEventComebackTaskItem:__OnClickReceive()
  if self._callback then
    self._callback(self._taskData)
  end
end

function UINEventComebackTaskItem:GetComebackTaskDataItem()
  return self._taskData
end

return UINEventComebackTaskItem
