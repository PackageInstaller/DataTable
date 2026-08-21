local var_0_0 = class("BackHomeCricketBuffItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddBtnListener(arg_2_0.buffBtn_, nil, arg_2_0.OnClick, arg_2_0)
end

function var_0_0.RefreshUI(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.buffID = arg_3_1.id
	arg_3_0.buffIcon_.sprite = IdolTraineeTools:GetBuffIcon(arg_3_0.buffID)

	if arg_3_1.showDuration then
		arg_3_0.buffRoundText_.text = arg_3_1.duration
	else
		arg_3_0.buffRoundText_.text = ""
	end

	arg_3_0.showInfoFunc = arg_3_2
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)
end

function var_0_0.OnClick(arg_5_0)
	manager.notify:CallUpdateFunc("OnBuffIconClick", arg_5_0.buffID, arg_5_0.showInfoFunc)
end

return var_0_0
