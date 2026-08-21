local var_0_0 = class("HeroDisplayExpressionItemView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()
end

function var_0_0.AddListeners(arg_2_0)
	arg_2_0:AddToggleListener(arg_2_0.slider_, function(arg_3_0)
		arg_2_0.skinMesh_:SetBlendShapeWeight(arg_2_0.index_, arg_3_0)
		HeroDisplayData:SetCacheExpressionParams(arg_2_0.index_ + 1, arg_3_0)
	end)
end

function var_0_0.SetData(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0.skinMesh_ = arg_4_1
	arg_4_0.index_ = arg_4_2 - 1

	local var_4_0 = HeroSkinMeshCfg[arg_4_3]

	arg_4_0.textName_.text = GetI18NText(var_4_0.name)
	arg_4_0.textLeft_.text = GetI18NText(var_4_0.leftName)
	arg_4_0.textRight_.text = GetI18NText(var_4_0.rightName)

	arg_4_0:Show(true)
end

function var_0_0.SetValue(arg_5_0, arg_5_1)
	arg_5_0.slider_.value = arg_5_1

	arg_5_0.skinMesh_:SetBlendShapeWeight(arg_5_0.index_, arg_5_1)
	HeroDisplayData:SetCacheExpressionParams(arg_5_0.index_ + 1, arg_5_1)
end

function var_0_0.Show(arg_6_0, arg_6_1)
	SetActive(arg_6_0.gameObject_, arg_6_1)
end

function var_0_0.Dispose(arg_7_0)
	var_0_0.super.Dispose(arg_7_0)
	Object.Destroy(arg_7_0.gameObject_)

	arg_7_0.transform_ = nil
	arg_7_0.gameObject_ = nil
end

return var_0_0
