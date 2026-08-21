local var_0_0 = class("SummeQuestRewardItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()

	arg_2_0.itemGoList_ = {}

	for iter_2_0 = 1, 3 do
		table.insert(arg_2_0.itemGoList_, arg_2_0["awardItem" .. iter_2_0 .. "Obj_"])
	end

	arg_2_0.itemList_ = {}
	arg_2_0.btnController_ = arg_2_0.allBtnController_:GetController("all")
	arg_2_0.greyController_ = arg_2_0.showController_:GetController("grey")
	arg_2_0.tagController_ = arg_2_0.showController_:GetController("type")
	arg_2_0.timeController_ = arg_2_0.showController_:GetController("TimeTips")
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.receiveBtn_, nil, function()
		TaskAction:SubmitTask(arg_4_0.taskID_)
	end)
end

function var_0_0.IndexItem(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = formatReward(arg_6_0.rewardData_[arg_6_1])
	local var_6_1 = clone(ItemTemplateData)

	var_6_1.id = var_6_0.id
	var_6_1.number = var_6_0.num
	var_6_1.timeValid = var_6_0.timeValid or 0

	function var_6_1.clickFun(arg_7_0)
		ShowPopItem(POP_ITEM, {
			arg_7_0.id,
			arg_7_0.number
		})
	end

	arg_6_2:SetData(var_6_1)
end

function var_0_0.SetData(arg_8_0, arg_8_1)
	arg_8_0.taskID_ = arg_8_1
	arg_8_0.cfg_ = AssignmentCfg[arg_8_1]
	arg_8_0.rewardData_ = arg_8_0.cfg_.reward

	if not arg_8_0.taskID_ or arg_8_0.taskID_ == 0 then
		return
	end

	arg_8_0:UpdateView()
	arg_8_0:AddTimer()
end

function var_0_0.UpdateView(arg_9_0)
	local var_9_0 = TaskData2:GetTaskComplete(arg_9_0.taskID_)
	local var_9_1 = TaskData2:GetTaskProgress(arg_9_0.taskID_) >= arg_9_0.cfg_.need
	local var_9_2 = math.min(TaskData2:GetTaskProgress(arg_9_0.taskID_), arg_9_0.cfg_.need)
	local var_9_3

	if arg_9_0.cfg_.condition == 51311 then
		var_9_3 = string.format(arg_9_0.cfg_.desc, HeroCfg[arg_9_0.cfg_.additional_parameter[1]].suffix)
	else
		var_9_3 = arg_9_0.cfg_.desc
	end

	arg_9_0.titleText_.text = var_9_3
	arg_9_0.progressText_.text = var_9_2 .. "/" .. arg_9_0.cfg_.need
	arg_9_0.progressBar_.value = var_9_2 / arg_9_0.cfg_.need

	if var_9_0 then
		arg_9_0.btnController_:SetSelectedState("complete")
	elseif var_9_1 then
		arg_9_0.btnController_:SetSelectedState("receive")
	else
		arg_9_0.btnController_:SetSelectedState("lock")
	end

	arg_9_0.greyController_:SetSelectedState(tostring(not var_9_0))

	if arg_9_0.cfg_.type == TaskConst.TASK_TYPE.SUMMER_WATER_WEEKLY or arg_9_0.cfg_.type == TaskConst.TASK_TYPE.SWIMSUIT_BATTLE_WEEKLY then
		arg_9_0.tagController_:SetSelectedState("everyweek")
	elseif arg_9_0.cfg_.type == TaskConst.TASK_TYPE.OSIRIS_TASK_DAILY then
		arg_9_0.tagController_:SetSelectedState("everyday")
	elseif arg_9_0.cfg_.type == TaskConst.TASK_TYPE.OSIRIS_TASK_CHALLENGE then
		arg_9_0.tagController_:SetSelectedState("challenge")
	end

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.itemGoList_) do
		if not arg_9_0.itemList_[iter_9_0] then
			arg_9_0.itemList_[iter_9_0] = CommonItemView.New(iter_9_1)
		end

		local var_9_4 = arg_9_0.itemList_[iter_9_0]

		if arg_9_0.rewardData_[iter_9_0] then
			arg_9_0:IndexItem(iter_9_0, var_9_4)
			SetActive(iter_9_1, true)
		else
			SetActive(iter_9_1, false)
		end
	end
end

function var_0_0.AddTimer(arg_10_0)
	if arg_10_0.timer_ then
		arg_10_0.timer_:Stop()

		arg_10_0.timer_ = nil
	end

	arg_10_0.timeController_:SetSelectedState("close")

	if not TaskData2:GetTask(arg_10_0.taskID_) then
		return
	end

	local var_10_0 = TaskData2:GetTask(arg_10_0.taskID_).expired_timestamp

	if arg_10_0.cfg_.type == TaskConst.TASK_TYPE.OSIRIS_TASK_CHALLENGE then
		arg_10_0.timeController_:SetSelectedState("close")

		return
	end

	if var_10_0 then
		if var_10_0 == 0 then
			arg_10_0.timeController_:SetSelectedState("close")
		else
			arg_10_0.timeText_.text = manager.time:GetLostTimeStrWith2Unit(var_10_0, true)

			arg_10_0.timeController_:SetSelectedState("show")

			arg_10_0.timer_ = Timer.New(function()
				if manager.time:GetServerTime() > var_10_0 then
					return
				end

				arg_10_0.timeText_.text = manager.time:GetLostTimeStrWith2Unit(var_10_0, true)
			end, 1, -1)
		end

		arg_10_0.timer_:Start()
	end
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0:RemoveAllListeners()

	if arg_12_0.itemList_ then
		for iter_12_0, iter_12_1 in ipairs(arg_12_0.itemList_) do
			iter_12_1:Dispose()
		end
	end

	if arg_12_0.timer_ then
		arg_12_0.timer_:Stop()

		arg_12_0.timer_ = nil
	end

	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
