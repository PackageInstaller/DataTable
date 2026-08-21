local var_0_0 = class("PolyhedronArtifactTipsItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = Object.Instantiate(arg_1_1, arg_1_2)

	arg_1_0.gameObject_ = var_1_0
	arg_1_0.transform_ = var_1_0.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_4_0)
	return
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.m_level.text = string.format("LV.<size=48>%d</size>", arg_5_2)
	arg_5_0.m_des.text = getAffixDesc({
		arg_5_1,
		arg_5_2
	})

	arg_5_0:SetActive(true)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_5_0.transform_)
end

function var_0_0.SetActive(arg_6_0, arg_6_1)
	SetActive(arg_6_0.gameObject_, arg_6_1)
end

function var_0_0.Dispose(arg_7_0)
	Object.Destroy(arg_7_0.gameObject_)

	arg_7_0.gameObject_ = nil
	arg_7_0.transform_ = nil

	var_0_0.super.Dispose(arg_7_0)
end

return var_0_0
