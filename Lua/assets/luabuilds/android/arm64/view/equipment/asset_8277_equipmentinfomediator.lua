local EquipmentInfoMediator = class("EquipmentInfoMediator", import("..base.ContextMediator"))

EquipmentInfoMediator.TYPE_DEFAULT = 1
EquipmentInfoMediator.TYPE_SHIP = 2
EquipmentInfoMediator.TYPE_REPLACE = 3
EquipmentInfoMediator.TYPE_DISPLAY = 4
EquipmentInfoMediator.SHOW_UNIQUE = {
	1,
	2,
	3,
	4
}
EquipmentInfoMediator.ON_DESTROY = "EquipmentInfoMediator:ON_DESTROY"
EquipmentInfoMediator.ON_EQUIP = "EquipmentInfoMediator:ON_EQUIP"
EquipmentInfoMediator.ON_INTENSIFY = "EquipmentInfoMediator.ON_INTENSIFY"
EquipmentInfoMediator.ON_CHANGE = "EquipmentInfoMediator.ON_CHANGE"
EquipmentInfoMediator.ON_UNEQUIP = "EquipmentInfoMediator:ON_UNEQUIP"
EquipmentInfoMediator.ON_REVERT = "EquipmentInfoMediator:ON_REVERT"
EquipmentInfoMediator.ON_MOVE = "EquipmentInfoMediator:ON_MOVE"
EquipmentInfoMediator.OPEN_LAYER = "OPEN LAYER"

function EquipmentInfoMediator:register()
	if getProxy(ContextProxy):getCurrentContext().scene == SCENE.EQUIPSCENE then
		self.viewComponent.fromEquipmentView = true
	end

	self:bind(EquipmentInfoMediator.ON_DESTROY, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.DESTROY_EQUIPMENTS, {
			equipments = {
				{
					self.contextData.equipmentId,
					arg_2_1
				}
			}
		})

		return
	end)
	self:bind(EquipmentInfoMediator.ON_EQUIP, function(arg_3_0)
		if self.contextData.oldShipId then
			local var_3_0, var_3_1 = ShipStatus.ShipStatusCheck("onModify", (getProxy(BayProxy):getShipById(self.contextData.oldShipId)))

			if not var_3_0 then
				pg.TipsMgr.GetInstance():ShowTips(var_3_1)
			else
				if self.viewComponent.fromEquipmentView then
					self:sendNotification(EquipmentMediator.NO_UPDATE)
				end

				self:sendNotification(GAME.EQUIP_FROM_SHIP, {
					equipmentId = self.contextData.equipmentId,
					shipId = self.contextData.shipId,
					pos = self.contextData.pos,
					oldShipId = self.contextData.oldShipId,
					oldPos = self.contextData.oldPos
				})
			end
		else
			if self.viewComponent.fromEquipmentView then
				self:sendNotification(EquipmentMediator.NO_UPDATE)
			end

			self:sendNotification(GAME.EQUIP_TO_SHIP, {
				equipmentId = self.contextData.equipmentId,
				shipId = self.contextData.shipId,
				pos = self.contextData.pos
			})
		end

		return
	end)
	self:bind(EquipmentInfoMediator.ON_UNEQUIP, function(arg_4_0)
		self:sendNotification(GAME.UNEQUIP_FROM_SHIP, {
			shipId = self.contextData.shipId,
			pos = self.contextData.pos
		})
		self.viewComponent:emit(BaseUI.ON_CLOSE)

		return
	end)
	self:bind(EquipmentInfoMediator.ON_INTENSIFY, function(arg_5_0)
		self:addSubLayers(Context.New({
			mediator = EquipUpgradeMediator,
			viewComponent = EquipUpgradeLayer,
			data = {
				equipmentId = self.contextData.equipmentId,
				shipId = self.contextData.shipId,
				pos = self.contextData.pos
			}
		}), true, function()
			self.viewComponent:emit(BaseUI.ON_CLOSE)

			return
		end)

		return
	end)
	self:bind(EquipmentInfoMediator.ON_CHANGE, function(arg_7_0)
		local var_7_0 = getProxy(BayProxy)
		local var_7_1 = var_7_0:getShipById(self.contextData.shipId)
		local var_7_2 = var_7_0:getEquipsInShips(function(arg_8_0, arg_8_1)
			return var_7_1.id ~= arg_8_1 and not var_7_1:isForbiddenAtPos(arg_8_0, self.contextData.pos)
		end)

		for iter_7_0, iter_7_1 in ipairs((getProxy(EquipmentProxy):getEquipments(true))) do
			if not var_7_1:isForbiddenAtPos(iter_7_1, self.contextData.pos) then
				table.insert(var_7_2, iter_7_1)
			end
		end

		_.each(var_7_2, function(arg_9_0)
			if not var_7_1:canEquipAtPos(arg_9_0, self.contextData.pos) then
				arg_9_0.mask = true
			end

			return
		end)
		self.viewComponent:emit(BaseUI.ON_CLOSE)
		self:sendNotification(GAME.GO_SCENE, SCENE.EQUIPSCENE, {
			lock = true,
			equipmentVOs = var_7_2,
			shipId = self.contextData.shipId,
			pos = self.contextData.pos,
			warp = StoreHouseConst.WARP_TO_WEAPON,
			mode = StoreHouseConst.EQUIPMENT
		})

		return
	end)
	self:bind(EquipmentInfoMediator.ON_REVERT, function(arg_10_0, arg_10_1)
		self:sendNotification(GAME.REVERT_EQUIPMENT, {
			id = arg_10_1
		})

		return
	end)
	self:bind(EquipmentInfoMediator.ON_MOVE, function(arg_11_0, arg_11_1)
		self.viewComponent:emit(BaseUI.ON_CLOSE)
		self:sendNotification(GAME.GO_SCENE, SCENE.SHIPINFO, {
			page = 2,
			shipId = arg_11_1
		})

		return
	end)
	self:bind(EquipmentInfoMediator.OPEN_LAYER, function(arg_12_0, ...)
		self:addSubLayers(...)

		return
	end)

	if self.contextData.equipment then
		self.viewComponent:setEquipment(self.contextData.equipment)
	else
		self.viewComponent:setEquipment(getProxy(EquipmentProxy):getEquipmentById(self.contextData.equipmentId) or self.contextData.equipmentId and self.contextData.equipmentId > 0 and Equipment.New({
			id = self.contextData.equipmentId
		}) or nil)
	end

	local var_1_1 = getProxy(BayProxy)

	self.viewComponent:setShip(self.contextData.shipVO or var_1_1:getShipById(self.contextData.shipId), self.contextData.oldShipId and var_1_1:getShipById(self.contextData.oldShipId) or nil)
	self.viewComponent:setPlayer((getProxy(PlayerProxy):getData()))

	return
end

function EquipmentInfoMediator:listNotificationInterests()
	return {
		GAME.DESTROY_EQUIPMENTS_DONE,
		GAME.EQUIP_TO_SHIP_DONE,
		GAME.REVERT_EQUIPMENT_DONE
	}
end

function EquipmentInfoMediator:handleNotification(arg_14_1)
	local var_14_0 = arg_14_1:getName()
	local var_14_1 = arg_14_1:getBody()

	if var_14_0 == GAME.DESTROY_EQUIPMENTS_DONE or var_14_0 == GAME.EQUIP_TO_SHIP_DONE or var_14_0 == GAME.REVERT_EQUIPMENT_DONE then
		self.viewComponent:emit(BaseUI.ON_CLOSE)
	end

	return
end

return EquipmentInfoMediator
