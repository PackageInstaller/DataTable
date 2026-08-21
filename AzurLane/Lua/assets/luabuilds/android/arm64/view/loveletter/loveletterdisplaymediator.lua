local var_0_0 = class("LoveLetterDisplayMediator", import("view.base.ContextMediator"))

var_0_0.ON_UNLOCK_LETTER = "LoveLetterDisplayMediator.ON_UNLOCK_LETTER"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.ON_UNLOCK_LETTER, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(GAME.UNLOCK_LOVE_LETTER, {
			id = arg_2_1
		})

		return
	end)
	arg_1_0.viewComponent:SetLoveLetter(arg_1_0.contextData.groupId)

	return
end

function var_0_0.initNotificationHandleDic(arg_3_0)
	arg_3_0.handleDic = {
		[GAME.UNLOCK_LOVE_LETTER_DONE] = function(arg_4_0, arg_4_1)
			arg_4_0.viewComponent:DoOpenLetter()

			return
		end
	}

	return
end

return var_0_0
