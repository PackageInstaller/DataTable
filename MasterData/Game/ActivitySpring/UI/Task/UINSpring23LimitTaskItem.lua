local base = require("Game.ActivityChristmas.UI.Task.UINChristmas22LimitTaskItem")
local UINSpring23LimitTaskItem = class("UINSpring23LimitTaskItem", base)
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")

function UINSpring23LimitTaskItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Refresh, self, self.ClickRefresh)
  UIUtil.AddButtonListener(self.ui.btn_ItemClick, self, self.ClickConfirm)
  self._itemPool = UIItemPool.New(UINBaseItemWithReceived, self.ui.uINBaseItemWithReceived)
  self.ui.uINBaseItemWithReceived:SetActive(false)
end

function UINSpring23LimitTaskItem:RefreshChristmas22LimitTaskItem()
  local schedule, aim = self._taskData:GetTaskProcess()
  self.ui.fill.value = schedule / aim
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

return UINSpring23LimitTaskItem
