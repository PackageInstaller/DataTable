local var_0_0 = class("SurviveSoloMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return SurviveSoloTools.GetMainUIName(arg_1_0.params_.activityID)
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

	arg_4_0.levelBtn_ = {}
	arg_4_0.levelTime_ = {}
	arg_4_0.levelText_ = {}
	arg_4_0.openCon_ = {}
	arg_4_0.clearCon_ = {}
	arg_4_0.activityList_ = ActivitySoloSlayerCfg.get_id_list_by_main_activity_id[arg_4_0.params_.activityID]

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.activityList_) do
		table.insert(arg_4_0.levelBtn_, arg_4_0["levelBtn_" .. iter_4_0])
		table.insert(arg_4_0.levelTime_, arg_4_0["levelTime_" .. iter_4_0])
		table.insert(arg_4_0.levelText_, arg_4_0["levelText_" .. iter_4_0])

		arg_4_0.levelText_[iter_4_0].text = GetI18NText(BattleSoloSlayerCfg[ActivitySoloSlayerCfg[iter_4_1].stage_id].name)

		table.insert(arg_4_0.openCon_, ControllerUtil.GetController(arg_4_0["levelBtn_" .. iter_4_0].transform, "open"))
		table.insert(arg_4_0.clearCon_, ControllerUtil.GetController(arg_4_0["levelBtn_" .. iter_4_0].transform, "clear"))
	end

	arg_4_0.levelData_ = {}
	arg_4_0.indexCon_ = ControllerUtil.GetController(arg_4_0.transform_, "index")

	if arg_4_0.scrollView_ then
		arg_4_0.positionCon_ = ControllerUtil.GetController(arg_4_0.transform_, "position")
	end
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.rewardBtn_, nil, function()
		if arg_5_0:IsOpenSectionView() then
			JumpTools.Back()
			arg_5_0:SetIndex(0)
		end

		JumpTools.OpenPageByJump("surviveSoloReward", {
			activityID = arg_5_0.activityID_
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.bgBtn_, nil, function()
		if arg_5_0:IsOpenSectionView() then
			JumpTools.Back()
			arg_5_0:SetIndex(0)
		end
	end)

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.activityList_) do
		arg_5_0:AddBtnListener(arg_5_0.levelBtn_[iter_5_0], nil, function()
			local var_8_0 = manager.time:GetServerTime()

			if var_8_0 >= arg_5_0.levelData_[iter_5_0].startTime and var_8_0 < arg_5_0.levelData_[iter_5_0].stopTime then
				SurviveSoloData:SetLastIndex(arg_5_0.activityID_, iter_5_0)
				arg_5_0:SetIndex(iter_5_0)
			elseif var_8_0 < arg_5_0.levelData_[iter_5_0].startTime then
				ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(arg_5_0.levelData_[iter_5_0].startTime)))
			else
				ShowTips("TIME_OVER")
			end
		end)
	end
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0:GetActivityData()
	arg_9_0:RefreshUI()
	arg_9_0:BindUIRedPoint()
end

function var_0_0.GetActivityData(arg_10_0)
	arg_10_0.activityID_ = arg_10_0.params_.activityID
	arg_10_0.activityData_ = ActivityData:GetActivityData(arg_10_0.activityID_)
	arg_10_0.startTime_ = arg_10_0.activityData_.startTime
	arg_10_0.stopTime_ = arg_10_0.activityData_.stopTime

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.activityList_) do
		arg_10_0.levelData_[iter_10_0] = ActivityData:GetActivityData(iter_10_1)
	end
end

function var_0_0.RefreshUI(arg_11_0)
	arg_11_0:RefreshLevel()
	arg_11_0:RefreshTime()

	arg_11_0.selectIndex_ = SurviveSoloData:GetLastIndex(arg_11_0.activityID_)

	if arg_11_0:IsOpenSectionView() then
		arg_11_0:SetIndex(arg_11_0.selectIndex_ or 0)
	else
		arg_11_0:SetIndex(0)
	end

	if arg_11_0.scrollView_ then
		arg_11_0.positionCon_:SetSelectedState(arg_11_0.selectIndex_ or 0)
	end
end

function var_0_0.RefreshLevel(arg_12_0)
	local var_12_0

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.activityList_) do
		local var_12_1 = SurviveSoloData:GetData(iter_12_1)

		if var_12_1 then
			arg_12_0.clearCon_[iter_12_0]:SetSelectedState(var_12_1.time > 0 and "true" or "false")
		else
			arg_12_0.clearCon_[iter_12_0]:SetSelectedState("false")
		end
	end
end

function var_0_0.RefreshTime(arg_13_0)
	local var_13_0
	local var_13_1 = manager.time:GetServerTime()

	arg_13_0:StopTimer()
	arg_13_0:RefreshLevelTime()

	if var_13_1 < arg_13_0.startTime_ then
		arg_13_0.timeTxt_.text = GetTips("SOLO_NOT_OPEN")
		arg_13_0.timer_ = Timer.New(function()
			var_13_0 = arg_13_0.startTime_ - manager.time:GetServerTime()

			arg_13_0:RefreshLevelTime()

			if var_13_0 <= 0 then
				arg_13_0:StopTimer()
				arg_13_0:RefreshTime()

				return
			end
		end, 1, -1)

		arg_13_0.timer_:Start()
	elseif var_13_1 < arg_13_0.stopTime_ then
		arg_13_0.timeTxt_.text = manager.time:GetLostTimeStr(arg_13_0.stopTime_)
		arg_13_0.timer_ = Timer.New(function()
			var_13_0 = arg_13_0.stopTime_ - manager.time:GetServerTime()

			arg_13_0:RefreshLevelTime()

			if var_13_0 <= 0 then
				arg_13_0:StopTimer()
				arg_13_0:RefreshTime()

				return
			end

			arg_13_0.timeTxt_.text = manager.time:GetLostTimeStr(arg_13_0.stopTime_)
		end, 1, -1)

		arg_13_0.timer_:Start()
	else
		arg_13_0.timeTxt_.text = GetTips("TIME_OVER")
	end
end

function var_0_0.RefreshLevelTime(arg_16_0)
	local var_16_0 = manager.time:GetServerTime()

	for iter_16_0, iter_16_1 in ipairs(arg_16_0.activityList_) do
		if var_16_0 < arg_16_0.levelData_[iter_16_0].startTime then
			arg_16_0.openCon_[iter_16_0]:SetSelectedState("false")

			arg_16_0.levelTime_[iter_16_0].text = string.format(GetTips("UNLOCK"), manager.time:GetLostTimeStr(arg_16_0.levelData_[iter_16_0].startTime))
		else
			arg_16_0.openCon_[iter_16_0]:SetSelectedState("true")
		end
	end
end

function var_0_0.SetIndex(arg_17_0, arg_17_1)
	arg_17_0.selectIndex_ = arg_17_1

	if arg_17_1 ~= 0 and arg_17_1 ~= -1 then
		arg_17_0:SetScrollEnable(false)

		local var_17_0 = ActivitySoloSlayerCfg.get_id_list_by_main_activity_id[arg_17_0.activityID_][arg_17_1]
		local var_17_1 = ActivitySoloSlayerCfg[var_17_0].stage_id

		manager.redPoint:setTip(RedPointConst.SOLO_SURVIVE_OPEN .. "_" .. var_17_0, 0)
		JumpTools.OpenPageByJump("surviveSoloSectionInfo", {
			index = arg_17_1,
			section = var_17_1,
			sectionType = BattleConst.STAGE_TYPE_NEW.SURVIVE_SOLO,
			activityID = var_17_0,
			repeat_id = var_17_0,
			backFunc = function()
				arg_17_0:SetIndex(0)
			end
		})

		if arg_17_0.scrollView_ then
			arg_17_0.positionCon_:SetSelectedState(0)
			arg_17_0.positionCon_:SetSelectedState(arg_17_1)
		end
	else
		arg_17_0:SetScrollEnable(true)
	end

	arg_17_0.indexCon_:SetSelectedState(arg_17_1)
end

function var_0_0.SetScrollEnable(arg_19_0, arg_19_1)
	if arg_19_0.scrollView_ then
		arg_19_0.scrollView_.enabled = arg_19_1
	end
end

function var_0_0.StopTimer(arg_20_0)
	if arg_20_0.timer_ then
		arg_20_0.timer_:Stop()

		arg_20_0.timer_ = nil
	end
end

function var_0_0.BindUIRedPoint(arg_21_0)
	manager.redPoint:bindUIandKey(arg_21_0.rewardBtn_.gameObject.transform, RedPointConst.SOLO_SURVIVE_REWARD .. "_" .. arg_21_0.activityID_)

	for iter_21_0, iter_21_1 in ipairs(arg_21_0.activityList_) do
		manager.redPoint:bindUIandKey(arg_21_0.levelBtn_[iter_21_0].gameObject.transform, RedPointConst.SOLO_SURVIVE_OPEN .. "_" .. iter_21_1)
	end
end

function var_0_0.UnbindUIRedPoint(arg_22_0)
	manager.redPoint:unbindUIandKey(arg_22_0.rewardBtn_.gameObject.transform, RedPointConst.SOLO_SURVIVE_REWARD .. "_" .. arg_22_0.activityID_)

	for iter_22_0, iter_22_1 in ipairs(arg_22_0.activityList_) do
		manager.redPoint:unbindUIandKey(arg_22_0.levelBtn_[iter_22_0].gameObject.transform, RedPointConst.SOLO_SURVIVE_OPEN .. "_" .. iter_22_1)
	end
end

function var_0_0.IsOpenSectionView(arg_23_0)
	return arg_23_0:IsOpenRoute("surviveSoloSectionInfo")
end

function var_0_0.OnTop(arg_24_0)
	arg_24_0:UpdataBar()
end

function var_0_0.UpdataBar(arg_25_0)
	local var_25_0 = SurviveSoloTools.GetGameHelpKey(arg_25_0.params_.activityID)

	if var_25_0 ~= "" then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			INFO_BAR
		})
		manager.windowBar:SetGameHelpKey(var_25_0)
	else
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR
		})
	end

	manager.windowBar:RegistBackCallBack(function()
		if arg_25_0:IsOpenSectionView() then
			arg_25_0:SetIndex(0)
			JumpTools.Back()
		else
			JumpTools.Back()
		end
	end)
end

function var_0_0.OnExit(arg_27_0)
	arg_27_0:UnbindUIRedPoint()
	arg_27_0:StopTimer()
	arg_27_0:SetIndex(-1)

	if arg_27_0.scrollView_ then
		arg_27_0.positionCon_:SetSelectedState(-1)
	end

	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_28_0)
	arg_28_0:RemoveAllListeners()
	arg_28_0.super.Dispose(arg_28_0)
end

return var_0_0
