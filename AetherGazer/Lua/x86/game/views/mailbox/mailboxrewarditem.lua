local var_0_0 = class("MailBoxRewardItem", ReduxView)

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

	arg_3_0.commonItem_ = CommonItemView.New(arg_3_0.commonItemGo_)
end

function var_0_0.AddUIListener(arg_4_0)
	return
end

function var_0_0.SetRewardData(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.rewardData_ = arg_5_1
	arg_5_0.haveGet_ = arg_5_2

	arg_5_0:UpdateView()
end

function var_0_0.UpdateView(arg_6_0)
	local var_6_0 = formatReward(arg_6_0.rewardData_)
	local var_6_1 = clone(ItemTemplateData)

	var_6_1.id = var_6_0.id
	var_6_1.number = var_6_0.num or var_6_0.number
	var_6_1.timeValid = var_6_0.timeValid or 0
	var_6_1.completedFlag = arg_6_0.haveGet_
	var_6_1.clickFun = handler(arg_6_0, arg_6_0.OnClickCommonItem)

	arg_6_0.commonItem_:SetData(var_6_1)
end

function var_0_0.OnEnter(arg_7_0)
	return
end

function var_0_0.OnExit(arg_8_0)
	return
end

function var_0_0.OnClickCommonItem(arg_9_0, arg_9_1)
	ShowPopItem(POP_ITEM, {
		arg_9_1.id,
		arg_9_1.number
	})
	OperationRecorder.Record("MailBoxRewardItem", "popItem")
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0:RemoveAllListeners()

	if arg_10_0.commonItem_ then
		arg_10_0.commonItem_:Dispose()

		arg_10_0.commonItem_ = nil
	end

	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
