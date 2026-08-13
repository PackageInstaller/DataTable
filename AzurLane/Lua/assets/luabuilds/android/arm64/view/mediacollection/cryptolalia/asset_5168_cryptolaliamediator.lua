class = var_0_10000

local var_0_0 = "CryptolaliaMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

var_0_1.UNLOCK = "CryptolaliaMediator:UNLOCK"

function var_0_1.register(arg_1_0)
	local var_1_0 = arg_1_0

	arg_1_0.bind(var_1_0, var_0_1.UNLOCK, function(arg_2_0, arg_2_1, arg_2_2)
		local var_2_0 = arg_1_0
		local var_2_1 = var_3.sendNotification

		GAME = var_2_10006

		var_2_1(var_2_0, var_2_10006.UNLOCK_CRYPTOLALIA, {
			id = arg_2_1,
			costType = arg_2_2
		})

		return
	end)

	getProxy = var_1
	PlayerProxy = var_1_0

	local var_1_1 = var_1(var_1_0)
	local var_1_2 = var_1.getRawData(var_1_1)
	local var_1_3 = arg_1_0.viewComponent

	var_2.SetCryptolaliaList(var_1_3, var_1_2:GetCryptolaliaList())

	return
end

function var_0_1.listNotificationInterests(arg_3_0)
	local var_3_0 = {}

	GAME = var_1_10002
	var_3_0[1] = var_1_10002.UNLOCK_CRYPTOLALIA_DONE

	return var_3_0
end

function var_0_1.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1
	local var_4_1 = arg_4_1.getName(var_4_0)
	local var_4_2 = arg_4_1:getBody()

	GAME = var_4_0

	if var_4_1 == var_4_0.UNLOCK_CRYPTOLALIA_DONE then
		local var_4_3 = arg_4_0.viewComponent
		local var_4_4 = var_4.emit

		CryptolaliaScene = var_1_10007

		var_4_4(var_4_3, var_1_10007.ON_UNLOCK, var_4_2.id)
	end

	return
end

return var_0_1
