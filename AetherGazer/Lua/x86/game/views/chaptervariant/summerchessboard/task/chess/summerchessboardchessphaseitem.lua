local var_0_0 = class("SummerChessBoardChessPhaseItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.activeController_ = arg_1_0.controllerEx_:GetController("active")
	arg_1_0.isHeadController_ = arg_1_0.controllerEx_:GetController("isHead")

	if arg_1_3 == 1 then
		arg_1_0.isHeadController_:SetSelectedState("true")
	else
		arg_1_0.isHeadController_:SetSelectedState("false")
	end

	arg_1_0.rewardItems_ = CommonItemView.New(arg_1_0.commonItem_)

	SetActive(arg_1_0.gameObject_, true)
end

function var_0_0.Dispose(arg_2_0)
	var_0_0.super.Dispose(arg_2_0)
	arg_2_0.rewardItems_:Dispose()
	Object.Destroy(arg_2_0.gameObject_)

	arg_2_0.transform_ = nil
	arg_2_0.gameObject_ = nil
end

function var_0_0.AddListeners(arg_3_0)
	return
end

function var_0_0.SetData(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.id_ = arg_4_1
	arg_4_0.idList_ = arg_4_2

	arg_4_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_5_0)
	local var_5_0 = arg_5_0.id_
	local var_5_1 = arg_5_0.idList_
	local var_5_2 = ActivityPointRewardCfg[var_5_0]
	local var_5_3 = var_5_2.activity_id
	local var_5_4 = table.keyof(var_5_1, var_5_0)
	local var_5_5 = 0

	if var_5_4 > 1 then
		var_5_5 = ActivityPointRewardCfg[var_5_1[var_5_4 - 1]].need
	end

	local var_5_6 = ItemTools.getItemNum(var_5_2.need_item_id)

	arg_5_0.slider_.value = (var_5_6 - var_5_5) / (var_5_2.need - var_5_5)
	arg_5_0.numText_.text = var_5_2.need

	if var_5_6 >= var_5_2.need then
		arg_5_0.activeController_:SetSelectedState("true")
	else
		arg_5_0.activeController_:SetSelectedState("false")
	end

	local var_5_7 = var_5_2.reward_item_list[1]
	local var_5_8 = clone(ItemTemplateData)

	var_5_8.id = var_5_7[1]
	var_5_8.number = var_5_7[2]

	local var_5_9 = ActivityPointData:IsCompleteID(var_5_0)

	if var_5_9 then
		var_5_8.completedFlag = true
	else
		var_5_8.highLight = var_5_6 >= var_5_2.need
	end

	function var_5_8.clickFun(arg_6_0)
		if not var_5_9 and var_5_6 >= var_5_2.need then
			ActivitySummerChessBoardAction.ReceiveAllExplorePhaseReward()
		else
			ShowPopItem(POP_ITEM, {
				arg_6_0.id,
				arg_6_0.number
			})
		end
	end

	arg_5_0.rewardItems_:SetData(var_5_8)
end

function var_0_0.GetLocalPosition(arg_7_0)
	return arg_7_0.transform_.localPosition
end

return var_0_0
