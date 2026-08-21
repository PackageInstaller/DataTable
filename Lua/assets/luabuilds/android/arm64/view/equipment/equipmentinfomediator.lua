local var_0_0 = class("EquipmentInfoMediator", import("..base.ContextMediator"))

var_0_0.TYPE_DEFAULT = 1
var_0_0.TYPE_SHIP = 2
var_0_0.TYPE_REPLACE = 3
var_0_0.TYPE_DISPLAY = 4
var_0_0.SHOW_UNIQUE = {
	1,
	2,
	3,
	4
}
var_0_0.ON_DESTROY = "EquipmentInfoMediator:ON_DESTROY"
var_0_0.ON_EQUIP = "EquipmentInfoMediator:ON_EQUIP"
var_0_0.ON_INTENSIFY = "EquipmentInfoMediator.ON_INTENSIFY"
var_0_0.ON_CHANGE = "EquipmentInfoMediator.ON_CHANGE"
var_0_0.ON_UNEQUIP = "EquipmentInfoMediator:ON_UNEQUIP"
var_0_0.ON_REVERT = "EquipmentInfoMediator:ON_REVERT"
var_0_0.ON_MOVE = "EquipmentInfoMediator:ON_MOVE"
var_0_0.OPEN_LAYER = "OPEN LAYER"

function var_0_0.register(arg_1_0)
	if getProxy(ContextProxy):getCurrentContext().scene == SCENE.EQUIPSCENE then
		arg_1_0.viewComponent.fromEquipmentView = true
	end

	arg_1_0:bind(var_0_0.ON_DESTROY, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(GAME.DESTROY_EQUIPMENTS, {
			equipments = {
				{
					arg_1_0.contextData.equipmentId,
					arg_2_1
				}
			}
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_EQUIP, function(arg_3_0)
		if arg_1_0.contextData.oldShipId then
			local var_3_0, var_3_1 = ShipStatus.ShipStatusCheck("onModify", (getProxy(BayProxy):getShipById(arg_1_0.contextData.oldShipId)))

			if not var_3_0 then
				pg.TipsMgr.GetInstance():ShowTips(var_3_1)
			else
				if arg_1_0.viewComponent.fromEquipmentView then
					arg_1_0:sendNotification(EquipmentMediator.NO_UPDATE)
				end

				arg_1_0:sendNotification(GAME.EQUIP_FROM_SHIP, {
					equipmentId = arg_1_0.contextData.equipmentId,
					shipId = arg_1_0.contextData.shipId,
					pos = arg_1_0.contextData.pos,
					oldShipId = arg_1_0.contextData.oldShipId,
					oldPos = arg_1_0.contextData.oldPos
				})
			end
		else
			if arg_1_0.viewComponent.fromEquipmentView then
				arg_1_0:sendNotification(EquipmentMediator.NO_UPDATE)
			end

			arg_1_0:sendNotification(GAME.EQUIP_TO_SHIP, {
				equipmentId = arg_1_0.contextData.equipmentId,
				shipId = arg_1_0.contextData.shipId,
				pos = arg_1_0.contextData.pos
			})
		end

		return
	end)
	arg_1_0:bind(var_0_0.ON_UNEQUIP, function(arg_4_0)
		arg_1_0:sendNotification(GAME.UNEQUIP_FROM_SHIP, {
			shipId = arg_1_0.contextData.shipId,
			pos = arg_1_0.contextData.pos
		})
		arg_1_0.viewComponent:emit(BaseUI.ON_CLOSE)

		return
	end)
	arg_1_0:bind(var_0_0.ON_INTENSIFY, function(arg_5_0)
		arg_1_0:addSubLayers(Context.New({
			mediator = EquipUpgradeMediator,
			viewComponent = EquipUpgradeLayer,
			data = {
				equipmentId = arg_1_0.contextData.equipmentId,
				shipId = arg_1_0.contextData.shipId,
				pos = arg_1_0.contextData.pos
			}
		}), true, function()
			arg_1_0.viewComponent:emit(BaseUI.ON_CLOSE)

			return
		end)

		return
	end)
	arg_1_0:bind(var_0_0.ON_CHANGE, function(arg_7_0)
		local var_7_0 = getProxy(BayProxy)
		local var_7_1 = var_7_0:getShipById(arg_1_0.contextData.shipId)
		local var_7_2 = var_7_0:getEquipsInShips(function(arg_8_0, arg_8_1)
			return var_7_1.id ~= arg_8_1 and not var_7_1:isForbiddenAtPos(arg_8_0, arg_1_0.contextData.pos)
		end)

		for iter_7_0, iter_7_1 in ipairs((getProxy(EquipmentProxy):getEquipments(true))) do
			if not var_7_1:isForbiddenAtPos(iter_7_1, arg_1_0.contextData.pos) then
				table.insert(var_7_2, iter_7_1)
			end
		end

		_.each(var_7_2, function(arg_9_0)
			if not var_7_1:canEquipAtPos(arg_9_0, arg_1_0.contextData.pos) then
				arg_9_0.mask = true
			end

			return
		end)
		arg_1_0.viewComponent:emit(BaseUI.ON_CLOSE)
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.EQUIPSCENE, {
			lock = true,
			equipmentVOs = var_7_2,
			shipId = arg_1_0.contextData.shipId,
			pos = arg_1_0.contextData.pos,
			warp = StoreHouseConst.WARP_TO_WEAPON,
			mode = StoreHouseConst.EQUIPMENT
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_REVERT, function(arg_10_0, arg_10_1)
		arg_1_0:sendNotification(GAME.REVERT_EQUIPMENT, {
			id = arg_10_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_MOVE, function(arg_11_0, arg_11_1)
		arg_1_0.viewComponent:emit(BaseUI.ON_CLOSE)
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.SHIPINFO, {
			page = 2,
			shipId = arg_11_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_LAYER, function(arg_12_0, ...)
		arg_1_0:addSubLayers(...)

		return
	end)

	if arg_1_0.contextData.equipment then
		arg_1_0.viewComponent:setEquipment(arg_1_0.contextData.equipment)
	else
		local var_1_0 = getProxy(EquipmentProxy)
		local var_1_1 = var_1_0:getEquipmentById(arg_1_0.contextData.equipmentId) or arg_1_0.contextData.equipmentId and arg_1_0.contextData.equipmentId > 0 and Equipment.New({
			id = arg_1_0.contextData.equipmentId
		}) or nil

		arg_1_0.viewComponent:setEquipment(var_1_1)
	end

	local var_1_2 = getProxy(BayProxy)
	local var_1_3 = arg_1_0.contextData.shipVO or var_1_2:getShipById(arg_1_0.contextData.shipId)
	local var_1_4 = arg_1_0.contextData.oldShipId and var_1_2:getShipById(arg_1_0.contextData.oldShipId) or nil

	arg_1_0.viewComponent:setShip(var_1_3, var_1_4)
	arg_1_0.viewComponent:setPlayer((getProxy(PlayerProxy):getData()))

	return
end

function var_0_0.listNotificationInterests(arg_13_0)
	return {
		GAME.DESTROY_EQUIPMENTS_DONE,
		GAME.EQUIP_TO_SHIP_DONE,
		GAME.REVERT_EQUIPMENT_DONE
	}
end

function var_0_0.handleNotification(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_1:getName()
	local var_14_1 = arg_14_1:getBody()

	if var_14_0 == GAME.DESTROY_EQUIPMENTS_DONE or var_14_0 == GAME.EQUIP_TO_SHIP_DONE or var_14_0 == GAME.REVERT_EQUIPMENT_DONE then
		arg_14_0.viewComponent:emit(BaseUI.ON_CLOSE)
	end

	return
end

return var_0_0
