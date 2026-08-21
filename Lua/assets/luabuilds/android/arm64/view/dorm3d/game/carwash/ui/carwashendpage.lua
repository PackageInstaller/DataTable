local var_0_0 = class("CarWashEndPage", import("view.dorm3d.Game.Dorm3dGameBaseSubView"))

function var_0_0.Init(arg_1_0)
	arg_1_0:InitUI()
	arg_1_0:BindEvent()
	arg_1_0:Hide()

	return
end

function var_0_0.InitUI(arg_2_0)
	onButton(arg_2_0, arg_2_0._tf:Find("btn_again"), function()
		arg_2_0:emit(CarWashGameFlowSystem.REQUEST_RESTART_GAME)

		return
	end)
	onButton(arg_2_0, arg_2_0._tf:Find("btn_exit"), function()
		arg_2_0:emit(BaseUI.ON_BACK)

		return
	end)

	arg_2_0.cleanRank = arg_2_0._tf:Find("rank")

	setText(arg_2_0._tf:Find("btn_again/text"), i18n("dorm3d_carwash_retry"))
	setText(arg_2_0._tf:Find("btn_exit/text"), i18n("dorm3d_carwash_exit"))

	return
end

function var_0_0.BindEvent(arg_5_0)
	arg_5_0:bind(CarWashGameFlowSystem.UPDATE_GAME_STATE, function(arg_6_0, arg_6_1)
		if arg_6_1.newValue == CarWashConst.GAME_STATE.END then
			arg_5_0:Show()
			arg_5_0:FlushCleanPersent()
		else
			arg_5_0:Hide()
		end

		return
	end)

	return
end

function var_0_0.Flush(arg_7_0)
	return
end

function var_0_0.FlushCleanPersent(arg_8_0)
	local var_8_0 = arg_8_0:GetRank((arg_8_0:GetCleanPersent()))

	eachChild(arg_8_0.cleanRank, function(arg_9_0)
		setActive(arg_9_0, arg_9_0.name == var_8_0)

		return
	end)

	return
end

function var_0_0.GetCleanPersent(arg_10_0)
	if arg_10_0.contextData.gameStatus.stainsCountMax == 0 then
		return 0
	end

	return (math.floor((1 - arg_10_0.contextData.gameStatus.stainsCount / arg_10_0.contextData.gameStatus.stainsCountMax) * 100))
end

function var_0_0.GetRank(arg_11_0, arg_11_1)
	return CarWashConst.GetScoreRank(arg_11_1)
end

return var_0_0
