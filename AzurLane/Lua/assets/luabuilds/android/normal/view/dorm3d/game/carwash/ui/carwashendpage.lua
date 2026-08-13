class = var_0_10000

local var_0_0 = "CarWashEndPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.dorm3d.Game.Dorm3dGameBaseSubView"))

function var_0_1.Init(arg_1_0)
	arg_1_0:InitUI()
	arg_1_0:BindEvent()
	arg_1_0:Hide()

	return
end

function var_0_1.InitUI(arg_2_0)
	onButton = var_1_10001

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0._tf

	var_1_10001(var_2_0, var_3.Find(var_2_1, "btn_again"), function()
		local var_3_0 = arg_2_0
		local var_3_1 = var_0.emit

		CarWashGameFlowSystem = var_2_10002

		var_3_1(var_3_0, var_2_10002.REQUEST_RESTART_GAME)

		return
	end)

	onButton = var_1_10001

	local var_2_2 = arg_2_0
	local var_2_3 = arg_2_0._tf

	var_1_10001(var_2_2, var_3.Find(var_2_3, "btn_exit"), function()
		local var_4_0 = arg_2_0
		local var_4_1 = var_0.emit

		BaseUI = var_2_10002

		var_4_1(var_4_0, var_2_10002.ON_BACK)

		return
	end)

	local var_2_4 = arg_2_0._tf

	arg_2_0.cleanRank = var_1.Find(var_2_4, "rank")
	setText = var_1

	local var_2_5 = arg_2_0._tf
	local var_2_6 = var_2.Find(var_2_5, "btn_again/text")

	i18n = var_2_5

	var_1(var_2_6, var_2_5("dorm3d_carwash_retry"))

	setText = var_1

	local var_2_7 = arg_2_0._tf
	local var_2_8 = var_2.Find(var_2_7, "btn_exit/text")

	i18n = var_2_7

	var_1(var_2_8, var_2_7("dorm3d_carwash_exit"))

	return
end

function var_0_1.BindEvent(arg_5_0)
	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.bind

	CarWashGameFlowSystem = var_1_10003

	var_5_1(var_5_0, var_1_10003.UPDATE_GAME_STATE, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_6_1.newValue

		CarWashConst = var_2_10003

		if var_6_0 == var_2_10003.GAME_STATE.END then
			local var_6_1 = arg_5_0

			var_2.Show(var_6_1)

			local var_6_2 = arg_5_0

			var_2.FlushCleanPersent(var_6_2)
		else
			local var_6_3 = arg_5_0

			var_2.Hide(var_6_3)
		end

		return
	end)

	return
end

function var_0_1.Flush(arg_7_0)
	return
end

function var_0_1.FlushCleanPersent(arg_8_0)
	local var_8_0 = arg_8_0:GetCleanPersent()
	local var_8_1 = arg_8_0
	local var_8_2 = arg_8_0.GetRank(var_8_1, var_8_0)

	eachChild = var_8_1

	var_8_1(arg_8_0.cleanRank, function(arg_9_0)
		setActive = var_2_10001

		var_2_10001(arg_9_0, arg_9_0.name == var_8_2)

		return
	end)

	return
end

function var_0_1.GetCleanPersent(arg_10_0)
	if arg_10_0.contextData.gameStatus.stainsCountMax == 0 then
		return 0
	end

	local var_10_0 = 1 - arg_10_0.contextData.gameStatus.stainsCount / arg_10_0.contextData.gameStatus.stainsCountMax

	math = var_2

	return (var_2.floor(var_10_0 * 100))
end

function var_0_1.GetRank(arg_11_0, arg_11_1)
	CarWashConst = var_1_10002

	return var_1_10002.GetScoreRank(arg_11_1)
end

return var_0_1
