class = var_0_10000

local var_0_0 = "Dorm3dShopMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

var_0_1.OPEN_DETAIL = "Dorm3dShopMediator.OPEN_DETAIL"
var_0_1.SHOW_SHOPPING_CONFIRM_WINDOW = "Dorm3dShopMediator.SHOW_SHOPPING_CONFIRM_WINDOW"
var_0_1.OPEN_ROOM_UNLOCK_WINDOW = "Dorm3dShopMediator.OPEN_ROOM_UNLOCK_WINDOW"
var_0_1.OPEN_DROP_LAYER = "Dorm3dShopMediator.OPEN_DROP_LAYER"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.OPEN_DETAIL, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		local var_2_0 = arg_1_0
		local var_2_1 = var_4.addSubLayers

		Context = var_2_10007

		local var_2_2 = var_2_10007.New
		local var_2_3 = {}

		Dorm3dShopDetailWindow = var_2_10010
		var_2_3.viewComponent = var_2_10010
		Dorm3dShopDetailMediator = var_2_10010
		var_2_3.mediator = var_2_10010
		var_2_3.data = {
			shopCfg = arg_2_1,
			groupId = arg_2_2,
			changeCount = arg_2_3
		}

		var_2_1(var_2_0, var_2_2(var_2_3))

		return
	end)
	arg_1_0:bind(var_0_1.SHOW_SHOPPING_CONFIRM_WINDOW, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.addSubLayers

		Context = var_2_10005

		local var_3_2 = var_2_10005.New
		local var_3_3 = {}

		Dorm3dShoppingConfirmWindow = var_2_10008
		var_3_3.viewComponent = var_2_10008
		Dorm3dShoppingConfirmWindowMediator = var_2_10008
		var_3_3.mediator = var_2_10008
		var_3_3.data = arg_3_1

		var_3_1(var_3_0, var_3_2(var_3_3))

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_ROOM_UNLOCK_WINDOW, function(arg_4_0, arg_4_1, arg_4_2)
		local var_4_0 = arg_1_0
		local var_4_1 = var_3.addSubLayers

		Context = var_2_10006

		local var_4_2 = var_2_10006.New
		local var_4_3 = {}

		Dorm3dRoomUnlockWindow = var_2_10009
		var_4_3.viewComponent = var_2_10009
		Dorm3dRoomUnlockWindowMediator = var_2_10009
		var_4_3.mediator = var_2_10009
		var_4_3.data = {
			roomId = arg_4_1,
			groupId = arg_4_2
		}

		var_4_1(var_4_0, var_4_2(var_4_3))

		return
	end)

	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.bind

	GAME = var_4

	var_1_1(var_1_0, var_4.SHOPPING, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_1_0
		local var_5_1 = var_2.sendNotification

		GAME = var_2_10005

		var_5_1(var_5_0, var_2_10005.SHOPPING, {
			id = arg_5_1.shopId,
			count = arg_5_1.count,
			silentTip = arg_5_1.silentTip
		})

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_DROP_LAYER, function(arg_6_0, arg_6_1, arg_6_2)
		local var_6_0 = arg_1_0
		local var_6_1 = var_3.addSubLayers

		Context = var_2_10006

		local var_6_2 = var_2_10006.New
		local var_6_3 = {}

		Dorm3dAwardInfoLayer = var_2_10009
		var_6_3.viewComponent = var_2_10009
		Dorm3dAwardInfoMediator = var_2_10009
		var_6_3.mediator = var_2_10009
		var_6_3.data = {
			items = arg_6_1
		}
		var_6_3.onRemoved = arg_6_2

		var_6_1(var_6_0, var_6_2(var_6_3))

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_7_0)
	local var_7_0 = {}

	PlayerProxy = var_1_10002
	var_7_0[1] = var_1_10002.UPDATED
	GAME = var_2
	var_7_0[2] = var_2.SHOPPING_DONE
	GAME = var_2
	var_7_0[3] = var_2.APARTMENT_ROOM_INVITE_UNLOCK_DONE

	return var_7_0
end

function var_0_1.handleNotification(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1
	local var_8_1 = arg_8_1.getName(var_8_0)
	local var_8_2 = arg_8_1
	local var_8_3 = arg_8_1.getBody(var_8_2)

	PlayerProxy = var_8_0

	if var_8_1 == var_8_0.UPDATED then
		local var_8_4 = arg_8_0.viewComponent

		var_4.ShowResUI(var_8_4)
	else
		GAME = var_4

		local var_8_5

		if var_8_1 == var_4.SHOPPING_DONE then
			var_8_5 = arg_8_1:getBody().awards
			ipairs = var_8_2

			for iter_8_0, iter_8_1 in var_8_2(var_8_5) do
				iter_8_1.count = arg_8_0.viewComponent.showCount
			end

			if var_8_5 and #var_8_5 > 0 then
				local var_8_6 = arg_8_0.viewComponent

				var_5.emit(var_8_6, var_0_1.OPEN_DROP_LAYER, var_8_5, function()
					local var_9_0 = var_8_3.id

					pg = var_2_10001

					local var_9_1 = var_2_10001.shop_template[var_9_0]

					return
				end)
			end

			local var_8_7 = arg_8_0.viewComponent

			var_5.SetPageBtns(var_8_7)

			local var_8_8 = arg_8_0.viewComponent

			var_5.RefreshPage(var_8_8)
		else
			GAME = var_8_5

			if var_8_1 == var_8_5.APARTMENT_ROOM_INVITE_UNLOCK_DONE then
				local var_8_9 = arg_8_0.viewComponent

				var_4.SetPageBtns(var_8_9)

				local var_8_10 = arg_8_0.viewComponent

				var_4.RefreshPage(var_8_10)
			end
		end
	end

	return
end

return var_0_1
