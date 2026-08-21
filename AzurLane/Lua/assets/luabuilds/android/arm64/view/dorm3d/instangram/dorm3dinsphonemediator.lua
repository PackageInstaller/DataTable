local var_0_0 = class("Dorm3dInsPhoneMediator", import("view.base.ContextMediator"))

var_0_0.ON_DORM = "Dorm3dInsPhoneMediator.ON_DORM"
var_0_0.MARK_READ = "Dorm3dInsPhoneMediator.MARK_READ"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.ON_DORM, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.DORM3D_ROOM, {
			isVideoTalk = true,
			roomId = arg_2_1.roomId,
			groupIds = arg_2_1.groupIds,
			specialId = arg_2_1.specialId
		})

		return
	end)
	arg_1_0:bind(var_0_0.MARK_READ, function(arg_3_0, arg_3_1)
		arg_1_0:sendNotification(GAME.DORM3D_INS_PHONE_OP, {
			groupId = arg_3_1.groupId,
			id = arg_3_1.id
		})

		return
	end)

	return
end

function var_0_0.initNotificationHandleDic(arg_4_0)
	arg_4_0.handleDic = {
		[GAME.DORM3D_INS_PHONE_OP_DONE] = function(arg_5_0)
			arg_4_0.viewComponent:Flush()

			return
		end
	}

	return
end

return var_0_0
