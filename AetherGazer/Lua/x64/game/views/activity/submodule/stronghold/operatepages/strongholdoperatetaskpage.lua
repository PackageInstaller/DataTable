local var_0_0 = class("StrongholdOperateTaskPage", StrongholdOperateBasePage)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.hander_ = arg_1_1

	local var_1_0 = Asset.Load("UI/VersionUI/XuHeng3rdUI/Stronghold/Operate/StrongholdNoteUI")

	arg_1_0.gameObject_ = Object.Instantiate(var_1_0, arg_1_2)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:Refresh()
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.tabController = ControllerUtil.GetController(arg_4_0.transform_, "tab")
	arg_4_0.rewardController = ControllerUtil.GetController(arg_4_0.transform_, "reward")
	arg_4_0.scrollHelper_ = LuaList.New(handler(arg_4_0, arg_4_0.indexItem), arg_4_0.m_taskList, StrongholdOperateTaskItem)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(nil, arg_5_0.m_type1Btn, function()
		if arg_5_0:SelectTab(1) then
			arg_5_0.m_animator:Play("Fx_messagebg_qiehuan", 0, 0)
		end
	end)
	arg_5_0:AddBtnListener(nil, arg_5_0.m_type2Btn, function()
		if arg_5_0:SelectTab(2) then
			arg_5_0.m_animator:Play("Fx_messagebg_qiehuan", 0, 0)
		end
	end)
	arg_5_0:AddBtnListener(nil, arg_5_0.m_type3Btn, function()
		if arg_5_0:SelectTab(3) then
			arg_5_0.m_animator:Play("Fx_messagebg_qiehuan", 0, 0)
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_rewardBtn, nil, function()
		TaskAction:SubmitTaskList(arg_5_0._finishList)
	end)
end

function var_0_0.UpdateTaskData(arg_10_0)
	arg_10_0._taskIDList, arg_10_0._finishList = arg_10_0:GetTaskData(arg_10_0.selectIndex)
end

function var_0_0.UpdateTaskRed(arg_11_0)
	local var_11_0, var_11_1 = arg_11_0:GetTaskData(1)
	local var_11_2, var_11_3 = arg_11_0:GetTaskData(2)
	local var_11_4, var_11_5 = arg_11_0:GetTaskData(3)

	manager.redPoint:SetRedPointIndependent(arg_11_0.m_type1Btn.transform, #var_11_1 > 0)
	manager.redPoint:SetRedPointIndependent(arg_11_0.m_type2Btn.transform, #var_11_3 > 0)
	manager.redPoint:SetRedPointIndependent(arg_11_0.m_type3Btn.transform, #var_11_5 > 0)
end

function var_0_0.GetTaskData(arg_12_0, arg_12_1)
	local var_12_0
	local var_12_1
	local var_12_2

	if arg_12_1 == 1 then
		var_12_0 = 711
		var_12_2 = 712
	elseif arg_12_1 == 2 then
		var_12_0 = 721
		var_12_2 = 722
	else
		var_12_0 = 731
		var_12_2 = 732
	end

	local var_12_3 = TaskTools:GetActivityTaskList(arg_12_0.task_activity_id) or {}
	local var_12_4 = clone(TaskTools.GetTaskList(var_12_3, var_12_0))

	table.insertto(var_12_4, TaskTools.GetTaskList(var_12_3, var_12_2))
	table.sort(var_12_4, function(arg_13_0, arg_13_1)
		local var_13_0 = AssignmentCfg[arg_13_0]
		local var_13_1 = AssignmentCfg[arg_13_1]
		local var_13_2 = TaskData2:GetTask(arg_13_0)
		local var_13_3 = TaskData2:GetTask(arg_13_1)
		local var_13_4 = var_13_2.complete_flag >= 1
		local var_13_5 = var_13_3.complete_flag >= 1
		local var_13_6 = var_13_2.progress >= var_13_0.need
		local var_13_7 = var_13_3.progress >= var_13_1.need

		if var_13_4 == var_13_5 then
			if var_13_6 == var_13_7 then
				return arg_13_0 < arg_13_1
			else
				return var_13_6
			end
		else
			return var_13_5
		end
	end)

	local var_12_5 = {}

	for iter_12_0, iter_12_1 in ipairs(var_12_4) do
		local var_12_6 = AssignmentCfg[iter_12_1]
		local var_12_7 = TaskData2:GetTask(iter_12_1)

		if var_12_7.complete_flag == 0 and var_12_7.progress >= var_12_6.need then
			table.insert(var_12_5, iter_12_1)
		end
	end

	return var_12_4, var_12_5
end

function var_0_0.SelectTab(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_0.selectIndex == arg_14_1 and not arg_14_2 then
		return false
	end

	arg_14_0.tabController:SetSelectedIndex(arg_14_1 - 1)

	arg_14_0.selectIndex = arg_14_1

	arg_14_0:UpdateTaskData()
	arg_14_0.scrollHelper_:StartScroll(#arg_14_0._taskIDList)
	arg_14_0:RefreshRecivedAll()
	arg_14_0:RefreshUI()

	return true
end

function var_0_0.RefreshUI(arg_15_0)
	local var_15_0 = arg_15_0.selectIndex
	local var_15_1, var_15_2, var_15_3, var_15_4 = StrongholdData:GetStrongholdLevel(var_15_0)
	local var_15_5 = ActivityStrongholdLevelCfg[var_15_1]

	arg_15_0.m_lvname.text = var_15_5.level_des

	local var_15_6 = GetTips("ACTIVITY_STRONGHOLD_TYPE_NAME_" .. var_15_0)

	arg_15_0.m_typeName.text = var_15_6 .. " Lv." .. var_15_2

	local var_15_7 = ActivityStrongholdLevelCfg[var_15_1 + 1]

	if var_15_7 then
		local var_15_8 = var_15_7.exp - var_15_5.exp

		arg_15_0.m_expSlider.value = var_15_3 / var_15_8
		arg_15_0.m_expLab.text = var_15_3 .. "/" .. var_15_8

		local var_15_9 = StrongholdData:GetWeeklyExp(arg_15_0.activity_id, var_15_0)
		local var_15_10 = StrongholdData:GetWeeklyMaxExp(arg_15_0.activity_id, var_15_0)

		arg_15_0.m_ceilLab.text = GetTips("ACTIVITY_STRONGHOLD_COIN_WEEK_CEIL") .. var_15_9 .. "/" .. var_15_10
	else
		arg_15_0.m_expSlider.value = 1
		arg_15_0.m_expLab.text = var_15_5.exp .. "/" .. var_15_5.exp
		arg_15_0.m_ceilLab.text = GetTips("ACTIVITY_STRONGHOLD_SKILL_MAX")
	end
end

function var_0_0.Refresh(arg_16_0, arg_16_1)
	arg_16_0.activity_id = arg_16_1
	arg_16_0.task_activity_id = 0

	local var_16_0 = ActivityCfg[arg_16_1]

	for iter_16_0, iter_16_1 in ipairs(var_16_0.sub_activity_list) do
		if ActivityTemplateConst.TASK == ActivityCfg[iter_16_1].activity_template then
			arg_16_0.task_activity_id = iter_16_1

			break
		end
	end

	if arg_16_0.selectIndex == nil then
		arg_16_0:SelectTab(1, true)
	else
		arg_16_0:UpdateTaskData()
		arg_16_0.scrollHelper_:Refresh()
		arg_16_0:RefreshRecivedAll()
	end

	arg_16_0:UpdateTaskRed()
end

function var_0_0.RefreshRecivedAll(arg_17_0)
	if #arg_17_0._finishList > 0 then
		arg_17_0.rewardController:SetSelectedIndex(1)
	else
		arg_17_0.rewardController:SetSelectedIndex(0)
	end
end

function var_0_0.OnTaskListChange(arg_18_0)
	arg_18_0:UpdateTaskData()

	local var_18_0 = arg_18_0.scrollHelper_:GetScrolledPosition()

	arg_18_0.scrollHelper_:StartScrollWithoutAnimator(#arg_18_0._taskIDList, var_18_0)
	arg_18_0:RefreshRecivedAll()
	arg_18_0:UpdateTaskRed()
end

function var_0_0.Dispose(arg_19_0)
	arg_19_0.scrollHelper_:Dispose()
	var_0_0.super.Dispose(arg_19_0)
end

function var_0_0.indexItem(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_0._taskIDList[arg_20_1]

	arg_20_2:SetData(arg_20_0.task_activity_id, var_20_0)
end

function var_0_0.OnCurrencyChange(arg_21_0)
	arg_21_0:RefreshUI()
end

return var_0_0
