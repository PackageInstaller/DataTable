local UINChristmas22ActTaskItem = class("UINChristmas22ActTaskItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")

function UINChristmas22ActTaskItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_ItemClick, self, self.OnClickConfirm)
  self._itemPool = UIItemPool.New(UINBaseItemWithReceived, self.ui.rewardItem)
  self.ui.rewardItem:SetActive(false)
end

function UINChristmas22ActTaskItem:InitChristmas22ActTaskItem(taskData, callback, index)
  self._taskData = taskData
  self._callback = callback
  self.index = index
  self.ui.tex_TaskDes.text = self._taskData:GetTaskFirstStepIntro()
  self._itemPool:HideAll()
  local itemids, itemnums = self._taskData:GetTaskCfgRewards()
  for i, itemId in ipairs(itemids) do
    local itemNum = itemnums[i]
    local itemCfg = ConfigData.item[itemId]
    local item = self._itemPool:GetOne()
    item:InitItemWithCount(itemCfg, itemNum)
  end
  self:RefreshChristmas22ActTaskItem()
end

function UINChristmas22ActTaskItem:RefreshChristmas22ActTaskItem()
  self:__RefreshFill()
  for i, v in ipairs(self._itemPool.listItem) do
    v:SetPickedUIActive(self._taskData.isPicked)
  end
  if self._taskData.isPicked then
    self:__RefreshPickConfirmBtn()
  else
    self:__RefreshConfirmBtn()
  end
end

function UINChristmas22ActTaskItem:__RefreshFill()
  local schedule, aim = self._taskData:GetTaskProcess()
  self.ui.fill.fillAmount = schedule / aim
  self.ui.tex_Progress:SetIndex(0, tostring(schedule), tostring(aim))
end

function UINChristmas22ActTaskItem:__RefreshPickConfirmBtn()
  self.ui.isOver:SetActive(true)
  self.ui.state:SetActive(false)
end

function UINChristmas22ActTaskItem:__RefreshConfirmBtn()
  self.ui.isOver:SetActive(false)
  self.ui.state:SetActive(true)
  local isComplete = self._taskData:CheckComplete()
  self.ui.img_state.gameObject:SetActive(isComplete)
  self.ui.tex_State:SetIndex(isComplete and 0 or 1)
end

function UINChristmas22ActTaskItem:OnClickConfirm()
  if self._callback ~= nil then
    self._callback(self._taskData)
  end
end

function UINChristmas22ActTaskItem:GetChristmasActTaskId()
  return self._taskData.id
end

function UINChristmas22ActTaskItem:PlayChristmasActTaskAnim()
  if IsNull(self.ui.animNode) then
    return
  end
  self:__StopAnim()
  local delayTime = self.index * 0.05 + 0.05
  self.ui.animNode:DOFade(0, 0.25):From():SetDelay(delayTime):SetLink(self.gameObject)
  self.ui.animNode.gameObject.transform:DOLocalMoveX(-15, 0.25):From():SetDelay(delayTime):SetLink(self.gameObject)
end

function UINChristmas22ActTaskItem:__StopAnim()
  if IsNull(self.ui.animNode) then
    return
  end
  self.ui.animNode:DOComplete()
  self.ui.animNode.gameObject.transform:DOComplete()
end

function UINChristmas22ActTaskItem:OnDelete()
  self:__StopAnim()
end

return UINChristmas22ActTaskItem
