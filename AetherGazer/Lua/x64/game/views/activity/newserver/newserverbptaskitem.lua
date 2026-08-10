local var_0_0 = class("NewServerBPTaskItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()

	arg_2_0.normalRewardList_ = {}
	arg_2_0.normalItemDataList_ = {}
	arg_2_0.upgradeRewardList_ = {}
	arg_2_0.upgradeItemDataList_ = {}
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.progressController_ = arg_3_0.controllerEx_:GetController("active")
	arg_3_0.progressHeadController_ = arg_3_0.controllerEx_:GetController("isHead")
end

function var_0_0.AddUIListeners(arg_4_0)
	return
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	arg_5_0.taskID_ = arg_5_1
	arg_5_0.activityID_ = arg_5_2
	arg_5_0.isHead_ = arg_5_3

	local var_5_0 = NewServerData:GetBPTaskIsRecharge()
	local var_5_1 = NewServerBPTaskCfg[arg_5_0.taskID_].need
	local var_5_2 = NewServerData:GetAccumulateCurrency()
	local var_5_3 = 0
	local var_5_4 = 0

	if var_5_1 <= var_5_2 then
		local var_5_5 = NewServerData:GetBPTaskStatus()

		var_5_3 = var_5_5[arg_5_1] and var_5_5[arg_5_1].is_receive_reward == 1 and 2 or 1

		if var_5_0 >= 1 then
			var_5_4 = var_5_5[arg_5_1] and var_5_5[arg_5_1].is_receive_recharge_reward == 1 and 2 or 1
		end
	end

	local var_5_6 = NewServerBPTaskCfg[arg_5_0.taskID_].reward

	for iter_5_0, iter_5_1 in ipairs(var_5_6) do
		if not arg_5_0.normalRewardList_[iter_5_0] then
			local var_5_7 = arg_5_0.normalRewardPanel_:GetChild(iter_5_0 - 1).gameObject

			arg_5_0.normalRewardList_[iter_5_0] = CommonItemView.New(var_5_7)
		end

		if not arg_5_0.normalItemDataList_[iter_5_0] then
			arg_5_0.normalItemDataList_[iter_5_0] = clone(ItemTemplateData)
			arg_5_0.normalItemDataList_[iter_5_0].clickFun = handler(arg_5_0, arg_5_0.OnClickReward)
		end

		arg_5_0.normalItemDataList_[iter_5_0].id = iter_5_1[1]
		arg_5_0.normalItemDataList_[iter_5_0].number = iter_5_1[2]
		arg_5_0.normalItemDataList_[iter_5_0].highLight = var_5_3 == 1
		arg_5_0.normalItemDataList_[iter_5_0].completedFlag = var_5_3 == 2

		arg_5_0.normalRewardList_[iter_5_0]:SetData(arg_5_0.normalItemDataList_[iter_5_0])
	end

	local var_5_8 = NewServerBPTaskCfg[arg_5_0.taskID_].recharge_reward

	for iter_5_2, iter_5_3 in ipairs(var_5_8) do
		if not arg_5_0.upgradeRewardList_[iter_5_2] then
			local var_5_9 = arg_5_0.upgradeRewardPanel_:GetChild(iter_5_2 - 1).gameObject

			arg_5_0.upgradeRewardList_[iter_5_2] = CommonItemView.New(var_5_9)
		end

		if not arg_5_0.upgradeItemDataList_[iter_5_2] then
			arg_5_0.upgradeItemDataList_[iter_5_2] = clone(ItemTemplateData)
			arg_5_0.upgradeItemDataList_[iter_5_2].clickFun = handler(arg_5_0, arg_5_0.OnClickReward)
		end

		arg_5_0.upgradeItemDataList_[iter_5_2].id = iter_5_3[1]
		arg_5_0.upgradeItemDataList_[iter_5_2].number = iter_5_3[2]
		arg_5_0.upgradeItemDataList_[iter_5_2].highLight = var_5_4 == 1
		arg_5_0.upgradeItemDataList_[iter_5_2].completedFlag = var_5_4 == 2
		arg_5_0.upgradeItemDataList_[iter_5_2].locked = var_5_0 < 1

		arg_5_0.upgradeRewardList_[iter_5_2]:SetData(arg_5_0.upgradeItemDataList_[iter_5_2])
	end

	arg_5_0.progressController_:SetSelectedState(var_5_1 <= var_5_2 and "true" or "false")
	arg_5_0.progressHeadController_:SetSelectedState(tostring(arg_5_0.isHead_))

	arg_5_0.targetText_.text = var_5_1

	local var_5_10
	local var_5_11

	if arg_5_4 then
		var_5_10 = var_5_1 - NewServerBPTaskCfg[arg_5_4].need
		var_5_11 = var_5_2 - NewServerBPTaskCfg[arg_5_4].need
	else
		var_5_10 = var_5_1
		var_5_11 = var_5_2
	end

	local var_5_12 = var_5_11 / var_5_10

	if var_5_12 < 0 then
		var_5_12 = 0
	elseif var_5_12 > 1 then
		var_5_12 = 1
	end

	if arg_5_3 then
		arg_5_0.headSlider_.value = var_5_12
	else
		arg_5_0.middleSlider_.value = var_5_12
	end
end

function var_0_0.OnClickReward(arg_6_0, arg_6_1)
	if not ActivityTools.ActivityOpenCheck(arg_6_0.activityID_) then
		return
	end

	local var_6_0 = arg_6_0:GetCanReceiveTaskList()

	if #var_6_0 > 0 then
		NewServerAction.ReceiveBPReward(var_6_0, arg_6_0.receiveHandler_)

		return true
	else
		ShowPopItem(POP_ITEM, {
			arg_6_1.id,
			arg_6_1.number
		})
	end

	return false
end

function var_0_0.GetCanReceiveTaskList(arg_7_0)
	local var_7_0 = {}
	local var_7_1 = NewServerCfg[arg_7_0.activityID_].bp
	local var_7_2 = NewServerData:GetBPTaskStatus()
	local var_7_3 = NewServerData:GetBPTaskIsRecharge()
	local var_7_4 = NewServerData:GetAccumulateCurrency()

	for iter_7_0, iter_7_1 in ipairs(var_7_1) do
		if var_7_4 >= NewServerBPTaskCfg[iter_7_1].need then
			if var_7_2[iter_7_1] then
				if var_7_2[iter_7_1].is_receive_reward < 1 then
					var_7_0[#var_7_0 + 1] = {
						receive_type = 1,
						id = iter_7_1
					}
				end

				if var_7_3 >= 1 and var_7_2[iter_7_1].is_receive_recharge_reward < 1 then
					var_7_0[#var_7_0 + 1] = {
						receive_type = 2,
						id = iter_7_1
					}
				end
			else
				var_7_0[#var_7_0 + 1] = {
					receive_type = 1,
					id = iter_7_1
				}

				if var_7_3 >= 1 then
					var_7_0[#var_7_0 + 1] = {
						receive_type = 2,
						id = iter_7_1
					}
				end
			end
		end
	end

	return var_7_0
end

function var_0_0.SetReceiveHandler(arg_8_0, arg_8_1)
	arg_8_0.receiveHandler_ = arg_8_1
end

function var_0_0.Dispose(arg_9_0)
	var_0_0.super.Dispose(arg_9_0)

	if arg_9_0.upgradeRewardList_ then
		for iter_9_0, iter_9_1 in ipairs(arg_9_0.upgradeRewardList_) do
			iter_9_1:Dispose()
		end

		arg_9_0.upgradeRewardList_ = nil
	end

	if arg_9_0.normalRewardList_ then
		for iter_9_2, iter_9_3 in ipairs(arg_9_0.normalRewardList_) do
			iter_9_3:Dispose()
		end

		arg_9_0.normalRewardList_ = nil
	end

	arg_9_0.receiveHandler_ = nil
end

return var_0_0
