local var_0_0 = class("PushTheSnowBallSingleView", ReduxView)
local var_0_1 = {
	BOSS = 3,
	SCORE = 1,
	BOWLING = 2
}
local var_0_2 = {
	NORMAL = 1,
	HARD = 2
}

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaPushTheSnowballUI/PushTheSnowballSingleModeUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
	arg_3_0:BindController()

	arg_3_0.taskItemList_ = {}

	for iter_3_0 = 1, 3 do
		local var_3_0 = PushSnowBallWeeklyTaskItem.New(arg_3_0["weeklyTaskItem" .. iter_3_0])

		table.insert(arg_3_0.taskItemList_, var_3_0)
	end

	arg_3_0.commonItem_ = CommonItem.New(arg_3_0.commonItemGo_)
end

function var_0_0.BindController(arg_4_0)
	arg_4_0.deviceController_ = ControllerUtil.GetController(arg_4_0.deviceBtn_.transform, "equipped")
	arg_4_0.rewardController_ = ControllerUtil.GetController(arg_4_0.weeklyTaskTrs_, "state")
	arg_4_0.modelSelectControllerList_ = {}
	arg_4_0.modelLockControllerList_ = {}
	arg_4_0.scoreSelectController_ = ControllerUtil.GetController(arg_4_0.scoreModelBtn_.transform, "select")
	arg_4_0.bowlingSelectController_ = ControllerUtil.GetController(arg_4_0.bowlingModelBtn_.transform, "select")
	arg_4_0.bossSelectController_ = ControllerUtil.GetController(arg_4_0.bossModelBtn_.transform, "select")
	arg_4_0.bowlingLockController_ = ControllerUtil.GetController(arg_4_0.bowlingModelBtn_.transform, "lock")
	arg_4_0.bossLockController_ = ControllerUtil.GetController(arg_4_0.bossModelBtn_.transform, "lock")

	table.insert(arg_4_0.modelSelectControllerList_, arg_4_0.scoreSelectController_)
	table.insert(arg_4_0.modelSelectControllerList_, arg_4_0.bowlingSelectController_)
	table.insert(arg_4_0.modelSelectControllerList_, arg_4_0.bossSelectController_)
	table.insert(arg_4_0.modelLockControllerList_, arg_4_0.bowlingLockController_)
	table.insert(arg_4_0.modelLockControllerList_, arg_4_0.bossLockController_)

	arg_4_0.levelSelectControllerList_ = {}
	arg_4_0.normalSelectController_ = ControllerUtil.GetController(arg_4_0.normalLevelBtn_.transform, "select")
	arg_4_0.hardSelectController_ = ControllerUtil.GetController(arg_4_0.hardLevelBtn_.transform, "select")
	arg_4_0.hardLockController_ = ControllerUtil.GetController(arg_4_0.hardLevelBtn_.transform, "lockByTime")
	arg_4_0.normalLevelImgController_ = ControllerUtil.GetController(arg_4_0.normalLevelBtn_.transform, "type")
	arg_4_0.hardlLevelImgController_ = ControllerUtil.GetController(arg_4_0.hardLevelBtn_.transform, "type")

	table.insert(arg_4_0.levelSelectControllerList_, arg_4_0.normalSelectController_)
	table.insert(arg_4_0.levelSelectControllerList_, arg_4_0.hardSelectController_)
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.heroBtn_, nil, function()
		JumpTools.OpenPageByJump("pushSnowBallHeroChangePop", {
			type = 1
		})
	end)
	arg_6_0:AddBtnListener(arg_6_0.deviceBtn_, nil, function()
		JumpTools.OpenPageByJump("pushSnowBallDevicePop")
	end)
	arg_6_0:AddBtnListener(arg_6_0.weeklyTaskRewardBtn_, nil, function()
		TaskAction:SubmitTaskList({
			arg_6_0.weeklyTaskID
		})
	end)
	arg_6_0:AddBtnListener(arg_6_0.touchHeroBtn_, nil, function()
		arg_6_0:OnTouchHero()
	end)
	arg_6_0:AddBtnListener(arg_6_0.scoreModelBtn_, nil, function()
		arg_6_0:SelectModel(var_0_1.SCORE)
	end)
	arg_6_0:AddBtnListener(arg_6_0.bowlingModelBtn_, nil, function()
		arg_6_0:SelectModel(var_0_1.BOWLING)
	end)
	arg_6_0:AddBtnListener(arg_6_0.bossModelBtn_, nil, function()
		arg_6_0:SelectModel(var_0_1.BOSS)
	end)
	arg_6_0:AddBtnListener(arg_6_0.modelDescBtn_, nil, function()
		local var_14_0 = GetTips(PushSnowBallData:GetSingleDescTipsByModelAndSubModel(arg_6_0.modelType_ or 1))

		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = var_14_0,
			key = var_14_0
		})
	end)
	arg_6_0:AddBtnListener(arg_6_0.normalLevelBtn_, nil, function()
		arg_6_0:SelectLevel(var_0_2.NORMAL)
	end)
	arg_6_0:AddBtnListener(arg_6_0.hardLevelBtn_, nil, function()
		arg_6_0:SelectLevel(var_0_2.HARD)
	end)
	arg_6_0:AddBtnListener(arg_6_0.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("pushSnowBallReward")
	end)
	arg_6_0:AddBtnListener(arg_6_0.startBtn_, nil, function()
		local var_18_0 = PushSnowBallData:GetSingleModelActivityIDByModelAndLevel(arg_6_0.modelType_, arg_6_0.levelType_)
		local var_18_1 = PushSnowBallCfg.get_id_list_by_activityId[var_18_0][1]
		local var_18_2 = PushSnowBallCfg[var_18_1].stageId
		local var_18_3 = BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.PUSH_SNOWBALL_SINGLE, var_18_2, {
			activityID = var_18_0
		})

		BattleController.GetInstance():LaunchBattle(var_18_3)
	end)
end

function var_0_0.OnEnter(arg_19_0)
	arg_19_0.activityID_ = PushSnowBallData:GetSingleActivityID()

	arg_19_0:SelectModel(_G["pushSnowBallModel" .. arg_19_0.activityID_] or arg_19_0.modelType_ or var_0_1.SCORE)
	arg_19_0:SetWindowBar()
	arg_19_0:RefreshUI()
	arg_19_0:AddTimer()
	manager.redPoint:bindUIandKey(arg_19_0.rewardBtn_.transform, RedPointConst.ACTIVITY_PUSH_SNOWBALL_SINGLE_SCORE)
	manager.redPoint:bindUIandKey(arg_19_0.deviceBtn_.transform, RedPointConst.ACTIVITY_PUSH_SNOWBALL_DEVICE_UNLOCK)
	manager.redPoint:bindUIandKey(arg_19_0.scoreModelBtn_.transform, RedPointConst.ACTIVITY_PUSH_SNOWBALL_LEVEL_UNLOCK .. 1)
	manager.redPoint:bindUIandKey(arg_19_0.bowlingModelBtn_.transform, RedPointConst.ACTIVITY_PUSH_SNOWBALL_LEVEL_UNLOCK .. 2)
	manager.redPoint:bindUIandKey(arg_19_0.bossModelBtn_.transform, RedPointConst.ACTIVITY_PUSH_SNOWBALL_LEVEL_UNLOCK .. 3)
	manager.redPoint:bindUIandKey(arg_19_0.commonItemGo_.transform, RedPointConst.ACTIVITY_PUSH_SNOWBALL_SINGLE_REWARD)
end

function var_0_0.SetWindowBar(arg_20_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		DestroyLua()
		LuaExchangeHelper.GoToMain()
		OpenPageUntilLoaded("/pushSnowBallMain")
	end)
	manager.windowBar:RegistHomeCallBack(function()
		DestroyLua()
		LuaExchangeHelper.GoToMain()
		OpenPageUntilLoaded("/home")
	end)
end

function var_0_0.OnTouchHero(arg_23_0)
	local var_23_0 = PushSnowBallGameMgr.GetInstance()
	local var_23_1 = PushSnowBallData:GetSelectedHeroID()
	local var_23_2 = var_23_0:GetPlayerEID()
	local var_23_3 = GameDisplayCfg.dorm_interaction_stroke.value
	local var_23_4 = DormHeroTemplate.PickInteractAction(var_23_3)
	local var_23_5 = DormInteractSequence[var_23_4].name

	Dorm.DormEntityManager.SendInteractToEntityCMD(var_23_2, var_23_2, var_23_4, false)
	SDKTools.SendMessageToSDK("backhome_dorm_stroke", {
		hero_id = var_23_1,
		activity_id = PushSnowBallData:GetActivityID()
	})
end

function var_0_0.GetWeeklyTaskList(arg_24_0)
	return PushSnowBallData:GetWeeklyTaskList() or {}
end

function var_0_0.RefreshUI(arg_25_0)
	arg_25_0:RefreshTaskList()
	arg_25_0:RefreshHeroIcon()
	arg_25_0:RefreshDeviceIcon()
	arg_25_0:RefreshLockState()
end

function var_0_0.RefreshTaskList(arg_26_0)
	local var_26_0 = arg_26_0:GetWeeklyTaskList() or {}
	local var_26_1 = {}

	for iter_26_0, iter_26_1 in pairs(var_26_0) do
		table.insert(var_26_1, iter_26_1)
	end

	table.sort(var_26_1, function(arg_27_0, arg_27_1)
		return arg_27_0.id < arg_27_1.id
	end)

	if table.isEmpty(var_26_0) then
		for iter_26_2 = 1, 3 do
			SetActive(arg_26_0.taskItemList_[iter_26_2].gameObject, false)
		end
	else
		arg_26_0:RefreshWeeklyTask()

		for iter_26_3 = 1, 3 do
			arg_26_0.taskItemList_[iter_26_3]:SetData(iter_26_3, var_26_1[iter_26_3 + 1])
		end
	end
end

function var_0_0.RefreshWeeklyTask(arg_28_0)
	local var_28_0 = arg_28_0:GetWeeklyTaskList()
	local var_28_1 = {}

	for iter_28_0, iter_28_1 in pairs(var_28_0) do
		table.insert(var_28_1, iter_28_1)
	end

	table.sort(var_28_1, function(arg_29_0, arg_29_1)
		return arg_29_0.id < arg_29_1.id
	end)

	arg_28_0.weeklyTaskID = var_28_1[1].id

	local var_28_2 = AssignmentCfg[arg_28_0.weeklyTaskID]
	local var_28_3 = AssignmentCfg[arg_28_0.weeklyTaskID].reward

	arg_28_0.commonItem_:RefreshData({
		id = var_28_3[1][1],
		number = var_28_3[1][2]
	})
	arg_28_0.commonItem_:RegistCallBack(function()
		ShowPopItem(POP_ITEM, {
			var_28_3[1][1]
		})
	end)

	arg_28_0.taskNumText_.text = var_28_1[1].progress .. "/" .. AssignmentCfg[arg_28_0.weeklyTaskID].need

	local var_28_4 = TaskData2:GetTaskComplete(arg_28_0.weeklyTaskID)

	if not (AssignmentCfg[arg_28_0.weeklyTaskID].need <= var_28_1[1].progress) then
		arg_28_0.rewardController_:SetSelectedState("unfinished")
	elseif not var_28_4 then
		arg_28_0.rewardController_:SetSelectedState("complete")
	else
		arg_28_0.rewardController_:SetSelectedState("rewarded")
	end
end

function var_0_0.RefreshHeroIcon(arg_31_0)
	arg_31_0.heroIconImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/BackHouseUI/RoleHead/" .. PushSnowBallData:GetSelectedHeroID())
end

function var_0_0.RefreshDeviceIcon(arg_32_0)
	local var_32_0 = PushSnowBallData:GetSelectedDeviceID()

	arg_32_0.deviceController_:SetSelectedState(tostring(var_32_0 ~= 0))

	if var_32_0 ~= 0 then
		arg_32_0.deviceIconImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Item_l" .. PushSnowBallDeviceCfg[PushSnowBallData:GetSelectedDeviceID()].icon)
	end
end

function var_0_0.RefreshLockState(arg_33_0)
	for iter_33_0 = 2, 3 do
		local var_33_0 = PushSnowBallData:GetSingleModelActivityIDByModelAndLevel(iter_33_0, 1)
		local var_33_1 = ActivityData:GetActivityData(var_33_0)

		if not arg_33_0:IsActiveTimeWithoutTips(var_33_1) then
			arg_33_0.modelLockControllerList_[iter_33_0 - 1]:SetSelectedState("true")
		else
			arg_33_0.modelLockControllerList_[iter_33_0 - 1]:SetSelectedState("false")
		end
	end

	local var_33_2 = PushSnowBallData:GetSingleModelActivityIDByModelAndLevel(arg_33_0.modelType_ or 1, 2)
	local var_33_3 = ActivityData:GetActivityData(var_33_2)

	if not arg_33_0:IsActiveTimeWithoutTips(var_33_3) then
		arg_33_0.hardLockController_:SetSelectedState("true")

		local var_33_4 = GetTips("OPEN_TIME")

		arg_33_0.lockText_.text = string.format(var_33_4, manager.time:GetLostTimeStr2(var_33_3.startTime, nil, true))
	else
		arg_33_0.hardLockController_:SetSelectedState("false")
	end
end

function var_0_0.SelectModel(arg_34_0, arg_34_1)
	local var_34_0 = PushSnowBallData:GetSingleModelActivityIDByModelAndLevel(arg_34_1, 1)
	local var_34_1 = ActivityData:GetActivityData(var_34_0)

	if not arg_34_0:IsActiveTime(var_34_1) then
		return
	end

	if arg_34_0.modelType_ then
		manager.redPoint:unbindUIandKey(arg_34_0.hardLevelBtn_.transform, RedPointConst.ACTIVITY_PUSH_SNOWBALL_LEVEL_UNLOCK .. arg_34_0.modelType_)
	end

	manager.redPoint:bindUIandKey(arg_34_0.hardLevelBtn_.transform, RedPointConst.ACTIVITY_PUSH_SNOWBALL_LEVEL_UNLOCK .. arg_34_1)

	arg_34_0.modelType_ = arg_34_1

	for iter_34_0, iter_34_1 in ipairs(arg_34_0.modelSelectControllerList_) do
		iter_34_1:SetSelectedState(tostring(iter_34_0 == arg_34_1))
	end

	arg_34_0.normalLevelImgController_:SetSelectedState(arg_34_1)
	arg_34_0.hardlLevelImgController_:SetSelectedState(arg_34_1)

	arg_34_0.modelNameText_.text = GetTips("ACTIVITY_SNOWBALL_PUSH_SINGLE_MOD_" .. arg_34_0.modelType_)
	_G["pushSnowBallModel" .. arg_34_0.activityID_] = arg_34_0.modelType_
	arg_34_0.levelType_ = _G["pushSnowBallLevel" .. arg_34_0.modelType_ .. arg_34_0.activityID_] or 1

	arg_34_0:SelectLevel(arg_34_0.levelType_)
	arg_34_0.levelAni_:Play("Fx_panelItem_cx 1", 0, 0)
	arg_34_0.levelAni_:Update(0)
end

function var_0_0.SelectLevel(arg_35_0, arg_35_1)
	local var_35_0 = PushSnowBallData:GetSingleModelActivityIDByModelAndLevel(arg_35_0.modelType_, arg_35_1)
	local var_35_1 = ActivityData:GetActivityData(var_35_0)

	if not arg_35_0:IsActiveTime(var_35_1) then
		return
	end

	arg_35_0.levelType_ = arg_35_1
	_G["pushSnowBallLevel" .. arg_35_0.modelType_ .. arg_35_0.activityID_] = arg_35_1

	for iter_35_0, iter_35_1 in ipairs(arg_35_0.levelSelectControllerList_) do
		iter_35_1:SetSelectedState(tostring(iter_35_0 == arg_35_1))
	end

	arg_35_0:RefreshLockState()
	saveData("PushSnowBall", "Level" .. arg_35_0.modelType_ .. PlayerData:GetPlayerInfo().userID, true)

	if arg_35_1 == 2 then
		manager.redPoint:setTip(RedPointConst.ACTIVITY_PUSH_SNOWBALL_LEVEL_UNLOCK .. arg_35_0.modelType_, 0)
	end
end

function var_0_0.IsActiveTime(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_1.startTime
	local var_36_1 = arg_36_1.stopTime

	if var_36_0 > manager.time:GetServerTime() then
		local var_36_2 = GetTips("OPEN_TIME")

		ShowTips(string.format(var_36_2, manager.time:GetLostTimeStr2(var_36_0, nil, true)))

		return false
	end

	if var_36_1 <= manager.time:GetServerTime() then
		ShowTips("TIME_OVER")

		return false
	end

	return true
end

function var_0_0.IsActiveTimeWithoutTips(arg_37_0, arg_37_1)
	local var_37_0 = arg_37_1.startTime
	local var_37_1 = arg_37_1.stopTime

	if var_37_0 > manager.time:GetServerTime() then
		return false
	end

	if var_37_1 <= manager.time:GetServerTime() then
		return false
	end

	return true
end

function var_0_0.OnExit(arg_38_0)
	manager.windowBar:HideBar()

	if arg_38_0.timer_ then
		arg_38_0.timer_:Stop()

		arg_38_0.timer_ = nil
	end

	manager.redPoint:unbindUIandKey(arg_38_0.rewardBtn_.transform, RedPointConst.ACTIVITY_PUSH_SNOWBALL_SINGLE_SCORE)
	manager.redPoint:unbindUIandKey(arg_38_0.deviceBtn_.transform, RedPointConst.ACTIVITY_PUSH_SNOWBALL_DEVICE_UNLOCK)

	if arg_38_0.modelType_ then
		manager.redPoint:unbindUIandKey(arg_38_0.hardLevelBtn_.transform, RedPointConst.ACTIVITY_PUSH_SNOWBALL_LEVEL_UNLOCK .. arg_38_0.modelType_)
	end

	manager.redPoint:unbindUIandKey(arg_38_0.scoreModelBtn_.transform, RedPointConst.ACTIVITY_PUSH_SNOWBALL_LEVEL_UNLOCK .. 1)
	manager.redPoint:unbindUIandKey(arg_38_0.bowlingModelBtn_.transform, RedPointConst.ACTIVITY_PUSH_SNOWBALL_LEVEL_UNLOCK .. 2)
	manager.redPoint:unbindUIandKey(arg_38_0.bossModelBtn_.transform, RedPointConst.ACTIVITY_PUSH_SNOWBALL_LEVEL_UNLOCK .. 3)
	manager.redPoint:unbindUIandKey(arg_38_0.commonItemGo_.transform, RedPointConst.ACTIVITY_PUSH_SNOWBALL_SINGLE_REWARD)
end

function var_0_0.OnTop(arg_39_0)
	arg_39_0:SetWindowBar()
	arg_39_0:RefreshUI()
end

function var_0_0.OnBehind(arg_40_0)
	manager.windowBar:HideBar()
end

function var_0_0.AddTimer(arg_41_0)
	local var_41_0 = ActivityData:GetActivityData(arg_41_0.activityID_).stopTime
	local var_41_1
	local var_41_2

	arg_41_0.leftTimeText_.text = manager.time:GetLostTimeStr2(var_41_0, nil, true)

	if arg_41_0.taskLeftTimeText_ then
		var_41_2 = ActivityData:GetActivityData(AssignmentCfg[arg_41_0.weeklyTaskID].activity_id).stopTime
		arg_41_0.taskLeftTimeText_.text = manager.time:GetLostTimeStr2(var_41_2, nil, true)
	end

	local var_41_3 = PushSnowBallData:GetRefreshTimeStamp()

	arg_41_0.timer_ = Timer.New(function()
		if manager.time:GetServerTime() > var_41_0 then
			return
		end

		arg_41_0:RefreshLockState()

		for iter_42_0, iter_42_1 in ipairs(var_41_3) do
			if manager.time:GetServerTime() == iter_42_1 then
				arg_41_0:RefreshTaskList()
			end
		end

		arg_41_0.leftTimeText_.text = manager.time:GetLostTimeStr2(var_41_0, nil, true)

		if arg_41_0.taskLeftTimeText_ then
			arg_41_0.taskLeftTimeText_.text = manager.time:GetLostTimeStr2(var_41_2, nil, true)
		end
	end, 1, -1)

	arg_41_0.timer_:Start()
end

function var_0_0.Dispose(arg_43_0)
	for iter_43_0, iter_43_1 in ipairs(arg_43_0.taskItemList_) do
		iter_43_1:Dispose()
	end

	arg_43_0.taskItemList_ = nil

	if arg_43_0.commonItem_ then
		arg_43_0.commonItem_:Dispose()

		arg_43_0.commonItem_ = nil
	end

	var_0_0.super.Dispose(arg_43_0)
end

return var_0_0
