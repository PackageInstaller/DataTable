class = var_0_10000

local var_0_0 = "IslandCheaterReconectCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = 1

	getProxy = var_1_10004
	IslandProxy = var_1_10005

	local var_1_2 = var_1_10004(var_1_10005)
	local var_1_3 = var_4.GetIsland(var_1_2)
	local var_1_4 = var_4.GetCheaterTavernAgency(var_1_3)

	pg = var_1_3

	local var_1_5 = var_1_3.ConnectionMgr.GetInstance()

	var_6.Send(var_1_5, 23106, {
		type = var_1_1
	}, 23107, function(arg_2_0)
		local var_2_3

		if arg_2_0.result == 0 then
			local var_2_0 = var_1_4

			var_2_3.SetIsConnecting(var_2_0, true)

			local var_2_1 = var_1_4

			var_2_3.SetResetGameData(var_2_1, arg_2_0)

			local var_2_2 = arg_1_0

			var_2_3.InitPlayerDate(var_2_2, arg_2_0)

			var_2_3 = {
				user_id = arg_2_0.user_id
			}
			IslandCheaterTavernConst = var_2
			var_2_3.operationType = var_2.PlayerCurrentOperateType.PutCardOrQuery
			var_2_3.auto_time = arg_2_0.auto_time
			pg = var_2
			var_2_10003 = var_2.m02

			local var_2_4 = var_2.sendNotification

			GAME = var_2_10004

			var_2_4(var_2_10003, var_2_10004.ISLAND_CHEATER_RECONNECT, {
				operation = var_2_3
			})
		else
			pg = var_2_3

			local var_2_5 = var_2_3.TipsMgr.GetInstance()
			local var_2_6 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_2_6(var_2_5, var_2_10003[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end, false)

	return
end

function var_0_1.InitPlayerDate(arg_3_0, arg_3_1)
	getProxy = var_1_10002
	IslandProxy = var_1_10003

	local var_3_0 = var_1_10002(var_1_10003)
	local var_3_1 = var_2.GetIsland(var_3_0)

	ipairs = var_3_0

	local var_3_2

	if not arg_3_1.player_list then
		var_3_2 = {}
	end

	for iter_3_0, iter_3_1 in var_3_0(var_3_2) do
		local var_3_3 = iter_3_1.seat
		local var_3_4 = iter_3_1.player_info
		local var_3_5 = {}

		PlayRoomTools = var_1_10011
		var_3_5.user_view = var_1_10011.GetGameViewID(var_3_4.user_view)
		var_3_5.seat = var_3_3
		var_3_5.id = var_3_4.id

		local var_3_6 = var_3_1

		var_1_10011 = var_3_1.DispatchEvent
		IslandCheaterTavernMonitor = var_1_10013

		var_1_10011(var_3_6, var_1_10013.ADD_CHEATERTAVERN_PLAYER, var_3_5)
	end

	local var_3_7 = var_3_1
	local var_3_8 = var_3_1.DispatchEvent

	IslandCheaterTavernMonitor = var_5

	var_3_8(var_3_7, var_5.INIT_PLAYER_DATA_DONE)

	return
end

return var_0_1
