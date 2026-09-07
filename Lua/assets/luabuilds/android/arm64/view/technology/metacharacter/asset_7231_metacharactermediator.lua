local MetaCharacterMediator = class("MetaCharacterMediator", import("...base.ContextMediator"))

MetaCharacterMediator.OPEN_PT_PREVIEW_LAYER = "MetaCharacterMediator:OPEN_PT_PREVIEW_LAYER"
MetaCharacterMediator.OPEN_PT_GET_WAY_LAYER = "MetaCharacterMediator:OPEN_PT_GET_WAY_LAYER"
MetaCharacterMediator.OPEN_INDEX_LAYER = "MetaCharacterMediator:OPEN_INDEX_LAYER"
MetaCharacterMediator.ON_REPAIR = "MetaCharacterMediator:ON_REPAIR"
MetaCharacterMediator.ON_ENERGY = "MetaCharacterMediator:ON_ENERGY"
MetaCharacterMediator.ON_TACTICS = "MetaCharacterMediator:ON_TACTICS"
MetaCharacterMediator.ON_SYN = "MetaCharacterMediator:ON_SYN"
MetaCharacterMediator.ON_UNLOCK = "MetaCharacterMediator:ON_UNLOCK"

function MetaCharacterMediator:register()
	self:bind(MetaCharacterMediator.OPEN_PT_PREVIEW_LAYER, function(arg_2_0, arg_2_1)
		self:addSubLayers(Context.New({
			viewComponent = MetaPTAwardPreviewLayer,
			mediator = MetaPTAwardPreviewMediator,
			data = {
				metaProgressVO = arg_2_1
			}
		}))

		return
	end)
	self:bind(MetaCharacterMediator.OPEN_PT_GET_WAY_LAYER, function(arg_3_0)
		self:addSubLayers(Context.New({
			viewComponent = MetaPTGetPreviewLayer,
			mediator = MetaPTGetPreviewMediator,
			data = {}
		}))

		return
	end)
	self:bind(MetaCharacterMediator.OPEN_INDEX_LAYER, function(arg_4_0, arg_4_1)
		self:addSubLayers(Context.New({
			viewComponent = CustomIndexLayer,
			mediator = CustomIndexMediator,
			data = arg_4_1
		}))

		return
	end)
	self:bind(MetaCharacterMediator.ON_REPAIR, function(arg_5_0, arg_5_1, arg_5_2)
		self:enbalePage(Context.New({
			viewComponent = MetaCharacterRepairLayer,
			mediator = MetaCharacterRepairMediator,
			data = {
				shipID = arg_5_1,
				groupName = self.viewComponent:getGroupName()
			},
			onRemoved = function()
				self.viewComponent:enterMenuPage(false)

				self.viewComponent.curPageIndex = nil

				self.viewComponent:resetToggleList()
				self.viewComponent:refreshBannerTF()
				self.viewComponent:updateRedPoints()

				return
			end
		}), arg_5_2)

		return
	end)
	self:bind(MetaCharacterMediator.ON_ENERGY, function(arg_7_0, arg_7_1, arg_7_2)
		local var_7_0 = self.viewComponent.isMainOpenLayerTag and true or nil

		self.viewComponent.isMainOpenLayerTag = nil

		self:enbalePage(Context.New({
			viewComponent = MetaCharacterEnergyLayer,
			mediator = MetaCharacterEnergyMediator,
			data = {
				shipID = arg_7_1,
				groupName = self.viewComponent:getGroupName(),
				isMainOpen = var_7_0
			},
			onRemoved = function()
				self.viewComponent:enterMenuPage(false)

				self.viewComponent.curPageIndex = nil

				self.viewComponent:resetToggleList()
				self.viewComponent:refreshBannerTF()
				self.viewComponent:updateRedPoints()

				return
			end
		}), arg_7_2)

		return
	end)
	self:bind(MetaCharacterMediator.ON_TACTICS, function(arg_9_0, arg_9_1, arg_9_2)
		local var_9_0 = self.viewComponent.isMainOpenLayerTag and true or nil

		self.viewComponent.isMainOpenLayerTag = nil

		self:enbalePage(Context.New({
			viewComponent = MetaCharacterTacticsLayer,
			mediator = MetaCharacterTacticsMediator,
			data = {
				shipID = arg_9_1,
				groupName = self.viewComponent:getGroupName(),
				isMainOpen = var_9_0
			},
			onRemoved = function()
				if self.contextData.isFromNavalMeta == true then
					self.viewComponent:closeView()

					self.contextData.isFromNavalMeta = nil
				else
					self.viewComponent:enterMenuPage(false)

					self.viewComponent.curPageIndex = nil

					self.viewComponent:resetToggleList()
					self.viewComponent:updateRedPoints()
				end

				return
			end
		}), arg_9_2)

		return
	end)
	self:bind(MetaCharacterMediator.ON_SYN, function(arg_11_0, arg_11_1, arg_11_2)
		local var_11_0 = self.viewComponent.isMainOpenLayerTag and true or nil

		self.viewComponent.isMainOpenLayerTag = nil

		self:enbalePage(Context.New({
			viewComponent = MetaCharacterSynLayer,
			mediator = MetaCharacterSynMediator,
			data = {
				shipID = arg_11_1,
				groupName = self.viewComponent:getGroupName(),
				isMainOpen = var_11_0
			},
			onRemoved = function()
				self.viewComponent:enterMenuPage(false)

				self.viewComponent.curPageIndex = nil

				self.viewComponent:resetToggleList()
				self.viewComponent:updateRedPoints()

				return
			end
		}), arg_11_2)

		return
	end)

	return
end

function MetaCharacterMediator:enbalePage(arg_13_1, arg_13_2)
	if arg_13_2 then
		self:addSubLayers(arg_13_1)
	else
		local var_13_0 = getProxy(ContextProxy):getContextByMediator(arg_13_1.mediator)

		if var_13_0 then
			self:sendNotification(GAME.REMOVE_LAYERS, {
				context = var_13_0
			})
		end
	end

	return
end

function MetaCharacterMediator:listNotificationInterests()
	return {
		GAME.ACT_NEW_PT_DONE,
		BayProxy.SHIP_ADDED,
		GAME.GET_META_PT_AWARD_DONE
	}
end

function MetaCharacterMediator:handleNotification(arg_15_1)
	local var_15_0 = arg_15_1:getName()
	local var_15_1 = arg_15_1:getBody()

	if var_15_0 == BayProxy.SHIP_ADDED then
		local var_15_2 = self.viewComponent:getCurMetaProgressVO()

		var_15_2:updateDataAfterAddShip()

		if var_15_2:isPassType() or var_15_2:isBuildType() then
			self.viewComponent:refreshBannerTF()
			self.viewComponent:updateMain()
		end
	elseif var_15_0 == GAME.GET_META_PT_AWARD_DONE then
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_15_1.awards, function()
			if var_15_1.callback then
				var_15_1.callback()
			end

			self.viewComponent:refreshBannerTF()
			self.viewComponent:updateMain(true)

			return
		end)
	end

	return
end

return MetaCharacterMediator
