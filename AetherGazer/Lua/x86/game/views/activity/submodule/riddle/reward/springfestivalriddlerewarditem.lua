local var_0_0 = class("SpringFestivalRiddleRewardItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1

	arg_1_0:BindCfgUI()

	arg_1_0.rewardUIList_ = LuaList.New(handler(arg_1_0, arg_1_0.RefreshItem), arg_1_0.uiList_, CommonItem)
	arg_1_0.controller_ = ControllerUtil.GetController(arg_1_0.btnTf_, "switchBtn")
end

function var_0_0.SetData(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.id_ = arg_2_2

	local var_2_0 = ActivityPointRewardCfg[arg_2_2]

	arg_2_0.descText_.text = string.format(GetTips("ACTIVITY_SPRING_FESTIVAL_RIDDLE_FINISH_CNT"), var_2_0.need)

	if table.keyof(SpringFestivalRiddleData:GetReceiveList(arg_2_1), arg_2_2) then
		arg_2_0.controller_:SetSelectedState("complete")
	else
		arg_2_0.controller_:SetSelectedState("not")
	end

	arg_2_0.rewardUIList_:StartScroll(#var_2_0.reward_item_list)
end

function var_0_0.Dispose(arg_3_0)
	if arg_3_0.rewardUIList_ then
		arg_3_0.rewardUIList_:Dispose()

		arg_3_0.rewardUIList_ = nil
	end

	var_0_0.super.Dispose(arg_3_0)
end

function var_0_0.RefreshItem(arg_4_0, arg_4_1, arg_4_2)
	arg_4_2:RegistCallBack(function(arg_5_0)
		ShowPopItem(POP_ITEM, {
			arg_5_0.id,
			arg_5_0.number
		})
	end)

	local var_4_0 = arg_4_0.id_
	local var_4_1 = ActivityPointRewardCfg[var_4_0]
	local var_4_2 = formatReward(var_4_1.reward_item_list[arg_4_1])

	arg_4_2:RefreshData(var_4_2)
end

return var_0_0
