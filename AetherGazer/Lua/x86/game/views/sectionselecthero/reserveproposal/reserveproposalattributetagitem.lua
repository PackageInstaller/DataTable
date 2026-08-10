local var_0_0 = class("ReserveProposalAttributeTagItem", ReduxView)

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
	arg_3_0.corlorController_ = arg_3_0.controllerEx_:GetController("color")
end

function var_0_0.AddListeners(arg_4_0)
	if arg_4_0.btn_ then
		arg_4_0:AddBtnListener(arg_4_0.btn_, nil, handler(arg_4_0, arg_4_0.OnSelect))
	end
end

function var_0_0.SetData(arg_5_0, arg_5_1)
	arg_5_0.id_ = arg_5_1

	arg_5_0:Refresh()
end

function var_0_0.Refresh(arg_6_0)
	arg_6_0:RefreshIcon()
end

function var_0_0.RefreshIcon(arg_7_0)
	arg_7_0.icon_.sprite = HeroTools.LoadSkillAttributeIcon(FormationProposalTagCfg[arg_7_0.id_].icon)
end

function var_0_0.SetSelectCallBack(arg_8_0, arg_8_1)
	arg_8_0.callback_ = arg_8_1
end

function var_0_0.OnSelect(arg_9_0)
	if arg_9_0.callback_ then
		arg_9_0.callback_(arg_9_0.id_, arg_9_0.isAll_)
	end
end

function var_0_0.SetSelect(arg_10_0, arg_10_1)
	arg_10_0.selectController_:SetSelectedState(arg_10_1 and "on" or "off")
end

function var_0_0.SetColor(arg_11_0, arg_11_1)
	arg_11_0.corlorController_:SetSelectedState(arg_11_1 and "on" or "off")
end

function var_0_0.GetId(arg_12_0)
	return arg_12_0.id_
end

function var_0_0.Show(arg_13_0, arg_13_1)
	SetActive(arg_13_0.gameObject_, arg_13_1)
end

return var_0_0
