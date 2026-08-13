class = var_0_10000

local var_0_0 = "GameRoomSuccessCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().roomId
	local var_1_1 = var_2.times
	local var_1_2 = var_2.score

	getProxy = var_1_10006
	GameRoomProxy = var_1_10008

	local var_1_3 = var_1_10006(var_1_10008)
	local var_1_4 = var_6.lastMonthlyTicket(var_1_3)

	getProxy = var_1_10007
	GameRoomProxy = var_1_10009

	local var_1_5 = var_1_10007(var_1_10009)

	if var_7.lastTicketMax(var_1_5) == 0 or var_1_4 == 0 then
		return
	end

	pg = var_1_3

	local var_1_6 = var_1_3.ConnectionMgr.GetInstance()

	var_8.Send(var_1_6, 26126, {
		roomid = var_1_0,
		times = var_1_1,
		score = var_1_2
	}, 26127, function(arg_2_0)
		local var_2_2

		if arg_2_0.result == 0 then
			getProxy = var_2_2
			GameRoomProxy = var_2_10003

			local var_2_0 = var_2_2(var_2_10003)

			var_2_2.storeGameScore(var_2_0, var_1_0, var_1_2)

			getProxy = var_2_2
			GameRoomProxy = var_2_0

			local var_2_1 = var_2_2(var_2_0)

			var_2_2 = var_2_2.lastTicketMax(var_2_1)
			id2res = var_2_10002
			GameRoomProxy = var_2_10004

			local var_2_3 = var_2_10002(var_2_10004.coin_res_id)

			getProxy = var_2_1
			PlayerProxy = var_5

			local var_2_4 = var_2_1(var_5)
			local var_2_5 = var_3.getRawData(var_2_4)
			local var_2_6 = var_3.consume
			local var_2_7 = {}
			local var_2_8

			if not var_1_1 then
				var_2_8 = 0
			end

			var_2_7[var_2_3] = var_2_8

			var_2_6(var_2_5, var_2_7)

			PlayerConst = var_2_6
			var_2_10004 = var_2_6.addTranDrop(arg_2_0.drop_list)[1].count
			getProxy = var_5
			GameRoomProxy = var_2_8

			local var_2_9 = var_5(var_2_8)

			if var_5.lastMonthlyTicket(var_2_9) < var_2_10004 then
				var_2_10004 = var_5
			end

			if var_2_2 < var_2_10004 then
				var_2_10004 = var_2_2
			end

			getProxy = var_2_7
			GameRoomProxy = var_2_10008

			local var_2_10 = var_2_7(var_2_10008)

			var_6.setMonthlyTicket(var_2_10, var_2_10004)

			var_3[1].count = var_2_10004

			if var_3[1].count ~= 0 then
				pg = var_6

				local var_2_11 = var_6.m02
				local var_2_12 = var_6.sendNotification

				GAME = var_9

				var_2_12(var_2_11, var_9.GAME_ROOM_AWARD_DONE, var_3)
			end
		else
			pg = var_2_2

			local var_2_13 = var_2_2.TipsMgr.GetInstance()
			local var_2_14 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_2_14(var_2_13, var_2_10004[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
