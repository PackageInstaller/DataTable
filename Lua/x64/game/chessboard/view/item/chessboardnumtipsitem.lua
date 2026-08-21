local var_0_0 = class("ChessBoardNumTipsItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.stateController = arg_3_0.controller_:GetController("state")
end

function var_0_0.RefreshUI(arg_4_0, arg_4_1)
	SetActive(arg_4_0.gameObject_, true)

	arg_4_0.goodText_.text = string.format("+%s", arg_4_1)
	arg_4_0.badText_.text = arg_4_1

	arg_4_0.stateController:SetSelectedState(arg_4_1 > 0 and "up" or "down")

	if arg_4_1 > 0 then
		manager.audio:PlayEffect("minigame_activity_3_3", "minigame_activity_3_3_chess_gridui_getcoin", "")
	else
		manager.audio:PlayEffect("minigame_activity_3_3", "minigame_activity_3_3_chess_gridui_losecoin", "")
	end

	arg_4_0:AddTimer()
end

function var_0_0.DelTimer(arg_5_0)
	if arg_5_0.timer then
		arg_5_0.timer:Stop()

		arg_5_0.timer = nil
	end
end

function var_0_0.AddTimer(arg_6_0)
	arg_6_0:DelTimer()

	arg_6_0.timer = Timer.New(function()
		SetActive(arg_6_0.gameObject_, false)
	end, 1.5)

	arg_6_0.timer:Start()
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0:DelTimer()
	arg_8_0.super.Dispose(arg_8_0)
end

return var_0_0
