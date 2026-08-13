class = var_0_10000

local var_0_0 = "MiniGameShopBuyCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

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
		local var_1_6 = iter_1_1.id

		var_1_5 = var_1_5 + iter_1_1.num
		var_1_4 = var_1_4 + var_1_3.price * var_15
	end

	getProxy = var_9
	GameRoomProxy = var_10

	local var_1_7 = var_9(var_10)

	if var_1_4 > var_9.getTicket(var_1_7) then
		pg = var_1_7

		local var_1_8 = var_1_7.MsgboxMgr.GetInstance()

		var_1_7 = var_1_7.ShowMsgBox

		local var_1_9 = {}

		i18n = iter_1_1
		var_1_9.content = iter_1_1("game_ticket_notenough")

		function var_1_9.onYes()
			local var_2_0 = arg_1_0
			local var_2_1 = var_0.sendNotification

			GAME = var_2_10002

			local var_2_2 = var_2_10002.GO_SCENE

			SCENE = var_2_10003

			var_2_1(var_2_0, var_2_2, var_2_10003.GAME_HALL)

			return
		end

		function var_1_9.onNo()
			return
		end

		var_1_7(var_1_8, var_1_9)

		return
	end

	pg = var_1_7

	local var_1_10 = var_1_7.ConnectionMgr.GetInstance()

	var_10.Send(var_1_10, 26152, {
		goodsid = var_1_1,
		selected = var_1_2
	}, 26153, function(arg_4_0)
		local var_4_0
		local var_4_1

		if arg_4_0.result == 0 then
			id2res = var_4_1
			GameRoomProxy = var_2_10003
			var_4_1 = var_4_1(var_2_10003.ticket_res_id)
			getProxy = var_3
			PlayerProxy = var_2_10004
			var_2_10004 = var_3(var_2_10004)
			var_2_10004 = var_3.getRawData(var_2_10004)

			local var_4_2 = var_3.consume
			local var_4_3 = {}
			local var_4_4

			if not var_1_4 then
				var_4_4 = 0
			end

			var_4_3[var_4_1] = var_4_4

			var_4_2(var_2_10004, var_4_3)

			getProxy = var_4_2
			ShopsProxy = var_2_10004
			var_2_10004 = var_4_2(var_2_10004)

			local var_4_5 = var_3.getMiniShop(var_2_10004)

			var_3.consume(var_4_5, var_1_1, var_1_5)

			getProxy = var_2_10004
			ShopsProxy = var_4_5

			local var_4_6 = var_2_10004(var_4_5)

			var_2_10004.setMiniShop(var_4_6, var_3)

			PlayerConst = var_2_10004
			var_2_10004 = var_2_10004.addTranDrop(arg_4_0.drop_list)

			local var_4_7 = arg_1_0
			local var_4_8 = var_5.sendNotification

			GAME = var_7

			var_4_8(var_4_7, var_7.MINI_GAME_SHOP_BUY_DONE, {
				list = var_2_10004
			})
		else
			pg = var_4_1

			local var_4_9 = var_4_1.TipsMgr.GetInstance()
			local var_4_10 = var_2.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_4_10(var_4_9, var_2_10004[arg_4_0.result] .. arg_4_0.result)
		end

		return
	end)

	return
end

return var_0_1
