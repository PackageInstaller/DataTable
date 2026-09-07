local CityRebuildStoryMediator = class("CityRebuildStoryMediator", import("view.base.ContextMediator"))

function CityRebuildStoryMediator:register()
	return
end

function CityRebuildStoryMediator:listNotificationInterests()
	return {}
end

function CityRebuildStoryMediator:handleNotification(arg_3_1)
	local var_3_0 = arg_3_1:getName()
	local var_3_1 = arg_3_1:getBody()

	return
end

return CityRebuildStoryMediator
