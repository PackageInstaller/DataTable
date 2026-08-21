local var_0_0 = class("NewSkinAtlasMediator", import("...base.ContextMediator"))

var_0_0.OPEN_SHOW_LAYER = "NewSkinAtlasMediator.OPEN_SHOW_LAYER"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.OPEN_SHOW_LAYER, function(arg_2_0, arg_2_1)
		arg_1_0:addSubLayers(Context.New({
			viewComponent = NewSkinShowLayer,
			mediator = NewSkinShowMediator,
			data = {
				skin = arg_2_1
			}
		}))

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_3_0)
	return {
		PlayerProxy.UPDATED
	}
end

function var_0_0.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getBody()

	if arg_4_1:getName() == PlayerProxy.UPDATED then
		arg_4_0.viewComponent:SetResource()
	end

	return
end

return var_0_0
