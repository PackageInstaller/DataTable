local var_0_0 = class("AshSystemTrustItem", ReduxView)

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

function var_0_0.RefreshUI(arg_4_0)
	local var_4_0 = ItemTools.getItemNum(CurrencyIdMapCfg.CURRENCY_ASH_COIN_4_4.item_id)
	local var_4_1 = GameSetting.skuld_trust_max.value[1]
	local var_4_2 = "<size=84><color=\"#FFEAB4\">%d</color></size><color=\"#D8B884\">/%d</color>"

	arg_4_0.itemText_.text = string.format(var_4_2, var_4_0, var_4_1)
	arg_4_0.fillImage_.fillAmount = var_4_0 / var_4_1
end

function var_0_0.OnEnter(arg_5_0)
	return
end

function var_0_0.OnExit(arg_6_0)
	arg_6_0.callback = nil
end

function var_0_0.AddUIListener(arg_7_0)
	return
end

function var_0_0.SetCallBack(arg_8_0, arg_8_1)
	arg_8_0.callBack = arg_8_1
end

function var_0_0.Dispose(arg_9_0)
	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
