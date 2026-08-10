local var_0_0 = class("PushTheSnowBallHomeView", PushSnowBallSingleView)
local var_0_1 = {
	SURVIVAL = 2,
	BOSS = 1
}

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaPushTheSnowballUI/PushTheSnowballTeamModeUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
	arg_3_0:BindController()

	arg_3_0.taskItemList_ = {}

	for iter_3_0 = 1, 4 do
		local var_3_0 = PushSnowBallTeamWinTaskItem.New(arg_3_0["weeklyTaskItem" .. iter_3_0])

		table.insert(arg_3_0.taskItemList_, var_3_0)
	end
end

function var_0_0.BindController(arg_4_0)
	arg_4_0.rewardController_ = ControllerUtil.GetController(arg_4_0.transform_, "dailyRewardState")
	arg_4_0.modelSelectControllerList_ = {}
	arg_4_0.survivalSelectController_ = ControllerUtil.GetController(arg_4_0.survivalModelBtn_.transform, "select")
	arg_4_0.bossSelectController_ = ControllerUtil.GetController(arg_4_0.bossModelBtn_.transform, "select")

	table.insert(arg_4_0.modelSelectControllerList_, arg_4_0.bossSelectController_)
	table.insert(arg_4_0.modelSelectControllerList_, arg_4_0.survivalSelectController_)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.heroBtn_, nil, function()
		JumpTools.OpenPageByJump("pushSnowBallHeroChangePop", {
			type = 2
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.rankBtn_, nil, function()
		JumpTools.OpenPageByJump("pushSnowBallRank")
	end)
	arg_5_0:AddBtnListener(arg_5_0.touchHeroBtn_, nil, function()
		arg_5_0:OnTouchHero()
	end)
	arg_5_0:AddBtnListener(arg_5_0.modelDescBtn_, nil, function()
		local var_9_0 = GetTips(PushSnowBallData:GetTeamDescTipsByModelAndSubModel(arg_5_0.modelType_))

		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = var_9_0,
			key = var_9_0
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.survivalModelBtn_, nil, function()
		arg_5_0:SelectModel(var_0_1.SURVIVAL)
	end)
	arg_5_0:AddBtnListener(arg_5_0.bossModelBtn_, nil, function()
		arg_5_0:SelectModel(var_0_1.BOSS)
	end)
	arg_5_0:AddBtnListener(arg_5_0.startBtn_, nil, function()
		local var_12_0 = PushSnowBallData:GetSelectedBattleModelID()
		local var_12_1 = PushSnowBallData:GetTeamModelActivityIDByModel(arg_5_0.modelType_)
		local var_12_2 = PushSnowBallCfg[PushSnowBallCfg.get_id_list_by_activityId[var_12_1][1]].stageId
		local var_12_3 = PushSnowBallCfg[PushSnowBallCfg.get_id_list_by_activityId[var_12_1][1]].mode
		local var_12_4

		if var_12_3 == 4 then
			var_12_4 = BattleConst.STAGE_TYPE_NEW.PUSH_SNOWBALL_TEAM_BOSS
		else
			var_12_4 = BattleConst.STAGE_TYPE_NEW.PUSH_SNOWBALL_TEAM_SURVIVAL
		end

		PushSnowBallAction.SendStartMatching(var_12_2, var_12_4, var_12_0, var_12_1)
	end)
	arg_5_0:AddBtnListener(arg_5_0.dailyRewardBtn_, nil, function()
		JumpTools.OpenPageByJump("pushSnowBallTeamTaskPop")
	end)
end

function var_0_0.OnEnter(arg_14_0)
	arg_14_0.modelType_ = _G.PushSnowBallTeamMode or 2
	arg_14_0.activityID_ = PushSnowBallData:GetTeamActivityID()

	arg_14_0:AddTimer()
	arg_14_0:RefreshUI()
	arg_14_0:SetWindowBar()
	arg_14_0:SelectModel(_G["pushSnowBallModel" .. arg_14_0.activityID_] or arg_14_0.modelType_ or 1)
	manager.redPoint:bindUIandKey(arg_14_0.dailyRewardBtn_.transform, RedPointConst.ACTIVITY_PUSH_SNOWBALL_TEAM_PARTICIPATE)
end

function var_0_0.OnTop(arg_15_0)
	arg_15_0:SetWindowBar()
	arg_15_0:RefreshUI()
end

function var_0_0.OnTaskListChange(arg_16_0)
	arg_16_0:RefreshUI()
end

function var_0_0.OnExit(arg_17_0)
	manager.windowBar:HideBar()

	if arg_17_0.timer_ then
		arg_17_0.timer_:Stop()

		arg_17_0.timer_ = nil
	end

	manager.redPoint:unbindUIandKey(arg_17_0.dailyRewardBtn_.transform, RedPointConst.ACTIVITY_PUSH_SNOWBALL_TEAM_PARTICIPATE)
end

function var_0_0.RefreshUI(arg_18_0)
	arg_18_0:RefreshTaskList()
	arg_18_0:RefreshHeroIcon()
end

function var_0_0.RefreshTaskList(arg_19_0)
	local var_19_0 = PushSnowBallData:GetTeamWinTaskList()
	local var_19_1 = {}

	for iter_19_0, iter_19_1 in pairs(var_19_0) do
		table.insert(var_19_1, iter_19_1)
	end

	table.sort(var_19_1, function(arg_20_0, arg_20_1)
		return arg_20_0.id < arg_20_1.id
	end)

	if table.isEmpty(var_19_0) then
		for iter_19_2 = 1, 4 do
			SetActive(arg_19_0.taskItemList_[iter_19_2].gameObject, false)
		end
	else
		for iter_19_3 = 4, 1, -1 do
			arg_19_0.taskItemList_[iter_19_3]:SetData(iter_19_3, var_19_1[iter_19_3])
		end
	end

	local var_19_2 = PushSnowBallData:GetTeamParticipateTaskList()
	local var_19_3 = PushSnowBallData:GetHasCompeletedTeamTask()
	local var_19_4 = PushSnowBallData:GetCompeletedTeamTaskNum()
	local var_19_5 = PushSnowBallData:GetHasAllRewardedTeamTask()

	arg_19_0.dailyTaskScoreText_.text = var_19_4 .. "<color=#86443C>/" .. #var_19_2 .. "</color>"

	if not var_19_3 then
		arg_19_0.rewardController_:SetSelectedState("uncomplete")
	elseif not var_19_5 then
		arg_19_0.rewardController_:SetSelectedState("unreceive")
	else
		arg_19_0.rewardController_:SetSelectedState("received")
	end
end

function var_0_0.SelectModel(arg_21_0, arg_21_1)
	local var_21_0 = PushSnowBallData:GetTeamModelActivityIDByModel(arg_21_1)
	local var_21_1 = ActivityData:GetActivityData(var_21_0)

	if not arg_21_0:IsActiveTime(var_21_1) then
		return
	end

	arg_21_0.modelType_ = arg_21_1
	_G.PushSnowBallTeamMode = arg_21_1

	for iter_21_0, iter_21_1 in ipairs(arg_21_0.modelSelectControllerList_) do
		iter_21_1:SetSelectedState(tostring(iter_21_0 == arg_21_1))
	end
end

function var_0_0.AddTimer(arg_22_0)
	local var_22_0 = ActivityData:GetActivityData(arg_22_0.activityID_).stopTime

	arg_22_0.leftTimeText_.text = manager.time:GetLostTimeStr2(var_22_0, nil, true)
	arg_22_0.timer_ = Timer.New(function()
		if manager.time:GetServerTime() > var_22_0 then
			return
		end

		arg_22_0.leftTimeText_.text = manager.time:GetLostTimeStr2(var_22_0, nil, true)
	end, 1, -1)

	arg_22_0.timer_:Start()
end

return var_0_0
