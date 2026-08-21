local var_0_0 = class("AdvanceTestMainItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()
	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0.selectController_ = ControllerUtil.GetController(arg_2_0.transform_, "status")
end

function var_0_0.Dispose(arg_3_0)
	var_0_0.super.Dispose(arg_3_0)
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.button_, nil, function()
		if arg_4_0.clickFunc_ then
			arg_4_0.clickFunc_(arg_4_0.subStageID)
		end
	end)
end

function var_0_0.RefreshUI(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0.subStageID = arg_6_1
	arg_6_0.cacheActivityID = arg_6_3

	arg_6_0:SetSelectMode(arg_6_0.subStageID == arg_6_2)

	local var_6_0 = AdvanceTestCfg[arg_6_1]
	local var_6_1 = AdvanceTestData:GetHistortyMaxScoreByIndex(var_6_0.stage_type, arg_6_0.cacheActivityID)

	if var_6_1 == -1 then
		arg_6_0.scoreText_.text = ""
	else
		arg_6_0.scoreText_.text = var_6_1
	end

	local var_6_2 = AdvanceTestCfg[arg_6_1]
	local var_6_3

	if var_6_2.stage_type == 1 then
		local var_6_4 = GetTips("TEST_CHALLENGE_SS")

		arg_6_0.stageText_.text = string.format(GetTips("TEST_CHALLENGE_TIPS_6"), var_6_4)
	elseif var_6_2.stage_type == 2 then
		local var_6_5 = GetTips("TEST_CHALLENGE_SSS")

		arg_6_0.stageText_.text = string.format(GetTips("TEST_CHALLENGE_TIPS_6"), var_6_5)
	elseif var_6_2.stage_type == 3 then
		local var_6_6 = GetTips("TEST_CHALLENGE_OMEGA")

		arg_6_0.stageText_.text = string.format(GetTips("TEST_CHALLENGE_TIPS_6"), var_6_6)
	else
		local var_6_7 = GetTips("TEST_CHALLENGE_SPE")

		arg_6_0.stageText_.text = string.format(GetTips("TEST_CHALLENGE_TIPS_6"), var_6_7)
	end
end

function var_0_0.SetSelectMode(arg_7_0, arg_7_1)
	if arg_7_1 then
		arg_7_0.selectController_:SetSelectedState("selected")
	else
		arg_7_0.selectController_:SetSelectedState("normal")
	end
end

function var_0_0.RegistClickFunc(arg_8_0, arg_8_1)
	arg_8_0.clickFunc_ = arg_8_1
end

return var_0_0
