class = var_0_10000

local var_0_0 = "ValentineQteGameView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..BaseMiniGameView"))

function var_0_1.getUIName(arg_1_0)
	return "ValentineQteGamePage"
end

function var_0_1.init(arg_2_0)
	ValentineQteGamePage = var_1_10001
	arg_2_0.gameView = var_1_10001.New(arg_2_0._tf)

	return
end

function var_0_1.didEnter(arg_3_0)
	local var_3_0 = arg_3_0:GetMGHubData().usedtime == 0
	local var_3_1 = arg_3_0.gameView

	var_3.SetUp(var_3_1, function()
		local var_4_0 = arg_3_0

		if var_0.GetMGHubData(var_4_0).count > 0 then
			local var_4_1 = arg_3_0

			var_0.SendSuccess(var_4_1, 0)
		end

		return
	end, function()
		if arg_3_0.gameView then
			arg_3_0.gameView = nil
		end

		local var_5_0 = arg_3_0

		var_0.emit(var_5_0, var_0_1.ON_BACK)

		return
	end, var_3_0)

	return
end

function var_0_1.onBackPressed(arg_6_0)
	if arg_6_0.gameView then
		local var_6_0 = arg_6_0.gameView

		if var_1.onBackPressed(var_6_0) then
			return
		end
	end

	var_0_1.super.onBackPressed(arg_6_0)

	return
end

function var_0_1.willExit(arg_7_0)
	if arg_7_0.gameView then
		local var_7_0 = arg_7_0.gameView

		var_1.Destroy(var_7_0)

		arg_7_0.gameView = nil
	end

	return
end

return var_0_1
