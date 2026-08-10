local var_0_0 = class("AnniversaryTaskItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.controller_ = ControllerUtil.GetController(arg_1_0.transform_, "name")
end

function var_0_0.SetData(arg_2_0, arg_2_1)
	arg_2_0.taskID_ = arg_2_1

	local var_2_0 = AssignmentCfg[arg_2_1]

	arg_2_0.descText_.text = GetI18NText(var_2_0.desc)

	local var_2_1 = TaskData2:GetTask(arg_2_1)

	arg_2_0.cntText_.text = string.format("%s/%s", var_2_1.progress > var_2_0.need and var_2_0.need or var_2_1.progress, var_2_0.need)
	arg_2_0.sliderImage_.fillAmount = var_2_1.progress / var_2_0.need

	if not arg_2_0.rewardItem_ then
		arg_2_0.rewardItem_ = CommonItem.New(arg_2_0.rewardGo_)
	end

	arg_2_0.rewardItem_:RefreshData(formatReward(var_2_0.reward[1]))
	arg_2_0.rewardItem_:RegistCallBack(function(arg_3_0)
		ShowPopItem(POP_ITEM, arg_3_0)
	end)
	arg_2_0.rewardItem_:ShowFloor(ItemConst.ITEM_FLOOR.SHORT)
	arg_2_0:RefreshBtnState()
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)
	arg_4_0:StopTimer()

	if arg_4_0.rewardItem_ then
		arg_4_0.rewardItem_:Dispose()

		arg_4_0.rewardItem_ = nil
	end
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.button_, nil, function()
		TaskAction:SubmitTask(arg_5_0.taskID_)
	end)
end

function var_0_0.RefreshBtnState(arg_7_0)
	local var_7_0 = arg_7_0.taskID_
	local var_7_1 = AssignmentCfg[var_7_0]
	local var_7_2 = TaskData2:GetTask(var_7_0)

	if var_7_2.complete_flag == 0 then
		if var_7_2.progress >= var_7_1.need then
			arg_7_0.controller_:SetSelectedState("complete")
		else
			local var_7_3 = var_7_1.activity_id

			if var_7_3 ~= 0 then
				local var_7_4 = ActivityData:GetActivityData(var_7_3)

				if manager.time:GetServerTime() < var_7_4.startTime then
					arg_7_0.controller_:SetSelectedState("lock")
					arg_7_0:AddTimer()
				else
					arg_7_0.controller_:SetSelectedState("uncomplate")
				end
			else
				arg_7_0.controller_:SetSelectedState("uncomplate")
			end
		end
	elseif var_7_2.complete_flag >= 1 then
		arg_7_0.controller_:SetSelectedState("finish")
	end
end

function var_0_0.AddTimer(arg_8_0)
	if arg_8_0.timer_ then
		arg_8_0:StopTimer()
	end

	local var_8_0 = AssignmentCfg[arg_8_0.taskID_]
	local var_8_1 = ActivityData:GetActivityData(var_8_0.activity_id).startTime

	if arg_8_0.timeText_ then
		arg_8_0.timeText_.text = string.format(GetTips("LATER"), manager.time:GetLostTimeStr(var_8_1))
	end

	arg_8_0.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= var_8_1 then
			arg_8_0.controller_:SetSelectedState("uncomplate")
			arg_8_0:StopTimer()

			return
		end

		if arg_8_0.timeText_ then
			arg_8_0.timeText_.text = string.format(GetTips("LATER"), manager.time:GetLostTimeStr(var_8_1))
		end
	end, 1, -1)

	arg_8_0.timer_:Start()
end

function var_0_0.StopTimer(arg_10_0)
	if arg_10_0.timer_ then
		arg_10_0.timer_:Stop()

		arg_10_0.timer_ = nil
	end
end

return var_0_0
