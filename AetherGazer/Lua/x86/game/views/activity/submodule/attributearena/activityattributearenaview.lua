local var_0_0 = class("ActivityAttributeArenaView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return AttributeArenaTools.GetMainUIName(arg_1_0.params_.activityID)
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.list = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.m_list, ActivityAttributeArenaItem)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(nil, arg_5_0.m_rewardBtn, function()
		JumpTools.OpenPageByJump("activityAttributeArenaReward", {
			task_activity_id = arg_5_0.task_activity_id
		})
	end)
	arg_5_0:AddBtnListener(nil, arg_5_0.m_desBtn, function()
		local var_7_0 = "ACTIVITY_ATTRIBUTE_GAME_TIP"

		JumpTools.OpenPageByJump("gameHelp", {
			content = GetTips(var_7_0),
			key = var_7_0
		})
	end)
	arg_5_0:AddBtnListener(nil, arg_5_0.m_roundBtn, function()
		JumpTools.OpenPageByJump("activityAttributeArenaRound", {
			activityID = arg_5_0.activity_id
		})
	end)
end

function var_0_0.OnTop(arg_9_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0.activity_id = arg_10_0.params_.activityID

	ActivityAttributeArenaAction.SetRead(arg_10_0.activity_id)

	arg_10_0.task_activity_id = AttributeArenaTools.GetTaskActivityID(arg_10_0.activity_id)
	arg_10_0.rank_activity_id = AttributeArenaTools.GetRankActivityID(arg_10_0.activity_id)

	arg_10_0:RefreshUI()
	arg_10_0:RefreshTime()

	arg_10_0.timer = Timer.New(function()
		arg_10_0:RefreshTime()
	end, 1, -1)

	arg_10_0.timer:Start()
	arg_10_0:QueryRankData(1)

	local var_10_0 = string.format("%s_%s", RedPointConst.ACTIVITY_ATTRIBUTE_ARENA_TASK, arg_10_0.activity_id)

	manager.redPoint:bindUIandKey(arg_10_0.m_rewardBtn.transform, var_10_0)
end

function var_0_0.QueryRankData(arg_12_0, arg_12_1)
	if arg_12_0.rank_activity_id == 0 then
		return
	end

	if arg_12_1 > 3 then
		return
	end

	RankAction.QueryActivityRank(arg_12_0.rank_activity_id, arg_12_1, function()
		arg_12_0:QueryRankData(arg_12_1 + 1)
	end, 1)
end

function var_0_0.RefreshUI(arg_14_0)
	arg_14_0.arena_list_data = ActivityAttributeArenaData:GetArenaList(arg_14_0.activity_id)

	arg_14_0.list:StartScroll(#arg_14_0.arena_list_data)
end

function var_0_0.RefreshTime(arg_15_0)
	local var_15_0 = ActivityData:GetActivityData(arg_15_0.activity_id)

	arg_15_0.m_timeLab.text = manager.time:GetLostTimeStrWith2UnitWithPrefix(var_15_0.stopTime, nil, true)

	local var_15_1 = ActivityData:GetActivityRefreshTime(arg_15_0.activity_id)

	arg_15_0.m_refreshTimeLab.text = manager.time:GetLostTimeStr2(var_15_1, nil, true)
end

function var_0_0.OnExit(arg_16_0)
	manager.windowBar:HideBar()

	if arg_16_0.timer then
		arg_16_0.timer:Stop()
	end

	arg_16_0.timer = nil

	local var_16_0 = string.format("%s_%s", RedPointConst.ACTIVITY_ATTRIBUTE_ARENA_TASK, arg_16_0.activity_id)

	manager.redPoint:unbindUIandKey(arg_16_0.m_rewardBtn.transform, var_16_0)
end

function var_0_0.Dispose(arg_17_0)
	arg_17_0.list:Dispose()
	var_0_0.super.Dispose(arg_17_0)
end

function var_0_0.IndexItem(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_0.arena_list_data[arg_18_1]

	arg_18_2:SetData(var_18_0, arg_18_0.activity_id, arg_18_0.rank_activity_id)
end

function var_0_0.OnActivityAttributeArenaUpdate(arg_19_0)
	arg_19_0:RefreshUI()
	arg_19_0:QueryRankData(1)
end

function var_0_0.OnActivityAttributeArenaReset(arg_20_0)
	arg_20_0:RefreshUI()
end

function var_0_0.OnRankUpdate(arg_21_0)
	arg_21_0.list:Refresh()
end

return var_0_0
