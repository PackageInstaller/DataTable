local var_0_0 = import("game.views.task.activityTaskCommon.ActivityTaskCommonModule")
local var_0_1 = class("SummerRaceResidentRewardView", var_0_0)

local function var_0_2()
	return string.format("%s_%s", RedPointConst.SUMMER_RACE_NORMAL_TASK, SummerRaceConst.ACTIVITY_ID.MAIN)
end

local function var_0_3(arg_2_0)
	arg_2_0.windowBarBackHandler_ = arg_2_0.windowBarBackHandler_ or function()
		JumpTools.Back()
	end

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(arg_2_0.windowBarBackHandler_)
end

local function var_0_4(arg_4_0)
	if arg_4_0.windowBarBackHandler_ ~= nil and manager.windowBar:GetLastBackFunc() == arg_4_0.windowBarBackHandler_ then
		manager.windowBar:HideBar()
	end
end

local function var_0_5(arg_5_0)
	local var_5_0 = LimitTimeTaskCfg and LimitTimeTaskCfg[arg_5_0] or nil

	if var_5_0 ~= nil and var_5_0.name ~= nil then
		return GetI18NText(var_5_0.name)
	end

	local var_5_1 = ActivityCfg and ActivityCfg[arg_5_0] or nil

	if var_5_1 ~= nil and var_5_1.name ~= nil then
		return GetI18NText(var_5_1.name)
	end

	return ""
end

local function var_0_6(arg_6_0)
	local var_6_0 = AssignmentCfg and AssignmentCfg.get_id_list_by_activity_id and AssignmentCfg.get_id_list_by_activity_id[arg_6_0] or {}
	local var_6_1 = 0

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		local var_6_2 = AssignmentCfg[iter_6_1]

		if TaskData2:GetTaskComplete(iter_6_1) then
			var_6_1 = var_6_1 + 1
		elseif var_6_2 ~= nil and var_6_2.need <= TaskData2:GetTaskProgress(iter_6_1) then
			var_6_1 = var_6_1 + 1
		end
	end

	return var_6_1, #var_6_0
end

function var_0_1.UIName(arg_7_0)
	return "Widget/System/Activity_SummerRace/com/Activity_SummerRace_Renwu"
end

function var_0_1.SetActivityID(arg_8_0)
	arg_8_0.activityPointRewardActivityID_ = ActivityConst.ACTIVITY_SUMMER_RACE_MAIN
end

function var_0_1.BindRedPoint(arg_9_0)
	manager.redPoint:bindUIandKey(arg_9_0.receiveBtn_.transform, var_0_2())
end

function var_0_1.UnbindRedPoint(arg_10_0)
	manager.redPoint:unbindUIandKey(arg_10_0.receiveBtn_.transform, var_0_2())
end

function var_0_1.OnEnter(arg_11_0)
	arg_11_0:SetActivityID()
	var_0_1.super.OnEnter(arg_11_0)
	arg_11_0:UpdateBar()
end

function var_0_1.OnTop(arg_12_0)
	arg_12_0:UpdateBar()
end

function var_0_1.UpdateBar(arg_13_0)
	var_0_3(arg_13_0)
end

function var_0_1.SetLevelText(arg_14_0)
	arg_14_0.curLv_, arg_14_0.maxLv_ = var_0_6(arg_14_0.activityPointRewardActivityID_)

	if arg_14_0.levelText_ ~= nil then
		arg_14_0.levelText_.text = "<size=90><color=\"#F4D179\">" .. tostring(arg_14_0.curLv_) .. "</color></size><color=\"#93847D\">/" .. tostring(arg_14_0.maxLv_) .. "</color>"
	end
end

function var_0_1.UpdateView(arg_15_0)
	arg_15_0:SetActivityID()

	arg_15_0.idList_ = arg_15_0:GetLevelIDList()

	arg_15_0:SetLevelText()

	arg_15_0.receiveList_ = {}
	arg_15_0.showIdList_ = {}

	local var_15_0 = 1
	local var_15_1 = true

	for iter_15_0, iter_15_1 in ipairs(arg_15_0.idList_ or {}) do
		local var_15_2 = AssignmentCfg[iter_15_1]
		local var_15_3 = TaskData2:GetTaskProgress(iter_15_1)
		local var_15_4 = TaskData2:GetTaskComplete(iter_15_1)
		local var_15_5 = "lock"

		if var_15_2 ~= nil and var_15_3 >= var_15_2.need then
			if not var_15_4 then
				table.insert(arg_15_0.receiveList_, iter_15_1)

				var_15_5 = "receive"
				var_15_1 = false
			else
				var_15_5 = "complete"

				if var_15_1 then
					var_15_0 = iter_15_0 + 1
				end
			end
		end

		table.insert(arg_15_0.showIdList_, {
			id = iter_15_1,
			ind = iter_15_0,
			state = var_15_5
		})
	end

	if var_15_0 > #arg_15_0.showIdList_ then
		var_15_0 = 1
	end

	arg_15_0.levelLuaList_:StartScroll(#arg_15_0.showIdList_, var_15_0)
	arg_15_0.onekeyController_:SetSelectedState(#arg_15_0.receiveList_ > 0 and "true" or "false")
end

function var_0_1.OnExit(arg_16_0)
	var_0_1.super.OnExit(arg_16_0)
	var_0_4(arg_16_0)
end

function var_0_1.Dispose(arg_17_0)
	var_0_4(arg_17_0)

	arg_17_0.windowBarBackHandler_ = nil

	var_0_1.super.Dispose(arg_17_0)
end

return var_0_1
