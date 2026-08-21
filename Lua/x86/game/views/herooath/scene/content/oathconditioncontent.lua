local var_0_0 = class("OathConditionContent", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.conditionItemList = {}
end

function var_0_0.AddListeners(arg_2_0)
	return
end

function var_0_0.Show(arg_3_0, arg_3_1)
	arg_3_0.gameObject_:SetActive(arg_3_1)
end

function var_0_0.RefreshUI(arg_4_0, arg_4_1)
	arg_4_0.data = arg_4_1

	arg_4_0:Show(true)
	arg_4_0:RefreshConditionUI()
	arg_4_0:OpenTimer()
end

function var_0_0.RefreshConditionUI(arg_5_0)
	local var_5_0 = OathToLuaBridge:GetOathHeroID()
	local var_5_1 = WeddingCfg[var_5_0].condition
	local var_5_2 = WeddingCfg[var_5_0].jump
	local var_5_3 = #var_5_1

	for iter_5_0 = 1, var_5_3 do
		if not arg_5_0.conditionItemList[iter_5_0] then
			arg_5_0.conditionItemList[iter_5_0] = OathConditionItem.New(Object.Instantiate(arg_5_0.conditionItemGo_, arg_5_0.contentTrs_))
		end

		arg_5_0.conditionItemList[iter_5_0]:SetData(var_5_1[iter_5_0], var_5_2[iter_5_0], var_5_0)
		SetActive(arg_5_0.conditionItemList[iter_5_0].gameObject_, true)
	end

	for iter_5_1 = var_5_3 + 1, #arg_5_0.conditionItemList do
		SetActive(arg_5_0.conditionItemList[iter_5_1].gameObject_, false)
	end
end

function var_0_0.DeleteCountDownTimer(arg_6_0)
	if arg_6_0.countDownTimer_ then
		arg_6_0.countDownTimer_:Stop()

		arg_6_0.countDownTimer_ = nil
	end
end

function var_0_0.OpenTimer(arg_7_0)
	arg_7_0:DeleteCountDownTimer()
end

function var_0_0.OnExit(arg_8_0)
	arg_8_0:DeleteCountDownTimer()

	if arg_8_0.data then
		arg_8_0.data.finishCallBack = nil
	end

	arg_8_0.data = nil
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0:DeleteCountDownTimer()

	for iter_9_0, iter_9_1 in pairs(arg_9_0.conditionItemList) do
		iter_9_1:Dispose()
	end

	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
