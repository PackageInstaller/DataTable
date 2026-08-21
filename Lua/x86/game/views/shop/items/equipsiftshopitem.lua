local var_0_0 = class("EquipSiftShopItem", ReduxView)

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

	arg_3_0.stateController = arg_3_0.controllerEx_:GetController("state")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.button_, nil, function()
		arg_4_0.callback(arg_4_0.id, arg_4_0.stateController)
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	arg_6_0.id = arg_6_1
	arg_6_0.cfg = EquipSuitCfg[arg_6_1]
	arg_6_0.selectTable = arg_6_2
	arg_6_0.callback = arg_6_3
	arg_6_0.isClickClean = arg_6_4

	arg_6_0:UpdateView()
end

function var_0_0.UpdateView(arg_7_0)
	arg_7_0.name_.text = GetI18NText(arg_7_0.cfg.name)

	SetSpriteWithoutAtlasAsync(arg_7_0.icon_, SpritePathCfg.EquipIcon_s.path .. arg_7_0.cfg.icon)
	arg_7_0.stateController:SetSelectedState(arg_7_0.selectTable[arg_7_0.id] and "select" or "false")

	if arg_7_0.isClickClean then
		arg_7_0.stateController:SetSelectedState("false")
	end
end

function var_0_0.UpdateTimerView(arg_8_0)
	return
end

function var_0_0.RegistCallBack(arg_9_0)
	return
end

function var_0_0.OnEnter(arg_10_0)
	return
end

function var_0_0.OnExit(arg_11_0)
	return
end

function var_0_0.Dispose(arg_12_0)
	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
