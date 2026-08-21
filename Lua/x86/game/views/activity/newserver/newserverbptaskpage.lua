local var_0_0 = class("NewServerBPTaskPage", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	local var_1_0 = Asset.Load("Widget/System/NewServer/NewServerPasserUI")
	local var_1_1 = Object.Instantiate(var_1_0, arg_1_1)

	arg_1_0.gameObject_ = var_1_1
	arg_1_0.transform_ = var_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()

	arg_2_0.taskItemList_ = LuaList.New(handler(arg_2_0, arg_2_0.IndexItem), arg_2_0.uiList_, NewServerBPTaskItem)
	arg_2_0.gsPayCallback_ = handler(arg_2_0, arg_2_0.OnPaySuccess)
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.ReceiveBtn_, nil, function()
		if not ActivityTools.ActivityOpenCheck(arg_3_0.activityID_) then
			return
		end

		NewServerAction.ReceiveBPReward(arg_3_0:GetCanReceiveTaskList(), handler(arg_3_0, arg_3_0.OnBPTaskReceive))
	end)
	arg_3_0:AddBtnListener(arg_3_0.UpgradeBtn_, nil, function()
		if not ActivityTools.ActivityOpenCheck(arg_3_0.activityID_) then
			return
		end

		PayAction.RequestGSPay(NewServerCfg[arg_3_0.activityID_].bp_goods_id, 1)
	end)
end

function var_0_0.InitUI(arg_6_0)
	arg_6_0:BindCfgUI()
end

function var_0_0.Dispose(arg_7_0)
	if arg_7_0.taskItemList_ then
		arg_7_0.taskItemList_:Dispose()

		arg_7_0.taskItemList_ = nil
	end

	arg_7_0.gsPayCallback_ = nil

	var_0_0.super.Dispose(arg_7_0)
end

function var_0_0.SetData(arg_8_0, arg_8_1)
	arg_8_0.activityID_ = arg_8_1
	arg_8_0.taskList_ = NewServerCfg[arg_8_0.activityID_].bp

	local var_8_0 = NewServerData:GetBPTaskStatus()
	local var_8_1 = NewServerData:GetBPTaskIsRecharge()
	local var_8_2 = NewServerData:GetAccumulateCurrency()

	arg_8_0.progressText_.text = var_8_2

	local var_8_3 = 1
	local var_8_4 = false

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.taskList_) do
		if var_8_2 >= NewServerBPTaskCfg[iter_8_1].need then
			if var_8_0[iter_8_1] == nil then
				var_8_4 = true
			elseif var_8_0[iter_8_1].is_receive_reward < 1 or var_8_1 >= 1 and var_8_0[iter_8_1].is_receive_recharge_reward < 1 then
				var_8_4 = true
			end
		end

		if var_8_4 == true then
			var_8_3 = iter_8_0

			break
		end
	end

	SetActive(arg_8_0.recevieBtnGo_, var_8_4)
	SetActive(arg_8_0.UpgradeGo_, var_8_1 < 1)
	arg_8_0.taskItemList_:StartScroll(#arg_8_0.taskList_, var_8_3)
end

function var_0_0.IndexItem(arg_9_0, arg_9_1, arg_9_2)
	arg_9_2:SetData(arg_9_0.taskList_[arg_9_1], arg_9_0.activityID_, arg_9_1 == 1, arg_9_0.taskList_[arg_9_1 - 1])
	arg_9_2:SetReceiveHandler(handler(arg_9_0, arg_9_0.OnBPTaskReceive))
end

function var_0_0.SetActive(arg_10_0, arg_10_1)
	SetActive(arg_10_0.gameObject_, arg_10_1)
end

function var_0_0.OnEnter(arg_11_0)
	manager.redPoint:bindUIandKey(arg_11_0.ReceiveBtn_.transform, RedPointConst.ACTIVITY_NEW_SERVER_BP)
	manager.notify:RegistListener(RECHARGE_SUCCESS, arg_11_0.gsPayCallback_)
end

function var_0_0.OnExit(arg_12_0)
	manager.redPoint:unbindUIandKey(arg_12_0.ReceiveBtn_.transform, RedPointConst.ACTIVITY_NEW_SERVER_BP)
	manager.notify:RemoveListener(RECHARGE_SUCCESS, arg_12_0.gsPayCallback_)
end

function var_0_0.OnPaySuccess(arg_13_0)
	NewServerAction.SetBPTaskIsRecharge()
	arg_13_0:SetData(arg_13_0.activityID_)
end

function var_0_0.OnBPTaskReceive(arg_14_0)
	arg_14_0:SetData(arg_14_0.activityID_)
end

function var_0_0.UpdateBar(arg_15_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.GetCanReceiveTaskList(arg_16_0)
	local var_16_0 = {}
	local var_16_1 = NewServerCfg[arg_16_0.activityID_].bp
	local var_16_2 = NewServerData:GetBPTaskStatus()
	local var_16_3 = NewServerData:GetBPTaskIsRecharge()
	local var_16_4 = NewServerData:GetAccumulateCurrency()

	for iter_16_0, iter_16_1 in ipairs(var_16_1) do
		if var_16_4 >= NewServerBPTaskCfg[iter_16_1].need then
			if var_16_2[iter_16_1] then
				if var_16_2[iter_16_1].is_receive_reward < 1 then
					var_16_0[#var_16_0 + 1] = {
						receive_type = 1,
						id = iter_16_1
					}
				end

				if var_16_3 >= 1 and var_16_2[iter_16_1].is_receive_recharge_reward < 1 then
					var_16_0[#var_16_0 + 1] = {
						receive_type = 2,
						id = iter_16_1
					}
				end
			else
				var_16_0[#var_16_0 + 1] = {
					receive_type = 1,
					id = iter_16_1
				}

				if var_16_3 >= 1 then
					var_16_0[#var_16_0 + 1] = {
						receive_type = 2,
						id = iter_16_1
					}
				end
			end
		end
	end

	return var_16_0
end

return var_0_0
