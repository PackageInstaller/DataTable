class = var_0_10000

local var_0_0 = "Dorm3dGiftMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

var_0_1.GIVE_GIFT = "Dorm3dGiftMediator.GIVE_GIFT"
var_0_1.DO_TALK = "Dorm3dGiftMediator.DO_TALK"
var_0_1.CHECK_LEVEL_UP = "Dorm3dGiftMediator.CHECK_LEVEL_UP"
var_0_1.OPEN_DROP_LAYER = "Dorm3dGiftMediator.OPEN_DROP_LAYER"
var_0_1.SHOW_SHOPPING_CONFIRM_WINDOW = "Dorm3dGiftMediator.SHOW_SHOPPING_CONFIRM_WINDOW"
var_0_1.FAVOR_LEVEL_UP = "Dorm3dGiftMediator.FAVOR_LEVEL_UP"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.FAVOR_LEVEL_UP, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10004

		var_2_1(var_2_0, var_2_10004.APARTMENT_LEVEL_UP, {
			groupId = arg_2_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.GIVE_GIFT, function(arg_3_0, arg_3_1, arg_3_2)
		local var_3_0 = arg_1_0
		local var_3_1 = var_3.sendNotification

		GAME = var_2_10005

		var_3_1(var_3_0, var_2_10005.APARTMENT_GIVE_GIFT, {
			groupId = arg_1_0.viewComponent.apartment.configId,
			giftId = arg_3_1,
			count = arg_3_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.DO_TALK, function(arg_4_0, arg_4_1, arg_4_2)
		local var_4_0 = arg_1_0
		local var_4_1 = var_3.sendNotification

		Dorm3dRoomMediator = var_2_10005

		var_4_1(var_4_0, var_2_10005.OTHER_DO_TALK, {
			talkId = arg_4_1,
			callback = arg_4_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.CHECK_LEVEL_UP, function(arg_5_0)
		local var_5_0 = arg_1_0
		local var_5_1 = var_1.sendNotification

		Dorm3dRoomMediator = var_2_10003

		var_5_1(var_5_0, var_2_10003.GUIDE_CHECK_LEVEL_UP)

		return
	end)
	arg_1_0:bind(var_0_1.SHOW_SHOPPING_CONFIRM_WINDOW, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_1_0
		local var_6_1 = var_2.addSubLayers

		Context = var_2_10004

		local var_6_2 = var_2_10004.New
		local var_6_3 = {}

		Dorm3dShoppingConfirmWindowMediator = var_2_10006
		var_6_3.mediator = var_2_10006
		Dorm3dShoppingConfirmWindow = var_2_10006
		var_6_3.viewComponent = var_2_10006
		var_6_3.data = arg_6_1

		var_6_1(var_6_0, var_6_2(var_6_3))

		return
	end)

	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.bind

	GAME = var_3

	var_1_1(var_1_0, var_3.SHOPPING, function(arg_7_0, arg_7_1)
		local var_7_0 = arg_1_0
		local var_7_1 = var_2.sendNotification

		GAME = var_2_10004

		var_7_1(var_7_0, var_2_10004.SHOPPING, {
			id = arg_7_1.shopId,
			count = arg_7_1.count,
			silentTip = arg_7_1.silentTip
		})

		return
	end)

	local var_1_2 = arg_1_0

	arg_1_0.bind(var_1_2, var_0_1.OPEN_DROP_LAYER, function(arg_8_0, arg_8_1, arg_8_2)
		local var_8_0 = arg_1_0
		local var_8_1 = var_3.addSubLayers

		Context = var_2_10005

		local var_8_2 = var_2_10005.New
		local var_8_3 = {}

		Dorm3dAwardInfoLayer = var_2_10007
		var_8_3.viewComponent = var_2_10007
		Dorm3dAwardInfoMediator = var_2_10007
		var_8_3.mediator = var_2_10007
		var_8_3.data = {
			items = arg_8_1
		}
		var_8_3.onRemoved = arg_8_2

		var_8_1(var_8_0, var_8_2(var_8_3))

		return
	end)

	getProxy = var_1
	ApartmentProxy = var_1_2

	local var_1_3 = var_1(var_1_2)
	local var_1_4 = var_1.getApartment(var_1_3, arg_1_0.contextData.groupId)
	local var_1_5 = arg_1_0.viewComponent

	var_2.SetApartment(var_1_5, var_1_4)

	return
end

function var_0_1.initNotificationHandleDic(arg_9_0)
	local var_9_0 = {}

	ApartmentProxy = var_1_10002
	var_9_0[var_1_10002.UPDATE_APARTMENT] = function(arg_10_0, arg_10_1)
		if arg_10_1:getBody().configId == arg_10_0.contextData.groupId then
			local var_10_0 = arg_10_0.viewComponent

			var_3.SetApartment(var_10_0, var_2)
		end

		return
	end
	ApartmentProxy = var_2
	var_9_0[var_2.UPDATE_GIFT_COUNT] = function(arg_11_0, arg_11_1)
		local var_11_0 = arg_11_1:getBody()
		local var_11_1 = arg_11_0.viewComponent

		var_3.SingleUpdateGift(var_11_1, var_11_0)

		return
	end
	GAME = var_2
	var_9_0[var_2.APARTMENT_GIVE_GIFT_DONE] = function(arg_12_0, arg_12_1)
		local var_12_0 = arg_12_1:getBody()
		local var_12_1 = arg_12_0.viewComponent

		var_3.AfterGiveGift(var_12_1, var_12_0)

		return
	end
	GAME = var_2
	var_9_0[var_2.SHOPPING_DONE] = function(arg_13_0, arg_13_1)
		if arg_13_1:getBody().awards and #var_2 > 0 then
			local var_13_0 = arg_13_0.viewComponent

			var_3.emit(var_13_0, var_0_1.OPEN_DROP_LAYER, var_2, function()
				local var_14_0 = arg_13_1
				local var_14_1 = var_0.getBody(var_14_0).id

				pg = var_14_0

				local var_14_2 = var_14_0.shop_template[var_14_1]
				local var_14_3 = arg_13_0.viewComponent

				var_2.SingleUpdateGift(var_14_3, var_14_2.effect_args[1])

				return
			end)
		end

		return
	end
	Dorm3dRoomMediator = var_2
	var_9_0[var_2.ON_LEVEL_UP_FINISH] = function(arg_15_0, arg_15_1)
		local var_15_0 = arg_15_0.viewComponent

		var_2.CheckLevelUp(var_15_0)

		return
	end
	arg_9_0.handleDic = var_9_0

	return
end

return var_0_1
