local var_0_0 = class("MoonCakeBagGroupItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:InitUI()
	arg_1_0:AddListeners()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.itemList_ = LuaList.New(handler(arg_2_0, arg_2_0.IndexItem), arg_2_0.listGo_, MoonCakeItem)
	arg_2_0.rewardItems_ = {}
	arg_2_0.statusController_ = ControllerUtil.GetController(arg_2_0.transform_, "status")
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.receiveBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_3_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		MoonCakeAction.ReceiveCakeCollectReward(arg_3_0.activityID_, arg_3_0.groupID_)
	end)
end

function var_0_0.Dispose(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(arg_5_0.rewardItems_) do
		iter_5_1:Dispose()
	end

	arg_5_0.rewardItems_ = nil

	arg_5_0.itemList_:Dispose()

	arg_5_0.itemList_ = nil

	var_0_0.super.Dispose(arg_5_0)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.groupID_ = arg_6_1
	arg_6_0.activityID_ = arg_6_2
	arg_6_0.groupCfg_ = MoonCakeGroupCfg[arg_6_0.groupID_]
	arg_6_0.groupName_.text = arg_6_0.groupCfg_.group_name

	arg_6_0:RefreshItem()
	arg_6_0:RefreshReward()
end

function var_0_0.RefreshItem(arg_7_0)
	arg_7_0.unlockMoonCakeDic_ = MoonCakeData:GetUnlockCakeDic(arg_7_0.activityID_)
	arg_7_0.itemIdList_ = arg_7_0.groupCfg_.collect_condition

	arg_7_0.itemList_:StartScroll(#arg_7_0.itemIdList_)
end

function var_0_0.IndexItem(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0.itemIdList_[arg_8_1]
	local var_8_1 = MoonCakeCfg[var_8_0].moon_cakes
	local var_8_2 = arg_8_0.unlockMoonCakeDic_[var_8_0]

	arg_8_2:SetData(var_8_1)
	arg_8_2:SetUnlock(var_8_2)
end

function var_0_0.RefreshReward(arg_9_0)
	arg_9_0.taskNeed_ = #arg_9_0.itemIdList_
	arg_9_0.taskProgress_ = 0

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.itemIdList_) do
		if arg_9_0.unlockMoonCakeDic_[iter_9_1] then
			arg_9_0.taskProgress_ = arg_9_0.taskProgress_ + 1
		end
	end

	arg_9_0.descText_.text = string.format(GetTips("MID_AUTUMN_FESTIVAL_MOONCAKE_COLLECT"), arg_9_0.taskProgress_, arg_9_0.taskNeed_)

	local var_9_0 = arg_9_0.groupCfg_.reward

	for iter_9_2, iter_9_3 in ipairs(var_9_0) do
		if arg_9_0.rewardItems_[iter_9_2] == nil then
			arg_9_0.rewardItems_[iter_9_2] = RewardPoolItem.New(arg_9_0.rewardPanelTrans_)
		end

		arg_9_0.rewardItems_[iter_9_2]:SetData(iter_9_3)
	end

	for iter_9_4 = #var_9_0 + 1, #arg_9_0.rewardItems_ do
		arg_9_0.rewardItems_[iter_9_4]:Show(false)
	end

	arg_9_0:RefreshStatus()
end

function var_0_0.RefreshStatus(arg_10_0)
	local var_10_0 = arg_10_0.taskProgress_ >= arg_10_0.taskNeed_

	if MoonCakeData:GetReceivedGroupDic(arg_10_0.activityID_)[arg_10_0.groupID_] == true == true then
		arg_10_0.statusController_:SetSelectedState("received")
	elseif var_10_0 == true then
		arg_10_0.statusController_:SetSelectedState("completed")
	else
		arg_10_0.statusController_:SetSelectedState("uncomplete")
	end
end

return var_0_0
