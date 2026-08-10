local var_0_0 = class("TrainBtnItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddUIListener()

	arg_2_0.upgradeController_ = arg_2_0.mainControllerEx_:GetController("upgradeState")
	arg_2_0.costController_ = arg_2_0.mainControllerEx_:GetController("costState")
	arg_2_0.selectController_ = arg_2_0.mainControllerEx_:GetController("select")
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btn_, nil, function()
		if arg_3_0.maxState_ then
			return
		end

		if arg_3_0.select_ and arg_3_0.timeOut_ then
			ShowTips(GetTips("IDOL_TRAIN_TIMES_NOT_ENOUGH"))

			return
		end

		if arg_3_0.select_ and not arg_3_0.costState_ then
			ShowTips(GetTips("DORM_FATIGUE_NOT_ENOUGH"))

			return
		end

		if arg_3_0.select_ and not arg_3_0.maxState_ and not arg_3_0.timeOut_ and arg_3_0.costState_ then
			IdolTraineeAction.TrainHeroProperty(arg_3_0.heroID_, arg_3_0.propertyIndex_)
		end

		if arg_3_0.clickFunc then
			arg_3_0.clickFunc(arg_3_0.propertyIndex_)
		end
	end)
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5, arg_5_6)
	arg_5_0.heroID_ = arg_5_1
	arg_5_0.propertyIndex_ = arg_5_2
	arg_5_0.maxState_ = arg_5_3
	arg_5_0.timeOut_ = arg_5_6
	arg_5_0.costState_ = arg_5_4
	arg_5_0.costText_.text = GameSetting.dorm_idol_hero_exercise_cost.value[1]

	arg_5_0.costController_:SetSelectedState(arg_5_4 and "true" or "false")

	if arg_5_3 then
		arg_5_0.upgradeController_:SetSelectedState("max")
	else
		arg_5_0.upgradeController_:SetSelectedState("cannot")
	end
end

function var_0_0.RegisterClickFunc(arg_6_0, arg_6_1)
	arg_6_0.clickFunc = arg_6_1
end

function var_0_0.RefreshBtnState(arg_7_0, arg_7_1)
	if arg_7_0.propertyIndex_ == arg_7_1 then
		arg_7_0.selectController_:SetSelectedState("state1")

		arg_7_0.select_ = true
	else
		arg_7_0.selectController_:SetSelectedState("state0")

		arg_7_0.select_ = false
	end
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
