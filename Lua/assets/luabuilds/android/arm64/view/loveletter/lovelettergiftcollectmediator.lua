local var_0_0 = class("LoveLetterGiftCollectMediator", import("view.base.ContextMediator"))

var_0_0.ON_RECORD_GIFT = "LoveLetterGiftCollectMediator.ON_RECORD_GIFT"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.ON_RECORD_GIFT, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(GAME.REALIZE_LOVE_LETTER_GIFT, {
			list = arg_2_1
		})

		return
	end)

	return
end

function var_0_0.initNotificationHandleDic(arg_3_0)
	arg_3_0.handleDic = {
		[GAME.REALIZE_LOVE_LETTER_GIFT_DONE] = function(arg_4_0, arg_4_1)
			arg_4_0.viewComponent:closeView()

			return
		end
	}

	return
end

return var_0_0
