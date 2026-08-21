local var_0_0 = class("LanternFestivalView", import("..BaseMiniGameView"))

function var_0_0.getUIName(arg_1_0)
	return "LanternFestivalUI"
end

function var_0_0.didEnter(arg_2_0)
	arg_2_0.controller = LanternRiddlesController.New()

	arg_2_0.controller.view:SetUI(arg_2_0._tf)
	arg_2_0.controller:SetCallBack(function()
		arg_2_0:emit(var_0_0.ON_BACK)

		return
	end, function()
		arg_2_0:emit(var_0_0.ON_HOME)

		return
	end, function()
		if arg_2_0:GetMGHubData().count > 0 then
			arg_2_0:SendSuccess(0)
		end

		return
	end, function()
		arg_2_0:StoreDataToServer((arg_2_0.controller:GetSaveData()))

		return
	end)
	arg_2_0.controller:SetUp((arg_2_0:PackData()))

	return
end

function var_0_0.PackData(arg_7_0)
	local var_7_0 = arg_7_0:GetMGHubData()
	local var_7_1 = arg_7_0:GetMGData():GetRuntimeData("elements")
	local var_7_2
	local var_7_3

	if var_7_1 and #var_7_1 > 0 then
		var_7_2 = _.slice(var_7_1, 1, 15)
		var_7_3 = _.slice(var_7_1, 15 + 1, var_7_0.usedtime)
	else
		var_7_2 = {}

		for iter_7_0 = 1, 15 do
			table.insert(var_7_2, 0)
		end

		var_7_3 = {}
	end

	return {
		finishCount = var_7_0.usedtime,
		unlockCount = var_7_0.count,
		nextTimes = var_7_2,
		finishList = var_7_3
	}
end

function var_0_0.OnGetAwardDone(arg_8_0, arg_8_1)
	if arg_8_1.cmd == MiniGameOPCommand.CMD_COMPLETE then
		local var_8_0 = arg_8_0:GetMGHubData()

		if var_8_0.ultimate == 0 and var_8_0:getConfig("reward_need") <= var_8_0.usedtime then
			pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
				hubid = var_8_0.id,
				cmd = MiniGameOPCommand.CMD_ULTIMATE,
				args1 = {}
			})
		end
	end

	return
end

function var_0_0.willExit(arg_9_0)
	arg_9_0.controller:Dispose()

	return
end

return var_0_0
