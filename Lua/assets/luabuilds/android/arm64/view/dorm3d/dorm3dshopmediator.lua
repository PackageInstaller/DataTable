local var_0_0 = class("Dorm3dShopMediator", import("view.base.ContextMediator"))

var_0_0.OPEN_DETAIL = "Dorm3dShopMediator.OPEN_DETAIL"
var_0_0.SHOW_SHOPPING_CONFIRM_WINDOW = "Dorm3dShopMediator.SHOW_SHOPPING_CONFIRM_WINDOW"
var_0_0.OPEN_ROOM_UNLOCK_WINDOW = "Dorm3dShopMediator.OPEN_ROOM_UNLOCK_WINDOW"
var_0_0.OPEN_DROP_LAYER = "Dorm3dShopMediator.OPEN_DROP_LAYER"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.OPEN_DETAIL, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		arg_1_0:addSubLayers(Context.New({
			viewComponent = Dorm3dShopDetailWindow,
			mediator = Dorm3dShopDetailMediator,
			data = {
				shopCfg = arg_2_1,
				groupId = arg_2_2,
				changeCount = arg_2_3
			}
		}))

		return
	end)
	arg_1_0:bind(var_0_0.SHOW_SHOPPING_CONFIRM_WINDOW, function(arg_3_0, arg_3_1)
		arg_1_0:addSubLayers(Context.New({
			viewComponent = Dorm3dShoppingConfirmWindow,
			mediator = Dorm3dShoppingConfirmWindowMediator,
			data = arg_3_1
		}))

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_ROOM_UNLOCK_WINDOW, function(arg_4_0, arg_4_1, arg_4_2)
		arg_1_0:addSubLayers(Context.New({
			viewComponent = Dorm3dRoomUnlockWindow,
			mediator = Dorm3dRoomUnlockWindowMediator,
			data = {
				roomId = arg_4_1,
				groupId = arg_4_2
			}
		}))

		return
	end)
	arg_1_0:bind(GAME.SHOPPING, function(arg_5_0, arg_5_1)
		arg_1_0:sendNotification(GAME.SHOPPING, {
			id = arg_5_1.shopId,
			count = arg_5_1.count,
			silentTip = arg_5_1.silentTip
		})

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_DROP_LAYER, function(arg_6_0, arg_6_1, arg_6_2)
		arg_1_0:addSubLayers(Context.New({
			viewComponent = Dorm3dAwardInfoLayer,
			mediator = Dorm3dAwardInfoMediator,
			data = {
				items = arg_6_1
			},
			onRemoved = arg_6_2
		}))

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_7_0)
	return {
		PlayerProxy.UPDATED,
		GAME.SHOPPING_DONE,
		GAME.APARTMENT_ROOM_INVITE_UNLOCK_DONE
	}
end

function var_0_0.handleNotification(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1:getName()
	local var_8_1 = arg_8_1:getBody()

	if var_8_0 == PlayerProxy.UPDATED then
		arg_8_0.viewComponent:ShowResUI()
	elseif var_8_0 == GAME.SHOPPING_DONE then
		local var_8_2 = arg_8_1:getBody().awards

		for iter_8_0, iter_8_1 in ipairs(var_8_2) do
			iter_8_1.count = arg_8_0.viewComponent.showCount
		end

		if var_8_2 and #var_8_2 > 0 then
			arg_8_0.viewComponent:emit(var_0_0.OPEN_DROP_LAYER, var_8_2, function()
				return
			end)
		end

		arg_8_0.viewComponent:SetPageBtns()
		arg_8_0.viewComponent:RefreshPage()
	elseif var_8_0 == GAME.APARTMENT_ROOM_INVITE_UNLOCK_DONE then
		arg_8_0.viewComponent:SetPageBtns()
		arg_8_0.viewComponent:RefreshPage()
	end

	return
end

return var_0_0
