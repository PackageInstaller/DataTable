local var_0_0 = class("SpringFestivalGreetingEnvelopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/EmptyDream/letter/EDream_letterpop"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.controller_ = ControllerUtil.GetController(arg_3_0.transform_, "name")
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0:RefreshUI()
end

function var_0_0.OnExit(arg_5_0)
	return
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)
	arg_6_0.commonItemView_:Dispose()

	arg_6_0.commonItemView_ = nil
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.closeBtn_, nil, function()
		arg_7_0:Back()
	end)
end

function var_0_0.GetActivityID(arg_9_0)
	return ActivityConst.SPRING_FESTIVAL_GREETING
end

function var_0_0.RefreshUI(arg_10_0)
	if arg_10_0.commonItemView_ == nil then
		arg_10_0.commonItemView_ = CommonItem.New(arg_10_0.itemGo_)
	end

	local var_10_0 = arg_10_0:GetActivityID()
	local var_10_1 = SpringFestivalGreetingData:GetUnlockCnt(var_10_0)
	local var_10_2 = ActivityPointRewardCfg.get_id_list_by_activity_id[var_10_0]
	local var_10_3 = var_10_2[var_10_1]
	local var_10_4 = ActivityPointRewardCfg[var_10_3].reward_item_list[1]

	arg_10_0.commonItemView_:RefreshData(formatReward(var_10_4))
	arg_10_0.commonItemView_:RegistCallBack(function()
		ShowPopItem(POP_ITEM, var_10_4)
	end)

	local var_10_5 = SpringFestivalGreetingData:GetReceiveCnt(var_10_0)

	arg_10_0.cntText_.text = string.format("%s/%s", var_10_5, #var_10_2)

	arg_10_0:RefreshTimeText()
end

function var_0_0.RefreshTimeText(arg_12_0)
	local var_12_0 = arg_12_0:GetActivityID()
	local var_12_1 = ActivityData:GetActivityData(var_12_0)
	local var_12_2 = var_12_1.startTime
	local var_12_3 = var_12_1.stopTime

	arg_12_0.timeText_.text = string.format("%s——%s", manager.time:STimeDescS(var_12_2, "!%m/%d %H:%M"), manager.time:STimeDescS(var_12_3, "!%m/%d %H:%M"))

	local var_12_4 = manager.time:GetServerTime()

	if var_12_4 < var_12_2 or var_12_3 < var_12_4 then
		arg_12_0.controller_:SetSelectedState("true")
	else
		arg_12_0.controller_:SetSelectedState("false")
	end
end

return var_0_0
