local base = require("Game.ActivityChristmas.UI.Task.UINChristmas22ActTaskItem")
local UINSpring23ActTaskItem = class("UINSpring23ActTaskItem", base)

function UINSpring23ActTaskItem:__RefreshFill()
  local schedule, aim = self._taskData:GetTaskProcess()
  self.ui.bar.value = schedule / aim
  self.ui.tex_Progress:SetIndex(0, tostring(schedule), tostring(aim))
end

function UINSpring23ActTaskItem:__RefreshPickConfirmBtn()
  self.ui.btn_Receive.color = self.ui.color_uncomplete
  self.ui.img_state.gameObject:SetActive(false)
  self.ui.tex_State:SetIndex(3)
  self.ui.tex_State.text.color = self.ui.color_pickText ~= nil and self.ui.color_pickText or Color.white
  self.ui.state:SetActive(false)
  if self.ui.pickedAlpha ~= nil then
    self.ui.animNode.alpha = self.ui.pickedAlpha
  end
end

function UINSpring23ActTaskItem:__RefreshConfirmBtn()
  self.ui.state:SetActive(true)
  local isComplete = self._taskData:CheckComplete()
  if isComplete then
    self.ui.btn_Receive.color = self.ui.color_canReceive
    self.ui.img_state:SetIndex(0)
    self.ui.tex_State:SetIndex(0)
    self.ui.tex_State.text.color = self.ui.color_completeText ~= nil and self.ui.color_completeText or Color.white
    return
  end
  local isGoto = self._taskData:GetTaskJumpArg()
  if isGoto then
    self.ui.btn_Receive.color = self.ui.color_goto
    self.ui.img_state:SetIndex(1)
    self.ui.tex_State:SetIndex(1)
    self.ui.tex_State.text.color = self.ui.color_gotoText ~= nil and self.ui.color_gotoText or Color.white
  else
    self.ui.btn_Receive.color = self.ui.color_uncomplete
    self.ui.img_state:SetIndex(2)
    self.ui.tex_State:SetIndex(2)
    self.ui.tex_State.text.color = self.ui.color_uncompleteText
  end
  if self.ui.unPickedAlpha ~= nil then
    self.ui.animNode.alpha = self.ui.unPickedAlpha
  end
end

return UINSpring23ActTaskItem
