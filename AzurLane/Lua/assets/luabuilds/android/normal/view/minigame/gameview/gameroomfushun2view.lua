class = var_0_10000

local var_0_0 = "GameRoomFushun2View"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..BaseMiniGameView"))

function var_0_1.getUIName(arg_1_0)
	return "GameRoomFushun2UI"
end

function var_0_1.getBGM(arg_2_0)
	FushunAdventureGameConst = var_1_10001

	return var_1_10001.BGM_NAME
end

function var_0_1.didEnter(arg_3_0)
	FushunAdventureGame = var_1_10001
	arg_3_0.game = var_1_10001.New(arg_3_0._go, arg_3_0:GetMGHubData(), arg_3_0:GetMGData())

	local var_3_0 = arg_3_0.game

	var_1.SetGameStateCallback(var_3_0, function()
		local var_4_0 = arg_3_0

		var_0.openCoinLayer(var_4_0, false)

		return
	end, function()
		local var_5_0 = arg_3_0

		var_0.openCoinLayer(var_5_0, true)

		return
	end)

	local var_3_1 = arg_3_0.game

	var_1.SetOnShowResult(var_3_1, function(arg_6_0)
		local var_6_0 = arg_3_0
		local var_6_1 = var_1.GetMGHubData(var_6_0)
		local var_6_2 = arg_3_0

		var_2.SendSuccess(var_6_2, arg_6_0)

		return
	end)

	local var_3_2 = arg_3_0.game

	var_1.SetOnLevelUpdate(var_3_2, function()
		local var_7_0 = arg_3_0

		var_0.CheckAaward(var_7_0)

		return
	end)

	local var_3_3 = arg_3_0.game

	var_1.setRoomTip(var_3_3, arg_3_0:getGameRoomData().game_help)

	local var_3_4 = arg_3_0.game

	var_1.setRoomId(var_3_4, arg_3_0:getGameRoomData().id)

	onButton = var_1

	local var_3_5 = arg_3_0

	findTF = var_3

	local var_3_6 = var_3(arg_3_0._go, "back")

	local function var_3_7()
		local var_8_0 = arg_3_0

		var_0.emit(var_8_0, var_0_1.ON_BACK)

		return
	end

	SFX_PANEL = var_5

	var_1(var_3_5, var_3_6, var_3_7, var_5)
	arg_3_0:CheckAaward()

	return
end

function var_0_1.CheckAaward(arg_9_0)
	return
end

function var_0_1.willExit(arg_10_0)
	if arg_10_0.game then
		local var_10_0 = arg_10_0.game

		var_1.Dispose(var_10_0)

		arg_10_0.game = nil
	end

	return
end

function var_0_1.OnSendMiniGameOPDone(arg_11_0)
	if arg_11_0.game then
		local var_11_0 = arg_11_0.game

		var_1.RefreshLevels(var_11_0)
	end

	return
end

function var_0_1.onBackPressed(arg_12_0)
	if arg_12_0.game then
		local var_12_0 = arg_12_0.game

		if var_1.IsStarting(var_12_0) then
			local var_12_1 = arg_12_0.game

			var_1.ShowPauseMsgbox(var_12_1)
		end
	end

	return
end

return var_0_1
