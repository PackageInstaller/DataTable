class = var_0_10000

local var_0_0 = "Dorm3dFurnitureSelectMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

var_0_1.SHOW_CONFIRM_WINDOW = "SHOW_CONFIRM_WINDOW"
var_0_1.SHOW_FURNITURE_ACESSES = "SHOW_FURNITURE_ACESSES"
var_0_1.OPEN_DROP_LAYER = "OPEN_DROP_LAYER"
var_0_1.SHOW_SHOPPING_CONFIRM_WINDOW = "SHOW_SHOPPING_CONFIRM_WINDOW"

function var_0_1.register(arg_1_0)
	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.bind

	GAME = var_1_10004

	var_1_1(var_1_0, var_1_10004.APARTMENT_REPLACE_FURNITURE, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10005

		var_2_1(var_2_0, var_2_10005.APARTMENT_REPLACE_FURNITURE, arg_2_1)

		return
	end)
	arg_1_0:bind(var_0_1.SHOW_CONFIRM_WINDOW, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.addSubLayers

		Context = var_2_10005

		local var_3_2 = var_2_10005.New
		local var_3_3 = {}

		Dorm3dFurnitureConfirmWindowMediator = var_2_10008
		var_3_3.mediator = var_2_10008
		Dorm3dFurnitureConfirmWindow = var_2_10008
		var_3_3.viewComponent = var_2_10008
		var_3_3.data = arg_3_1

		var_3_1(var_3_0, var_3_2(var_3_3))

		return
	end)
	arg_1_0:bind(var_0_1.SHOW_FURNITURE_ACESSES, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0
		local var_4_1 = var_2.addSubLayers

		Context = var_2_10005

		local var_4_2 = var_2_10005.New
		local var_4_3 = {}

		Dorm3dFurnitureAcessesWindowMediator = var_2_10008
		var_4_3.mediator = var_2_10008
		Dorm3dFurnitureAcessesWindow = var_2_10008
		var_4_3.viewComponent = var_2_10008
		var_4_3.data = arg_4_1

		var_4_1(var_4_0, var_4_2(var_4_3))

		return
	end)
	arg_1_0:bind(var_0_1.SHOW_SHOPPING_CONFIRM_WINDOW, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_1_0
		local var_5_1 = var_2.addSubLayers

		Context = var_2_10005

		local var_5_2 = var_2_10005.New
		local var_5_3 = {}

		Dorm3dShoppingConfirmWindowMediator = var_2_10008
		var_5_3.mediator = var_2_10008
		Dorm3dShoppingConfirmWindow = var_2_10008
		var_5_3.viewComponent = var_2_10008
		var_5_3.data = arg_5_1

		var_5_1(var_5_0, var_5_2(var_5_3))

		return
	end)

	local var_1_2 = arg_1_0
	local var_1_3 = arg_1_0.bind

	GAME = var_4

	var_1_3(var_1_2, var_4.SHOPPING, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_1_0
		local var_6_1 = var_2.sendNotification

		GAME = var_2_10005

		var_6_1(var_6_0, var_2_10005.SHOPPING, {
			id = arg_6_1.shopId,
			count = arg_6_1.count,
			silentTip = arg_6_1.silentTip
		})

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_DROP_LAYER, function(arg_7_0, arg_7_1, arg_7_2)
		local var_7_0 = arg_1_0
		local var_7_1 = var_3.addSubLayers

		Context = var_2_10006

		local var_7_2 = var_2_10006.New
		local var_7_3 = {}

		Dorm3dAwardInfoLayer = var_2_10009
		var_7_3.viewComponent = var_2_10009
		Dorm3dAwardInfoMediator = var_2_10009
		var_7_3.mediator = var_2_10009
		var_7_3.data = {
			items = arg_7_1
		}
		var_7_3.onRemoved = arg_7_2

		var_7_1(var_7_0, var_7_2(var_7_3))

		return
	end)

	pg = var_1

	local var_1_4 = var_1.m02
	local var_1_5 = var_1.retrieveMediator

	Dorm3dRoomMediator = var_4

	local var_1_6 = var_1_5(var_1_4, var_4.__cname)
	local var_1_7 = var_1.getViewComponent(var_1_6)
	local var_1_8 = arg_1_0.viewComponent

	var_3.SetSceneRoot(var_1_8, var_1_7)

	local var_1_9 = arg_1_0.viewComponent

	var_3.SetRoom(var_1_9, var_1_7.room)

	return
end

function var_0_1.listNotificationInterests(arg_8_0)
	local var_8_0 = {}

	Dorm3dRoomMediator = var_1_10002
	var_8_0[1] = var_1_10002.ON_CLICK_FURNITURE_SLOT
	GAME = var_2
	var_8_0[2] = var_2.APARTMENT_REPLACE_FURNITURE_DONE
	GAME = var_2
	var_8_0[3] = var_2.APARTMENT_REPLACE_FURNITURE_ERROR
	GAME = var_2
	var_8_0[4] = var_2.SHOPPING_DONE

	return var_8_0
end

function var_0_1.handleNotification(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1
	local var_9_1 = arg_9_1.getName(var_9_0)
	local var_9_2 = arg_9_1:getBody()

	ApartmentProxy = var_9_0

	if var_9_1 == var_9_0.UPDATE_ROOM then
		-- block empty
	else
		Dorm3dRoomMediator = var_4

		if var_9_1 == var_4.ON_CLICK_FURNITURE_SLOT then
			-- block empty
		else
			GAME = var_4

			if var_9_1 == var_4.APARTMENT_REPLACE_FURNITURE_DONE then
				local var_9_3 = arg_9_0.viewComponent

				var_4.OnReplaceFurnitureDone(var_9_3)
			else
				GAME = var_4

				if var_9_1 == var_4.APARTMENT_REPLACE_FURNITURE_ERROR then
					local var_9_4 = arg_9_0.viewComponent

					var_4.OnReplaceFurnitureError(var_9_4)
				else
					GAME = var_4

					if var_9_1 == var_4.SHOPPING_DONE and var_9_2.awards and #var_4 > 0 then
						local var_9_5 = arg_9_0.viewComponent

						var_5.emit(var_9_5, var_0_1.OPEN_DROP_LAYER, var_4, function()
							local var_10_0 = arg_9_1
							local var_10_1 = var_0.getBody(var_10_0).id

							pg = var_2_10001

							local var_10_2 = var_2_10001.shop_template[var_10_1].effect_args[1]
							local var_10_3 = arg_9_0.viewComponent.room

							var_3.AddFurnitureByID(var_10_3, var_10_2)

							local var_10_4 = arg_9_0.viewComponent

							var_3.UpdateDataDisplayFurnitures(var_10_4)

							local var_10_5 = arg_9_0.viewComponent

							var_3.UpdateView(var_10_5)

							return
						end)
					end
				end
			end
		end
	end

	return
end

function var_0_1.remove(arg_11_0)
	return
end

return var_0_1
