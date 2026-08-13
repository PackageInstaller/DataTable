class = var_0_10000

local var_0_0 = "EquipCodeShareMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.ContextMediator"))

var_0_1.OPEN_TAG_INDEX = "EquipCodeShareMediator.OPEN_TAG_INDEX"
var_0_1.LIKE_EQUIP_CODE = "EquipCodeShareMediator.LIKE_EQUIP_CODE"
var_0_1.IMPEACH_EQUIP_CODE = "EquipCodeShareMediator.IMPEACH_EQUIP_CODE"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.IMPEACH_EQUIP_CODE, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		local var_2_0 = arg_1_0
		local var_2_1 = var_4.sendNotification

		GAME = var_2_10006

		var_2_1(var_2_0, var_2_10006.EQUIP_CODE_IMPEACH, {
			groupId = arg_2_1,
			shareId = arg_2_2,
			type = arg_2_3
		})

		return
	end)
	arg_1_0:bind(var_0_1.LIKE_EQUIP_CODE, function(arg_3_0, arg_3_1, arg_3_2)
		local var_3_0 = arg_1_0
		local var_3_1 = var_3.sendNotification

		GAME = var_2_10005

		var_3_1(var_3_0, var_2_10005.EQUIP_CODE_LIKE, {
			groupId = arg_3_1,
			shareId = arg_3_2
		})

		return
	end)

	local var_1_0 = arg_1_0

	arg_1_0.bind(var_1_0, var_0_1.OPEN_TAG_INDEX, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0
		local var_4_1 = var_2.addSubLayers

		Context = var_2_10004

		local var_4_2 = var_2_10004.New
		local var_4_3 = {}

		CustomIndexLayer = var_2_10006
		var_4_3.viewComponent = var_2_10006
		CustomIndexMediator = var_2_10006
		var_4_3.mediator = var_2_10006
		var_4_3.data = arg_4_1

		var_4_1(var_4_0, var_4_2(var_4_3))

		return
	end)

	getProxy = var_1
	CollectionProxy = var_1_0

	local var_1_1 = var_1(var_1_0)
	local var_1_2 = var_1.getShipGroup(var_1_1, arg_1_0.contextData.shipGroupId)
	local var_1_3 = arg_1_0.viewComponent

	var_2.setShipGroup(var_1_3, var_1_2)

	return
end

function var_0_1.initNotificationHandleDic(arg_5_0)
	local var_5_0 = {}

	GAME = var_1_10002
	var_5_0[var_1_10002.EQUIP_CODE_LIKE_DONE] = function(arg_6_0, arg_6_1)
		local var_6_0 = arg_6_1:getBody()
		local var_6_1 = arg_6_0.viewComponent

		var_3.refreshLikeCommand(var_6_1, var_6_0.shareId, var_6_0.like)

		return
	end
	arg_5_0.handleDic = var_5_0

	return
end

return var_0_1
