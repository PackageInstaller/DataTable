local var_0_0 = class("SkinAtlasMediator", import("...base.ContextMediator"))

var_0_0.OPEN_INDEX = "SkinAtlasMediator:OPEN_INDEX"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.OPEN_INDEX, function(arg_2_0, arg_2_1)
		arg_1_0:addSubLayers(Context.New({
			viewComponent = SkinAtlasIndexLayer,
			mediator = CustomIndexMediator,
			data = arg_2_1
		}))

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_3_0)
	return {
		SetShipSkinCommand.SKIN_UPDATED
	}
end

function var_0_0.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getBody()

	if arg_4_1:getName() == SetShipSkinCommand.SKIN_UPDATED then
		arg_4_0.viewComponent:UpdateSkinCards()
	end

	return
end

return var_0_0
