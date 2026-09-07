local SixthAnniversaryJPDarkMediator = class("SixthAnniversaryJPDarkMediator", import("view.base.ContextMediator"))

SixthAnniversaryJPDarkMediator.GO_SCENE = "GO_SCENE"
SixthAnniversaryJPDarkMediator.GO_SUBLAYER = "GO_SUBLAYER"

function SixthAnniversaryJPDarkMediator:register()
	self:BindEvent()

	return
end

function SixthAnniversaryJPDarkMediator:BindEvent()
	self:bind(SixthAnniversaryJPDarkMediator.GO_SCENE, function(arg_3_0, arg_3_1, ...)
		self:sendNotification(GAME.GO_SCENE, arg_3_1, ...)

		return
	end)
	self:bind(SixthAnniversaryJPDarkMediator.GO_SUBLAYER, function(arg_4_0, arg_4_1, arg_4_2)
		self:addSubLayers(arg_4_1, nil, arg_4_2)

		return
	end)

	return
end

function SixthAnniversaryJPDarkMediator:listNotificationInterests()
	return {
		ActivityProxy.ACTIVITY_UPDATED,
		GAME.SUBMIT_TASK_DONE
	}
end

function SixthAnniversaryJPDarkMediator:handleNotification(arg_6_1)
	local var_6_0 = arg_6_1:getName()

	if var_6_0 == ActivityProxy.ACTIVITY_UPDATED then
		if arg_6_1:getBody().id == ActivityConst.MINIGAME_ZUMA then
			self.viewComponent:UpdateLevels()
			self.viewComponent:UpdateCount()
		end
	elseif var_6_0 == GAME.SUBMIT_TASK_DONE then
		self.viewComponent:UpdateTaskTip()
	end

	return
end

return SixthAnniversaryJPDarkMediator
