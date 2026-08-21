local var_0_0 = class("DormDanceHeroItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.onClick_ = nil

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.selectController_ = arg_3_0.mainControllerEx_:GetController("select")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		arg_4_0.onClick_(arg_4_0.heroID_)
	end)
end

function var_0_0.Show(arg_6_0, arg_6_1)
	arg_6_0.heroID_ = arg_6_1
	arg_6_0.headIcon_.sprite = DormHeroTools.GetBackHomeHeadSprite(arg_6_1, true)

	SetActive(arg_6_0.gameObject_, true)
end

function var_0_0.Hide(arg_7_0)
	SetActive(arg_7_0.gameObject_, false)
end

function var_0_0.SetSelectState(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.heroID_ == arg_8_1 and true or false

	arg_8_0.selectController_:SetSelectedState(var_8_0 and "true" or "false")
end

function var_0_0.RegistCallBack(arg_9_0, arg_9_1)
	arg_9_0.onClick_ = arg_9_1
end

function var_0_0.Dispose(arg_10_0)
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
