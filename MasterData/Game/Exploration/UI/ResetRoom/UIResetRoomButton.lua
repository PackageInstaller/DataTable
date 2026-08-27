local UIResetRoomButton = class("UIResetRoomButton", UIBaseNode)
local base = UIBaseNode

function UIResetRoomButton:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Operation, self, self.OnButtonClick)
end

function UIResetRoomButton:InitOperationButton(id, reseRoomData, clickAction)
  self.id = id
  self.price = reseRoomData.costNum
  self:UpdateMoney(reseRoomData.costNum)
  self.clickAction = clickAction
  self.ui.tex_Name:SetIndex(id)
end

function UIResetRoomButton:UpdateMoney(costNum)
  self.ui.tex_Money:SetIndex(0, tostring(costNum))
end

function UIResetRoomButton:OnButtonClick()
  if self.clickAction ~= nil then
    self.clickAction(self)
  end
end

return UIResetRoomButton
