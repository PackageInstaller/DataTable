local EducateScheduleMediator = class("EducateScheduleMediator", import(".base.EducateContextMediator"))

EducateScheduleMediator.GET_PLANS = "GET_PLANS"
EducateScheduleMediator.OPEN_FILTER_LAYER = "OPEN_FILTER_LAYER"

function EducateScheduleMediator:register()
	self:bind(EducateScheduleMediator.GET_PLANS, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.EDUCATE_GET_PLANS, {
			plans = EducatePlanProxy.GridData2ProtData(arg_2_1.gridData),
			isSkip = arg_2_1.isSkip,
			isSkipEvent = arg_2_1.isSkipEvent,
			callback = function()
				return
			end
		})

		return
	end)
	self:bind(EducateScheduleMediator.OPEN_FILTER_LAYER, function(arg_4_0, arg_4_1)
		self:addSubLayers(Context.New({
			viewComponent = EducateScheduleFilterLayer,
			mediator = EducateScheduleFilterMediator,
			data = arg_4_1
		}))

		return
	end)

	return
end

function EducateScheduleMediator:listNotificationInterests()
	return {
		GAME.EDUCATE_REFRESH_DONE
	}
end

function EducateScheduleMediator:handleNotification(arg_6_1)
	local var_6_0 = arg_6_1:getBody()

	if arg_6_1:getName() == GAME.EDUCATE_REFRESH_DONE then
		self.viewComponent:emit(EducateBaseUI.EDUCATE_CHANGE_SCENE, SCENE.EDUCATE)
	end

	return
end

return EducateScheduleMediator
