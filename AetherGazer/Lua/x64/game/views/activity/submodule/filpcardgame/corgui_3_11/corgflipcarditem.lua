local var_0_0 = class("CORGFlipCardItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddUIListener()

	arg_2_0.typeController_ = arg_2_0.controller_:GetController("type")
end

function var_0_0.AddUIListener(arg_3_0)
	return
end

function var_0_0.RefreshUI(arg_4_0)
	local var_4_0 = FlipCardCfg[XH3rdFlipCardData:GetActivityID()]

	if var_4_0.atlas_name ~= "" and var_4_0.normal_front_back_icon ~= "" and var_4_0.special_front_back_icon ~= "" then
		arg_4_0.normalBg_.sprite = getSprite(var_4_0.atlas_name, var_4_0.normal_front_back_icon)
		arg_4_0.specialBg_.sprite = getSprite(var_4_0.atlas_name, var_4_0.special_front_back_icon)
	else
		arg_4_0.normalBg_.spriteAsync = var_4_0.normal_front_back_icon
		arg_4_0.specialBg_.spriteAsync = var_4_0.special_front_back_icon
	end

	if var_4_0.icon_path ~= "" then
		arg_4_0.icon_.spriteAsync = var_4_0.icon_path .. "_" .. arg_4_0.id_
	end
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.index_ = arg_5_1
	arg_5_0.id_ = arg_5_2

	arg_5_0:RefreshUI()
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)
end

return var_0_0
