class = var_0_10000

local var_0_0 = "ProposeMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.ContextMediator"))

var_0_1.ON_PROPOSE = "ProposeMediator.ON_PROPOSE"
var_0_1.RENAME_SHIP = "ProposeMediator.RENAME_SHIP"
var_0_1.HIDE_SHIP_MAIN_WORD = "ShipMainMediator.HIDE_SHIP_MAIN_WORD"
var_0_1.EXCHANGE_TIARA = "ProposeMediator.EXCHANGE_TIARA"
var_0_1.REGISTER_SHIP = "ProposeMediator.REGISTER_SHIP"
var_0_1.GIFT_SHIP = "ProposeMediaotr.GIFT_SHIP"

function var_0_1.register(arg_1_0)
	getProxy = var_1_10001
	BayProxy = var_1_10002

	local var_1_0 = var_1_10001(var_1_10002)
	local var_1_1

	if arg_1_0.contextData.shipId then
		var_1_10003 = var_1_0
		var_1_1 = var_1_0.getShipById(var_1_10003, arg_1_0.contextData.shipId)

		local var_1_2 = arg_1_0.viewComponent

		var_1_10003.setShip(var_1_2, var_1_1)
	elseif arg_1_0.contextData.review then
		var_1_10003 = arg_1_0.viewComponent

		var_1_1.setShipGroupID(var_1_10003, arg_1_0.contextData.group.id)

		var_1_10003 = arg_1_0.viewComponent

		var_1_1.setWeddingReviewSkinID(var_1_10003, arg_1_0.contextData.skinID)
	end

	getProxy = var_1_1
	BagProxy = var_1_10003

	local var_1_3 = var_1_1(var_1_10003)
	local var_1_4 = arg_1_0.viewComponent

	var_3.setBagProxy(var_1_4, var_1_3)

	getProxy = var_3
	PlayerProxy = var_1_4

	local var_1_5 = var_3(var_1_4)
	local var_1_6 = var_3.getData(var_1_5)
	local var_1_7 = arg_1_0.viewComponent

	var_4.setPlayer(var_1_7, var_1_6)
	arg_1_0:bind(var_0_1.ON_PROPOSE, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10004

		var_2_1(var_2_0, var_2_10004.PROPOSE_SHIP, {
			shipId = arg_2_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.RENAME_SHIP, function(arg_3_0, arg_3_1, arg_3_2)
		local var_3_0 = arg_1_0
		local var_3_1 = var_3.sendNotification

		GAME = var_2_10005

		var_3_1(var_3_0, var_2_10005.RENAME_SHIP, {
			shipId = arg_3_1,
			name = arg_3_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.HIDE_SHIP_MAIN_WORD, function(arg_4_0, arg_4_1, arg_4_2)
		local var_4_0 = arg_1_0
		local var_4_1 = var_3.sendNotification

		GAME = var_2_10005

		var_4_1(var_4_0, var_2_10005.HIDE_Ship_MAIN_SCENE_WORD)

		return
	end)
	arg_1_0:bind(var_0_1.EXCHANGE_TIARA, function(arg_5_0)
		local var_5_0 = arg_1_0
		local var_5_1 = var_1.sendNotification

		GAME = var_2_10003

		var_5_1(var_5_0, var_2_10003.PROPOSE_EXCHANGE_RING)

		return
	end)
	arg_1_0:bind(var_0_1.REGISTER_SHIP, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_1_0
		local var_6_1 = var_2.sendNotification

		GAME = var_2_10004

		var_6_1(var_6_0, var_2_10004.PROPOSE_REGISTER_SHIP, {
			shipId = arg_6_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.GIFT_SHIP, function(arg_7_0, arg_7_1)
		local var_7_0 = arg_1_0
		local var_7_1 = var_2.sendNotification

		GAME = var_2_10004

		local var_7_2 = var_2_10004.GO_SCENE

		SCENE = var_2_10005

		var_7_1(var_7_0, var_7_2, var_2_10005.SHIP_GIFT, {
			shipID = arg_7_1
		})

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_8_0)
	local var_8_0 = {}

	GAME = var_1_10002
	var_8_0[1] = var_1_10002.PROPOSE_SHIP_DONE
	GAME = var_2
	var_8_0[2] = var_2.RENAME_SHIP_DONE
	GAME = var_2
	var_8_0[3] = var_2.PROPOSE_EXCHANGE_RING_DONE
	GAME = var_2
	var_8_0[4] = var_2.PROPOSE_REGISTER_SHIP_DONE

	return var_8_0
end

function var_0_1.handleNotification(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1:getName()
	local var_9_1 = arg_9_1
	local var_9_2 = arg_9_1.getBody(var_9_1)

	GAME = var_9_1

	if var_9_0 == var_9_1.PROPOSE_SHIP_DONE then
		local var_9_3 = var_9_2.ship

		if var_4.getProposeSkin(var_9_3) then
			var_1_10006 = arg_9_0

			local var_9_4 = arg_9_0.sendNotification

			GAME = var_1_10007

			var_9_4(var_1_10006, var_1_10007.SET_SHIP_SKIN, {
				phantomId = 0,
				hideTip = true,
				shipId = var_9_2.ship.id,
				skinId = var_4.id
			})
		end

		var_1_10006 = arg_9_0.viewComponent

		var_5.setShip(var_1_10006, var_9_2.ship)

		var_1_10006 = arg_9_0.viewComponent

		var_5.RingFadeout(var_1_10006)
	else
		GAME = var_4

		if var_9_0 == var_4.RENAME_SHIP_DONE then
			local var_9_5 = arg_9_0.viewComponent

			var_4.closeView(var_9_5)
		else
			GAME = var_4

			local var_9_7

			if var_9_0 == var_4.PROPOSE_EXCHANGE_RING_DONE then
				local var_9_6 = arg_9_0.viewComponent

				var_9_7 = var_9_7.emit
				BaseUI = var_1_10006

				var_9_7(var_9_6, var_1_10006.ON_ACHIEVE, var_9_2.items, function()
					local var_10_0 = arg_9_0.viewComponent

					var_0.onUpdateItemCount(var_10_0)

					return
				end)
			else
				GAME = var_9_7

				if var_9_0 == var_9_7.PROPOSE_REGISTER_SHIP_DONE and arg_9_0.viewComponent.afterRegisterCall then
					arg_9_0.viewComponent.afterRegisterCall()
				end
			end
		end
	end

	return
end

return var_0_1
