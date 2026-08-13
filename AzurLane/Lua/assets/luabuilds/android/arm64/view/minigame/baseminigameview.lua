class = var_0_10000

local var_0_0 = "BaseMiniGameView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseUI"))

function var_0_1.SetExtraData(arg_1_0, arg_1_1)
	arg_1_0.mg_extraData = arg_1_1

	return
end

function var_0_1.GetExtraValue(arg_2_0, arg_2_1)
	if arg_2_0.mg_extraData[arg_2_1] then
		return arg_2_0.mg_extraData[arg_2_1]
	else
		return nil
	end

	return
end

function var_0_1.SetMGData(arg_3_0, arg_3_1)
	arg_3_0.mg_data = arg_3_1

	return
end

function var_0_1.GetMGData(arg_4_0)
	return arg_4_0.mg_data
end

function var_0_1.SetMGHubData(arg_5_0, arg_5_1)
	arg_5_0.mg_hubData = arg_5_1

	return
end

function var_0_1.GetMGHubData(arg_6_0)
	return arg_6_0.mg_hubData
end

function var_0_1.setGameRoomData(arg_7_0, arg_7_1)
	arg_7_0.gameRoomData = arg_7_1

	return
end

function var_0_1.getGameRoomData(arg_8_0)
	local var_8_0

	if not arg_8_0.gameRoomData then
		var_8_0 = nil
	end

	return var_8_0
end

function var_0_1.SendSuccess(arg_9_0, ...)
	local var_9_0 = arg_9_0
	local var_9_1 = arg_9_0.emit

	BaseMiniGameMediator = var_1_10004

	var_9_1(var_9_0, var_1_10004.MINI_GAME_SUCCESS, ...)

	return
end

function var_0_1.SendFailure(arg_10_0, ...)
	local var_10_0 = arg_10_0
	local var_10_1 = arg_10_0.emit

	BaseMiniGameMediator = var_1_10004

	var_10_1(var_10_0, var_1_10004.MINI_GAME_FAILURE, ...)

	return
end

function var_0_1.StoreDataToServer(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0.mg_data
	local var_11_1 = var_2.getConfig(var_11_0, "type")

	MiniGameConst = var_1_10003

	if var_11_1 == var_1_10003.MG_TYPE_2 then
		local var_11_2 = {
			arg_11_0.mg_data.id,
			2
		}

		table = var_4

		var_4.insertto(var_11_2, arg_11_1)

		local var_11_3 = arg_11_0.mg_data

		var_4.SetRuntimeData(var_11_3, "elements", arg_11_1)

		local var_11_4 = arg_11_0
		local var_11_5 = arg_11_0.emit

		BaseMiniGameMediator = var_7

		local var_11_6 = var_7.MINI_GAME_OPERATOR

		MiniGameOPCommand = var_8

		var_11_5(var_11_4, var_11_6, var_8.CMD_SPECIAL_GAME, var_11_2)
	end

	return
end

function var_0_1.SendOperator(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0
	local var_12_1 = arg_12_0.emit

	BaseMiniGameMediator = var_1_10006

	var_12_1(var_12_0, var_1_10006.MINI_GAME_OPERATOR, arg_12_1, arg_12_2)

	return
end

function var_0_1.OnSendMiniGameOPDone(arg_13_0, arg_13_1)
	return
end

function var_0_1.OnModifyMiniGameDataDone(arg_14_0, arg_14_1)
	return
end

function var_0_1.loadCoinLayer(arg_15_0)
	if not arg_15_0.coinLayer then
		local var_15_0 = arg_15_0
		local var_15_1 = arg_15_0.emit

		BaseMiniGameMediator = var_1_10004

		var_15_1(var_15_0, var_1_10004.MINI_GAME_COIN)
	end

	return
end

function var_0_1.setCoinLayer(arg_16_0)
	if arg_16_0.coinLayer then
		return
	end

	arg_16_0:checkTicktRemind()

	arg_16_0.coinLayer = true

	return
end

function var_0_1.openCoinLayer(arg_17_0, arg_17_1)
	if not arg_17_0.coinLayer then
		return
	end

	if arg_17_1 then
		arg_17_0:checkTicktRemind()
	end

	arg_17_0.coinLayerVisible = arg_17_1

	local var_17_0 = arg_17_0
	local var_17_1 = arg_17_0.emit

	BaseMiniGameMediator = var_1_10005

	var_17_1(var_17_0, var_1_10005.COIN_WINDOW_CHANGE, arg_17_1)

	return
end

function var_0_1.checkTicktRemind(arg_18_0)
	getProxy = var_1_10001
	GameRoomProxy = var_1_10003

	local var_18_0 = var_1_10001(var_1_10003)

	if var_1.ticketMaxTip(var_18_0) then
		GameRoomProxy = var_1_10002

		if not var_1_10002.ticket_remind then
			GameRoomProxy = var_2
			var_2.ticket_remind = true
			pg = var_2

			local var_18_1 = var_2.MsgboxMgr.GetInstance()

			var_2.ShowMsgBox(var_18_1, {
				content = var_1,
				onYes = function()
					return
				end,
				onNo = function()
					local var_20_0 = arg_18_0

					var_0.closeView(var_20_0)

					return
				end
			})
		end
	end

	return
end

function var_0_1.OnGetAwardDone(arg_21_0, arg_21_1)
	return
end

function var_0_1.OnApplicationPaused(arg_22_0, arg_22_1)
	return
end

return var_0_1
