local SailingShip3SkinMediator = class("SailingShip3SkinMediator", import("view.base.ContextMediator"))

SailingShip3SkinMediator.ON_TASK_SUBMIT = "SailingShip3SkinMediator.eventOnTaskSubmit"
SailingShip3SkinMediator.ON_TASK_GO = "SailingShip3SkinMediator.eventOnTaskGo"

function SailingShip3SkinMediator:register()
	self:bind(SailingShip3SkinMediator.ON_TASK_SUBMIT, function(arg_2_0, arg_2_1, arg_2_2)
		self:sendNotification(GAME.SUBMIT_TASK, arg_2_1.id, arg_2_2)

		return
	end)
	self:bind(SailingShip3SkinMediator.ON_TASK_GO, function(arg_3_0, arg_3_1)
		self:sendNotification(GAME.TASK_GO, {
			taskVO = arg_3_1
		})

		return
	end)

	return
end

function SailingShip3SkinMediator:listNotificationInterests()
	return {
		ActivityProxy.ACTIVITY_UPDATED,
		GAME.SUBMIT_TASK_DONE,
		GAME.SUBMIT_ACTIVITY_TASK_DONE,
		GAME.ACTIVITY_STORYUNLOCKED_DONE
	}
end

function SailingShip3SkinMediator:handleNotification(arg_5_1)
	local var_5_0 = arg_5_1:getName()
	local var_5_1 = arg_5_1:getBody()

	if var_5_0 == GAME.ACTIVITY_STORYUNLOCKED_DONE then
		self.viewComponent:UpdataStoryState(var_5_1)
	elseif var_5_0 == ActivityProxy.ACTIVITY_UPDATED then
		if var_5_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_TownSkinStory then
			self.viewComponent:UpdateItemView(var_5_1)
		end
	elseif var_5_0 == GAME.SUBMIT_ACTIVITY_TASK_DONE then
		self.viewComponent:OnUpdateFlush(var_5_1)
		self.viewComponent:DisplayBigTask()
	end

	return
end

return SailingShip3SkinMediator
