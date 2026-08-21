local var_0_0 = class("SeaWarfareGmButtomItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.selectController_ = arg_3_0.controllerEx_:GetController("select")
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		arg_4_0.clickCallback(arg_4_0.id_)
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1)
	arg_6_0.id_ = arg_6_1
	arg_6_0.title_.text = arg_6_1
end

function var_0_0.SetSelect(arg_7_0, arg_7_1)
	arg_7_0.selectController_:SetSelectedState(arg_7_1 and "on" or "off")
end

function var_0_0.SetClickCallBack(arg_8_0, arg_8_1)
	arg_8_0.clickCallback = arg_8_1
end

function var_0_0.GetID(arg_9_0)
	return arg_9_0.id_
end

return var_0_0
