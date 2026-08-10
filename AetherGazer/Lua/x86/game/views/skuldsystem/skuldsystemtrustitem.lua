local var_0_0 = class("SkuldSystemTrustItem", ReduxView)

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
	local var_4_0 = ItemTools.getItemNum(CurrencyIdMapCfg.CURRENCY_SKULD_COIN_4_0.item_id)
	local var_4_1 = GameSetting.skuld_trust_max.value[1]

	arg_4_0.itemText_.text = var_4_0 .. "/" .. var_4_1
	arg_4_0.fillImage_.fillAmount = var_4_0 / var_4_1
end

function var_0_0.OnEnter(arg_5_0)
	local var_5_0 = RedPointConst.SKULD_SYSTEM_TRUST_ALL

	manager.redPoint:bindUIandKey(arg_5_0.transform_, var_5_0)
end

function var_0_0.OnExit(arg_6_0)
	arg_6_0.callback = nil

	local var_6_0 = RedPointConst.SKULD_SYSTEM_TRUST_ALL

	manager.redPoint:unbindUIandKey(arg_6_0.transform_, var_6_0)
end

function var_0_0.AddUIListener(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.btn_, nil, function()
		if arg_7_0.callBack then
			arg_7_0.callBack()
		end

		JumpTools.OpenPageByJump("skuldSystemTrustView")
	end)
end

function var_0_0.SetCallBack(arg_9_0, arg_9_1)
	arg_9_0.callBack = arg_9_1
end

function var_0_0.Dispose(arg_10_0)
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
