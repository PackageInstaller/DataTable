local var_0_0 = class("CultureGravureEquiptInfoItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()

	arg_2_0.posNumController_ = ControllerUtil.GetController(arg_2_0.transform_, "num")
	arg_2_0.posController_ = {}

	for iter_2_0 = 1, 3 do
		arg_2_0.posController_[iter_2_0] = ControllerUtil.GetController(arg_2_0["posStateTrs" .. iter_2_0 .. "_"], "pos")
	end
end

function var_0_0.SetData(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.index_ = arg_3_1
	arg_3_0.equipIDList_ = arg_3_2

	table.sort(arg_3_0.equipIDList_, function(arg_4_0, arg_4_1)
		return EquipCfg[arg_4_0].pos < EquipCfg[arg_4_1].pos
	end)
	arg_3_0:RefreshUI()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()
end

function var_0_0.SetCallBack(arg_6_0, arg_6_1)
	arg_6_0.callback = arg_6_1
end

function var_0_0.RefreshUI(arg_7_0)
	arg_7_0.nameText_.text = EquipSuitCfg[EquipCfg[arg_7_0.equipIDList_[1]].suit].name

	arg_7_0.posNumController_:SetSelectedState(#arg_7_0.equipIDList_)

	for iter_7_0 = 1, #arg_7_0.equipIDList_ do
		local var_7_0 = EquipCfg[arg_7_0.equipIDList_[iter_7_0]]

		arg_7_0.posController_[iter_7_0]:SetSelectedState(var_7_0.pos)
	end
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
