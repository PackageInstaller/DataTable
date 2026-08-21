local var_0_0 = class("GuildActivitySpAffixItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.statusController_ = ControllerUtil.GetController(arg_2_0.gameObject_.transform, "bp")

	arg_2_0:AddUIListener()
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.showButton, nil, function()
		if arg_3_0.clickCallBack then
			arg_3_0.clickCallBack()
		end
	end)
end

function var_0_0.RefreshUI(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.affixInfo = arg_5_1
	arg_5_0.iconImg_.sprite = getAffixSprite(arg_5_1)

	if arg_5_2 then
		arg_5_0.statusController_:SetSelectedState("true")
	else
		arg_5_0.statusController_:SetSelectedState("false")
	end
end

function var_0_0.SetClickCallBack(arg_6_0, arg_6_1)
	if arg_6_1 then
		arg_6_0.clickCallBack = arg_6_1
	end
end

function var_0_0.Dispose(arg_7_0)
	var_0_0.super.Dispose(arg_7_0)
end

return var_0_0
