local var_0_0 = class("NewWarChessDiceItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.stateController_ = ControllerUtil.GetController(arg_3_0.transform_, "point")
	arg_3_0.maskController_ = ControllerUtil.GetController(arg_3_0.transform_, "mask")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		if arg_4_0.clickHandler_ then
			arg_4_0.clickHandler_(arg_4_0.index_)
		end
	end)
end

function var_0_0.SetStatus(arg_6_0, arg_6_1)
	arg_6_0.stateController_:SetSelectedIndex(arg_6_1)
end

function var_0_0.SetData(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.index_ = arg_7_1
	arg_7_0.diceData_ = arg_7_2
	arg_7_0.dicePoint_ = arg_7_0.diceData_[1]

	arg_7_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_8_0)
	if arg_8_0.diceData_.IsNew == true then
		arg_8_0.animator_:Play("ani")
	else
		arg_8_0.animator_:Play("empty")
	end

	arg_8_0.stateController_:SetSelectedIndex(arg_8_0.dicePoint_)

	if arg_8_0.diceData_.hasInput then
		arg_8_0.maskController_:SetSelectedState("true")
	else
		arg_8_0.maskController_:SetSelectedState("false")
	end
end

function var_0_0.SetClickCallBack(arg_9_0, arg_9_1)
	arg_9_0.clickHandler_ = arg_9_1
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0.clickHandler_ = nil

	Object.Destroy(arg_10_0.gameObject_)
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
