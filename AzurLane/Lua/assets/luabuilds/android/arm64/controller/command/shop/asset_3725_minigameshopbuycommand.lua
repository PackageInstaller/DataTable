class = var_0_10000

local var_0_0 = "MiniGameShopBuyCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0

	var_1_0 = arg_1_1:getBody() and var_2.callback

	local var_1_1 = var_2.id
	local var_1_2 = var_2.list

	pg = var_1_10006

	local var_1_3 = var_1_10006.gameroom_shop_template[var_1_1]
	local var_1_4 = 0
	local var_1_5 = 0

	ipairs = var_1_10009

	for iter_1_0, iter_1_1 in var_1_10009(var_1_2) do
		var_1_10014 = iter_1_1.id
		var_1_5 = var_1_5 + iter_1_1.num
		var_1_4 = var_1_4 + var_1_3.price * var_15
	end

	getProxy = var_9
	GameRoomProxy = var_11

	local var_1_6 = var_9(var_11)
	local var_1_8

	if var_1_4 > var_9.getTicket(var_1_6) then
		pg = var_1_8

		local var_1_7 = var_1_8.MsgboxMgr.GetInstance()

		var_1_8 = var_1_8.ShowMsgBox

		local var_1_9 = {}

		i18n = var_1_10014
		var_1_9.content = var_1_10014("game_ticket_notenough")

		function var_1_9.onYes()
			local var_2_0 = arg_1_0
			local var_2_1 = var_0.sendNotification

			GAME = var_2_10003

			local var_2_2 = var_2_10003.GO_SCENE

			SCENE = var_2_10004

			var_2_1(var_2_0, var_2_2, var_2_10004.GAME_HALL)

			return
		end

		function var_1_9.onNo()
			return
		end

		var_1_8(var_1_7, var_1_9)

		return
	end

	pg = var_1_8

	local var_1_10 = var_1_8.ConnectionMgr.GetInstance()

	var_10.Send(var_1_10, 26152, {
		goodsid = var_1_1,
		selected = var_1_2
	}, 26153, function(arg_4_0)
		local var_4_0
		local var_4_1

		if arg_4_0.result == 0 then
			id2res = var_4_1
			GameRoomProxy = var_2_10004
			var_4_1 = var_4_1(var_2_10004.ticket_res_id)
			getProxy = var_2_10003
			PlayerProxy = var_2_10005
			var_2_10005 = var_2_10003(var_2_10005)
			var_2_10005 = var_3.getRawData(var_2_10005)

			local var_4_2 = var_3.consume
			local var_4_3 = {}
			local var_4_4

			if not var_1_4 then
				var_4_4 = 0
			end

			var_4_3[var_4_1] = var_4_4

			var_4_2(var_2_10005, var_4_3)

			getProxy = var_4_2
			ShopsProxy = var_2_10005
			var_2_10005 = var_4_2(var_2_10005)

			local var_4_5 = var_3.getMiniShop(var_2_10005)

			var_3.consume(var_4_5, var_1_1, var_1_5)

			getProxy = var_4
			ShopsProxy = var_4_5

			local var_4_6 = var_4(var_4_5)

			var_4.setMiniShop(var_4_6, var_3)

			PlayerConst = var_4

			local var_4_7 = var_4.addTranDrop(arg_4_0.drop_list)
			local var_4_8 = arg_1_0

			var_2_10005 = var_2_10005.sendNotification
			GAME = var_8

			var_2_10005(var_4_8, var_8.MINI_GAME_SHOP_BUY_DONE, {
				list = var_4_7
			})
		else
			pg = var_4_1

			local var_4_9 = var_4_1.TipsMgr.GetInstance()
			local var_4_10 = var_2.ShowTips

			ERROR_MESSAGE = var_2_10005

			var_4_10(var_4_9, var_2_10005[arg_4_0.result] .. arg_4_0.result)
		end

		return
	end)

	return
end

return var_0_1
