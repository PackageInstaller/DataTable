local var_0_0 = class("TownSkinMediator", import("view.base.ContextMediator"))

var_0_0.UnlockStoryDone = "TownSkinMediator.UnlockStoryDone"

function var_0_0.register(arg_1_0)
	return
end

function var_0_0.listNotificationInterests(arg_2_0)
	return {
		var_0_0.UnlockStoryDone,
		ActivityProxy.ACTIVITY_UPDATED,
		GAME.ACTIVITY_STORYUNLOCKED_DONE
	}
end

function var_0_0.handleNotification(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1:getName()
	local var_3_1 = arg_3_1:getBody()

	if var_3_0 == GAME.ACTIVITY_STORYUNLOCKED_DONE then
		arg_3_0.viewComponent:UpdataStoryState(var_3_1)
	elseif var_3_0 == ActivityProxy.ACTIVITY_UPDATED and var_3_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_TownSkinStory then
		arg_3_0.viewComponent:UpdateItemView(var_3_1)
	end

	return
end

return var_0_0
