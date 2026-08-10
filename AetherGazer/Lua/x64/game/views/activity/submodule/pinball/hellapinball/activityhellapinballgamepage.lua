ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local var_0_0 = class("ActivityHellaPinballGamePage", ActivityMainBasePanel)

function var_0_0.GetUIName(arg_1_0)
	return "Widget/System/Activity_Hel/Activity_Hel_Main/Activity_Hel_MainUI"
end

function var_0_0.Init(arg_2_0)
	arg_2_0.super.Init(arg_2_0)

	arg_2_0.preRewardList_ = LuaList.New(handler(arg_2_0, arg_2_0.IndexPreviewItem), arg_2_0.preRewardListGo_, CommonItemView)
end

function var_0_0.OnEnter(arg_3_0)
	var_0_0.super.OnEnter(arg_3_0)

	arg_3_0.rewardActivityID_ = PinballData:GetRewardActivityID()

	arg_3_0:OnUpdateView()

	local var_3_0 = PinballData:GetActivityID()
	local var_3_1 = ActivityCfg[var_3_0].sub_activity_list[2]

	arg_3_0.limitTaskGroup = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, var_3_1)

	manager.redPoint:bindUIandKey(arg_3_0.goBtn_.transform, string.format("%s%s", ActivityTools.GetRedPointKey(arg_3_0.activityID_), arg_3_0.activityID_))
	manager.redPoint:bindUIandKey(arg_3_0.limitRewardBtn_.transform, arg_3_0.limitTaskGroup)
end

function var_0_0.OnExit(arg_4_0)
	var_0_0.super.OnExit(arg_4_0)
	manager.redPoint:unbindUIandKey(arg_4_0.goBtn_.transform, string.format("%s%s", ActivityTools.GetRedPointKey(arg_4_0.activityID_), arg_4_0.activityID_))
	manager.redPoint:unbindUIandKey(arg_4_0.limitRewardBtn_.transform, arg_4_0.limitTaskGroup)
end

function var_0_0.OnTop(arg_5_0)
	return
end

function var_0_0.OnUpdateView(arg_6_0)
	local var_6_0 = ActivityCfg[arg_6_0.activityID_]

	if var_6_0 and var_6_0.reward_show and var_6_0.reward_show ~= "" then
		local var_6_1 = {}

		for iter_6_0, iter_6_1 in ipairs(var_6_0.reward_show) do
			table.insert(var_6_1, rewardToItemTemplate({
				id = iter_6_1
			}, nil, true))
		end

		arg_6_0.preRewards_ = ItemTools.SortRewardItemList(var_6_1)

		arg_6_0.preRewardList_:StartScroll(#arg_6_0.preRewards_)
	end
end

function var_0_0.Show(arg_7_0, arg_7_1)
	SetActive(arg_7_0.gameObject_, arg_7_1)

	if arg_7_1 then
		arg_7_0:UpdatePreview()
	end

	arg_7_0:RefreshTimeText()
end

function var_0_0.IndexPreviewItem(arg_8_0, arg_8_1, arg_8_2)
	arg_8_2:SetData(arg_8_0.preRewards_[arg_8_1])
end

function var_0_0.AddTimer(arg_9_0)
	arg_9_0:StopTimer()
	arg_9_0:RefreshTimeText()

	arg_9_0.timer_ = Timer.New(function()
		if manager.time:GetServerTime() > arg_9_0.stopTime_ then
			return
		end

		arg_9_0:RefreshTimeText()
	end, 1, -1)

	arg_9_0.timer_:Start()
end

function var_0_0.RefreshTimeText(arg_11_0)
	local var_11_0 = ActivityData:GetActivityData(arg_11_0.rewardActivityID_)

	arg_11_0.rewardStartTime_ = var_11_0.startTime
	arg_11_0.rewardStopTime_ = var_11_0.stopTime
	arg_11_0.limitTimeTxt_.text = manager.time.WrapTimeStrWithTips(manager.time:GetLostTimeStr2(arg_11_0.rewardStopTime_))
end

function var_0_0.AddListeners(arg_12_0)
	arg_12_0:AddBtnListener(arg_12_0.goBtn_, nil, function()
		manager.story:CheckBattleStory(5300101, manager.story.BEFORE, function()
			PinballAction.EnterPinballGameScene()
			manager.story:RemovePlayer()
			saveData("PinballGame", "firstEnter", true)
			PinballAction.UpdateStageRedPoint()
		end)
	end)
	arg_12_0:AddBtnListener(arg_12_0.infoBtn_, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "GOD_EATER_GAME_TIPS_1",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("PINBALLGAME_GAME_ENTRANCE_TITLE")
		})
	end)
	arg_12_0:AddBtnListener(arg_12_0.limitRewardBtn_, nil, function()
		JumpTools.OpenPageByJump("/hellaPinballLimitTask", {
			activityID = arg_12_0.rewardActivityID_
		})
	end)
end

function var_0_0.Dispose(arg_17_0)
	if arg_17_0.preRewardList_ then
		arg_17_0.preRewardList_:Dispose()

		arg_17_0.preRewardList_ = nil
	end

	var_0_0.super.Dispose(arg_17_0)
end

return var_0_0
