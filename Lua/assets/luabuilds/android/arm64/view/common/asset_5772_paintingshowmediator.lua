local PaintingShowMediator = class("PaintingShowMediator", import("view.base.ContextMediator"))

function PaintingShowMediator:register()
	return
end

function PaintingShowMediator:listNotificationInterests()
	return {}
end

function PaintingShowMediator:handleNotification(arg_3_1)
	local var_3_0 = arg_3_1:getBody()

	if arg_3_1:getName() == nil then
		-- block empty
	end

	return
end

return PaintingShowMediator
