local TownSkinMediator = class("TownSkinMediator", import("view.base.ContextMediator"))

TownSkinMediator.UnlockStoryDone = "TownSkinMediator.UnlockStoryDone"

function TownSkinMediator:register()
	return
end

function TownSkinMediator:listNotificationInterests()
	return {
		TownSkinMediator.UnlockStoryDone,
		ActivityProxy.ACTIVITY_UPDATED,
		GAME.ACTIVITY_STORYUNLOCKED_DONE
	}
end

function TownSkinMediator:handleNotification(arg_3_1)
	local var_3_0 = arg_3_1:getName()
	local var_3_1 = arg_3_1:getBody()

	if var_3_0 == GAME.ACTIVITY_STORYUNLOCKED_DONE then
		self.viewComponent:UpdataStoryState(var_3_1)
	elseif var_3_0 == ActivityProxy.ACTIVITY_UPDATED and var_3_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_TownSkinStory then
		self.viewComponent:UpdateItemView(var_3_1)
	end

	return
end

return TownSkinMediator
