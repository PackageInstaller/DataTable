local var_0_0 = class("SurpassUpAttrItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
end

function var_0_0.RefreshUi(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = PublicAttrCfg[arg_3_1]

	arg_3_0.icon01Img_.sprite = getSprite("Atlas/SystemCommonAtlas", var_3_0.icon)
	arg_3_0.textattack01Text_.text = var_3_0.name

	local var_3_1 = var_3_0.percent == 1 and string.format("%.2f", (arg_3_3 - arg_3_2) / 10) .. "%" or string.format("%.0f", arg_3_3 - arg_3_2)

	arg_3_0.textnum01Text_.text = var_3_1

	local var_3_2 = var_3_0.percent == 1 and string.format("%.2f", arg_3_3 / 10) .. "%" or string.format("%.0f", arg_3_3)

	arg_3_0.textnumup01Text_.text = var_3_2

	arg_3_0:SetActive(true)
end

function var_0_0.SetActive(arg_4_0, arg_4_1)
	arg_4_0.gameObject_:SetActive(arg_4_1)
end

function var_0_0.Dispose(arg_5_0)
	var_0_0.super.Dispose(arg_5_0)
end

return var_0_0
