class = var_0_10000

local var_0_0 = "Dorm3dPhotoSelectFrameMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

var_0_1.CONFIRMFRAME = "Dorm3dPhotoSelectFrameMediator:CONFIRMFRAME"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.CONFIRMFRAME, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
		local var_2_0 = arg_1_0

		var_5.sendNotification(var_2_0, var_0_1.CONFIRMFRAME, {
			selectFrameId = arg_2_1,
			imagePos = arg_2_2,
			imageScale = arg_2_3,
			specialPosDic = arg_2_4
		})

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_3_0)
	return {}
end

function var_0_1.remove(arg_4_0)
	return
end

return var_0_1
