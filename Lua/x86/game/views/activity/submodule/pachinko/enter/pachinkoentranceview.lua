ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local var_0_0 = class("PaChinKoEntranceView", ActivityMainBasePanel)

function var_0_0.GetUIName(arg_1_0)
	return PaChinKoTools.GetEntranceUIName(arg_1_0.activityID_)
end

function var_0_0.Init(arg_2_0)
	var_0_0.super.Init(arg_2_0)

	arg_2_0.clearCon_ = arg_2_0.taskPanelControllerEx_:GetController("clear")
	arg_2_0.scrollHelper_ = LuaList.New(handler(arg_2_0, arg_2_0.IndexItem), arg_2_0.scrollView_, PaChinKoEntranceItem)

	arg_2_0:BindHelpBtn(PaChinKoTools.GetDesc(arg_2_0.activityID_), arg_2_0.descBtn_)

	arg_2_0.refreshTaskHandler_ = handler(arg_2_0, arg_2_0.RefreshTask)
end

function var_0_0.OnEnter(arg_3_0)
	var_0_0.super.OnEnter(arg_3_0)
	manager.notify:RegistListener(ON_TASK_SUBMIT_LIST_RESPONSE, arg_3_0.refreshTaskHandler_)
	manager.notify:RegistListener(ON_TASK_SUBMIT_RESPONSE, arg_3_0.refreshTaskHandler_)
	arg_3_0:RefreshTask()
	manager.redPoint:bindUIandKey(arg_3_0.playBtn_.transform, RedPointConst.ACTIVITY_PACHINKO .. "_" .. arg_3_0.activityID_)
end

function var_0_0.OnExit(arg_4_0)
	manager.notify:RemoveListener(ON_TASK_SUBMIT_LIST_RESPONSE, arg_4_0.refreshTaskHandler_)
	manager.notify:RemoveListener(ON_TASK_SUBMIT_RESPONSE, arg_4_0.refreshTaskHandler_)
	var_0_0.super.OnExit(arg_4_0)
	manager.redPoint:unbindUIandKey(arg_4_0.playBtn_.transform, RedPointConst.ACTIVITY_PACHINKO .. "_" .. arg_4_0.activityID_)
end

function var_0_0.Dispose(arg_5_0)
	arg_5_0.scrollHelper_:Dispose()

	arg_5_0.scrollHelper_ = nil
	arg_5_0.refreshTaskHandler_ = nil

	var_0_0.super.Dispose(arg_5_0)
end

function var_0_0.AddListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.allReceiveBtn_, nil, function()
		local var_7_0 = {}

		for iter_7_0, iter_7_1 in ipairs(arg_6_0.list_) do
			if iter_7_1 ~= 0 then
				local var_7_1 = AssignmentCfg[iter_7_1]
				local var_7_2 = TaskData2:GetTask(iter_7_1)

				if var_7_2.complete_flag < 1 and var_7_2.progress >= var_7_1.need then
					table.insert(var_7_0, iter_7_1)
				end
			end
		end

		TaskAction:SubmitTaskList(var_7_0)
	end)
	arg_6_0:AddBtnListener(arg_6_0.playBtn_, nil, function()
		JumpTools.OpenPageByJump("/paChinKoMain", {
			mainActivityID = arg_6_0.activityID_
		})
	end)
end

function var_0_0.Show(arg_9_0, arg_9_1)
	var_0_0.super.Show(arg_9_0, arg_9_1)

	if arg_9_1 then
		arg_9_0:RefreshTask()
	end
end

function var_0_0.UpdateBar(arg_10_0)
	local var_10_0 = PaChinKoTools.GetCurrencyID(arg_10_0.activityID_)

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		var_10_0
	})
	manager.windowBar:SetBarCanClick(var_10_0, true)
end

function var_0_0.IndexItem(arg_11_0, arg_11_1, arg_11_2)
	arg_11_2:Refresh(arg_11_0.list_[arg_11_1], arg_11_0.activityID_)
end

function var_0_0.RefreshTask(arg_12_0)
	local var_12_0 = PaChinKoTools.GetTaskActivityID(arg_12_0.activityID_)

	arg_12_0.list_ = {}

	local var_12_1 = TaskTools:GetActivityTaskList(var_12_0) or {}

	local function var_12_2(arg_13_0, arg_13_1)
		local var_13_0 = AssignmentCfg[arg_13_0]
		local var_13_1 = AssignmentCfg[arg_13_1]

		if var_13_0.type ~= var_13_1.type then
			return var_13_0.type < var_13_1.type
		end

		return arg_13_0 < arg_13_1
	end

	local var_12_3 = {}
	local var_12_4 = {}
	local var_12_5 = {}

	for iter_12_0, iter_12_1 in pairs(var_12_1) do
		local var_12_6 = iter_12_1.id
		local var_12_7 = AssignmentCfg[var_12_6]

		if var_12_7.activity_id == var_12_0 then
			if iter_12_1.complete_flag >= 1 then
				table.insert(var_12_5, var_12_6)
			elseif iter_12_1.progress >= var_12_7.need then
				table.insert(var_12_3, var_12_6)
			else
				table.insert(var_12_4, var_12_6)
			end
		end
	end

	table.sort(var_12_3, var_12_2)
	table.sort(var_12_4, var_12_2)
	table.sort(var_12_5, var_12_2)
	table.insertto(arg_12_0.list_, var_12_3)
	table.insertto(arg_12_0.list_, var_12_4)
	table.insertto(arg_12_0.list_, var_12_5)

	if #var_12_3 > 0 then
		arg_12_0.clearCon_:SetSelectedState("true")
	else
		arg_12_0.clearCon_:SetSelectedState("false")
	end

	arg_12_0.scrollHelper_:StartScroll(#arg_12_0.list_)
end

return var_0_0
