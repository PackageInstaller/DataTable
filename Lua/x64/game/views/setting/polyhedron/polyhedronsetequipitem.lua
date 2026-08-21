local var_0_0 = class("PolyhedronSetEquipItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

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

function var_0_0.SetData(arg_5_0, arg_5_1)
	local var_5_0 = EquipSuitCfg[arg_5_1]

	arg_5_0.m_icon.sprite = getSpriteViaConfig("EquipIcon_s", var_5_0.icon)
	arg_5_0.m_name.text = var_5_0.name
	arg_5_0.m_des.text = EquipTools.GetEffectDesc(var_5_0.suit_effect[1])

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_5_0.m_des.transform)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_5_0.transform_)
end

function var_0_0.SetActive(arg_6_0, arg_6_1)
	SetActive(arg_6_0.gameObject_, arg_6_1)
end

function var_0_0.Dispose(arg_7_0)
	var_0_0.super.Dispose(arg_7_0)
end

return var_0_0
