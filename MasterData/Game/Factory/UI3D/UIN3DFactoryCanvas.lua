local UIN3DFactoryCanvas = class("UIN3DFactoryCanvas", UIBaseNode)
local base = UIBaseNode
local UIN3DFactoryRoomInfo = require("Game.Factory.UI3D.UIN3DFactoryRoomInfo")

function UIN3DFactoryCanvas:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.roomInfoPool = UIItemPool.New(UIN3DFactoryRoomInfo, self.ui.obj_factoryRoomInfo)
  self.roomItemDic = {}
  self.ui.obj_factoryRoomInfo:SetActive(false)
  UIUtil.AddButtonListener(self.ui.btn_background, self, self.OnClickBackground)
end

function UIN3DFactoryCanvas:GenRoomInfo(roomIndex, roomTramsform, roomEntityType, unlockDes)
  local item = self.roomInfoPool:GetOne()
  local pos = Vector3.__mul(roomTramsform.position, 1 / self.ui.canvasScale)
  item.transform.localPosition = pos
  item:InitRoomInfo(roomIndex, roomEntityType, unlockDes)
  self.roomItemDic[roomIndex] = item
  return item
end

function UIN3DFactoryCanvas:SetRoomInfoSate(roomIndex, roomEntityType)
  local uiRoomInfo = self.roomItemDic[roomIndex]
  uiRoomInfo:SetRoomStateImage(roomEntityType)
end

function UIN3DFactoryCanvas:RefreshProcessLines(ProcessingOrders)
  for roomIndex, roomIte in pairs(self.roomItemDic) do
    roomIte:RefreshProcessLine(ProcessingOrders)
  end
end

function UIN3DFactoryCanvas:SetClickBackgroundCallback(clickBGCallback)
  self.clickBGCallback = clickBGCallback
end

function UIN3DFactoryCanvas:OnClickBackground()
  if self.clickBGCallback ~= nil then
    self.clickBGCallback()
  end
end

function UIN3DFactoryCanvas:OnDelete()
  self.roomInfoPool:DeleteAll()
  self.roomItemDic = nil
  base.OnDelete(self)
end

return UIN3DFactoryCanvas
