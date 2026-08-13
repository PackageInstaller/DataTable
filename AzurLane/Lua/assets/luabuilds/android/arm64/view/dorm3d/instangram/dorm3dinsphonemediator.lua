class = var_0_10000

local var_0_0 = "Dorm3dInsPhoneMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

var_0_1.ON_DORM = "Dorm3dInsPhoneMediator.ON_DORM"
var_0_1.MARK_READ = "Dorm3dInsPhoneMediator.MARK_READ"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_DORM, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10005

		local var_2_2 = var_2_10005.GO_SCENE

		SCENE = var_2_10006

		var_2_1(var_2_0, var_2_2, var_2_10006.DORM3D_ROOM, {
			isVideoTalk = true,
			roomId = arg_2_1.roomId,
			groupIds = arg_2_1.groupIds,
			specialId = arg_2_1.specialId
		})

		return
	end)
	arg_1_0:bind(var_0_1.MARK_READ, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10005

		var_3_1(var_3_0, var_2_10005.DORM3D_INS_PHONE_OP, {
			groupId = arg_3_1.groupId,
			id = arg_3_1.id
		})

		return
	end)

	return
end

function var_0_1.initNotificationHandleDic(arg_4_0)
	local var_4_0 = {}

	GAME = var_1_10002
	var_4_0[var_1_10002.DORM3D_INS_PHONE_OP_DONE] = function(arg_5_0)
		local var_5_0 = arg_4_0.viewComponent

		var_1.Flush(var_5_0)

		return
	end
	arg_4_0.handleDic = var_4_0

	return
end

return var_0_1
