local var_0_0 = class("Dorm3dFurnitureSelectMediator", import("view.base.ContextMediator"))

var_0_0.SHOW_CONFIRM_WINDOW = "SHOW_CONFIRM_WINDOW"
var_0_0.SHOW_FURNITURE_ACESSES = "SHOW_FURNITURE_ACESSES"
var_0_0.OPEN_DROP_LAYER = "OPEN_DROP_LAYER"
var_0_0.SHOW_SHOPPING_CONFIRM_WINDOW = "SHOW_SHOPPING_CONFIRM_WINDOW"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(GAME.APARTMENT_REPLACE_FURNITURE, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(GAME.APARTMENT_REPLACE_FURNITURE, arg_2_1)

		return
	end)
	arg_1_0:bind(var_0_0.SHOW_CONFIRM_WINDOW, function(arg_3_0, arg_3_1)
		arg_1_0:addSubLayers(Context.New({
			mediator = Dorm3dFurnitureConfirmWindowMediator,
			viewComponent = Dorm3dFurnitureConfirmWindow,
			data = arg_3_1
		}))

		return
	end)
	arg_1_0:bind(var_0_0.SHOW_FURNITURE_ACESSES, function(arg_4_0, arg_4_1)
		arg_1_0:addSubLayers(Context.New({
			mediator = Dorm3dFurnitureAcessesWindowMediator,
			viewComponent = Dorm3dFurnitureAcessesWindow,
			data = arg_4_1
		}))

		return
	end)
	arg_1_0:bind(var_0_0.SHOW_SHOPPING_CONFIRM_WINDOW, function(arg_5_0, arg_5_1)
		arg_1_0:addSubLayers(Context.New({
			mediator = Dorm3dShoppingConfirmWindowMediator,
			viewComponent = Dorm3dShoppingConfirmWindow,
			data = arg_5_1
		}))

		return
	end)
	arg_1_0:bind(GAME.SHOPPING, function(arg_6_0, arg_6_1)
		arg_1_0:sendNotification(GAME.SHOPPING, {
			id = arg_6_1.shopId,
			count = arg_6_1.count,
			silentTip = arg_6_1.silentTip
		})

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_DROP_LAYER, function(arg_7_0, arg_7_1, arg_7_2)
		arg_1_0:addSubLayers(Context.New({
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

	arg_1_0.viewComponent:SetSceneRoot(var_1_0)
	arg_1_0.viewComponent:SetRoom(var_1_0.room)

	return
end

function var_0_0.listNotificationInterests(arg_8_0)
	return {
		Dorm3dRoomMediator.ON_CLICK_FURNITURE_SLOT,
		GAME.APARTMENT_REPLACE_FURNITURE_DONE,
		GAME.APARTMENT_REPLACE_FURNITURE_ERROR,
		GAME.SHOPPING_DONE
	}
end

function var_0_0.handleNotification(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1:getName()
	local var_9_1 = arg_9_1:getBody()

	if var_9_0 == ApartmentProxy.UPDATE_ROOM then
		-- block empty
	elseif var_9_0 == Dorm3dRoomMediator.ON_CLICK_FURNITURE_SLOT then
		-- block empty
	elseif var_9_0 == GAME.APARTMENT_REPLACE_FURNITURE_DONE then
		arg_9_0.viewComponent:OnReplaceFurnitureDone()
	elseif var_9_0 == GAME.APARTMENT_REPLACE_FURNITURE_ERROR then
		arg_9_0.viewComponent:OnReplaceFurnitureError()
	elseif var_9_0 == GAME.SHOPPING_DONE then
		if var_9_1.awards and #var_9_1.awards > 0 then
			arg_9_0.viewComponent:emit(var_0_0.OPEN_DROP_LAYER, var_9_1.awards, function()
				arg_9_0.viewComponent.room:AddFurnitureByID(pg.shop_template[arg_9_1:getBody().id].effect_args[1])
				arg_9_0.viewComponent:UpdateDataDisplayFurnitures()
				arg_9_0.viewComponent:UpdateView()

				return
			end)
		end
	end

	return
end

function var_0_0.remove(arg_11_0)
	return
end

return var_0_0
