local var_0_0 = class("PolyhedronOverDifficultyItem", ReduxView)

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
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		if arg_4_0.clickFunc then
			local var_5_0 = arg_4_0.transform_.position

			arg_4_0.clickFunc(arg_4_0.name, arg_4_0.desc, var_5_0, arg_4_0.level)
		end
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 == 1 then
		local var_6_0 = arg_6_2

		arg_6_0.m_icon.sprite = getAffixSprite(var_6_0)
		arg_6_0.name = getAffixName(var_6_0)
		arg_6_0.desc = getAffixDesc(var_6_0)
	elseif arg_6_1 == 2 then
		local var_6_1 = arg_6_2[1]
		local var_6_2 = arg_6_2[2]
		local var_6_3 = PublicAttrCfg[var_6_1]

		if var_6_3.percent == 1 then
			var_6_2 = var_6_2 / 10 .. "%"
		end

		if PolyhedronConst.SPECIAL_ATTR_DESC[var_6_1] ~= nil then
			arg_6_0.name = GetTips(PolyhedronConst.SPECIAL_ATTR_DESC[var_6_1][2])
			arg_6_0.desc = GetTips(PolyhedronConst.SPECIAL_ATTR_DESC[var_6_1][3]) .. var_6_2
		else
			arg_6_0.name = var_6_3.name
			arg_6_0.desc = var_6_3.name .. var_6_2
		end

		arg_6_0.m_icon.sprite = pureGetSpriteWithoutAtlas(PolyhedronConst.HERO_ATTRIBUTE_ICON_PATH .. var_6_1)
	end
end

function var_0_0.RegistCallBack(arg_7_0, arg_7_1)
	arg_7_0.clickFunc = arg_7_1
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
