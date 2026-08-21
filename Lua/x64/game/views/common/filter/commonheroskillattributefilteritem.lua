local var_0_0 = class("CommonHeroSkillAttributeFilterItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:InitController()
	arg_2_0:AddListeners()
end

function var_0_0.InitController(arg_3_0)
	arg_3_0.selectController_ = arg_3_0.controllerEx_:GetController("select")
	arg_3_0.allController_ = arg_3_0.controllerEx_:GetController("all")
	arg_3_0.nameController_ = arg_3_0.controllerEx_:GetController("name")
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, handler(arg_4_0, arg_4_0.OnSelect))
end

function var_0_0.SetData(arg_5_0, arg_5_1)
	arg_5_0.id_ = arg_5_1
	arg_5_0.isAll_ = arg_5_1 == HeroConst.HERO_ATTACK_TYPE.ALL

	arg_5_0:Refresh()
end

function var_0_0.Refresh(arg_6_0)
	arg_6_0:RefreshType()
	arg_6_0:RefreshIcon()
end

function var_0_0.RefreshType(arg_7_0)
	arg_7_0.allController_:SetSelectedState(arg_7_0.isAll_ and "on" or "off")
end

function var_0_0.RefreshIcon(arg_8_0)
	if not arg_8_0.isAll_ then
		arg_8_0.icon_.sprite = HeroTools.GetSkillAttributeIcon(arg_8_0.id_)
	end
end

function var_0_0.SetSelectCallBack(arg_9_0, arg_9_1)
	arg_9_0.callback_ = arg_9_1
end

function var_0_0.OnSelect(arg_10_0)
	if arg_10_0.callback_ then
		arg_10_0.callback_(arg_10_0.id_, arg_10_0.isAll_)
	end
end

function var_0_0.RefreshSelect(arg_11_0, arg_11_1)
	arg_11_0.selectController_:SetSelectedState(arg_11_1 and "on" or "off")
end

function var_0_0.GetId(arg_12_0)
	return arg_12_0.id_
end

function var_0_0.SetNeedName(arg_13_0, arg_13_1)
	arg_13_0.needName_ = arg_13_1

	arg_13_0.nameController_:SetSelectedState(arg_13_1 and "on" or "off")

	if arg_13_0.needName_ and arg_13_0.id_ then
		arg_13_0.name_.text = HeroTools.GetSkillAttributeName(arg_13_0.id_)
	end
end

function var_0_0.Show(arg_14_0, arg_14_1)
	SetActive(arg_14_0.gameObject_, arg_14_1)
end

return var_0_0
