local var_0_0 = class("MatrixArtifactSettingItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
end

function var_0_0.SetData(arg_2_0, arg_2_1)
	local var_2_0 = MatrixItemCfg[arg_2_1]

	arg_2_0.name_.text = GetI18NText(var_2_0.name)
	arg_2_0.desc_.text = MatrixTools.GetMatrixItemDes(arg_2_1)
	arg_2_0.icon_.sprite = MatrixTools.GetMatrixItemSprite(arg_2_1)
end

function var_0_0.Dispose(arg_3_0)
	var_0_0.super.Dispose(arg_3_0)

	arg_3_0.icon_.sprite = nil

	Object.Destroy(arg_3_0.gameObject_)

	arg_3_0.transform_ = nil
	arg_3_0.gameObject_ = nil
end

return var_0_0
