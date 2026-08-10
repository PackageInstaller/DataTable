local var_0_0 = class("MoonFillingMaterialItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.statusController_ = ControllerUtil.GetController(arg_2_0.transform_, "status")
end

function var_0_0.SetData(arg_3_0, arg_3_1)
	arg_3_0.activityID_ = activityID
	arg_3_0.ID_ = arg_3_1
	arg_3_0.nameText_.text = ""

	arg_3_0.SetActive(true)
end

function var_0_0.SetNum(arg_4_0, arg_4_1)
	arg_4_0.numText_.text = arg_4_1
end

function var_0_0.SetEnough(arg_5_0, arg_5_1)
	if arg_5_0.statusController_ then
		arg_5_0.statusController_:SetSelectedState(arg_5_1 and "true" or "false")
	end
end

function var_0_0.SetActive(arg_6_0, arg_6_1)
	SetActive(arg_6_0.gameObject_, arg_6_1)
end

return var_0_0
