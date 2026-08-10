local var_0_0 = class("AutoChessMedalItem", BaseView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.id = arg_1_2

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddUIListeners()

	arg_2_0.iconController1001_ = arg_2_0.controller1001_:GetController("state")
	arg_2_0.iconController1002_ = arg_2_0.controller1002_:GetController("state")
	arg_2_0.iconController1003_ = arg_2_0.controller1003_:GetController("state")
	arg_2_0.iconController1004_ = arg_2_0.controller1004_:GetController("state")
end

function var_0_0.AddUIListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btn_, nil, function()
		JumpTools.OpenPageByJump("autoChessMedalInfoView", {
			id = arg_3_0.id
		})
		OperationRecorder.RecordButtonTouch({
			source = 1,
			button_name = "activity_autochess_achie_touch",
			activity_id = AutoChessData:GetActivityID()
		})
	end)
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.id = arg_5_1

	local var_5_0 = AutoChessMedalCfg[arg_5_1]
	local var_5_1, var_5_2 = AutoChessData:FindMedalInfo(arg_5_1)
	local var_5_3 = AutoChessData.IsMedalUnlockedFromInfo(var_5_2)

	SetActive(arg_5_0.gameObject_, var_5_3)

	if arg_5_2 then
		arg_5_0.anim_:Play("medalItem", 0, 0)
	end

	if var_5_3 then
		local var_5_4 = AutoChessData.IsMedalAdvancedFromInfo(var_5_2)

		arg_5_0["iconController" .. arg_5_0.id .. "_"]:SetSelectedState(var_5_4 and "03" or "01")
	end
end

function var_0_0.SetOnClick(arg_6_0, arg_6_1)
	arg_6_0.onClick = arg_6_1
end

function var_0_0.SetTips(arg_7_0, arg_7_1)
	arg_7_0.onTips = arg_7_1
end

return var_0_0
