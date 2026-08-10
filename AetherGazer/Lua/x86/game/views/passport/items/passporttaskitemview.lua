local var_0_0 = class("PassportTaskItemView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
	arg_2_0:StartTimer()
end

function var_0_0.StartTimer(arg_3_0)
	if not arg_3_0.timer_ then
		arg_3_0.timer_ = Timer.New(function()
			arg_3_0:UpdateTimer()
		end, 1, -1)
	end

	arg_3_0.timer_:Start()
end

function var_0_0.RemoveTimer(arg_5_0)
	if arg_5_0.timer_ then
		arg_5_0.timer_:Stop()

		arg_5_0.timer_ = nil
	end
end

function var_0_0.UpdateTimer(arg_6_0)
	if arg_6_0.taskInfo_ == nil then
		arg_6_0.lastTimeLabel_.text = ""

		arg_6_0.timeController_:SetSelectedState("false")

		return
	end

	local var_6_0 = arg_6_0.taskInfo_.expired_timestamp or 0

	if var_6_0 > 0 then
		SetActive(arg_6_0.timeGo_, true)
		arg_6_0.timeController_:SetSelectedState("true")

		arg_6_0.lastTimeLabel_.text = manager.time:GetLostTimeStr(var_6_0)
	else
		SetActive(arg_6_0.timeGo_, false)
		arg_6_0.timeController_:SetSelectedState("false")
	end
end

function var_0_0.InitUI(arg_7_0)
	arg_7_0:BindCfgUI()

	arg_7_0.statusController_ = ControllerUtil.GetController(arg_7_0.gameObject_.transform, "status")
	arg_7_0.timeController_ = ControllerUtil.GetController(arg_7_0.gameObject_.transform, "time")
	arg_7_0.list_ = LuaList.New(handler(arg_7_0, arg_7_0.indexItem), arg_7_0.listGo_, CommonItemView)
end

function var_0_0.indexItem(arg_8_0, arg_8_1, arg_8_2)
	CommonTools.SetCommonData(arg_8_2, {
		id = arg_8_0.rewardList_[arg_8_1][1],
		number = arg_8_0.rewardList_[arg_8_1][2],
		grayFlag = arg_8_0.taskInfo_.complete_flag == 1,
		clickFun = function(arg_9_0)
			ShowPopItem(POP_OTHER_ITEM, {
				arg_9_0.id,
				arg_9_0.number
			})
		end
	})
end

function var_0_0.AddUIListener(arg_10_0)
	arg_10_0:AddBtnListener(arg_10_0.goBtn_, nil, function()
		JumpTools.JumpToPage2(arg_10_0.taskCfg_.source)
	end)
	arg_10_0:AddBtnListener(arg_10_0.getBtn_, nil, function()
		local var_12_0 = true
		local var_12_1 = getData("passport_task", "tip_deadline")

		if var_12_1 and tonumber(var_12_1) > manager.time:GetServerTime() then
			var_12_0 = false
		end

		if var_12_0 and (arg_10_0.taskCfg_.type == 7 or arg_10_0.taskCfg_.type == 8) and PassportData:GetExpWeekly() >= GameSetting.battlepass_exp_limit_weekly.value[1] then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("PASSPORT_WEEKLY_EXP_LIMIT_TIP"),
				toggleText = GetTips("WEEKLY_MUTE_TIP"),
				OkCallback = function()
					TaskAction:SubmitTask(arg_10_0.taskCfg_.id)
				end,
				ToggleCallback = function(arg_14_0)
					if arg_14_0 then
						saveData("passport_task", "tip_deadline", tostring(_G.gameTimer:GetNextWeekFreshTime()))
					end
				end
			})
		else
			TaskAction:SubmitTask(arg_10_0.taskCfg_.id)
		end
	end)
end

function var_0_0.SetData(arg_15_0, arg_15_1)
	arg_15_0.taskCfg_ = AssignmentCfg[arg_15_1]
	arg_15_0.taskInfo_ = TaskData2:GetTask(arg_15_1)
	arg_15_0.rewardList_ = arg_15_0.taskCfg_.reward or {}

	arg_15_0:UpdateView()
	arg_15_0:UpdateTimer()
end

function var_0_0.UpdateView(arg_16_0)
	arg_16_0.list_:StartScroll(#arg_16_0.rewardList_)

	arg_16_0.typeLabel_.text = GetI18NText(arg_16_0.taskCfg_.name)
	arg_16_0.descLabel_.text = GetI18NText(arg_16_0.taskCfg_.desc)

	local var_16_0 = TaskData2:GetTaskProgress(arg_16_0.taskCfg_.id)
	local var_16_1 = arg_16_0.taskCfg_.need

	if var_16_1 < var_16_0 then
		var_16_0 = var_16_1
	end

	arg_16_0.progressLabel_.text = string.format("%d/%d", var_16_0, var_16_1)
	arg_16_0.progressSlider_.value = var_16_0 / var_16_1

	if arg_16_0.taskInfo_.complete_flag == 1 then
		arg_16_0.statusController_:SetSelectedState("haveGet")
	elseif var_16_1 <= var_16_0 then
		arg_16_0.statusController_:SetSelectedState("canGet")
	else
		arg_16_0.statusController_:SetSelectedState("cannotGet")
	end
end

function var_0_0.OnEnter(arg_17_0)
	return
end

function var_0_0.OnExit(arg_18_0)
	arg_18_0:RemoveTimer()
end

function var_0_0.Dispose(arg_19_0)
	if arg_19_0.list_ then
		arg_19_0.list_:Dispose()

		arg_19_0.list_ = nil
	end

	arg_19_0:RemoveTimer()
	var_0_0.super.Dispose(arg_19_0)
end

return var_0_0
