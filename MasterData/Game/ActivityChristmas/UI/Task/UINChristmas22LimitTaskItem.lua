local UINChristmas22LimitTaskItem = class("UINChristmas22LimitTaskItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")

function UINChristmas22LimitTaskItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_GetReward, self, self.ClickConfirm)
  UIUtil.AddButtonListener(self.ui.btn_Refresh, self, self.ClickRefresh)
  self._itemPool = UIItemPool.New(UINBaseItemWithReceived, self.ui.uINBaseItemWithReceived)
  self.ui.uINBaseItemWithReceived:SetActive(false)
end

function UINChristmas22LimitTaskItem:InitChristmas22LimitTaskItem(taskData, callback, refCallback)
  self._taskData = taskData
  self._callback = callback
  self._refCallback = refCallback
  self.ui.tex_TaskDes.text = self._taskData:GetTaskFirstStepIntro()
  self._itemPool:HideAll()
  local itemids, itemnums = self._taskData:GetTaskCfgRewards()
  for i, itemId in ipairs(itemids) do
    local itemNum = itemnums[i]
    local itemCfg = ConfigData.item[itemId]
    local item = self._itemPool:GetOne()
    item:InitItemWithCount(itemCfg, itemNum)
  end
  self:RefreshChristmas22LimitTaskItem()
  self:PlayChristmas22LimitTaskItemAnim()
end

function UINChristmas22LimitTaskItem:SetChristmas22LimitTaskRef(flag)
  self.ui.btn_Refresh.gameObject:SetActive(flag and not self._taskData:CheckComplete())
end

function UINChristmas22LimitTaskItem:RefreshChristmas22LimitTaskItem()
  local schedule, aim = self._taskData:GetTaskProcess()
  self.ui.fill.fillAmount = schedule / aim
  self.ui.tex_Progress:SetIndex(0, tostring(schedule), tostring(aim))
  local isComplete = self._taskData:CheckComplete()
  self.ui.img_GetReward.gameObject:SetActive(isComplete)
  self.ui.img_GetReward:SetIndex(0)
  self.ui.tex_GetReward.gameObject:SetActive(isComplete)
  self.ui.tex_GetReward:SetIndex(0)
end

function UINChristmas22LimitTaskItem:ClickRefresh()
  if self._refCallback ~= nil then
    self._refCallback(self, self._taskData)
  end
end

function UINChristmas22LimitTaskItem:ClickConfirm()
  if self._callback ~= nil then
    self._callback(self._taskData)
  end
end

function UINChristmas22LimitTaskItem:PlayChristmas22LimitTaskItemAnim()
  if IsNull(self.ui.animNode) then
    return
  end
  self:__StopAnim()
  self.ui.animNode:DOFade(0, 0.35):From():SetDelay(0.15):SetLink(self.gameObject)
  self.ui.animNode.gameObject.transform:DOLocalMoveX(-15, 0.35):From():SetDelay(0.15):SetLink(self.gameObject)
end

function UINChristmas22LimitTaskItem:__StopAnim()
  if IsNull(self.ui.animNode) then
    return
  end
  self.ui.animNode:DOComplete()
  self.ui.animNode.gameObject.transform:DOComplete()
end

function UINChristmas22LimitTaskItem:OnDelete()
  self:__StopAnim()
end

return UINChristmas22LimitTaskItem
