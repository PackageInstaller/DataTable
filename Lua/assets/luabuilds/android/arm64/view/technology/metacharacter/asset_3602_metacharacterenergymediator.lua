local MetaCharacterEnergyMediator = class("MetaCharacterEnergyMediator", import("...base.ContextMediator"))

MetaCharacterEnergyMediator.ON_ACTIVATION = "MetaCharacterEnergyMediator:ON_ACTIVATION"
MetaCharacterEnergyMediator.ON_PREVIEW = "MetaCharacterEnergyMediator:ON_PREVIEW"

function MetaCharacterEnergyMediator:register()
	self:bind(MetaCharacterEnergyMediator.ON_ACTIVATION, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.ENERGY_META_ACTIVATION, {
			shipId = arg_2_1
		})

		return
	end)
	self:bind(MetaCharacterEnergyMediator.ON_PREVIEW, function(arg_3_0, arg_3_1, arg_3_2)
		self:addSubLayers(Context.New({
			viewComponent = ShipPreviewLayer,
			mediator = ShipPreviewMediator,
			data = {
				equipSkinId = 0,
				shipVO = arg_3_1,
				weaponIds = arg_3_2
			}
		}))

		return
	end)

	return
end

function MetaCharacterEnergyMediator:listNotificationInterests()
	return {
		GAME.ENERGY_META_ACTIVATION_DONE,
		BayProxy.SHIP_UPDATED,
		BagProxy.ITEM_UPDATED
	}
end

function MetaCharacterEnergyMediator:handleNotification(arg_5_1)
	local var_5_0 = arg_5_1:getBody()

	if arg_5_1:getName() == GAME.ENERGY_META_ACTIVATION_DONE then
		self:addSubLayers(Context.New({
			viewComponent = ShipBreakResultLayer,
			mediator = ShipBreakResultMediator,
			data = {
				newShip = var_5_0.newShip,
				oldShip = var_5_0.oldShip
			}
		}))
		self.viewComponent:updateData()
		self.viewComponent:updateNamePanel()
		self.viewComponent:updateAttrPanel()
		self.viewComponent:updateMaterialPanel()
		self.viewComponent:initPreviewPanel()
	end

	return
end

return MetaCharacterEnergyMediator
