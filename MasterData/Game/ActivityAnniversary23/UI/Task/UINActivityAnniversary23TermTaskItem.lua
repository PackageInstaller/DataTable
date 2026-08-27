local base = require("Game.CommonUI.Activity.UINActivityCommonTermTaskItem")
local UINActivityAnniversary23TermTaskItem = class("UINActivityAnniversary23TermTaskItem", base)
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")

function UINActivityAnniversary23TermTaskItem:InitTermTaskItem(taskData, callback, index, isSpecial, textIndex)
  self._taskData = taskData
  self._callback = callback
  self._index = index
  self.ui.tex_TaskDes.text = self._taskData:GetTaskFirstStepIntro()
  self._itemPool:HideAll()
  local itemIds, itemNums = self._taskData:GetTaskCfgRewards()
  for i, itemId in ipairs(itemIds) do
    local itemNum = itemNums[i]
    local itemCfg = ConfigData.item[itemId]
    local item = self._itemPool:GetOne()
    item:InitItemWithCount(itemCfg, itemNum)
  end
  self:RefreshTermTaskItem()
  self.ui.Obj_Tag:SetActive(isSpecial)
  if isSpecial then
    self.ui.Tex_Tag:SetIndex(textIndex)
  end
end

function UINActivityAnniversary23TermTaskItem:RefreshTermTaskItem()
  self:__RefreshFill()
  for i, v in ipairs(self._itemPool.listItem) do
    v:SetPickedUIActive(self._taskData.isPicked)
  end
  if self._taskData.isPicked then
    self:__RefreshPickConfirmBtn()
  else
    self:__RefreshConfimBtn()
  end
end

function UINActivityAnniversary23TermTaskItem:__RefreshFill()
  local schedule, aim = self._taskData:GetTaskProcess()
  self.ui.bar.value = schedule / aim
  self.ui.tex_Progress:SetIndex(0, tostring(schedule), tostring(aim))
end

function UINActivityAnniversary23TermTaskItem:__RefreshPickConfirmBtn()
  self.ui.isOver:SetActive(true)
  self.ui.img_state:SetIndex(0)
  self.ui.tex_Progress:SetIndex(1)
  self.ui.tex_State:SetIndex(3)
  self.ui.btn_Receive.color = self.ui.color_goto
  self.ui.tex_State.text.color = self.ui.color_completeText ~= nil and self.ui.color_completeText or Color.white
end

function UINActivityAnniversary23TermTaskItem:__RefreshConfimBtn()
  self.ui.isOver:SetActive(false)
  self.ui.state:SetActive(true)
  local schedule, aim = self._taskData:GetTaskProcess()
  local isComplete = self._taskData:CheckComplete()
  if isComplete then
    self.ui.tex_Progress:SetIndex(1)
    self.ui.img_state:SetIndex(0)
    self.ui.tex_State:SetIndex(0)
    self.ui.btn_Receive.color = self.ui.color_canReceive
    self.ui.tex_State.text.color = self.ui.color_completeText ~= nil and self.ui.color_completeText or Color.white
    return
  end
  self.ui.tex_Progress:SetIndex(0, tostring(schedule), tostring(aim))
  local haveJump = self._taskData:GetTaskJumpArg()
  if haveJump then
    self.ui.img_state:SetIndex(1)
    self.ui.tex_State:SetIndex(1)
    self.ui.btn_Receive.color = self.ui.color_goto
    local tex_StateColor = self.ui.color_gotoText ~= nil and self.ui.color_gotoText or Color.white
    self.ui.tex_State.text.color = tex_StateColor
  else
    self.ui.img_state:SetIndex(2)
    self.ui.tex_State:SetIndex(2)
    self.ui.btn_Receive.color = self.ui.color_uncomplete
    self.ui.tex_State.text.color = self.ui.color_uncompleteText
  end
end

function UINActivityAnniversary23TermTaskItem:OnClickConfirm()
  if self._callback ~= nil then
    self._callback(self._taskData)
  end
end

function UINActivityAnniversary23TermTaskItem:GetTermTaskId()
  return self._taskData.id
end

return UINActivityAnniversary23TermTaskItem
