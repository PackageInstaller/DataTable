class = var_0_10000

local var_0_0 = "Dorm3dCollectionMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

var_0_1.DO_TALK = "Dorm3dCollectionMediator.DO_TALK"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.DO_TALK, function(arg_2_0, arg_2_1, arg_2_2)
		local var_2_0 = arg_1_0
		local var_2_1 = var_3.sendNotification

		Dorm3dRoomMediator = var_2_10006

		var_2_1(var_2_0, var_2_10006.OTHER_DO_TALK, {
			isReplay = true,
			talkId = arg_2_1,
			callback = arg_2_2
		})

		local var_2_2 = arg_1_0.viewComponent

		var_3.closeView(var_2_2)

		return
	end)

	local var_1_0 = arg_1_0.viewComponent

	var_1.SetRoom(var_1_0, arg_1_0.contextData.roomId)

	return
end

function var_0_1.initNotificationHandleDic(arg_3_0)
	arg_3_0.handleDic = {}

	return
end

function var_0_1.remove(arg_4_0)
	return
end

return var_0_1
