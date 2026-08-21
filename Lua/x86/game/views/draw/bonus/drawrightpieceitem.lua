local var_0_0 = class("DrawRightPieceItem", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Pool/SendCharacterBtn"
end

function var_0_0.Ctor(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.gameObject_ = Object.Instantiate(Asset.Load(arg_2_0:UIName()), arg_2_1.transform)
	arg_2_0.transform_ = arg_2_0.gameObject_.transform

	arg_2_0:BindCfgUI()
	arg_2_0:AddListeners()

	arg_2_0.taskIDList_ = {}
	arg_2_0.stateController_ = arg_2_0.controller_:GetController("state")
	arg_2_0.headController1_ = arg_2_0.controller1_:GetController("status")
	arg_2_0.headController2_ = arg_2_0.controller2_:GetController("status")
end

function var_0_0.Dispose(arg_3_0)
	arg_3_0.onModifyBonusHandler_ = nil

	var_0_0.super.Dispose(arg_3_0)
	Object.Destroy(arg_3_0.gameObject_)

	arg_3_0.gameObject_ = nil
	arg_3_0.transfrom_ = nil
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.infoBtn_, nil, function()
		DrawAction.GetPoolData(arg_4_0.selectPoolID_)
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.activityID_ = arg_6_1
	arg_6_0.selectPoolID_ = arg_6_2
	arg_6_0.taskActivity_ = ActivityDrawPieceCfg[arg_6_1].task_activity
	arg_6_0.taskIDList_ = {}

	for iter_6_0, iter_6_1 in ipairs(AssignmentCfg.get_id_list_by_activity_id[arg_6_0.taskActivity_]) do
		table.insert(arg_6_0.taskIDList_, iter_6_1)
	end

	table.sort(arg_6_0.taskIDList_, function(arg_7_0, arg_7_1)
		local var_7_0 = AssignmentCfg[arg_7_0]
		local var_7_1 = AssignmentCfg[arg_7_1]
		local var_7_2 = TaskData2:GetTask(arg_7_0)
		local var_7_3 = TaskData2:GetTask(arg_7_1)
		local var_7_4 = TaskData2:GetTaskComplete(arg_7_0)
		local var_7_5 = TaskData2:GetTaskComplete(arg_7_1)
		local var_7_6 = var_7_2 and var_7_2.progress >= var_7_0.need or false
		local var_7_7 = var_7_3 and var_7_3.progress >= var_7_1.need or false

		if var_7_4 and not var_7_5 then
			return false
		elseif not var_7_4 and var_7_5 then
			return true
		elseif var_7_6 and not var_7_7 then
			return true
		elseif not var_7_6 and var_7_7 then
			return false
		else
			return arg_7_0 < arg_7_1
		end
	end)

	arg_6_0.activeTask_ = 0

	for iter_6_2, iter_6_3 in ipairs(arg_6_0.taskIDList_) do
		local var_6_0 = TaskData2:GetTask(iter_6_3)
		local var_6_1 = TaskData2:GetTaskComplete(iter_6_3)
		local var_6_2 = var_6_0 and var_6_0.progress >= AssignmentCfg[iter_6_3].need or false

		if not var_6_1 and var_6_2 then
			arg_6_0.activeTask_ = iter_6_3

			break
		end
	end

	if arg_6_0.activeTask_ == 0 then
		arg_6_0.activeTask_ = arg_6_0.taskIDList_[#arg_6_0.taskIDList_]
	end

	local var_6_3 = AssignmentCfg[arg_6_0.activeTask_]
	local var_6_4 = TaskData2:GetTask(arg_6_0.activeTask_)

	if var_6_3 then
		local var_6_5 = clone(ItemTemplateData)

		var_6_5.id = var_6_3.reward[1][1]
		var_6_5.number = var_6_3.reward[1][2]
		var_6_5.taskID = arg_6_0.activeTask_

		function var_6_5.clickFun(arg_8_0)
			local var_8_0 = TaskData2:GetTask(arg_8_0.taskID)
			local var_8_1 = var_8_0 and var_8_0.progress >= AssignmentCfg[arg_8_0.taskID].need or false
			local var_8_2 = TaskData2:GetTaskComplete(arg_8_0.taskID)

			if var_8_1 and not var_8_2 then
				TaskAction:SubmitTaskList({
					arg_8_0.taskID
				}, 0, function()
					arg_6_0:RefreshText()
				end)
			else
				ShowPopItem(POP_ITEM, {
					arg_8_0.id
				})
			end
		end

		if not arg_6_0.item_ then
			arg_6_0.item = CommonItemView.New(arg_6_0.pieceItem1_, true)
		end

		arg_6_0.item:SetData(var_6_5)
	end

	arg_6_0:RefreshText()
end

function var_0_0.CheckCompleteList(arg_10_0, arg_10_1)
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.taskIDList_) do
		local var_10_1 = TaskData2:GetTask(iter_10_1)
		local var_10_2 = TaskData2:GetTaskComplete(iter_10_1)
		local var_10_3 = var_10_1 and var_10_1.progress >= AssignmentCfg[iter_10_1].need or false

		if not var_10_2 and var_10_3 then
			table.insert(var_10_0, iter_10_1)
		end
	end

	if #var_10_0 > 0 then
		arg_10_0.stateController_:SetSelectedState("claimable")

		if arg_10_0.timer_ then
			arg_10_0.timer_:Stop()

			arg_10_0.timer_ = nil
		end

		if arg_10_1 then
			SetActive(arg_10_1.maskGo_, true)
		end

		arg_10_0.timer_ = Timer.New(function()
			if arg_10_1 then
				SetActive(arg_10_1.maskGo_, false)
			end

			TaskAction:SubmitTaskList(var_10_0, 0, function()
				arg_10_0:RefreshText()
			end)
			arg_10_0.timer_:Stop()

			arg_10_0.timer_ = nil
		end, 1, -1)

		arg_10_0.timer_:Start()
	else
		SetActive(arg_10_0.maskGo_, false)
		arg_10_0.stateController_:SetSelectedState("normal")
	end
end

function var_0_0.RefreshText(arg_13_0)
	local var_13_0 = arg_13_0.item:GetData()
	local var_13_1 = AssignmentCfg[arg_13_0.activeTask_]
	local var_13_2 = TaskData2:GetTask(arg_13_0.activeTask_)
	local var_13_3 = TaskData2:GetTaskComplete(arg_13_0.activeTask_)
	local var_13_4 = var_13_2 and var_13_2.progress >= AssignmentCfg[arg_13_0.activeTask_].need or false

	var_13_0.highLight = not var_13_3 and var_13_4
	var_13_0.completedFlag = TaskData2:GetTaskComplete(var_13_3)
	var_13_0.grayFlag = TaskData2:GetTaskComplete(var_13_3)

	arg_13_0.item:SetData(var_13_0)

	local var_13_5 = {}
	local var_13_6 = {}

	for iter_13_0, iter_13_1 in ipairs(arg_13_0.taskIDList_) do
		local var_13_7 = AssignmentCfg[iter_13_1]
		local var_13_8 = TaskData2:GetTask(iter_13_1)
		local var_13_9 = var_13_8 and var_13_8.progress or 0
		local var_13_10 = var_13_7.additional_parameter[1]

		if not var_13_6[var_13_10] then
			var_13_6[var_13_10] = true

			table.insert(var_13_5, {
				roleID = var_13_10,
				progress = math.max(var_13_5[var_13_10] or 0, var_13_9)
			})
		end

		for iter_13_2, iter_13_3 in ipairs(var_13_5) do
			if iter_13_3.roleID == var_13_10 then
				iter_13_3.progress = math.max(iter_13_3.progress, var_13_9)

				break
			end
		end
	end

	table.sort(var_13_5, function(arg_14_0, arg_14_1)
		return arg_14_0.roleID < arg_14_1.roleID
	end)

	local var_13_11 = 0
	local var_13_12 = 0

	for iter_13_4, iter_13_5 in ipairs(var_13_5) do
		local var_13_13 = 0

		for iter_13_6, iter_13_7 in ipairs(arg_13_0.taskIDList_) do
			if AssignmentCfg[iter_13_7].additional_parameter[1] == iter_13_5.roleID then
				var_13_13 = math.max(var_13_13, AssignmentCfg[iter_13_7].need)
			end
		end

		var_13_11 = var_13_11 + math.min(iter_13_5.progress, var_13_13)
		var_13_12 = var_13_12 + var_13_13
	end

	arg_13_0.headController1_:SetSelectedIndex(var_13_5[1].progress)
	arg_13_0.headController2_:SetSelectedIndex(var_13_5[2].progress)

	if not var_13_2 or not math.min(var_13_2.progress, var_13_1.need) then
		local var_13_14 = 0
	end

	arg_13_0.progressText1_.text = string.format("%s/%s", var_13_11, var_13_12)

	arg_13_0:Show(true)
end

function var_0_0.OnExit(arg_15_0)
	if arg_15_0.timer_ then
		arg_15_0.timer_:Stop()

		arg_15_0.timer_ = nil
	end
end

function var_0_0.Show(arg_16_0, arg_16_1)
	SetActive(arg_16_0.gameObject_, arg_16_1)
end

return var_0_0
