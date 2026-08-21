local var_0_0 = class("SkuldSystemTaskScheduleItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.item_ = CommonItemView.New(arg_3_0.itemGo_)
	arg_3_0.controller_ = arg_3_0.controllerEx_:GetController("state")
end

function var_0_0.SetData(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.taskID_ = arg_4_1
	arg_4_0.nextTaskID_ = arg_4_2

	if arg_4_0.nextTaskID_ == nil then
		arg_4_0.isLast_ = true
	end

	arg_4_0:UpdateView()
end

function var_0_0.AddUIListener(arg_5_0)
	return
end

function var_0_0.UpdateView(arg_6_0)
	local var_6_0, var_6_1 = SkuldSystemData:GetCurTaskScheduleInfo()
	local var_6_2 = AssignmentCfg[arg_6_0.taskID_]

	arg_6_0.needText_.text = var_6_2.need

	if arg_6_0.isLast_ then
		SetActive(arg_6_0.processGo_, false)
	else
		SetActive(arg_6_0.processGo_, true)

		local var_6_3 = AssignmentCfg[arg_6_0.nextTaskID_]

		if var_6_0 >= var_6_3.need then
			arg_6_0.fillImage_.fillAmount = 1
		elseif var_6_0 < var_6_2.need then
			arg_6_0.fillImage_.fillAmount = 0
		else
			local var_6_4 = var_6_0 - var_6_2.need
			local var_6_5 = var_6_3.need - var_6_2.need

			arg_6_0.fillImage_.fillAmount = var_6_4 / var_6_5
		end
	end

	local var_6_6 = clone(ItemTemplateData)
	local var_6_7 = var_6_2.reward[1]

	var_6_6.id = var_6_7[1]
	var_6_6.number = var_6_7[2]

	function var_6_6.clickFun(arg_7_0)
		if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_SKULD_MAIN_TASK) then
			if TaskData2:GetTaskComplete(arg_6_0.taskID_) then
				ShowPopItem(POP_ITEM, {
					arg_7_0.id,
					arg_7_0.number
				})
			elseif var_6_0 >= var_6_2.need then
				local var_7_0 = AssignmentCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_SKULD_SCHEDULE_TASK]
				local var_7_1 = {}

				for iter_7_0, iter_7_1 in pairs(var_7_0) do
					if TaskData2:GetTaskComplete(iter_7_1) then
						-- block empty
					elseif var_6_0 >= AssignmentCfg[iter_7_1].need then
						table.insert(var_7_1, iter_7_1)
					end
				end

				TaskAction:SubmitTaskList(var_7_1)
			else
				ShowPopItem(POP_ITEM, {
					arg_7_0.id,
					arg_7_0.number
				})
			end
		else
			ShowTips("TIME_OUT")
		end
	end

	if TaskData2:GetTaskComplete(arg_6_0.taskID_) then
		var_6_6.grayFlag = true
		var_6_6.highLight = false

		arg_6_0.controller_:SetSelectedState("alreadyget")
	elseif var_6_0 >= var_6_2.need then
		var_6_6.grayFlag = false
		var_6_6.highLight = true

		arg_6_0.controller_:SetSelectedState("canget")
	else
		var_6_6.grayFlag = false
		var_6_6.highLight = false

		arg_6_0.controller_:SetSelectedState("notyet")
	end

	arg_6_0.item_:SetData(var_6_6)
end

function var_0_0.OnEnter(arg_8_0)
	local var_8_0 = RedPointConst.SKULD_SYSTEM_TASK_ITEM .. arg_8_0.taskID_

	manager.redPoint:bindUIandKey(arg_8_0.transform_, var_8_0)
end

function var_0_0.OnExit(arg_9_0)
	local var_9_0 = RedPointConst.SKULD_SYSTEM_TASK_ITEM .. arg_9_0.taskID_

	manager.redPoint:unbindUIandKey(arg_9_0.transform_, var_9_0)
end

function var_0_0.Dispose(arg_10_0)
	var_0_0.super.Dispose(arg_10_0)
	Object.Destroy(arg_10_0.gameObject_)
end

return var_0_0
