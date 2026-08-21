local var_0_0 = class("Dorm3dPhotoSelectFrameMediator", import("view.base.ContextMediator"))

var_0_0.CONFIRMFRAME = "Dorm3dPhotoSelectFrameMediator:CONFIRMFRAME"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.CONFIRMFRAME, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
		arg_1_0:sendNotification(var_0_0.CONFIRMFRAME, {
			selectFrameId = arg_2_1,
			imagePos = arg_2_2,
			imageScale = arg_2_3,
			specialPosDic = arg_2_4
		})

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_3_0)
	return {}
end

function var_0_0.remove(arg_4_0)
	return
end

return var_0_0
