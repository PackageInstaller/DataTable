local var_0_0 = class("GameRoomFushun2View", import("..BaseMiniGameView"))

function var_0_0.getUIName(arg_1_0)
	return "GameRoomFushun2UI"
end

function var_0_0.getBGM(arg_2_0)
	return FushunAdventureGameConst.BGM_NAME
end

function var_0_0.didEnter(arg_3_0)
	arg_3_0.game = FushunAdventureGame.New(arg_3_0._go, arg_3_0:GetMGHubData(), arg_3_0:GetMGData())

	arg_3_0.game:SetGameStateCallback(function()
		arg_3_0:openCoinLayer(false)

		return
	end, function()
		arg_3_0:openCoinLayer(true)

		return
	end)
	arg_3_0.game:SetOnShowResult(function(arg_6_0)
		local var_6_0 = arg_3_0:GetMGHubData()

		arg_3_0:SendSuccess(arg_6_0)

		return
	end)
	arg_3_0.game:SetOnLevelUpdate(function()
		arg_3_0:CheckAaward()

		return
	end)
	arg_3_0.game:setRoomTip(arg_3_0:getGameRoomData().game_help)
	arg_3_0.game:setRoomId(arg_3_0:getGameRoomData().id)
	onButton(arg_3_0, findTF(arg_3_0._go, "back"), function()
		arg_3_0:emit(var_0_0.ON_BACK)

		return
	end, SFX_PANEL)
	arg_3_0:CheckAaward()

	return
end

function var_0_0.CheckAaward(arg_9_0)
	return
end

function var_0_0.willExit(arg_10_0)
	if arg_10_0.game then
		arg_10_0.game:Dispose()

		arg_10_0.game = nil
	end

	return
end

function var_0_0.OnSendMiniGameOPDone(arg_11_0)
	if arg_11_0.game then
		arg_11_0.game:RefreshLevels()
	end

	return
end

function var_0_0.onBackPressed(arg_12_0)
	if arg_12_0.game and arg_12_0.game:IsStarting() then
		arg_12_0.game:ShowPauseMsgbox()
	end

	return
end

return var_0_0
