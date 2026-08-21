local var_0_0 = class("Dorm3dGiftMediator", import("view.base.ContextMediator"))

var_0_0.GIVE_GIFT = "Dorm3dGiftMediator.GIVE_GIFT"
var_0_0.DO_TALK = "Dorm3dGiftMediator.DO_TALK"
var_0_0.CHECK_LEVEL_UP = "Dorm3dGiftMediator.CHECK_LEVEL_UP"
var_0_0.OPEN_DROP_LAYER = "Dorm3dGiftMediator.OPEN_DROP_LAYER"
var_0_0.SHOW_SHOPPING_CONFIRM_WINDOW = "Dorm3dGiftMediator.SHOW_SHOPPING_CONFIRM_WINDOW"
var_0_0.FAVOR_LEVEL_UP = "Dorm3dGiftMediator.FAVOR_LEVEL_UP"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.FAVOR_LEVEL_UP, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(GAME.APARTMENT_LEVEL_UP, {
			groupId = arg_2_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.GIVE_GIFT, function(arg_3_0, arg_3_1, arg_3_2)
		arg_1_0:sendNotification(GAME.APARTMENT_GIVE_GIFT, {
			groupId = arg_1_0.viewComponent.apartment.configId,
			giftId = arg_3_1,
			count = arg_3_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.DO_TALK, function(arg_4_0, arg_4_1, arg_4_2)
		arg_1_0:sendNotification(Dorm3dRoomMediator.OTHER_DO_TALK, {
			talkId = arg_4_1,
			callback = arg_4_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.CHECK_LEVEL_UP, function(arg_5_0)
		arg_1_0:sendNotification(Dorm3dRoomMediator.GUIDE_CHECK_LEVEL_UP)

		return
	end)
	arg_1_0:bind(var_0_0.SHOW_SHOPPING_CONFIRM_WINDOW, function(arg_6_0, arg_6_1)
		arg_1_0:addSubLayers(Context.New({
			mediator = Dorm3dShoppingConfirmWindowMediator,
			viewComponent = Dorm3dShoppingConfirmWindow,
			data = arg_6_1
		}))

		return
	end)
	arg_1_0:bind(GAME.SHOPPING, function(arg_7_0, arg_7_1)
		arg_1_0:sendNotification(GAME.SHOPPING, {
			id = arg_7_1.shopId,
			count = arg_7_1.count,
			silentTip = arg_7_1.silentTip
		})

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_DROP_LAYER, function(arg_8_0, arg_8_1, arg_8_2)
		arg_1_0:addSubLayers(Context.New({
			viewComponent = Dorm3dAwardInfoLayer,
			mediator = Dorm3dAwardInfoMediator,
			data = {
				items = arg_8_1
			},
			onRemoved = arg_8_2
		}))

		return
	end)
	arg_1_0.viewComponent:SetApartment((getProxy(ApartmentProxy):getApartment(arg_1_0.contextData.groupId)))

	return
end

function var_0_0.initNotificationHandleDic(arg_9_0)
	arg_9_0.handleDic = {
		[ApartmentProxy.UPDATE_APARTMENT] = function(arg_10_0, arg_10_1)
			local var_10_0 = arg_10_1:getBody()

			if var_10_0.configId == arg_10_0.contextData.groupId then
				arg_10_0.viewComponent:SetApartment(var_10_0)
			end

			return
		end,
		[ApartmentProxy.UPDATE_GIFT_COUNT] = function(arg_11_0, arg_11_1)
			arg_11_0.viewComponent:SingleUpdateGift((arg_11_1:getBody()))

			return
		end,
		[GAME.APARTMENT_GIVE_GIFT_DONE] = function(arg_12_0, arg_12_1)
			arg_12_0.viewComponent:AfterGiveGift((arg_12_1:getBody()))

			return
		end,
		[GAME.SHOPPING_DONE] = function(arg_13_0, arg_13_1)
			local var_13_0 = arg_13_1:getBody().awards

			if var_13_0 and #var_13_0 > 0 then
				arg_13_0.viewComponent:emit(var_0_0.OPEN_DROP_LAYER, var_13_0, function()
					arg_13_0.viewComponent:SingleUpdateGift(pg.shop_template[arg_13_1:getBody().id].effect_args[1])

					return
				end)
			end

			return
		end,
		[Dorm3dRoomMediator.ON_LEVEL_UP_FINISH] = function(arg_15_0, arg_15_1)
			arg_15_0.viewComponent:CheckLevelUp()

			return
		end
	}

	return
end

return var_0_0
