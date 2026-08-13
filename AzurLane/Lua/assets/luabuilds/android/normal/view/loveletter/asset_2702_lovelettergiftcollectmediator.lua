class = var_0_10000

local var_0_0 = "LoveLetterGiftCollectMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

var_0_1.ON_RECORD_GIFT = "LoveLetterGiftCollectMediator.ON_RECORD_GIFT"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_RECORD_GIFT, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10004

		var_2_1(var_2_0, var_2_10004.REALIZE_LOVE_LETTER_GIFT, {
			list = arg_2_1
		})

		return
	end)

	return
end

function var_0_1.initNotificationHandleDic(arg_3_0)
	local var_3_0 = {}

	GAME = var_1_10002
	var_3_0[var_1_10002.REALIZE_LOVE_LETTER_GIFT_DONE] = function(arg_4_0, arg_4_1)
		local var_4_0 = arg_4_0.viewComponent

		var_2.closeView(var_4_0)

		return
	end
	arg_3_0.handleDic = var_3_0

	return
end

return var_0_1
