local var_0_0 = class("PaperCutRewardItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddListeners()

	arg_2_0.itemList_ = LuaList.New(handler(arg_2_0, arg_2_0.IndexItem), arg_2_0.itemListGo_, CommonItem)
	arg_2_0.rewardState_ = ControllerUtil.GetController(arg_2_0.transform_, "status")
end

function var_0_0.SetData(arg_3_0, arg_3_1)
	arg_3_0.taskID_ = arg_3_1
	arg_3_0.activityID_ = ActivityPointRewardCfg[arg_3_1].activity_id

	arg_3_0:RefreshUI()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.receiveBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_5_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		PaperCutAction.RequireReceive(arg_5_0.taskID_, function(arg_7_0)
			if isSuccess(arg_7_0.result) then
				getReward2(arg_7_0.reward_list)
				PaperCutData:SetReceivedList(arg_5_0.activityID_, arg_5_0.taskID_)
				arg_5_0:RefreshState()

				if arg_5_0.onReceived_ ~= nil then
					arg_5_0.onReceived_()
				end
			else
				ShowTips(arg_7_0.result)
			end
		end)
	end)
end

function var_0_0.RefreshUI(arg_8_0)
	arg_8_0.descText_.text = string.format(GetTips("ACTIVITY_CUT_POINT_REWARD"), GetI18NText(PaperCutCfg[arg_8_0.activityID_].name), ActivityPointRewardCfg[arg_8_0.taskID_].need)

	arg_8_0:RefreshState()
	arg_8_0:RefreshItem()
end

function var_0_0.RefreshState(arg_9_0)
	local var_9_0 = PaperCutData:GetScore(arg_9_0.activityID_)
	local var_9_1 = PaperCutData:GetReceivedList(arg_9_0.activityID_)
	local var_9_2 = var_9_0 >= ActivityPointRewardCfg[arg_9_0.taskID_].need
	local var_9_3 = table.keyof(var_9_1, arg_9_0.taskID_) ~= nil

	if not var_9_2 then
		arg_9_0.rewardState_:SetSelectedState("uncompleted")
	elseif not var_9_3 then
		arg_9_0.rewardState_:SetSelectedState("unreceived")
	else
		arg_9_0.rewardState_:SetSelectedState("received")
	end
end

function var_0_0.RefreshItem(arg_10_0)
	arg_10_0.rewardCfg_ = ActivityPointRewardCfg[arg_10_0.taskID_].reward_item_list

	arg_10_0.itemList_:StartScroll(#arg_10_0.rewardCfg_)
end

function var_0_0.IndexItem(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0.rewardCfg_[arg_11_1]

	arg_11_2:RefreshData(formatReward(var_11_0))
	arg_11_2:RegistCallBack(function()
		ShowPopItem(POP_ITEM, var_11_0)
	end)
end

function var_0_0.Dispose(arg_13_0)
	if arg_13_0.itemList_ then
		arg_13_0.itemList_:Dispose()

		arg_13_0.itemList_ = nil
	end

	arg_13_0.onReceived_ = nil

	var_0_0.super.Dispose(arg_13_0)
end

function var_0_0.SetReveivedHandler(arg_14_0, arg_14_1)
	arg_14_0.onReceived_ = arg_14_1
end

return var_0_0
