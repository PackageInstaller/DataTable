local var_0_0 = class("AtelierStoreBaseMediator", import("view.base.ContextMediator"))

function var_0_0.register(arg_1_0)
	arg_1_0:bind(AtelierMaterialDetailMediator.SHOW_DETAIL, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_2_1:GetVersion() == 1 and AtelierMaterialDetailLayer or AtelierMaterialDetailYumiaLayer

		arg_1_0:addSubLayers(Context.New({
			mediator = AtelierMaterialDetailMediator,
			viewComponent = var_2_0,
			data = {
				material = arg_2_1
			}
		}))

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_3_0)
	return {
		AtelierCompositeMediator.OPEN_FORMULA
	}
end

function var_0_0.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getBody()

	if arg_4_1:getName() == AtelierCompositeMediator.OPEN_FORMULA then
		arg_4_0.viewComponent:closeView()
	end

	return
end

return var_0_0
