local var_0_0 = class("EquipCodeMediator", import("..base.ContextMediator"))

var_0_0.SHARE_EQUIP_CODE = "EquipCodeMediator.SHARE_EQUIP_CODE"
var_0_0.IMPORT_SHIP_EQUIP = "EquipCodeMediator.IMPORT_SHIP_EQUIP"
var_0_0.OPEN_CUSTOM_INDEX = "EquipCodeMediator.OPEN_CUSTOM_INDEX"
var_0_0.OPEN_EQUIP_CODE_SHARE = "EquipCodeMediator.OPEN_EQUIP_CODE_SHARE"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.SHARE_EQUIP_CODE, function(arg_2_0, arg_2_1, arg_2_2)
		arg_1_0:sendNotification(GAME.EQUIP_CODE_SHARE, {
			groupId = arg_2_1,
			code = arg_2_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.IMPORT_SHIP_EQUIP, function(arg_3_0, arg_3_1, arg_3_2)
		arg_1_0:sendNotification(GAME.SHIP_EQUIP_ALL_CHANGE, {
			shipId = arg_3_1,
			equipData = arg_3_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_CUSTOM_INDEX, function(arg_4_0, arg_4_1)
		arg_1_0:addSubLayers(Context.New({
			viewComponent = CustomIndexLayer,
			mediator = CustomIndexMediator,
			data = arg_4_1
		}))

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_EQUIP_CODE_SHARE, function(arg_5_0, arg_5_1)
		arg_1_0:addSubLayers(Context.New({
			mediator = EquipCodeShareMediator,
			viewComponent = EquipCodeShareLayer,
			data = {
				shipGroupId = arg_5_1
			}
		}))

		return
	end)

	local var_1_0 = getProxy(EquipmentProxy):getEquipments(true)

	for iter_1_0, iter_1_1 in ipairs(getProxy(BayProxy):getEquipsInShips()) do
		table.insert(var_1_0, iter_1_1)
	end

	local var_1_1 = underscore.values(getProxy(EquipmentProxy):GetSpWeapons())

	for iter_1_2, iter_1_3 in ipairs(getProxy(BayProxy):GetSpWeaponsInShips()) do
		table.insert(var_1_1, iter_1_3)
	end

	arg_1_0.viewComponent:setEquipments(var_1_0, var_1_1)
	arg_1_0.viewComponent:setShip(arg_1_0.contextData.shipId)

	return
end

function var_0_0.initNotificationHandleDic(arg_6_0)
	arg_6_0.handleDic = {
		[GAME.SHIP_EQUIP_ALL_CHANGE_DONE] = function(arg_7_0, arg_7_1)
			assert(arg_7_1:getBody() == arg_7_0.contextData.shipId)
			arg_7_0.viewComponent:closeView()

			return
		end
	}

	return
end

return var_0_0
