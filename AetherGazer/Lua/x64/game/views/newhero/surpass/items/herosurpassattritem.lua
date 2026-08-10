local var_0_0 = class("HeroSurpassAttrItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
end

function var_0_0.RefreshUI(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	arg_3_0:SetActive(true)

	arg_3_0.num01Text_.text = arg_3_2
	arg_3_0.numText_.text = arg_3_1

	if not arg_3_1 or not arg_3_2 then
		SetActive(arg_3_0.arrowGo_, false)
	else
		SetActive(arg_3_0.arrowGo_, true)
	end

	if arg_3_3 then
		local var_3_0 = PublicAttrCfg[arg_3_3]

		if arg_3_4 then
			arg_3_0.nameText_.text = string.format(GetTips("EQUIP_UPGRADE_ATTR_DES"), GetI18NText(var_3_0.name))
		else
			arg_3_0.nameText_.text = GetI18NText(var_3_0.name)
		end

		arg_3_0.iconImg_.sprite = getSprite("Atlas/SystemCommonAtlas", var_3_0.icon)
	end
end

function var_0_0.SetActive(arg_4_0, arg_4_1)
	SetActive(arg_4_0.gameObject_, arg_4_1)
end

function var_0_0.Dispose(arg_5_0)
	var_0_0.super.Dispose(arg_5_0)
end

return var_0_0
