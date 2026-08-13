class = var_0_10000

local var_0_0 = "EquipmentTransformTreeMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

var_0_1.OPEN_LAYER = "OPEN_LAYER"

function var_0_1.register(arg_1_0)
	arg_1_0:BindEvent()

	arg_1_0.env = {}

	local var_1_0 = arg_1_0:getViewComponent()

	var_1.SetEnv(var_1_0, arg_1_0.env)

	local var_1_1 = arg_1_0.env

	getProxy = var_1_10002
	EquipmentProxy = var_4

	local var_1_2 = var_1_10002(var_4)

	var_1_1.tracebackHelper = var_2.GetWeakEquipsDict(var_1_2)

	local var_1_3 = arg_1_0.env

	EquipmentProxy = var_2
	var_1_3.nationsTree = var_2.EquipmentTransformTreeTemplate

	return
end

function var_0_1.BindEvent(arg_2_0)
	arg_2_0:bind(var_0_1.OPEN_LAYER, function(arg_3_0, ...)
		local var_3_0 = arg_2_0

		var_1.addSubLayers(var_3_0, ...)

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_4_0)
	local var_4_0 = {}

	GAME = var_1_10002
	var_4_0[1] = var_1_10002.TRANSFORM_EQUIPMENT_DONE
	PlayerProxy = var_2
	var_4_0[2] = var_2.UPDATED
	BagProxy = var_2
	var_4_0[3] = var_2.ITEM_UPDATED
	EquipmentProxy = var_2
	var_4_0[4] = var_2.EQUIPMENT_UPDATED
	EquipmentTransformMediator = var_2
	var_4_0[5] = var_2.UPDATE_NEW_FLAG

	return var_4_0
end

function var_0_1.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1
	local var_5_1 = arg_5_1.getName(var_5_0)
	local var_5_2 = arg_5_1:getBody()

	PlayerProxy = var_5_0

	if var_5_1 ~= var_5_0.UPDATED then
		BagProxy = var_4

		if var_5_1 == var_4.ITEM_UPDATED then
			local var_5_3 = arg_5_0:getViewComponent()

			var_4.UpdateItemNodes(var_5_3)
		else
			EquipmentProxy = var_4

			local var_5_4

			if var_5_1 == var_4.EQUIPMENT_UPDATED then
				var_5_4 = var_5_2.count == 0

				if var_5_4 then
					local var_5_5 = arg_5_0:getViewComponent()

					var_5.UpdateItemNodes(var_5_5)
				end
			else
				EquipmentTransformMediator = var_5_4

				if var_5_1 == var_5_4.UPDATE_NEW_FLAG then
					local var_5_6 = arg_5_0:getViewComponent()

					var_4.UpdateItemNodeByID(var_5_6, var_5_2)
				end
			end
		end

		return
	end
end

return var_0_1
