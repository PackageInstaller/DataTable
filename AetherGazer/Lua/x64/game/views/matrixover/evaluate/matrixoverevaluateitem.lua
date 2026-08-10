local var_0_0 = class("MatrixOverEvaluateItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
end

function var_0_0.SetEvaluateID(arg_2_0, arg_2_1)
	local var_2_0 = MatrixEvaluateCfg[arg_2_1]

	arg_2_0.titleText_.text = GetI18NText(var_2_0.title)
	arg_2_0.infoText_.text = GetI18NText(var_2_0.condition)

	local var_2_1 = "icon_matrix_assess_b"

	if var_2_0.class == 3 then
		var_2_1 = "icon_matrix_assess_s"
	elseif var_2_0.class == 2 then
		var_2_1 = "icon_matrix_assess_a"
	end

	arg_2_0.icon_.sprite = getSprite("Atlas/Matrix", var_2_1)

	arg_2_0:Show(true)
end

function var_0_0.Show(arg_3_0, arg_3_1)
	SetActive(arg_3_0.gameObject_, arg_3_1)
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)
end

return var_0_0
