class = var_0_10000

local var_0_0 = "LoveLetterDisplayMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

var_0_1.ON_UNLOCK_LETTER = "LoveLetterDisplayMediator.ON_UNLOCK_LETTER"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_UNLOCK_LETTER, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10005

		var_2_1(var_2_0, var_2_10005.UNLOCK_LOVE_LETTER, {
			id = arg_2_1
		})

		return
	end)

	local var_1_0 = arg_1_0.viewComponent

	var_1.SetLoveLetter(var_1_0, arg_1_0.contextData.groupId)

	return
end

function var_0_1.initNotificationHandleDic(arg_3_0)
	local var_3_0 = {}

	GAME = var_1_10002
	var_3_0[var_1_10002.UNLOCK_LOVE_LETTER_DONE] = function(arg_4_0, arg_4_1)
		local var_4_0 = arg_4_0.viewComponent

		var_2.DoOpenLetter(var_4_0)

		return
	end
	arg_3_0.handleDic = var_3_0

	return
end

return var_0_1
