local UIEpRoomInterface = class("UIEpRoomInterface", UIBaseNode)
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")

function UIEpRoomInterface:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UIEpRoomInterface:InitRoomInterface(roomData)
  self.roomData = roomData
end

function UIEpRoomInterface:SetInterfaceRightPass(isPass, color)
  if isPass then
    self.ui.img_Right:SetIndex(1)
    self.ui.img_Right.image.color = color
  else
    self.ui.img_Right:SetIndex(0)
    self.ui.img_Right.image.color = Color.white
  end
end

function UIEpRoomInterface:SetInterfaceLeftPass(isPass, color)
  if isPass then
    self.ui.img_Left:SetIndex(1)
    self.ui.img_Left.image.color = color
  else
    self.ui.img_Left:SetIndex(0)
    self.ui.img_Left.image.color = Color.white
  end
end

function UIEpRoomInterface:SetAllInterfacePass(isPass, color)
  self:SetInterfaceLeftPass(isPass, color)
  self:SetInterfaceRightPass(isPass, color)
end

function UIEpRoomInterface:SetRoomUIAlpha(alphaValue)
  self.ui.EpInterfaceAlpha.alpha = alphaValue
end

return UIEpRoomInterface
