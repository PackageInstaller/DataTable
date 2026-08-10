local var_0_0 = class("ActivityHeroLetterMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return ActivityHeroLetterTools.GetMainUIName(arg_1_0.params_.activityID)
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

	arg_4_0.rewardCon_ = arg_4_0.conCollecter_:GetController("reward")
	arg_4_0.scrollHelper_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.listGo_, ActivityHeroLetterItem)
end

function var_0_0.IndexItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:Refresh(arg_5_0.list_[arg_5_1])
	arg_5_0:RefreshRewardType()
	arg_5_0:RefreshItemTime()
end

function var_0_0.AddUIListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.playBackBtn_, nil, function()
		arg_6_0:GotoView()
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.activityID_ = arg_8_0.params_.activityID

	arg_8_0:BindRedPointUI()
	arg_8_0:CheckEnter()
	arg_8_0:RefreshUI()
end

function var_0_0.CheckEnter(arg_9_0)
	if ActivityHeroLetterData:GetActivityUrl() == ActivityConst.ACTIVITY_2_10_HERO_LETTER_H5_WEB then
		local var_9_0 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_2_10_HERO_LETTER_H5_WEB)
		local var_9_1 = var_9_0.startTime
		local var_9_2 = var_9_0.stopTime
		local var_9_3 = ActivityHeroLetterData:GetSign(ActivityConst.ACTIVITY_2_10_HERO_LETTER_H5_WEB)

		SetActive(arg_9_0.playBackBtn_.gameObject, var_9_2 > manager.time:GetServerTime())

		if var_9_2 > manager.time:GetServerTime() and var_9_3 == 0 then
			arg_9_0:GotoView()
			ActivityHeroLetterAction.SetSign(ActivityConst.ACTIVITY_2_10_HERO_LETTER_H5_WEB)
		end
	else
		local var_9_4 = getData("activityHeroLetter", "enter_" .. arg_9_0.activityID_)

		if not var_9_4 or var_9_4 == 0 then
			arg_9_0:GotoView()
			saveData("activityHeroLetter", "enter_" .. arg_9_0.activityID_, 1)
		end
	end
end

function var_0_0.RefreshUI(arg_10_0)
	arg_10_0:RefreshData()
	arg_10_0:RefreshTime()
	arg_10_0:RefreshList()
end

function var_0_0.RefreshData(arg_11_0)
	arg_11_0.activityData_ = ActivityData:GetActivityData(arg_11_0.activityID_)
	arg_11_0.startTime_ = arg_11_0.activityData_.startTime
	arg_11_0.stopTime_ = arg_11_0.activityData_.stopTime
end

function var_0_0.RefreshTime(arg_12_0)
	arg_12_0:StopTimer()

	arg_12_0.timeLable_.text = manager.time:GetLostTimeStr2(arg_12_0.stopTime_)
	arg_12_0.timer_ = Timer.New(function()
		arg_12_0.timeLable_.text = manager.time:GetLostTimeStr2(arg_12_0.stopTime_)
	end, 1, -1)

	arg_12_0.timer_:Start()
end

function var_0_0.StopTimer(arg_14_0)
	if arg_14_0.timer_ then
		arg_14_0.timer_:Stop()

		arg_14_0.timer_ = nil
	end
end

function var_0_0.RefreshList(arg_15_0)
	arg_15_0.list_ = ActivityHeroTaskCfg.get_id_list_by_main_activity_id[arg_15_0.activityID_]

	if arg_15_0.params_.isEnter then
		arg_15_0.scrollHelper_:StartScroll(#arg_15_0.list_)

		arg_15_0.params_.isEnter = false
	else
		arg_15_0.scrollHelper_:Refresh()
	end

	arg_15_0:StopItemTimer()
	arg_15_0:RefreshItemTime()

	arg_15_0.itemTimer_ = Timer.New(function()
		arg_15_0:RefreshItemTime()
	end, 1, -1)

	arg_15_0.itemTimer_:Start()
end

function var_0_0.StopItemTimer(arg_17_0)
	if arg_17_0.itemTimer_ then
		arg_17_0.itemTimer_:Stop()

		arg_17_0.itemTimer_ = nil
	end
end

function var_0_0.RefreshItemTime(arg_18_0)
	local var_18_0 = manager.time:GetServerTime()

	for iter_18_0, iter_18_1 in pairs(arg_18_0.scrollHelper_:GetItemList()) do
		iter_18_1:RefreshTime(var_18_0)
	end
end

function var_0_0.GotoView(arg_19_0)
	JumpTools.OpenPageByJump("activityHeroLetterPlayBack", {
		activityID = arg_19_0.activityID_
	})
end

function var_0_0.RefreshRewardType(arg_20_0)
	local var_20_0 = arg_20_0.scrollHelper_:GetItemList() or {}
	local var_20_1 = var_20_0[#var_20_0]

	if not var_20_1 then
		return
	end

	local var_20_2 = var_20_1.id_

	for iter_20_0 = table.indexof(arg_20_0.list_, var_20_2) + 1, #arg_20_0.list_ do
		local var_20_3 = ActivityHeroTaskCfg[arg_20_0.list_[iter_20_0]].task_id
		local var_20_4 = AssignmentCfg[var_20_3].need
		local var_20_5 = TaskData2:GetTask(var_20_3)
		local var_20_6 = var_20_5 and var_20_5.complete_flag == 0 and var_20_4 <= var_20_5.progress

		if ActivityData:GetActivityData(ActivityHeroTaskCfg[arg_20_0.list_[iter_20_0]].activity_id):IsActivitying() and var_20_6 then
			arg_20_0.rewardCon_:SetSelectedState("on")

			return
		end
	end

	arg_20_0.rewardCon_:SetSelectedState("off")
end

function var_0_0.BindRedPointUI(arg_21_0)
	manager.redPoint:bindUIandKey(arg_21_0.playBackBtn_.transform, RedPointConst.ACTIVITY_HERO_LETTER_REPORT .. "_" .. arg_21_0.activityID_)
end

function var_0_0.UnbindRedPointUI(arg_22_0)
	manager.redPoint:unbindUIandKey(arg_22_0.playBackBtn_.transform, RedPointConst.ACTIVITY_HERO_LETTER_REPORT .. "_" .. arg_22_0.activityID_)
end

function var_0_0.OnTop(arg_23_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnExit(arg_24_0)
	manager.windowBar:HideBar()
	arg_24_0:StopTimer()
	arg_24_0:StopItemTimer()
	arg_24_0:UnbindRedPointUI()
	arg_24_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_25_0)
	arg_25_0:RemoveAllListeners()

	for iter_25_0, iter_25_1 in ipairs(arg_25_0.scrollHelper_:GetItemList()) do
		iter_25_1:Dispose()
	end

	arg_25_0.scrollHelper_:Dispose()
	arg_25_0.super.Dispose(arg_25_0)
end

return var_0_0
