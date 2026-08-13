class = var_0_10000

local var_0_0 = "GameHallMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.ContextMediator"))

var_0_1.OPEN_MINI_GAME = "open mini game"
var_0_1.OPEN_GAME_SHOP = "open game shop "
var_0_1.GET_WEEKLY_COIN = "get weekly coin"
var_0_1.EXCHANGE_COIN = "exchange coin"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.OPEN_MINI_GAME, function(arg_2_0, arg_2_1, arg_2_2)
		print = var_2_10003

		var_2_10003("open minigame " .. arg_2_1.game_id)

		pg = var_2_10003

		local var_2_0 = var_2_10003.m02
		local var_2_1 = var_3.sendNotification

		GAME = var_5

		var_2_1(var_2_0, var_5.GO_MINI_GAME, arg_2_1.game_id)

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_GAME_SHOP, function(arg_3_0, arg_3_1, arg_3_2)
		pg = var_2_10003

		local var_3_0 = var_2_10003.m02
		local var_3_1 = var_3.sendNotification

		GAME = var_2_10005

		local var_3_2 = var_2_10005.GO_SCENE

		SCENE = var_2_10006

		local var_3_3 = var_2_10006.SHOP
		local var_3_4 = {}

		NewShopsScene = var_2_10008
		var_3_4.warp = var_2_10008.TYPE_MINI_GAME

		var_3_1(var_3_0, var_3_2, var_3_3, var_3_4)

		return
	end)
	arg_1_0:bind(var_0_1.GET_WEEKLY_COIN, function(arg_4_0, arg_4_1, arg_4_2)
		pg = var_2_10003

		local var_4_0 = var_2_10003.m02
		local var_4_1 = var_3.sendNotification

		GAME = var_2_10005

		var_4_1(var_4_0, var_2_10005.GAME_ROOM_WEEK_COIN)

		return
	end)
	arg_1_0:bind(var_0_1.EXCHANGE_COIN, function(arg_5_0, arg_5_1, arg_5_2)
		pg = var_2_10003

		local var_5_0 = var_2_10003.m02
		local var_5_1 = var_3.sendNotification

		GAME = var_2_10005

		var_5_1(var_5_0, var_2_10005.GAME_ROOM_EXCHANGE_COIN, arg_5_1)

		return
	end)

	return
end

function var_0_1.onUIAvalible(arg_6_0)
	getProxy = var_1_10001
	GameRoomProxy = var_1_10002

	local var_6_0 = var_1_10001(var_1_10002)

	if var_1.getFirstEnter(var_6_0) then
		pg = var_6_0

		local var_6_1 = var_6_0.m02

		var_6_0 = var_6_0.sendNotification
		GAME = var_1_10004

		var_6_0(var_6_1, var_1_10004.GAME_ROOM_FIRST_COIN)
	else
		pg = var_6_0

		local var_6_2 = var_6_0.SystemGuideMgr.GetInstance()

		var_2.Play(var_6_2, arg_6_0.viewComponent)
	end

	return
end

function var_0_1.listNotificationInterests(arg_7_0)
	local var_7_0 = {}

	GAME = var_1_10002
	var_7_0[1] = var_1_10002.GAME_ROOM_AWARD_DONE
	GAME = var_2
	var_7_0[2] = var_2.ROOM_FIRST_COIN_DONE
	GAME = var_2
	var_7_0[3] = var_2.END_GUIDE

	return var_7_0
end

function var_0_1.handleNotification(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1:getName()
	local var_8_1 = arg_8_1
	local var_8_2 = arg_8_1.getBody(var_8_1)

	GAME = var_8_1

	local var_8_4

	if var_8_0 == var_8_1.GAME_ROOM_AWARD_DONE then
		local var_8_3 = arg_8_0.viewComponent

		var_8_4 = var_8_4.emit
		BaseUI = var_1_10006

		var_8_4(var_8_3, var_1_10006.ON_AWARD, {
			items = var_8_2
		})

		local var_8_5 = arg_8_0.viewComponent

		var_8_4.updateUI(var_8_5)
	else
		GAME = var_8_4

		if var_8_0 == var_8_4.ROOM_FIRST_COIN_DONE then
			seriesAsync = var_4

			var_4({
				function(arg_9_0)
					local var_9_0 = arg_8_0.viewComponent
					local var_9_1 = var_1.emit

					BaseUI = var_2_10003

					var_9_1(var_9_0, var_2_10003.ON_AWARD, {
						items = var_8_2,
						removeFunc = arg_9_0
					})

					return
				end,
				function(arg_10_0)
					local var_10_0 = arg_8_0.viewComponent

					var_1.updateUI(var_10_0)

					pg = var_1

					local var_10_1 = var_1.SystemGuideMgr.GetInstance()

					var_1.Play(var_10_1, arg_8_0.viewComponent)
					arg_10_0()

					return
				end
			})
		else
			GAME = var_4

			if var_8_0 == var_4.END_GUIDE then
				pg = var_4

				local var_8_6 = var_4.SystemGuideMgr.GetInstance()

				var_4.Play(var_8_6, arg_8_0.viewComponent)
			end
		end
	end

	return
end

return var_0_1
