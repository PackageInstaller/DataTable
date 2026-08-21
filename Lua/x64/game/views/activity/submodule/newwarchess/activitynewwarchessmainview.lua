ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local var_0_0 = class("ActivityNewWarChessMainView", ActivityMainBasePanel)
local var_0_1 = "ACTIVITY_NEW_WARCHESS_DESCRIBE"

function var_0_0.GetUIName(arg_1_0)
	if arg_1_0.activityID_ == ActivityConst.ACTIVITY_NEWWARCHESS_2_6 then
		return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionNewWarChessUI"
	elseif arg_1_0.activityID_ == ActivityConst.ACTIVITY_2_10_NEWWARCHESS then
		return "UI/VersionUI/JapanRegionUI_2_10/JapanRegionUI_2_10NewWarChessUI"
	end
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.taskListModule = CommonActivityTaskListModule.New(arg_3_0.taskPanelTrans_.gameObject)
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.descBtn_, nil, function()
		local var_5_0 = NewChessTools.GetNewWarChessGameSetting("new_warchess_describe", NewWarChessData:GetCurrentMainActivity())

		JumpTools.OpenPageByJump("gameHelpPro", {
			isPrefab = true,
			pages = var_5_0
		})
	end)
	arg_4_0:AddBtnListener(arg_4_0.rewardBtn_, nil, function()
		local var_6_0 = ActivityCfg[arg_4_0.activityID_].sub_activity_list

		JumpTools.OpenPageByJump("activityNewWarChessRewardView", {
			mainActivityID = arg_4_0.activityID_,
			activityIDList = var_6_0
		})
	end)
	arg_4_0:AddBtnListener(arg_4_0.levelBtn_, nil, function()
		local var_7_0 = RedPointConst.NEW_WARCHESS_NEWMAP .. "_" .. arg_4_0.activityID_

		manager.redPoint:setTip(var_7_0, 0)
		JumpTools.OpenPageByJump("/newWarChessLevelView", {
			ActivityID = arg_4_0.activityID_
		})
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.taskListModule:OnEnter()
	arg_8_0:RefreshUI()
	arg_8_0:BindRedPoint()
end

function var_0_0.BindRedPoint(arg_9_0)
	local var_9_0 = RedPointConst.NEW_WARCHESS_NEWMAP .. "_" .. arg_9_0.activityID_

	manager.redPoint:bindUIandKey(arg_9_0.levelBtn_.transform, var_9_0)

	local var_9_1 = RedPointConst.NEW_WARCHESS_EXPROLE_REWARD .. "_" .. arg_9_0.activityID_

	manager.redPoint:bindUIandKey(arg_9_0.rewardBtn_.transform, var_9_1)
end

function var_0_0.UnBindRedPoint(arg_10_0)
	local var_10_0 = RedPointConst.NEW_WARCHESS_NEWMAP .. "_" .. arg_10_0.activityID_

	manager.redPoint:unbindUIandKey(arg_10_0.levelBtn_.transform, var_10_0)

	local var_10_1 = RedPointConst.NEW_WARCHESS_EXPROLE_REWARD .. "_" .. arg_10_0.activityID_

	manager.redPoint:unbindUIandKey(arg_10_0.rewardBtn_.transform, var_10_1)
end

function var_0_0.RefreshUI(arg_11_0)
	arg_11_0:RefreshTime()
	arg_11_0:RefreshTask()
end

function var_0_0.StopTimer(arg_12_0)
	if arg_12_0.timer_ then
		arg_12_0.timer_:Stop()

		arg_12_0.timer_ = nil
	end
end

function var_0_0.RefreshTime(arg_13_0)
	arg_13_0.activityID_ = arg_13_0.activityID_
	arg_13_0.stopTime_ = ActivityData:GetActivityData(arg_13_0.activityID_).stopTime

	if manager.time:GetServerTime() < arg_13_0.stopTime_ then
		arg_13_0.timeText_.text = manager.time:GetLostTimeStrWith2Unit(arg_13_0.stopTime_)
	else
		arg_13_0:StopTimer()

		arg_13_0.timeText_.text = GetTips("TIME_OVER")
	end

	arg_13_0.timer_ = Timer.New(function()
		if manager.time:GetServerTime() < arg_13_0.stopTime_ then
			arg_13_0.timeText_.text = manager.time:GetLostTimeStrWith2Unit(arg_13_0.stopTime_)
		else
			arg_13_0:StopTimer()

			arg_13_0.timeText_.text = GetTips("TIME_OVER")
		end
	end, 1, -1)

	arg_13_0.timer_:Start()
end

function var_0_0.RefreshTask(arg_15_0)
	arg_15_0.taskListModule:RenderView(arg_15_0.activityID_)
end

function var_0_0.Show(arg_16_0, arg_16_1)
	var_0_0.super.Show(arg_16_0, arg_16_1)

	if arg_16_1 then
		arg_16_0:RefreshTask()
	end
end

function var_0_0.UpdateBar(arg_17_0)
	local var_17_0 = {}

	for iter_17_0, iter_17_1 in pairs(ItemCfg.get_id_list_by_sub_type[ItemConst.ITEM_SUB_TYPE.NEWWARCHESS_MOVEPOINT_PACKAGE]) do
		if ItemCfg[iter_17_1].time[2][1] == arg_17_0.activityID_ then
			table.insert(var_17_0, iter_17_1)
		end
	end

	local var_17_1 = {
		BACK_BAR,
		HOME_BAR
	}

	for iter_17_2, iter_17_3 in pairs(var_17_0) do
		table.insert(var_17_1, iter_17_3)
	end

	manager.windowBar:SwitchBar(var_17_1)

	for iter_17_4, iter_17_5 in pairs(var_17_0) do
		manager.windowBar:SetBarCanAdd(iter_17_5, true)
	end
end

function var_0_0.OnExit(arg_18_0)
	arg_18_0.taskListModule:OnExit()
	manager.windowBar:HideBar()
	arg_18_0:StopTimer()
	arg_18_0:UnBindRedPoint()
end

function var_0_0.Dispose(arg_19_0)
	arg_19_0.taskListModule:Dispose()
	arg_19_0:StopTimer()
	arg_19_0:RemoveAllListeners()

	if arg_19_0.list_ then
		arg_19_0.list_:Dispose()

		arg_19_0.list_ = nil
	end

	arg_19_0.super.Dispose(arg_19_0)
end

return var_0_0
