local var_0_0 = class("polyhedronDifficultyItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()

	local var_1_0 = arg_1_2[1]

	if var_1_0 == 1 then
		local var_1_1 = arg_1_2[2]
		local var_1_2 = arg_1_2[3]
		local var_1_3 = arg_1_2[4]
		local var_1_4 = {
			var_1_1,
			var_1_2,
			var_1_3
		}

		arg_1_0.m_name.text = getAffixName(var_1_4) .. NumberTools.IntToRomam(var_1_2)
		arg_1_0.m_des.text = getAffixDesc(var_1_4)
		arg_1_0.m_icon.sprite = getAffixSprite(var_1_4)
	elseif var_1_0 == 2 then
		local var_1_5 = arg_1_2[2]
		local var_1_6 = arg_1_2[3]
		local var_1_7 = PublicAttrCfg[var_1_5]

		if var_1_7.percent == 1 then
			var_1_6 = var_1_6 / 10 .. "%"
		end

		if PolyhedronConst.SPECIAL_ATTR_DESC[var_1_5] ~= nil then
			arg_1_0.m_name.text = GetTips(PolyhedronConst.SPECIAL_ATTR_DESC[var_1_5][2])
			arg_1_0.m_des.text = GetTips(PolyhedronConst.SPECIAL_ATTR_DESC[var_1_5][3]) .. var_1_6
		else
			arg_1_0.m_name.text = GetI18NText(var_1_7.name)
			arg_1_0.m_des.text = GetI18NText(var_1_7.name) .. var_1_6
		end

		arg_1_0.m_icon.sprite = pureGetSpriteWithoutAtlas(PolyhedronConst.HERO_ATTRIBUTE_ICON_PATH .. var_1_5)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_0.m_desTrans)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_0.transform_)
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
	return
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)
end

return var_0_0
