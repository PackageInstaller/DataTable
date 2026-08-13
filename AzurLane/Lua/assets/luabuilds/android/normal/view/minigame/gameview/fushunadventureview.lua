class = var_0_10000

local var_0_0 = "FushunAdventureView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..BaseMiniGameView"))

function var_0_1.getUIName(arg_1_0)
	return "FushunAdventureUI"
end

function var_0_1.getBGM(arg_2_0)
	FushunAdventureGameConst = var_1_10001

	return var_1_10001.BGM_NAME
end

function var_0_1.didEnter(arg_3_0)
	FushunAdventureGame = var_1_10001
	arg_3_0.game = var_1_10001.New(arg_3_0._go, arg_3_0:GetMGHubData(), arg_3_0:GetMGData())

	local var_3_0 = arg_3_0.game

	var_1.SetOnShowResult(var_3_0, function(arg_4_0)
		local var_4_0 = arg_3_0

		if var_1.GetMGHubData(var_4_0).count > 0 then
			local var_4_1 = arg_3_0

			var_2.SendSuccess(var_4_1, 0)
		end

		local var_4_2 = arg_3_0
		local var_4_3 = var_2.GetMGData(var_4_2)
		local var_4_4

		if not var_2.GetRuntimeData(var_4_3, "elements") then
			var_4_4 = {}
		end

		local var_4_5

		if not var_4_4[1] then
			var_4_5 = 0
		end

		if var_4_5 < arg_4_0 then
			local var_4_6 = arg_3_0

			var_4.StoreDataToServer(var_4_6, {
				arg_4_0
			})
		end

		return
	end)

	local var_3_1 = arg_3_0.game

	var_1.SetOnLevelUpdate(var_3_1, function()
		local var_5_0 = arg_3_0

		var_0.CheckAaward(var_5_0)

		return
	end)

	onButton = var_1

	local var_3_2 = arg_3_0

	findTF = var_3

	local var_3_3 = var_3(arg_3_0._go, "back")

	local function var_3_4()
		local var_6_0 = arg_3_0

		var_0.emit(var_6_0, var_0_1.ON_BACK)

		return
	end

	SFX_PANEL = var_5

	var_1(var_3_2, var_3_3, var_3_4, var_5)
	arg_3_0:CheckAaward()

	return
end

function var_0_1.CheckAaward(arg_7_0)
	local var_7_0 = arg_7_0:GetMGHubData().ultimate
	local var_7_1 = var_1.usedtime
	local var_7_2 = var_1
	local var_7_3 = var_1.getConfig(var_7_2, "reward_need")

	if var_7_0 == 0 and var_7_3 <= var_7_1 then
		pg = var_7_2

		local var_7_4 = var_7_2.m02
		local var_7_5 = var_5.sendNotification

		GAME = var_1_10007

		local var_7_6 = var_1_10007.SEND_MINI_GAME_OP
		local var_7_7 = {
			hubid = var_1.id
		}

		MiniGameOPCommand = var_9
		var_7_7.cmd = var_9.CMD_ULTIMATE
		var_7_7.args1 = {}

		var_7_5(var_7_4, var_7_6, var_7_7)
	end

	return
end

function var_0_1.willExit(arg_8_0)
	if arg_8_0.game then
		local var_8_0 = arg_8_0.game

		var_1.Dispose(var_8_0)

		arg_8_0.game = nil
	end

	return
end

function var_0_1.OnSendMiniGameOPDone(arg_9_0)
	if arg_9_0.game then
		local var_9_0 = arg_9_0.game

		var_1.RefreshLevels(var_9_0)
	end

	return
end

function var_0_1.onBackPressed(arg_10_0)
	if arg_10_0.game then
		local var_10_0 = arg_10_0.game

		if var_1.IsStarting(var_10_0) then
			local var_10_1 = arg_10_0.game

			var_1.ShowPauseMsgbox(var_10_1)
		end
	end

	return
end

return var_0_1
