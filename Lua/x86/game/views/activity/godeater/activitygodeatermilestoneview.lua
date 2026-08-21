CommonTaskPopView = import("game.views.task.pop.CommonTaskPopView")

local var_0_0 = class("ActivityGodEaterMilestoneView", CommonTaskPopView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/V4_2_GodEaterUI/V4_2_GodEaterUI_Bounty/V4_2_GodEaterUI_Bounty_QuestPopUI"
end

function var_0_0.Init(arg_2_0)
	var_0_0.super.Init(arg_2_0)

	arg_2_0.btnControlller = arg_2_0.v4_2_godeaterui_bounty_questpopuiControllerexcollection_:GetController("onekey")
end

function var_0_0.OnEnter(arg_3_0)
	var_0_0.super.OnEnter(arg_3_0)
	arg_3_0:ResortList()
	arg_3_0.constVar.taskListModule:RegisterTaskListChangedEvent(function()
		arg_3_0:ResortList()
		GodEaterAction.UpdateRedPoint()
		arg_3_0:UpdateOnekey()
	end)

	arg_3_0.timer = Timer.New(function()
		if not ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_GODEATER_MAIN_KEY) then
			JumpTools.OpenPageByJump("/ActivityGodEaterGameMainView", {
				activity_id = ActivityConst.ACTIVITY_GODEATER_MAIN_KEY
			})
			ShowTips(GetTips("TIME_OVER"))

			return
		end
	end, 1)

	arg_3_0:UpdateOnekey()
end

function var_0_0.ResortList(arg_6_0)
	if arg_6_0.data.activityId == ActivityConst.ACTIVITY_CIVILIZATION then
		return
	end

	table.sort(arg_6_0.constVar.taskListModule.constVar.taskList, function(arg_7_0, arg_7_1)
		return arg_7_0.id < arg_7_1.id
	end)

	local var_6_0 = 1
	local var_6_1 = false
	local var_6_2 = false
	local var_6_3 = 1
	local var_6_4 = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.constVar.taskListModule.constVar.taskList) do
		if AssignmentCfg[iter_6_1.id].type == 3002 then
			table.insert(var_6_4, iter_6_1)
		end
	end

	arg_6_0.constVar.taskListModule.constVar.taskList = var_6_4

	for iter_6_2, iter_6_3 in ipairs(arg_6_0.constVar.taskListModule.constVar.taskList) do
		local var_6_5 = AssignmentCfg[iter_6_3.id]
		local var_6_6 = iter_6_3.progress
		local var_6_7 = var_6_5.need

		if var_6_6 < var_6_7 and iter_6_3.complete_flag == 0 and not var_6_2 then
			var_6_3 = iter_6_2
			var_6_2 = true
		end

		if var_6_7 <= var_6_6 and iter_6_3.complete_flag == 0 and not var_6_1 then
			var_6_0 = iter_6_2
			var_6_1 = true
		end
	end

	if not var_6_1 then
		var_6_0 = var_6_3
	end

	arg_6_0.constVar.taskListModule.constVar.scrollHelper:StartScroll(#arg_6_0.constVar.taskListModule.constVar.taskList, var_6_0)
end

function var_0_0.UpdateOnekey(arg_8_0)
	if arg_8_0.data.activityId == ActivityConst.ACTIVITY_CIVILIZATION then
		arg_8_0.titleText_ = GetTips("GODEATER_CIVILIZATION_TASK_NAME")

		SetActive(arg_8_0.titleGo_, false)
		SetActive(arg_8_0.taskGo_, true)
	else
		arg_8_0.titleText_ = GetTips("GODEATER_TASK_NAME")

		SetActive(arg_8_0.titleGo_, true)
		SetActive(arg_8_0.taskGo_, false)
	end

	arg_8_0.oneKeyList = {}

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.constVar.taskListModule.constVar.taskList) do
		local var_8_0 = AssignmentCfg[iter_8_1.id]

		if iter_8_1.progress >= var_8_0.need and iter_8_1.complete_flag == 0 then
			table.insert(arg_8_0.oneKeyList, iter_8_1.id)
		end
	end

	arg_8_0.btnControlller:SetSelectedState(#arg_8_0.oneKeyList > 0 and "true" or "false")
end

function var_0_0.OnExit(arg_9_0)
	var_0_0.super.OnExit(arg_9_0)
	arg_9_0:StopTimer()
end

function var_0_0.AddUIListener(arg_10_0)
	var_0_0.super.AddUIListener(arg_10_0)
	arg_10_0:AddBtnListener(arg_10_0.btn01Btn_, nil, function()
		TaskAction:SubmitTaskList(arg_10_0.oneKeyList)
	end)
	arg_10_0:AddBtnListener(arg_10_0.btn_backBtn_, nil, function()
		arg_10_0:Back()
	end)
end

function var_0_0.Dispose(arg_13_0)
	var_0_0.super.Dispose(arg_13_0)
end

function var_0_0.StopTimer(arg_14_0)
	if arg_14_0.timer_ then
		arg_14_0.timer_:Stop()

		arg_14_0.timer_ = nil
	end
end

return var_0_0
