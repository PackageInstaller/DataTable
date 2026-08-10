local var_0_0 = class("SPHeroChallengeScheduleStartItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.stateController = arg_3_0.controller:GetController("state")
end

function var_0_0.RefreshUI(arg_4_0, arg_4_1)
	arg_4_0.scheduleID = arg_4_1.scheduleID

	if not arg_4_0.scheduleID then
		arg_4_0.state = "empty"
		arg_4_0.index = arg_4_1.index

		arg_4_0.stateController:SetSelectedState("empty")
	else
		arg_4_0.stateController:SetSelectedState("start")

		arg_4_0.index = arg_4_1.index
		arg_4_0.iconImg_.sprite = SPHeroChallengeTools:GetScheduleIcon(arg_4_0.scheduleID)
		arg_4_0.nameText_.text = ActivityHeroChallengeScheduleCfg[arg_4_0.scheduleID].name
		arg_4_0.descText_.text = ActivityHeroChallengeScheduleCfg[arg_4_0.scheduleID].linkgame_des

		if arg_4_1.isFinish then
			arg_4_0.stateController:SetSelectedState("grey")
		else
			arg_4_0.stateController:SetSelectedState("start")
		end
	end
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.reduceBtn_, nil, function()
		local var_6_0 = SPHeroChallengeData:GetCurActivityInfo()

		if var_6_0 and arg_5_0.scheduleID then
			var_6_0:RemoveScheduleInDailyList(arg_5_0.scheduleID, arg_5_0.index)
		end

		if arg_5_0.cancelFunc then
			arg_5_0.cancelFunc()
		end
	end)
end

function var_0_0.RegisterCancelCallBack(arg_7_0, arg_7_1)
	if arg_7_1 then
		arg_7_0.cancelFunc = arg_7_1
	end
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
