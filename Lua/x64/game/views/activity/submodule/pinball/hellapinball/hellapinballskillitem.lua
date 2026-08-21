local var_0_0 = class("HellaPinballSkillItem", BaseView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddUIListener()

	arg_2_0.statusController_ = arg_2_0.controllerEx_:GetController("status")
end

function var_0_0.AddUIListener(arg_3_0)
	return
end

function var_0_0.SetData(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.index_ = arg_4_1
	arg_4_0.id_ = arg_4_2

	arg_4_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_5_0)
	local var_5_0 = PinballSkillCfg[arg_5_0.id_]

	if var_5_0 then
		arg_5_0.icon_.sprite = pureGetSpriteWithoutAtlas(var_5_0.icon)

		arg_5_0.statusController_:SetSelectedState("normal")
	else
		arg_5_0.statusController_:SetSelectedState("empty")
	end
end

function var_0_0.SetSelect(arg_6_0, arg_6_1)
	return
end

function var_0_0.SetClickCallBack(arg_7_0, arg_7_1)
	return
end

return var_0_0
