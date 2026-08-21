local var_0_0 = class("BaseMiniGameView", import("..base.BaseUI"))

function var_0_0.SetExtraData(arg_1_0, arg_1_1)
	arg_1_0.mg_extraData = arg_1_1

	return
end

function var_0_0.GetExtraValue(arg_2_0, arg_2_1)
	if arg_2_0.mg_extraData[arg_2_1] then
		return arg_2_0.mg_extraData[arg_2_1]
	else
		return nil
	end

	return
end

function var_0_0.SetMGData(arg_3_0, arg_3_1)
	arg_3_0.mg_data = arg_3_1

	return
end

function var_0_0.GetMGData(arg_4_0)
	return arg_4_0.mg_data
end

function var_0_0.SetMGHubData(arg_5_0, arg_5_1)
	arg_5_0.mg_hubData = arg_5_1

	return
end

function var_0_0.GetMGHubData(arg_6_0)
	return arg_6_0.mg_hubData
end

function var_0_0.setGameRoomData(arg_7_0, arg_7_1)
	arg_7_0.gameRoomData = arg_7_1

	return
end

function var_0_0.getGameRoomData(arg_8_0)
	return arg_8_0.gameRoomData or nil
end

function var_0_0.SendSuccess(arg_9_0, ...)
	arg_9_0:emit(BaseMiniGameMediator.MINI_GAME_SUCCESS, ...)

	return
end

function var_0_0.SendFailure(arg_10_0, ...)
	arg_10_0:emit(BaseMiniGameMediator.MINI_GAME_FAILURE, ...)

	return
end

function var_0_0.StoreDataToServer(arg_11_0, arg_11_1)
	if arg_11_0.mg_data:getConfig("type") == MiniGameConst.MG_TYPE_2 then
		table.insertto({
			arg_11_0.mg_data.id,
			2
		}, arg_11_1)
		arg_11_0.mg_data:SetRuntimeData("elements", arg_11_1)
		arg_11_0:emit(BaseMiniGameMediator.MINI_GAME_OPERATOR, MiniGameOPCommand.CMD_SPECIAL_GAME, {
			arg_11_0.mg_data.id,
			2
		})
	end

	return
end

function var_0_0.SendOperator(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0:emit(BaseMiniGameMediator.MINI_GAME_OPERATOR, arg_12_1, arg_12_2)

	return
end

function var_0_0.OnSendMiniGameOPDone(arg_13_0, arg_13_1)
	return
end

function var_0_0.OnModifyMiniGameDataDone(arg_14_0, arg_14_1)
	return
end

function var_0_0.loadCoinLayer(arg_15_0)
	if not arg_15_0.coinLayer then
		arg_15_0:emit(BaseMiniGameMediator.MINI_GAME_COIN)
	end

	return
end

function var_0_0.setCoinLayer(arg_16_0)
	if arg_16_0.coinLayer then
		return
	end

	arg_16_0:checkTicktRemind()

	arg_16_0.coinLayer = true

	return
end

function var_0_0.openCoinLayer(arg_17_0, arg_17_1)
	if not arg_17_0.coinLayer then
		return
	end

	if arg_17_1 then
		arg_17_0:checkTicktRemind()
	end

	arg_17_0.coinLayerVisible = arg_17_1

	arg_17_0:emit(BaseMiniGameMediator.COIN_WINDOW_CHANGE, arg_17_1)

	return
end

function var_0_0.checkTicktRemind(arg_18_0)
	local var_18_0 = getProxy(GameRoomProxy):ticketMaxTip()

	if var_18_0 and not GameRoomProxy.ticket_remind then
		GameRoomProxy.ticket_remind = true

		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = var_18_0,
			onYes = function()
				return
			end,
			onNo = function()
				arg_18_0:closeView()

				return
			end
		})
	end

	return
end

function var_0_0.OnGetAwardDone(arg_21_0, arg_21_1)
	return
end

function var_0_0.OnApplicationPaused(arg_22_0, arg_22_1)
	return
end

return var_0_0
