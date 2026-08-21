local var_0_0 = class("SailingShip3SkinMediator", import("view.base.ContextMediator"))

var_0_0.ON_TASK_SUBMIT = "SailingShip3SkinMediator.eventOnTaskSubmit"
var_0_0.ON_TASK_GO = "SailingShip3SkinMediator.eventOnTaskGo"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.ON_TASK_SUBMIT, function(arg_2_0, arg_2_1, arg_2_2)
		arg_1_0:sendNotification(GAME.SUBMIT_TASK, arg_2_1.id, arg_2_2)

		return
	end)
	arg_1_0:bind(var_0_0.ON_TASK_GO, function(arg_3_0, arg_3_1)
		arg_1_0:sendNotification(GAME.TASK_GO, {
			taskVO = arg_3_1
		})

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_4_0)
	return {
		ActivityProxy.ACTIVITY_UPDATED,
		GAME.SUBMIT_TASK_DONE,
		GAME.SUBMIT_ACTIVITY_TASK_DONE,
		GAME.ACTIVITY_STORYUNLOCKED_DONE
	}
end

function var_0_0.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:getName()
	local var_5_1 = arg_5_1:getBody()

	if var_5_0 == GAME.ACTIVITY_STORYUNLOCKED_DONE then
		arg_5_0.viewComponent:UpdataStoryState(var_5_1)
	elseif var_5_0 == ActivityProxy.ACTIVITY_UPDATED then
		if var_5_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_TownSkinStory then
			arg_5_0.viewComponent:UpdateItemView(var_5_1)
		end
	elseif var_5_0 == GAME.SUBMIT_ACTIVITY_TASK_DONE then
		arg_5_0.viewComponent:OnUpdateFlush(var_5_1)
		arg_5_0.viewComponent:DisplayBigTask()
	end

	return
end

return var_0_0
