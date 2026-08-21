local var_0_0 = class("PolyhedronOverBeaconItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

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
	arg_5_0.id = arg_5_1

	local var_5_0 = PolyhedronBeaconCfg[arg_5_0.id]

	arg_5_0.m_icon.sprite = pureGetSpriteWithoutAtlas(PolyhedronConst.BEACON_ICON_PATH .. var_5_0.icon)
	arg_5_0.m_name.text = GetI18NText(var_5_0.name)
	arg_5_0.m_des.text = GetI18NText(var_5_0.desc)

	arg_5_0:SetActive(true)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_5_0.m_desTrs)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_5_0.transform_)
end

function var_0_0.RegistCallBack(arg_6_0, arg_6_1)
	arg_6_0.clickFunc = arg_6_1
end

function var_0_0.Dispose(arg_7_0)
	var_0_0.super.Dispose(arg_7_0)
	Object.Destroy(arg_7_0.gameObject_)

	arg_7_0.gameObject_ = nil
	arg_7_0.transform_ = nil
end

function var_0_0.SetActive(arg_8_0, arg_8_1)
	SetActive(arg_8_0.gameObject_, arg_8_1)
end

return var_0_0
