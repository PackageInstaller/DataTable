local var_0_0 = class("PolyhedronSetArtifactItem", ReduxView)

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
	local var_5_0 = arg_5_1.id

	arg_5_0.id = var_5_0
	arg_5_0.level = arg_5_1.level

	local var_5_1 = PolyhedronArtifactCfg[var_5_0]

	arg_5_0.m_icon.sprite = pureGetSpriteWithoutAtlas(PolyhedronConst.ARTIFACT_ICON_PATH .. var_5_1.icon)

	local var_5_2 = var_5_1.affix_id
	local var_5_3 = var_5_1.affix_target
	local var_5_4 = arg_5_1.level

	arg_5_0.m_name.text = getAffixName({
		var_5_2,
		var_5_4,
		var_5_3
	})
	arg_5_0.m_des.text = getAffixDesc({
		var_5_2,
		var_5_4,
		var_5_3
	})
	arg_5_0.m_levelLab.text = "LV." .. var_5_4

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_5_0.transform_)
end

function var_0_0.SetActive(arg_6_0, arg_6_1)
	SetActive(arg_6_0.gameObject_, arg_6_1)
end

function var_0_0.RegistCallBack(arg_7_0, arg_7_1)
	arg_7_0.clickFunc = arg_7_1
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)
	Object.Destroy(arg_8_0.gameObject_)

	arg_8_0.gameObject_ = nil
	arg_8_0.transform_ = nil
end

return var_0_0
