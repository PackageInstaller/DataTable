class = var_0_10000

local var_0_0 = "SenrankaguraTrainMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.ContextMediator"))

var_0_1.LEVEL_UP = "level up"
var_0_1.GET_REWARD = "get reward"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.LEVEL_UP, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10005

		var_2_1(var_2_0, var_2_10005.SENRANKAGURA_TRAIN_ACT_OP, arg_2_1)

		return
	end)
	arg_1_0:bind(var_0_1.GET_REWARD, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10005

		var_3_1(var_3_0, var_2_10005.SENRANKAGURA_TRAIN_ACT_OP, arg_3_1)

		return
	end)

	return
end

function var_0_1.initNotificationHandleDic(arg_4_0)
	local var_4_0 = {}

	GAME = var_1_10002
	var_4_0[var_1_10002.SENRANKAGURA_TRAIN_ACT_OP_DONE] = function(arg_5_0, arg_5_1)
		local var_5_0 = arg_5_1:getBody()
		local var_5_1 = arg_5_0.viewComponent

		var_3.LevelUp(var_5_1, var_5_0)

		return
	end
	arg_4_0.handleDic = var_4_0

	return
end

return var_0_1
