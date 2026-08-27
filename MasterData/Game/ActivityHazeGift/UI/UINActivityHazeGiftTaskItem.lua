local UINActivityHazeGiftTaskItem = class("UINActivityHazeGiftTaskItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")

function UINActivityHazeGiftTaskItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Get, self, self.OnClickReceive)
  if self.ui.btn_Goto ~= nil then
    UIUtil.AddButtonListener(self.ui.btn_Goto, self, self.OnClickJump)
  end
  self._itemPool = UIItemPool.New(UINBaseItemWithReceived, self.ui.rewardItem)
  self.ui.rewardItem:SetActive(false)
end

function UINActivityHazeGiftTaskItem:InitHazeGiftTaskItem(taskData, getCallback, gotoCallback)
  self._getCallback = getCallback
  self._gotoCallback = gotoCallback
  self._taskData = taskData
  self._itemPool:HideAll()
  local itemIds, itemNums = self._taskData:GetTaskCfgRewards()
  for i, itemId in ipairs(itemIds) do
    local item = self._itemPool:GetOne()
    local num = itemNums[i]
    local itemCfg = ConfigData.item[itemId]
    item:InitItemWithCount(itemCfg, num)
  end
  self.ui.tex_TaskDes.text = self._taskData:GetTaskFirstStepIntro()
  self:RefreshHazeGiftTaskItem()
end

function UINActivityHazeGiftTaskItem:RefreshHazeGiftTaskItem()
  local schedule, aim = self._taskData:GetTaskProcess()
  self.ui.tex_Progress:SetIndex(0, tostring(schedule), tostring(aim))
  self.ui.processSlider.value = schedule / aim
  if self._taskData.isPicked then
    for i, v in ipairs(self._itemPool.listItem) do
      v:SetPickedUIActive(true)
    end
    self.ui.btn_Get.gameObject:SetActive(false)
    self.ui.btn_Received.gameObject:SetActive(true)
    self.ui.btn_UnClear.gameObject:SetActive(false)
    if self.ui.btn_Goto then
      self.ui.btn_Goto.gameObject:SetActive(false)
    end
    return
  end
  if self._taskData:CheckComplete() then
    self.ui.btn_Get.gameObject:SetActive(true)
    self.ui.btn_Received.gameObject:SetActive(false)
    self.ui.btn_UnClear.gameObject:SetActive(false)
    if self.ui.btn_Goto then
      self.ui.btn_Goto.gameObject:SetActive(false)
    end
    return
  end
  self.ui.btn_Get.gameObject:SetActive(false)
  self.ui.btn_Received.gameObject:SetActive(false)
  if self.ui.btn_Goto then
    local canJump = 0 < (self._taskData.stcData.jump_id or 0)
    self.ui.btn_Goto.gameObject:SetActive(canJump)
    self.ui.btn_UnClear.gameObject:SetActive(not canJump)
  else
    self.ui.btn_UnClear.gameObject:SetActive(true)
  end
end

function UINActivityHazeGiftTaskItem:GetEnvTaskId()
  return self._taskData.id
end

function UINActivityHazeGiftTaskItem:OnClickReceive()
  if self._getCallback ~= nil then
    self._getCallback(self._taskData)
  end
end

function UINActivityHazeGiftTaskItem:OnClickJump()
  if self._gotoCallback ~= nil then
    self._gotoCallback(self._taskData)
  end
end

function UINActivityHazeGiftTaskItem:OnDelete()
  base.OnDelete(self)
end

return UINActivityHazeGiftTaskItem
