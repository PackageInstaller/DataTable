local var_0_0 = class("SenrankaguraTrainMediator", import("..base.ContextMediator"))

var_0_0.LEVEL_UP = "level up"
var_0_0.GET_REWARD = "get reward"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.LEVEL_UP, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(GAME.SENRANKAGURA_TRAIN_ACT_OP, arg_2_1)

		return
	end)
	arg_1_0:bind(var_0_0.GET_REWARD, function(arg_3_0, arg_3_1)
		arg_1_0:sendNotification(GAME.SENRANKAGURA_TRAIN_ACT_OP, arg_3_1)

		return
	end)

	return
end

function var_0_0.initNotificationHandleDic(arg_4_0)
	arg_4_0.handleDic = {
		[GAME.SENRANKAGURA_TRAIN_ACT_OP_DONE] = function(arg_5_0, arg_5_1)
			arg_5_0.viewComponent:LevelUp((arg_5_1:getBody()))

			return
		end
	}

	return
end

return var_0_0
