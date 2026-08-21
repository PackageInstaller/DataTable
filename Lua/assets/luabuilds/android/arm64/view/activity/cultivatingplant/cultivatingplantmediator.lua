local var_0_0 = class("CultivatingPlantMediator", import("view.base.ContextMediator"))

var_0_0.GO_SCENE = "CultivatingPlantMediator::GO_SCENE"
var_0_0.ON_TASK_SUBMIT = "CultivatingPlantMediator::ON_TASK_SUBMIT"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.GO_SCENE, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.NEW_EDUCATE_SELECT)

		return
	end)
	arg_1_0:bind(var_0_0.ON_TASK_SUBMIT, function(arg_3_0, arg_3_1)
		arg_1_0:sendNotification(GAME.SUBMIT_TASK_V2, arg_3_1.id)

		return
	end)

	return
end

function var_0_0.initNotificationHandleDic(arg_4_0)
	arg_4_0.handleDic = {
		[GAME.SUBMIT_ACTIVITY_TASK_V2_DONE] = function(arg_5_0, arg_5_1)
			arg_5_0.viewComponent:RefreshSubmitTaskDone()

			return
		end
	}

	return
end

function var_0_0.remove(arg_6_0)
	return
end

return var_0_0
