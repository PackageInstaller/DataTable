local var_0_0 = class("CombineGameMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaKf/IndiaKfModeUI_2"
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

	arg_4_0.dailyController = ControllerUtil.GetController(arg_4_0.dailyGo_.transform, "daily")
	arg_4_0.endlessController = ControllerUtil.GetController(arg_4_0.endlessGo_.transform, "endless")
	arg_4_0.rewardController = ControllerUtil.GetController(arg_4_0.dailyGo_.transform, "reward")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.poolBtn_, nil, function()
		JumpTools.GoToSystem("/CombineGamePoolView")
	end)
	arg_5_0:AddBtnListener(arg_5_0.taskBtn_, nil, function()
		JumpTools.GoToSystem("CombineGameTaskView")
	end)
	arg_5_0:AddBtnListener(arg_5_0.factorBtn_, nil, function()
		JumpTools.GoToSystem("CombineGameWatchFactorView", {
			id = arg_5_0.endlessId
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.roleBtn_, nil, function()
		JumpTools.GoToSystem("CombineGameRoleView", {
			lv = 999
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.tutorialBtn_, nil, function()
		JumpTools.GoToSystem("/CombineGameTeachView")
	end)
	arg_5_0:AddBtnListener(arg_5_0.dailyBtn_, nil, function()
		if arg_5_0.isLock then
			ShowTips(string.format(GetTips("ACTIVITY_COMBINE_GAME_OPEN_LIMIT_TIPS"), GetI18NText(ActivityCombineLevelCfg[arg_5_0.idList[1]].name)))

			return
		end

		JumpTools.GoToSystem("/CombineGameDailyView")
	end)
	arg_5_0:AddBtnListener(arg_5_0.endlessBtn_, nil, function()
		if arg_5_0.isLock then
			ShowTips(string.format(GetTips("ACTIVITY_COMBINE_GAME_OPEN_LIMIT_TIPS"), GetI18NText(ActivityCombineLevelCfg[arg_5_0.idList[1]].name)))

			return
		end

		JumpTools.GoToSystem("/CombineGameEndlessView")
	end)
	arg_5_0:AddBtnListener(arg_5_0.tipsBtn_, nil, function()
		local var_13_0 = GetTips("ACTIVITY_COMBINE_GAME_DESC")

		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = var_13_0
		})
	end)
end

function var_0_0.OnEnter(arg_14_0)
	arg_14_0.activityId = CombineGameData:GetDataByPara("activityId")

	if not ActivityData:GetActivityIsOpen(arg_14_0.activityId) then
		gameContext:Go("/home", nil, nil, true)
		ShowTips("TIME_OVER")

		return
	end

	arg_14_0:UpdateView()
	arg_14_0:BindRedPoint()
end

function var_0_0.UpdateView(arg_15_0)
	local var_15_0 = ActivityData:GetActivityData(CombineGameData:GetDataByPara("activityId"))

	arg_15_0.startTime_ = var_15_0.startTime
	arg_15_0.stopTime_ = var_15_0.stopTime
	arg_15_0.remainTime_.text = manager.time:GetLostTimeStr2(arg_15_0.stopTime_, nil, true)
	arg_15_0.timer_ = Timer.New(function()
		arg_15_0.remainTime_.text = manager.time:GetLostTimeStr2(arg_15_0.stopTime_, nil, true)
	end, 1, -1)

	arg_15_0.timer_:Start()

	arg_15_0.idList = {}

	for iter_15_0, iter_15_1 in ipairs(ActivityCombineLevelCfg.all) do
		local var_15_1 = ActivityCombineLevelCfg[iter_15_0]

		if var_15_1.type == CombineGameConst.TypeConst.TEACH then
			table.insert(arg_15_0.idList, iter_15_0)
		end

		if var_15_1.type == CombineGameConst.TypeConst.ENDLESS then
			arg_15_0.endlessId = iter_15_0
		end
	end

	local var_15_2 = CombineGameData:GetDataByPara("stageDataTable")

	arg_15_0.isLock = false

	for iter_15_2, iter_15_3 in ipairs(arg_15_0.idList) do
		if var_15_2[iter_15_3] ~= true then
			arg_15_0.isLock = true
		end
	end

	arg_15_0.id = CombineGameData:GetDataByPara("nowDay")
	arg_15_0.cfg = ActivityCombineLevelCfg[arg_15_0.id]

	local var_15_3 = arg_15_0.cfg.reward_list
	local var_15_4 = CombineGameData:GetDataByPara("stageDataTable")[arg_15_0.id]

	arg_15_0.dailyController:SetSelectedState(arg_15_0.isLock and "false" or "true")
	arg_15_0.endlessController:SetSelectedState(arg_15_0.isLock and "false" or "true")
	arg_15_0.rewardController:SetSelectedState(var_15_4 and "true" or "false")

	arg_15_0.techTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_MODE_NAME_1")
	arg_15_0.dailyTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_MODE_NAME_2")
	arg_15_0.endlessTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_MODE_NAME_3")
	arg_15_0.poolTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_POOL_NAME")
	arg_15_0.factorTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_FACTOR")
	arg_15_0.titleName_.text = GetTips("ACTIVITY_COMBINE_GAME_NAME")
	arg_15_0.titleDesc_.text = GetTips("ACTIVITY_COMBINE_GAME_CONTENT")
	arg_15_0.dailyLockTxt_.text = string.format(GetTips("ACTIVITY_COMBINE_GAME_OPEN_LIMIT_TIPS"), GetI18NText(ActivityCombineLevelCfg[arg_15_0.idList[1]].name))
	arg_15_0.endlessLockTxt_.text = string.format(GetTips("ACTIVITY_COMBINE_GAME_OPEN_LIMIT_TIPS"), GetI18NText(ActivityCombineLevelCfg[arg_15_0.idList[1]].name))
end

function var_0_0.BindRedPoint(arg_17_0)
	manager.redPoint:bindUIandKey(arg_17_0.dailyBtn_.transform, string.format("%s%s_DAILY", ActivityTools.GetRedPointKey(arg_17_0.activityId), arg_17_0.activityId), {
		x = 360,
		y = 225
	})
	manager.redPoint:bindUIandKey(arg_17_0.tutorialBtn_.transform, string.format("%s%s_TEACH", ActivityTools.GetRedPointKey(arg_17_0.activityId), arg_17_0.activityId), {
		x = 170,
		y = 225
	})
	manager.redPoint:bindUIandKey(arg_17_0.poolBtn_.transform, RedPointConst.ACTIVITY_SPRING_COMBINE_GAME_POOL, {
		x = 110,
		y = 35
	})
	manager.redPoint:bindUIandKey(arg_17_0.taskBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_TASK, ActivityConst.SPRING_FESTIVAL_ACTIVITY_V2_COMBINE_GAME_TASK), {
		x = 110,
		y = 35
	})
end

function var_0_0.UnbindRedPoint(arg_18_0)
	manager.redPoint:unbindUIandKey(arg_18_0.dailyBtn_.transform, string.format("%s%s_DAILY", ActivityTools.GetRedPointKey(arg_18_0.activityId), arg_18_0.activityId))
	manager.redPoint:unbindUIandKey(arg_18_0.tutorialBtn_.transform, string.format("%s%s_TEACH", ActivityTools.GetRedPointKey(arg_18_0.activityId), arg_18_0.activityId))
	manager.redPoint:unbindUIandKey(arg_18_0.poolBtn_.transform, RedPointConst.ACTIVITY_SPRING_COMBINE_GAME_POOL)
	manager.redPoint:unbindUIandKey(arg_18_0.taskBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_TASK, ActivityConst.SPRING_FESTIVAL_ACTIVITY_V2_COMBINE_GAME_TASK))
end

function var_0_0.OnCombineGameRefresh(arg_19_0)
	arg_19_0.id = CombineGameData:GetDataByPara("nowDay")

	arg_19_0:UpdateView()
end

function var_0_0.OnExit(arg_20_0)
	if arg_20_0.timer_ then
		arg_20_0.timer_:Stop()

		arg_20_0.timer_ = nil
	end

	arg_20_0:UnbindRedPoint()
	manager.windowBar:HideBar()
end

function var_0_0.OnTop(arg_21_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.Dispose(arg_22_0)
	var_0_0.super.Dispose(arg_22_0)
	Object.Destroy(arg_22_0.gameObject_)
end

return var_0_0
