local var_0_0 = class("StrongholdBattleResultOrderItem", ReduxView)

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

	arg_3_0.typeController = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "type")
end

function var_0_0.AddUIListener(arg_4_0)
	return
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0

	if arg_5_1 == 1 then
		var_5_0 = CurrencyConst.CURRENCY_TYPE_STRONGHOLD_EXP_1

		arg_5_0.typeController:SetSelectedIndex(0)
	elseif arg_5_1 == 2 then
		var_5_0 = CurrencyConst.CURRENCY_TYPE_STRONGHOLD_EXP_2

		arg_5_0.typeController:SetSelectedIndex(1)
	else
		var_5_0 = CurrencyConst.CURRENCY_TYPE_STRONGHOLD_EXP_3

		arg_5_0.typeController:SetSelectedIndex(2)
	end

	local var_5_1 = 0

	for iter_5_0, iter_5_1 in ipairs(arg_5_2) do
		if var_5_0 == iter_5_1[1] then
			var_5_1 = iter_5_1[2]
		end
	end

	local var_5_2, var_5_3, var_5_4, var_5_5 = StrongholdData:GetStrongholdLevel(arg_5_1)
	local var_5_6 = ActivityStrongholdLevelCfg[var_5_2]

	arg_5_0.m_name.text = GetTips("ACTIVITY_STRONGHOLD_TYPE_NAME_" .. arg_5_1)
	arg_5_0.m_lvLab.text = var_5_6.level_des

	local var_5_7 = ActivityStrongholdLevelCfg[var_5_2 + 1]

	if var_5_7 then
		arg_5_0.m_expSlider.value = var_5_4 / (var_5_7.exp - var_5_6.exp)
		arg_5_0.m_exoLab.text = "+" .. var_5_1
	else
		arg_5_0.m_expSlider.value = 1
		arg_5_0.m_exoLab.text = ""
	end

	local var_5_8 = StrongholdData:GetWeeklyExp(arg_5_3, arg_5_1)
	local var_5_9 = StrongholdData:GetWeeklyMaxExp(arg_5_3, arg_5_1)

	arg_5_0.m_ceilLab.text = GetTips("ACTIVITY_STRONGHOLD_COIN_WEEK_CEIL") .. var_5_8 .. "/" .. var_5_9
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)
end

return var_0_0
