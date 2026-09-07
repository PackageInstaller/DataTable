local Dorm3dFurnitureSelectMediator = class("Dorm3dFurnitureSelectMediator", import("view.base.ContextMediator"))

Dorm3dFurnitureSelectMediator.SHOW_CONFIRM_WINDOW = "SHOW_CONFIRM_WINDOW"
Dorm3dFurnitureSelectMediator.SHOW_FURNITURE_ACESSES = "SHOW_FURNITURE_ACESSES"
Dorm3dFurnitureSelectMediator.OPEN_DROP_LAYER = "OPEN_DROP_LAYER"
Dorm3dFurnitureSelectMediator.SHOW_SHOPPING_CONFIRM_WINDOW = "SHOW_SHOPPING_CONFIRM_WINDOW"

function Dorm3dFurnitureSelectMediator:register()
	self:bind(GAME.APARTMENT_REPLACE_FURNITURE, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.APARTMENT_REPLACE_FURNITURE, arg_2_1)

		return
	end)
	self:bind(Dorm3dFurnitureSelectMediator.SHOW_CONFIRM_WINDOW, function(arg_3_0, arg_3_1)
		self:addSubLayers(Context.New({
			mediator = Dorm3dFurnitureConfirmWindowMediator,
			viewComponent = Dorm3dFurnitureConfirmWindow,
			data = arg_3_1
		}))

		return
	end)
	self:bind(Dorm3dFurnitureSelectMediator.SHOW_FURNITURE_ACESSES, function(arg_4_0, arg_4_1)
		self:addSubLayers(Context.New({
			mediator = Dorm3dFurnitureAcessesWindowMediator,
			viewComponent = Dorm3dFurnitureAcessesWindow,
			data = arg_4_1
		}))

		return
	end)
	self:bind(Dorm3dFurnitureSelectMediator.SHOW_SHOPPING_CONFIRM_WINDOW, function(arg_5_0, arg_5_1)
		self:addSubLayers(Context.New({
			mediator = Dorm3dShoppingConfirmWindowMediator,
			viewComponent = Dorm3dShoppingConfirmWindow,
			data = arg_5_1
		}))

		return
	end)
	self:bind(GAME.SHOPPING, function(arg_6_0, arg_6_1)
		self:sendNotification(GAME.SHOPPING, {
			id = arg_6_1.shopId,
			count = arg_6_1.count,
			silentTip = arg_6_1.silentTip
		})

		return
	end)
	self:bind(Dorm3dFurnitureSelectMediator.OPEN_DROP_LAYER, function(arg_7_0, arg_7_1, arg_7_2)
		self:addSubLayers(Context.New({
			viewComponent = Dorm3dAwardInfoLayer,
			mediator = Dorm3dAwardInfoMediator,
			data = {
				items = arg_7_1
			},
			onRemoved = arg_7_2
		}))

		return
	end)

	local var_1_0 = pg.m02:retrieveMediator(Dorm3dRoomMediator.__cname):getViewComponent()

	self.viewComponent:SetSceneRoot(var_1_0)
	self.viewComponent:SetRoom(var_1_0.room)

	return
end

function Dorm3dFurnitureSelectMediator:listNotificationInterests()
	return {
		Dorm3dRoomMediator.ON_CLICK_FURNITURE_SLOT,
		GAME.APARTMENT_REPLACE_FURNITURE_DONE,
		GAME.APARTMENT_REPLACE_FURNITURE_ERROR,
		GAME.SHOPPING_DONE
	}
end

function Dorm3dFurnitureSelectMediator:handleNotification(arg_9_1)
	local var_9_0 = arg_9_1:getName()

	if var_9_0 == ApartmentProxy.UPDATE_ROOM then
		-- block empty
	elseif var_9_0 == Dorm3dRoomMediator.ON_CLICK_FURNITURE_SLOT then
		-- block empty
	elseif var_9_0 == GAME.APARTMENT_REPLACE_FURNITURE_DONE then
		self.viewComponent:OnReplaceFurnitureDone()
	elseif var_9_0 == GAME.APARTMENT_REPLACE_FURNITURE_ERROR then
		self.viewComponent:OnReplaceFurnitureError()
	elseif var_9_0 == GAME.SHOPPING_DONE then
		if arg_9_1:getBody().awards and #arg_9_1:getBody().awards > 0 then
			self.viewComponent:emit(Dorm3dFurnitureSelectMediator.OPEN_DROP_LAYER, arg_9_1:getBody().awards, function()
				self.viewComponent.room:AddFurnitureByID(pg.shop_template[arg_9_1:getBody().id].effect_args[1])
				self.viewComponent:UpdateDataDisplayFurnitures()
				self.viewComponent:UpdateView()

				return
			end)
		end
	end

	return
end

function Dorm3dFurnitureSelectMediator:remove()
	return
end

return Dorm3dFurnitureSelectMediator
