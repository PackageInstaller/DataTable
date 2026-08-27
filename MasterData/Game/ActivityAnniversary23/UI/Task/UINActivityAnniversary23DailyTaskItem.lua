local base = require("Game.CommonUI.Activity.UINActivityCommonDailyTaskItem")
local UINActivityAnniversary23DailyTaskItem = class("UINActivityAnniversary23DailyTaskItem", base)

function UINActivityAnniversary23DailyTaskItem:InitDailyTaskItem(taskData, callback, refCallback)
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
  self:RefreshDailyTaskItem()
end

function UINActivityAnniversary23DailyTaskItem:SetDailyTaskItemRef(flag)
  self.ui.btn_Refresh.gameObject:SetActive(flag and not self._taskData:CheckComplete())
end

function UINActivityAnniversary23DailyTaskItem:RefreshDailyTaskItem()
  local schedule, aim = self._taskData:GetTaskProcess()
  self.ui.fill.value = schedule / aim
  self.ui.tex_Progress:SetIndex(0, tostring(schedule), tostring(aim))
  local isComplete = self._taskData:CheckComplete()
  if isComplete then
    self.ui.tex_Progress:SetIndex(1)
    self.ui.state:SetIndex(0)
    self.ui.tex_State:SetIndex(0)
    self.ui.btn_ReceiveItem.color = self.ui.color_canReceive
    self.ui.tex_State.text.color = self.ui.color_completeText ~= nil and self.ui.color_completeText or Color.white
    return
  end
  self.ui.tex_Progress:SetIndex(0, tostring(schedule), tostring(aim))
  local haveJump = self._taskData:GetTaskJumpArg()
  if haveJump then
    self.ui.state:SetIndex(1)
    self.ui.tex_State:SetIndex(1)
    self.ui.btn_ReceiveItem.color = self.ui.color_goto
    local tex_StateColor = self.ui.color_gotoText ~= nil and self.ui.color_gotoText or Color.white
    self.ui.tex_State.text.color = tex_StateColor
  else
    self.ui.state:SetIndex(2)
    self.ui.tex_State:SetIndex(2)
    self.ui.btn_ReceiveItem.color = self.ui.color_uncomplete
    self.ui.tex_State.text.color = self.ui.color_uncompleteText
  end
end

function UINActivityAnniversary23DailyTaskItem:ClickRefresh()
  if self._refCallback ~= nil then
    self._refCallback(self, self._taskData)
  end
end

function UINActivityAnniversary23DailyTaskItem:ClickConfirm()
  if self._callback ~= nil then
    self._callback(self._taskData)
  end
end

return UINActivityAnniversary23DailyTaskItem
