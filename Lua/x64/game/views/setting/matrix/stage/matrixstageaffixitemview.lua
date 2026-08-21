local var_0_0 = class("MatrixStageAffixItemView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:SetData(arg_1_3)
	arg_1_0:Show(true)
end

function var_0_0.SetData(arg_2_0, arg_2_1)
	arg_2_0.nameText_.text = getAffixName(arg_2_1)
	arg_2_0.icon_.sprite = getAffixSprite(arg_2_1)
	arg_2_0.desc_.text = getAffixDesc(arg_2_1)

	arg_2_0:Show(true)
end

function var_0_0.Show(arg_3_0, arg_3_1)
	SetActive(arg_3_0.gameObject_, arg_3_1)
end

function var_0_0.Dispose(arg_4_0)
	Object.Destroy(arg_4_0.gameObject_)

	arg_4_0.gameObject_ = nil

	var_0_0.super.Dispose(arg_4_0)
end

return var_0_0
