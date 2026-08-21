local var_0_0 = class("DormTaskRankItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.rankRewardItem_ = CommonItemView.New(arg_3_0.itemGo_, true)
end

function var_0_0.SetData(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5)
	arg_4_0.index_ = arg_4_1
	arg_4_0.rank_ = arg_4_2
	arg_4_0.curNum = arg_4_3
	arg_4_0.maxNum = arg_4_4
	arg_4_0.cfg = arg_4_5

	arg_4_0:UpdateView()
end

function var_0_0.UpdateView(arg_5_0)
	arg_5_0.numText_.text = arg_5_0.cfg.item_id[2]

	if arg_5_0.index_ == 1 then
		arg_5_0.slider_.value = arg_5_0.curNum >= arg_5_0.cfg.item_id[2] and 1 or arg_5_0.curNum % 100 / 100
	else
		local var_5_0 = IdolTraineeRewardRankCfg[arg_5_0.index_ - 1]

		arg_5_0.slider_.value = arg_5_0.curNum >= arg_5_0.cfg.item_id[2] and 1 or (arg_5_0.curNum - var_5_0.item_id[2]) / 100
	end

	if arg_5_0.slider_.value == 0 then
		arg_5_0.fillImg_.enabled = false
	else
		arg_5_0.fillImg_.enabled = true
	end

	local var_5_1 = clone(ItemTemplateData)

	var_5_1.id = arg_5_0.cfg.icon
	var_5_1.number = arg_5_0.cfg.num
	var_5_1.clickFun = handler(arg_5_0, arg_5_0.OnClickCommonItem)

	arg_5_0.rankRewardItem_:SetData(var_5_1)
	arg_5_0.rankRewardItem_:RefreshCompleted(arg_5_0.index_ < arg_5_0.rank_)
end

function var_0_0.OnClickCommonItem(arg_6_0, arg_6_1)
	ShowPopItem(POP_ITEM, {
		arg_6_1.id,
		arg_6_1.number
	})
	OperationRecorder.Record("task", "task_item")
end

function var_0_0.Dispose(arg_7_0)
	if arg_7_0.rankRewardItem_ then
		arg_7_0.rankRewardItem_:Dispose()

		arg_7_0.rankRewardItem_ = nil
	end

	var_0_0.super.Dispose(arg_7_0)
	Object.Destroy(arg_7_0.gameObject_)
end

return var_0_0
