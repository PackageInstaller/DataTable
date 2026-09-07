local AtelierStoreBaseMediator = class("AtelierStoreBaseMediator", import("view.base.ContextMediator"))

function AtelierStoreBaseMediator:register()
	self:bind(AtelierMaterialDetailMediator.SHOW_DETAIL, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_2_1:GetVersion() == 1 and AtelierMaterialDetailLayer or AtelierMaterialDetailYumiaLayer

		self:addSubLayers(Context.New({
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

function AtelierStoreBaseMediator:listNotificationInterests()
	return {
		AtelierCompositeMediator.OPEN_FORMULA
	}
end

function AtelierStoreBaseMediator:handleNotification(arg_4_1)
	local var_4_0 = arg_4_1:getBody()

	if arg_4_1:getName() == AtelierCompositeMediator.OPEN_FORMULA then
		self.viewComponent:closeView()
	end

	return
end

return AtelierStoreBaseMediator
