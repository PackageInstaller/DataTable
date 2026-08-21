local var_0_0 = class("ValentineGameTestView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return ValentineGameTools.GetTestUIName(arg_1_0.params_.activityID)
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

	arg_4_0.levelData_ = {}
	arg_4_0.rewardItems_ = {}
	arg_4_0.levelBtn_ = {}
	arg_4_0.levelText_ = {}
	arg_4_0.levelStateCon_ = {}
	arg_4_0.levelCompleteCon_ = {}

	for iter_4_0 = 1, #ActivityCfg[arg_4_0.params_.activityID].sub_activity_list do
		arg_4_0.levelBtn_[iter_4_0] = arg_4_0["level_" .. iter_4_0]
		arg_4_0.levelText_[iter_4_0] = arg_4_0["levelText_" .. iter_4_0]
		arg_4_0.levelStateCon_[iter_4_0] = ControllerUtil.GetController(arg_4_0.levelBtn_[iter_4_0].transform, "state")
		arg_4_0.levelCompleteCon_[iter_4_0] = ControllerUtil.GetController(arg_4_0.levelBtn_[iter_4_0].transform, "complet")
	end

	arg_4_0.rewardItems_ = {
		ValentineGameSPRewardItem.New(arg_4_0.rewardGo_1),
		ValentineGameSPRewardItem.New(arg_4_0.rewardGo_2),
		(ValentineGameSPRewardItem.New(arg_4_0.rewardGo_3))
	}
	arg_4_0.stateCon_ = ControllerUtil.GetController(arg_4_0.gameObject_.transform, "state")
	arg_4_0.indexCon_ = ControllerUtil.GetController(arg_4_0.gameObject_.transform, "index")
end

function var_0_0.AddUIListeners(arg_5_0)
	for iter_5_0 = 1, #ActivityCfg[arg_5_0.params_.activityID].sub_activity_list do
		arg_5_0:AddBtnListener(arg_5_0.levelBtn_[iter_5_0], nil, function()
			if manager.time:GetServerTime() < arg_5_0.levelData_[iter_5_0].startTime then
				ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(arg_5_0.levelData_[iter_5_0].startTime)))
			else
				ValentineGameData:SetLastLevel(arg_5_0.activityID_, arg_5_0.list_[iter_5_0])

				arg_5_0.curIndex_ = iter_5_0

				arg_5_0:RefreshLevelTime()
				arg_5_0:RefreshReward()
			end
		end)
	end

	arg_5_0:AddBtnListener(arg_5_0.goBtn_, nil, function()
		local var_7_0 = manager.time:GetServerTime()
		local var_7_1 = arg_5_0.list_[arg_5_0.curIndex_]

		if var_7_0 >= arg_5_0.levelData_[arg_5_0.curIndex_].startTime and var_7_0 < arg_5_0.levelData_[arg_5_0.curIndex_].stopTime then
			JumpTools.OpenPageByJump("/valentineGameLoading", {
				mainActivityID = arg_5_0.activityID_,
				activityID = var_7_1
			})
		else
			ShowTips("TIME_OVER")
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.rewardBtn_, nil, function()
		local var_8_0 = manager.time:GetServerTime()
		local var_8_1 = arg_5_0.list_[arg_5_0.curIndex_]

		if var_8_0 >= arg_5_0.levelData_[arg_5_0.curIndex_].startTime and var_8_0 < arg_5_0.levelData_[arg_5_0.curIndex_].stopTime then
			ValentineGameAction:GetReward(var_8_1)
		else
			ShowTips("TIME_OVER")
		end
	end)
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0:RefreshData()
	arg_9_0:RefreshUI()
	arg_9_0:BindUIRedPoint()
end

function var_0_0.RefreshData(arg_10_0)
	arg_10_0.activityID_ = arg_10_0.params_.activityID
	arg_10_0.activityData_ = ActivityData:GetActivityData(arg_10_0.activityID_)
	arg_10_0.startTime_ = arg_10_0.activityData_.startTime
	arg_10_0.stopTime_ = arg_10_0.activityData_.stopTime
	arg_10_0.list_ = ActivityCfg[arg_10_0.params_.activityID].sub_activity_list

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.list_) do
		arg_10_0.levelData_[iter_10_0] = ActivityData:GetActivityData(iter_10_1)
	end
end

function var_0_0.RefreshUI(arg_11_0)
	local var_11_0 = ValentineGameData:GetLastLevel(arg_11_0.activityID_)

	arg_11_0.curIndex_ = table.indexof(arg_11_0.list_, var_11_0) or 1

	arg_11_0:RefreshTime()
	arg_11_0:RefreshList()
	arg_11_0:RefreshReward()
end

function var_0_0.RefreshTime(arg_12_0)
	local var_12_0
	local var_12_1 = manager.time:GetServerTime()

	arg_12_0:StopTimer()
	arg_12_0:RefreshLevelTime()

	if var_12_1 < arg_12_0.startTime_ then
		arg_12_0.timer_ = Timer.New(function()
			var_12_0 = arg_12_0.startTime_ - manager.time:GetServerTime()

			arg_12_0:RefreshLevelTime()

			if var_12_0 <= 0 then
				arg_12_0:StopTimer()
				arg_12_0:RefreshTime()

				return
			end
		end, 1, -1)

		arg_12_0.timer_:Start()
	elseif var_12_1 < arg_12_0.stopTime_ then
		arg_12_0.timer_ = Timer.New(function()
			var_12_0 = arg_12_0.stopTime_ - manager.time:GetServerTime()

			arg_12_0:RefreshLevelTime()

			if var_12_0 <= 0 then
				arg_12_0:StopTimer()
				arg_12_0:RefreshTime()

				return
			end
		end, 1, -1)

		arg_12_0.timer_:Start()
	end
end

function var_0_0.RefreshLevelTime(arg_15_0)
	local var_15_0 = manager.time:GetServerTime()

	for iter_15_0, iter_15_1 in ipairs(arg_15_0.list_) do
		local var_15_1 = arg_15_0.levelData_[iter_15_0].startTime

		if var_15_0 < var_15_1 then
			arg_15_0.levelStateCon_[iter_15_0]:SetSelectedState("lock")
			arg_15_0.levelCompleteCon_[iter_15_0]:SetSelectedState("false")

			arg_15_0.levelText_[iter_15_0].text = string.format(GetTips("UNLOCK"), manager.time:GetLostTimeStr(var_15_1))
		elseif iter_15_0 ~= arg_15_0.curIndex_ then
			arg_15_0.levelStateCon_[iter_15_0]:SetSelectedState("normal")
		else
			arg_15_0.levelStateCon_[iter_15_0]:SetSelectedState("selected")
		end
	end
end

function var_0_0.RefreshList(arg_16_0)
	for iter_16_0, iter_16_1 in ipairs(arg_16_0.list_) do
		local var_16_0 = ValentineGameData:GetData(iter_16_1)

		if var_16_0 and var_16_0.isClear then
			arg_16_0.levelCompleteCon_[iter_16_0]:SetSelectedState("true")
		else
			arg_16_0.levelCompleteCon_[iter_16_0]:SetSelectedState("false")
		end
	end
end

function var_0_0.RefreshReward(arg_17_0)
	arg_17_0.indexCon_:SetSelectedState(arg_17_0.curIndex_)
	ValentineGameData:SetNotNewOpen(arg_17_0.list_[arg_17_0.curIndex_])

	local var_17_0 = arg_17_0.list_[arg_17_0.curIndex_]
	local var_17_1 = ActivityValentineCfg[var_17_0]
	local var_17_2 = var_17_1.reward_item_list

	for iter_17_0, iter_17_1 in ipairs(var_17_2) do
		arg_17_0.rewardItems_[iter_17_0]:SetData(iter_17_1)
	end

	for iter_17_2 = #var_17_2 + 1, #arg_17_0.rewardItems_ do
		arg_17_0.rewardItems_[iter_17_2]:Show(false)
	end

	local var_17_3 = ValentineGameData:GetData(var_17_0)

	if var_17_3 and var_17_3.isReward then
		arg_17_0:SetPoint(var_17_3.point, var_17_1)
		arg_17_0.stateCon_:SetSelectedState("received")
	elseif var_17_3 and var_17_3.isClear then
		arg_17_0:SetPoint(var_17_3.point, var_17_1)
		arg_17_0.stateCon_:SetSelectedState("complete")
	else
		arg_17_0.testText_.text = GetI18NText(var_17_1.desc)

		arg_17_0.stateCon_:SetSelectedState("test")
	end
end

function var_0_0.SetPoint(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0, var_18_1 = ValentineGameTools.GetPointRule(arg_18_0.params_.activityID)

	if arg_18_1 <= var_18_0 then
		arg_18_0.resultText_.text = GetTips("ACTIVITY_VALENTINE_RESULT_TITLE_1")
		arg_18_0.completeText_.text = GetI18NText(arg_18_2.result_desc[1])
	elseif arg_18_1 <= var_18_1 then
		arg_18_0.resultText_.text = GetTips("ACTIVITY_VALENTINE_RESULT_TITLE_2")
		arg_18_0.completeText_.text = GetI18NText(arg_18_2.result_desc[2])
	else
		arg_18_0.resultText_.text = GetTips("ACTIVITY_VALENTINE_RESULT_TITLE_3")
		arg_18_0.completeText_.text = GetI18NText(arg_18_2.result_desc[3])
	end
end

function var_0_0.StopTimer(arg_19_0)
	if arg_19_0.timer_ then
		arg_19_0.timer_:Stop()

		arg_19_0.timer_ = nil
	end
end

function var_0_0.BindUIRedPoint(arg_20_0)
	for iter_20_0, iter_20_1 in ipairs(arg_20_0.list_) do
		manager.redPoint:bindUIandKey(arg_20_0.levelBtn_[iter_20_0].transform, RedPointConst.VALENTINE_GAME .. "_" .. iter_20_1)
	end
end

function var_0_0.UnBindUIRedPoint(arg_21_0)
	for iter_21_0, iter_21_1 in ipairs(arg_21_0.list_) do
		manager.redPoint:unbindUIandKey(arg_21_0.levelBtn_[iter_21_0].transform, RedPointConst.VALENTINE_GAME .. "_" .. iter_21_1)
	end
end

function var_0_0.OnValentineGameReward(arg_22_0)
	arg_22_0:RefreshReward()
end

function var_0_0.OnTop(arg_23_0)
	local var_23_0 = ValentineGameTools.GetGameHelpKey(arg_23_0.activityID_)

	if var_23_0 ~= "" then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			INFO_BAR
		})
		manager.windowBar:SetGameHelpKey(var_23_0)
	else
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR
		})
	end
end

function var_0_0.OnExit(arg_24_0)
	manager.windowBar:HideBar()
	arg_24_0:StopTimer()

	for iter_24_0 = 1, #arg_24_0.rewardItems_ do
		arg_24_0.rewardItems_[iter_24_0]:OnExit()
	end

	arg_24_0:UnBindUIRedPoint()
end

function var_0_0.Dispose(arg_25_0)
	arg_25_0:RemoveAllListeners()

	for iter_25_0 = 1, #arg_25_0.rewardItems_ do
		arg_25_0.rewardItems_[iter_25_0]:Dispose()
	end

	arg_25_0.super.Dispose(arg_25_0)
end

return var_0_0
