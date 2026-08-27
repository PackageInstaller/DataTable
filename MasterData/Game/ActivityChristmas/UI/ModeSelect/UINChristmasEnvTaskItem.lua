local UINChristmasEnvTaskItem = class("UINChristmasEnvTaskItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")

function UINChristmasEnvTaskItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Get, self, self.OnClickReceive)
  UIUtil.AddButtonListener(self.ui.btn_Goto, self, self.OnClickJump)
  self._itemPool = UIItemPool.New(UINBaseItemWithReceived, self.ui.rewardItem)
  self.ui.rewardItem:SetActive(false)
end

function UINChristmasEnvTaskItem:InitChristmasEnvTaskItem(taskData, getCallback, gotoCallback)
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
  self.ui.tex_TaskIntro.text = self._taskData:GetTaskFirstStepIntro()
  self:RefreshChristmasEnvTaskItem()
end

function UINChristmasEnvTaskItem:RefreshChristmasEnvTaskItem()
  local schedule, aim = self._taskData:GetTaskProcess()
  self.ui.tex_Progress.text = tostring(schedule) .. "/" .. tostring(aim)
  self.ui.img_Fill.fillAmount = schedule / aim
  if self._taskData.isPicked then
    for i, v in ipairs(self._itemPool.listItem) do
      v:SetPickedUIActive(true)
    end
    self.ui.img_Buttom:SetIndex(2)
    self.ui.obj_Completed:SetActive(true)
    self.ui.obj_Unfinish:SetActive(false)
    self.ui.btn_Get.gameObject:SetActive(false)
    self.ui.btn_Goto.gameObject:SetActive(false)
    self.ui.tex_TaskIntro.color = self.ui.col_isFinish
    self.ui.tex_Progress.color = self.ui.col_isFinish
    return
  end
  self.ui.tex_TaskIntro.color = Color.black
  self.ui.tex_Progress.color = Color.black
  self.ui.obj_Completed:SetActive(false)
  if self._taskData:CheckComplete() then
    self.ui.img_Buttom:SetIndex(1)
    self.ui.btn_Get.gameObject:SetActive(true)
    self.ui.obj_Unfinish:SetActive(false)
    self.ui.btn_Goto.gameObject:SetActive(false)
    return
  end
  self.ui.btn_Get.gameObject:SetActive(false)
  self.ui.img_Buttom:SetIndex(0)
  local canJump = 0 < (self._taskData.stcData.jump_id or 0)
  self.ui.obj_Unfinish:SetActive(not canJump)
  self.ui.btn_Goto.gameObject:SetActive(canJump)
end

function UINChristmasEnvTaskItem:GetEnvTaskId()
  return self._taskData.id
end

function UINChristmasEnvTaskItem:OnClickReceive()
  if self._getCallback ~= nil then
    self._getCallback(self._taskData)
  end
end

function UINChristmasEnvTaskItem:OnClickJump()
  if self._gotoCallback ~= nil then
    self._gotoCallback(self._taskData)
  end
end

return UINChristmasEnvTaskItem
