local var_0_0 = class("FushunAdventureView", import("..BaseMiniGameView"))

function var_0_0.getUIName(arg_1_0)
	return "FushunAdventureUI"
end

function var_0_0.getBGM(arg_2_0)
	return FushunAdventureGameConst.BGM_NAME
end

function var_0_0.didEnter(arg_3_0)
	arg_3_0.game = FushunAdventureGame.New(arg_3_0._go, arg_3_0:GetMGHubData(), arg_3_0:GetMGData())

	arg_3_0.game:SetOnShowResult(function(arg_4_0)
		if arg_3_0:GetMGHubData().count > 0 then
			arg_3_0:SendSuccess(0)
		end

		local var_4_0 = arg_3_0:GetMGData():GetRuntimeData("elements")

		var_4_0 = var_4_0 or {}

		local var_4_1 = var_4_0[1] or 0

		if var_4_1 < arg_4_0 then
			arg_3_0:StoreDataToServer({
				arg_4_0
			})
		end

		return
	end)
	arg_3_0.game:SetOnLevelUpdate(function()
		arg_3_0:CheckAaward()

		return
	end)
	onButton(arg_3_0, findTF(arg_3_0._go, "back"), function()
		arg_3_0:emit(var_0_0.ON_BACK)

		return
	end, SFX_PANEL)
	arg_3_0:CheckAaward()

	return
end

function var_0_0.CheckAaward(arg_7_0)
	local var_7_0 = arg_7_0:GetMGHubData()

	if var_7_0.ultimate == 0 and var_7_0:getConfig("reward_need") <= var_7_0.usedtime then
		pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = var_7_0.id,
			cmd = MiniGameOPCommand.CMD_ULTIMATE,
			args1 = {}
		})
	end

	return
end

function var_0_0.willExit(arg_8_0)
	if arg_8_0.game then
		arg_8_0.game:Dispose()

		arg_8_0.game = nil
	end

	return
end

function var_0_0.OnSendMiniGameOPDone(arg_9_0)
	if arg_9_0.game then
		arg_9_0.game:RefreshLevels()
	end

	return
end

function var_0_0.onBackPressed(arg_10_0)
	if arg_10_0.game and arg_10_0.game:IsStarting() then
		arg_10_0.game:ShowPauseMsgbox()
	end

	return
end

return var_0_0
