local var_0_0 = class("PolyhedronDifficultyOverviewItem", ReduxView)

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

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 == 1 then
		local var_5_0 = arg_5_2

		arg_5_0.m_des.text = getAffixName(var_5_0) .. NumberTools.IntToRomam(var_5_0[2]) .. "\n" .. getAffixDesc(var_5_0)
		arg_5_0.m_icon.sprite = getAffixSprite(var_5_0)
	elseif arg_5_1 == 2 then
		local var_5_1 = arg_5_2[1]
		local var_5_2 = arg_5_2[2]

		if PublicAttrCfg[var_5_1].percent == 1 then
			var_5_2 = var_5_2 / 10 .. "%"
		end

		arg_5_0.m_des.text = GetTips(PolyhedronConst.SPECIAL_ATTR_DESC[var_5_1][2]) .. "\n" .. GetTips(PolyhedronConst.SPECIAL_ATTR_DESC[var_5_1][3]) .. var_5_2
		arg_5_0.m_icon.sprite = pureGetSpriteWithoutAtlas(PolyhedronConst.HERO_ATTRIBUTE_ICON_PATH .. var_5_1)
	end
end

function var_0_0.SetActive(arg_6_0, arg_6_1)
	SetActive(arg_6_0.gameObject_, arg_6_1)
end

function var_0_0.Dispose(arg_7_0)
	var_0_0.super.Dispose(arg_7_0)
end

return var_0_0
