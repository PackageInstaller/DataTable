local DormCtrlBase = require("Game.Dorm.Ctrl.DormCtrlBase")
local DormShopCtrl = class("DormShopCtrl", DormCtrlBase)
local DormEnum = require("Game.Dorm.DormEnum")

function DormShopCtrl:ctor(dormCtrl)
end

function DormShopCtrl:EnterDormShop()
  local shopId = 0
  local itemType
  if self.dormCtrl.state == DormEnum.eDormState.House or self.dormCtrl.state == DormEnum.eDormState.HouseEdit then
    shopId = ConfigData.game_config.DormRoomShopId
    itemType = eItemType.DormRoom
  elseif self.dormCtrl.state == DormEnum.eDormState.Room or self.dormCtrl.state == DormEnum.eDormState.RoomEdit then
    shopId = ConfigData.game_config.DormFntShopId
    itemType = eItemType.DormFurniture
  end
  if shopId <= 0 then
    return
  end
  ControllerManager:GetController(ControllerTypeId.Shop, true):ReqShopDetail(shopId, function(shopData)
    print("UIWindowTypeID.DormShop the prefab is Delete")
  end)
end

function DormShopCtrl:OnDelete()
end

return DormShopCtrl
