local var_0_0 = class("BattleFirstPassView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return ActivityTools.GetUIName(arg_1_0.params_.activityID)
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.scrollHelper_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.listGo_, BattleFirstPassItem)
end

function var_0_0.IndexItem(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0.battleList_[arg_5_1]

	arg_5_2:RefreshUI(arg_5_0.activityID_, var_5_0)
	arg_5_2:SetSelected(arg_5_0:IsSelect(var_5_0))
	arg_5_2:RegisterClickListener(function(arg_6_0)
		BattleFirstPassData:SetLastBattleID(arg_5_0.activityID_, arg_6_0)
		arg_5_0:SetCurBattleID(arg_6_0)
	end)
end

function var_0_0.AddUIListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.goBtn_, nil, function()
		if arg_7_0.stopTime_ <= manager.time:GetServerTime() then
			ShowTips("ERROR_ACTIVITY_NOT_OPEN")

			return
		end

		local var_8_0 = ActivityFirstClearCfg[arg_7_0.curBattleID_].stage_id
		local var_8_1 = ActivityTools.GetSectionType(arg_7_0.activityID_)

		arg_7_0:Go("/sectionSelectHero", {
			section = var_8_0,
			sectionType = var_8_1,
			activityID = arg_7_0.curBattleID_
		})
	end)
	arg_7_0:AddBtnListener(arg_7_0.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("firstPassRewardPop", {
			activityID = arg_7_0.activityID_
		})
	end)
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0:GetActivityData()
	arg_10_0:BindRedPointUI()
	arg_10_0:RefreshUI()
	arg_10_0:SetCurBattleID(BattleFirstPassData:GetLastBattleID(arg_10_0.activityID_) or arg_10_0.battleList_[1])
	arg_10_0.scrollHelper_:StartScroll(#arg_10_0.battleList_)
end

function var_0_0.GetActivityData(arg_11_0)
	arg_11_0.activityID_ = arg_11_0.params_.activityID
	arg_11_0.activityData_ = ActivityData:GetActivityData(arg_11_0.activityID_)
	arg_11_0.startTime_ = arg_11_0.activityData_.startTime
	arg_11_0.stopTime_ = arg_11_0.activityData_.stopTime
end

function var_0_0.BindRedPointUI(arg_12_0)
	manager.redPoint:bindUIandKey(arg_12_0.rewardBtn_.transform, RedPointConst.BATTLE_FIRST_PASS_REWARD .. arg_12_0.activityID_)
end

function var_0_0.RefreshUI(arg_13_0)
	arg_13_0:RefreshTime()
	arg_13_0:RefreshList()
end

function var_0_0.RefreshTime(arg_14_0)
	local var_14_0
	local var_14_1 = manager.time:GetServerTime()

	arg_14_0:StopActivityTimer()

	if var_14_1 < arg_14_0.startTime_ then
		arg_14_0.activityTimeCnt_.text = GetTips("ERROR_NOT_TIME")
		arg_14_0.activityTimer_ = Timer.New(function()
			var_14_0 = arg_14_0.startTime_ - manager.time:GetServerTime()

			if var_14_0 <= 0 then
				arg_14_0:StopActivityTimer()
				arg_14_0:RefreshTime()
				arg_14_0.scrollHelper_:StartScrollByPosition(#arg_14_0.battleList_, arg_14_0.scrollHelper_:GetScrolledPosition())

				return
			end
		end, 1, -1)

		arg_14_0.activityTimer_:Start()
	elseif var_14_1 < arg_14_0.stopTime_ then
		arg_14_0.activityTimeCnt_.text = manager.time:GetLostTimeStr(arg_14_0.stopTime_)
		arg_14_0.activityTimer_ = Timer.New(function()
			var_14_0 = arg_14_0.stopTime_ - manager.time:GetServerTime()

			if var_14_0 <= 0 then
				arg_14_0:StopActivityTimer()
				arg_14_0:RefreshTime()
				arg_14_0.scrollHelper_:StartScrollByPosition(#arg_14_0.battleList_, arg_14_0.scrollHelper_:GetScrolledPosition())

				return
			end

			arg_14_0.activityTimeCnt_.text = manager.time:GetLostTimeStr(arg_14_0.stopTime_)
		end, 1, -1)

		arg_14_0.activityTimer_:Start()
	else
		arg_14_0.activityTimeCnt_.text = GetTips("TIME_OVER")
	end
end

function var_0_0.RefreshList(arg_17_0)
	arg_17_0.battleList_ = BattleFirstPassData:GetBattleList(arg_17_0.activityID_)
end

function var_0_0.SetCurBattleID(arg_18_0, arg_18_1)
	local var_18_0

	arg_18_0.curBattleID_ = arg_18_1
	arg_18_0.title_.text = GetI18NText(ActivityFirstClearCfg[arg_18_1].name)

	for iter_18_0, iter_18_1 in pairs(arg_18_0.scrollHelper_:GetItemList()) do
		local var_18_1 = iter_18_1:GetID()

		iter_18_1:SetSelected(arg_18_0:IsSelect(var_18_1))
	end
end

function var_0_0.IsSelect(arg_19_0, arg_19_1)
	return arg_19_0.curBattleID_ == arg_19_1
end

function var_0_0.StopActivityTimer(arg_20_0)
	if arg_20_0.activityTimer_ then
		arg_20_0.activityTimer_:Stop()

		arg_20_0.activityTimer_ = nil
	end
end

function var_0_0.UnBindRedPointUI(arg_21_0)
	manager.redPoint:unbindUIandKey(arg_21_0.rewardBtn_.transform, RedPointConst.BATTLE_FIRST_PASS_REWARD .. arg_21_0.activityID_)
end

function var_0_0.OnTop(arg_22_0)
	local var_22_0 = ActivityTools.GetGameHelpKey(arg_22_0.activityID_)

	if var_22_0 ~= "" then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			INFO_BAR
		})
		manager.windowBar:SetGameHelpKey(var_22_0)
	else
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR
		})
	end
end

function var_0_0.OnExit(arg_23_0)
	arg_23_0:StopActivityTimer()
	arg_23_0:UnBindRedPointUI()

	for iter_23_0, iter_23_1 in pairs(arg_23_0.scrollHelper_:GetItemList()) do
		iter_23_1:OnExit()
	end

	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_24_0)
	arg_24_0:RemoveAllListeners()
	arg_24_0.scrollHelper_:Dispose()
	var_0_0.super.Dispose(arg_24_0)
end

return var_0_0
