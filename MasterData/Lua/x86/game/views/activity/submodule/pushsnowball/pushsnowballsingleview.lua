local PushTheSnowBallSingleView = class("PushTheSnowBallSingleView", ReduxView)
local var_0_1 = {
	BOSS = 3,
	SCORE = 1,
	BOWLING = 2
}
local var_0_2 = {
	NORMAL = 1,
	HARD = 2
}

function PushTheSnowBallSingleView:UIName()
	return "UI/VersionUI/IndiaUI_2_8/IndiaPushTheSnowballUI/PushTheSnowballSingleModeUI"
end

function PushTheSnowBallSingleView:UIParent()
	return manager.ui.uiMain.transform
end

function PushTheSnowBallSingleView:Init()
	self:InitUI()
	self:AddUIListener()
	self:BindController()

	self.taskItemList_ = {}

	for iter_3_0 = 1, 3 do
		table.insert(self.taskItemList_, (PushSnowBallWeeklyTaskItem.New(self["weeklyTaskItem" .. iter_3_0])))
	end

	self.commonItem_ = CommonItem.New(self.commonItemGo_)
end

function PushTheSnowBallSingleView:BindController()
	self.deviceController_ = ControllerUtil.GetController(self.deviceBtn_.transform, "equipped")
	self.rewardController_ = ControllerUtil.GetController(self.weeklyTaskTrs_, "state")
	self.modelSelectControllerList_ = {}
	self.modelLockControllerList_ = {}
	self.scoreSelectController_ = ControllerUtil.GetController(self.scoreModelBtn_.transform, "select")
	self.bowlingSelectController_ = ControllerUtil.GetController(self.bowlingModelBtn_.transform, "select")
	self.bossSelectController_ = ControllerUtil.GetController(self.bossModelBtn_.transform, "select")
	self.bowlingLockController_ = ControllerUtil.GetController(self.bowlingModelBtn_.transform, "lock")
	self.bossLockController_ = ControllerUtil.GetController(self.bossModelBtn_.transform, "lock")

	table.insert(self.modelSelectControllerList_, self.scoreSelectController_)
	table.insert(self.modelSelectControllerList_, self.bowlingSelectController_)
	table.insert(self.modelSelectControllerList_, self.bossSelectController_)
	table.insert(self.modelLockControllerList_, self.bowlingLockController_)
	table.insert(self.modelLockControllerList_, self.bossLockController_)

	self.levelSelectControllerList_ = {}
	self.normalSelectController_ = ControllerUtil.GetController(self.normalLevelBtn_.transform, "select")
	self.hardSelectController_ = ControllerUtil.GetController(self.hardLevelBtn_.transform, "select")
	self.hardLockController_ = ControllerUtil.GetController(self.hardLevelBtn_.transform, "lockByTime")
	self.normalLevelImgController_ = ControllerUtil.GetController(self.normalLevelBtn_.transform, "type")
	self.hardlLevelImgController_ = ControllerUtil.GetController(self.hardLevelBtn_.transform, "type")

	table.insert(self.levelSelectControllerList_, self.normalSelectController_)
	table.insert(self.levelSelectControllerList_, self.hardSelectController_)
end

function PushTheSnowBallSingleView:InitUI()
	self:BindCfgUI()
end

function PushTheSnowBallSingleView:AddUIListener()
	self:AddBtnListener(self.heroBtn_, nil, function()
		JumpTools.OpenPageByJump("pushSnowBallHeroChangePop", {
			type = 1
		})
	end)
	self:AddBtnListener(self.deviceBtn_, nil, function()
		JumpTools.OpenPageByJump("pushSnowBallDevicePop")
	end)
	self:AddBtnListener(self.weeklyTaskRewardBtn_, nil, function()
		TaskAction:SubmitTaskList({
			self.weeklyTaskID
		})
	end)
	self:AddBtnListener(self.touchHeroBtn_, nil, function()
		self:OnTouchHero()
	end)
	self:AddBtnListener(self.scoreModelBtn_, nil, function()
		self:SelectModel(var_0_1.SCORE)
	end)
	self:AddBtnListener(self.bowlingModelBtn_, nil, function()
		self:SelectModel(var_0_1.BOWLING)
	end)
	self:AddBtnListener(self.bossModelBtn_, nil, function()
		self:SelectModel(var_0_1.BOSS)
	end)
	self:AddBtnListener(self.modelDescBtn_, nil, function()
		local var_14_1 = GetTips(PushSnowBallData:GetSingleDescTipsByModelAndSubModel(self.modelType_ or 1))

		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = var_14_1,
			key = var_14_1
		})
	end)
	self:AddBtnListener(self.normalLevelBtn_, nil, function()
		self:SelectLevel(var_0_2.NORMAL)
	end)
	self:AddBtnListener(self.hardLevelBtn_, nil, function()
		self:SelectLevel(var_0_2.HARD)
	end)
	self:AddBtnListener(self.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("pushSnowBallReward")
	end)
	self:AddBtnListener(self.startBtn_, nil, function()
		local var_18_0 = PushSnowBallData:GetSingleModelActivityIDByModelAndLevel(self.modelType_, self.levelType_)

		BattleController.GetInstance():LaunchBattle((BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.PUSH_SNOWBALL_SINGLE, PushSnowBallCfg[PushSnowBallCfg.get_id_list_by_activityId[var_18_0][1]].stageId, {
			activityID = var_18_0
		})))
	end)
end

function PushTheSnowBallSingleView:OnEnter()
	self.activityID_ = PushSnowBallData:GetSingleActivityID()

	self:SelectModel(_G["pushSnowBallModel" .. self.activityID_] or self.modelType_ or var_0_1.SCORE)
	self:SetWindowBar()
	self:RefreshUI()
	self:AddTimer()
	manager.redPoint:bindUIandKey(self.rewardBtn_.transform, RedPointConst.ACTIVITY_PUSH_SNOWBALL_SINGLE_SCORE)
	manager.redPoint:bindUIandKey(self.deviceBtn_.transform, RedPointConst.ACTIVITY_PUSH_SNOWBALL_DEVICE_UNLOCK)
	manager.redPoint:bindUIandKey(self.scoreModelBtn_.transform, RedPointConst.ACTIVITY_PUSH_SNOWBALL_LEVEL_UNLOCK .. 1)
	manager.redPoint:bindUIandKey(self.bowlingModelBtn_.transform, RedPointConst.ACTIVITY_PUSH_SNOWBALL_LEVEL_UNLOCK .. 2)
	manager.redPoint:bindUIandKey(self.bossModelBtn_.transform, RedPointConst.ACTIVITY_PUSH_SNOWBALL_LEVEL_UNLOCK .. 3)
	manager.redPoint:bindUIandKey(self.commonItemGo_.transform, RedPointConst.ACTIVITY_PUSH_SNOWBALL_SINGLE_REWARD)
end

function PushTheSnowBallSingleView:SetWindowBar()
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

function PushTheSnowBallSingleView:OnTouchHero()
	local var_23_0 = PushSnowBallGameMgr.GetInstance():GetPlayerEID()

	Dorm.DormEntityManager.SendInteractToEntityCMD(var_23_0, var_23_0, DormHeroTemplate.PickInteractAction(GameDisplayCfg.dorm_interaction_stroke.value), false)
	SDKTools.SendMessageToSDK("backhome_dorm_stroke", {
		hero_id = PushSnowBallData:GetSelectedHeroID(),
		activity_id = PushSnowBallData:GetActivityID()
	})
end

function PushTheSnowBallSingleView:GetWeeklyTaskList()
	return PushSnowBallData:GetWeeklyTaskList() or {}
end

function PushTheSnowBallSingleView:RefreshUI()
	self:RefreshTaskList()
	self:RefreshHeroIcon()
	self:RefreshDeviceIcon()
	self:RefreshLockState()
end

function PushTheSnowBallSingleView:RefreshTaskList()
	local var_26_0 = self:GetWeeklyTaskList() or {}
	local var_26_1 = {}

	for iter_26_0, iter_26_1 in pairs(var_26_0) do
		table.insert(var_26_1, iter_26_1)
	end

	table.sort(var_26_1, function(arg_27_0, arg_27_1)
		return arg_27_0.id < arg_27_1.id
	end)

	if table.isEmpty(var_26_0) then
		for iter_26_2 = 1, 3 do
			SetActive(self.taskItemList_[iter_26_2].gameObject, false)
		end
	else
		self:RefreshWeeklyTask()

		for iter_26_3 = 1, 3 do
			self.taskItemList_[iter_26_3]:SetData(iter_26_3, var_26_1[iter_26_3 + 1])
		end
	end
end

function PushTheSnowBallSingleView:RefreshWeeklyTask()
	local var_28_0 = {}

	for iter_28_0, iter_28_1 in pairs((self:GetWeeklyTaskList())) do
		table.insert(var_28_0, iter_28_1)
	end

	table.sort(var_28_0, function(arg_29_0, arg_29_1)
		return arg_29_0.id < arg_29_1.id
	end)

	self.weeklyTaskID = var_28_0[1].id

	local var_28_2 = AssignmentCfg[self.weeklyTaskID].reward

	self.commonItem_:RefreshData({
		id = AssignmentCfg[self.weeklyTaskID].reward[1][1],
		number = AssignmentCfg[self.weeklyTaskID].reward[1][2]
	})
	self.commonItem_:RegistCallBack(function()
		ShowPopItem(POP_ITEM, {
			var_28_2[1][1]
		})
	end)

	self.taskNumText_.text = var_28_0[1].progress .. "/" .. AssignmentCfg[self.weeklyTaskID].need

	local var_28_3 = TaskData2:GetTaskComplete(self.weeklyTaskID)

	if AssignmentCfg[self.weeklyTaskID].need > var_28_0[1].progress then
		self.rewardController_:SetSelectedState("unfinished")
	elseif not var_28_3 then
		self.rewardController_:SetSelectedState("complete")
	else
		self.rewardController_:SetSelectedState("rewarded")
	end
end

function PushTheSnowBallSingleView:RefreshHeroIcon()
	self.heroIconImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/BackHouseUI/RoleHead/" .. PushSnowBallData:GetSelectedHeroID())
end

function PushTheSnowBallSingleView:RefreshDeviceIcon()
	local var_32_0 = PushSnowBallData:GetSelectedDeviceID()

	self.deviceController_:SetSelectedState(tostring(var_32_0 ~= 0))

	if var_32_0 ~= 0 then
		self.deviceIconImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Item_l" .. PushSnowBallDeviceCfg[PushSnowBallData:GetSelectedDeviceID()].icon)
	end
end

function PushTheSnowBallSingleView:RefreshLockState()
	for iter_33_0 = 2, 3 do
		if not self:IsActiveTimeWithoutTips((ActivityData:GetActivityData((PushSnowBallData:GetSingleModelActivityIDByModelAndLevel(iter_33_0, 1))))) then
			self.modelLockControllerList_[iter_33_0 - 1]:SetSelectedState("true")
		else
			self.modelLockControllerList_[iter_33_0 - 1]:SetSelectedState("false")
		end
	end

	local var_33_0 = ActivityData:GetActivityData((PushSnowBallData:GetSingleModelActivityIDByModelAndLevel(self.modelType_ or 1, 2)))

	if not self:IsActiveTimeWithoutTips(var_33_0) then
		self.hardLockController_:SetSelectedState("true")

		self.lockText_.text = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr2(var_33_0.startTime, nil, true))
	else
		self.hardLockController_:SetSelectedState("false")
	end
end

function PushTheSnowBallSingleView:SelectModel(arg_34_1)
	if not self:IsActiveTime((ActivityData:GetActivityData((PushSnowBallData:GetSingleModelActivityIDByModelAndLevel(arg_34_1, 1))))) then
		return
	end

	if self.modelType_ then
		manager.redPoint:unbindUIandKey(self.hardLevelBtn_.transform, RedPointConst.ACTIVITY_PUSH_SNOWBALL_LEVEL_UNLOCK .. self.modelType_)
	end

	manager.redPoint:bindUIandKey(self.hardLevelBtn_.transform, RedPointConst.ACTIVITY_PUSH_SNOWBALL_LEVEL_UNLOCK .. arg_34_1)

	self.modelType_ = arg_34_1

	for iter_34_0, iter_34_1 in ipairs(self.modelSelectControllerList_) do
		iter_34_1:SetSelectedState(tostring(iter_34_0 == arg_34_1))
	end

	self.normalLevelImgController_:SetSelectedState(arg_34_1)
	self.hardlLevelImgController_:SetSelectedState(arg_34_1)

	self.modelNameText_.text = GetTips("ACTIVITY_SNOWBALL_PUSH_SINGLE_MOD_" .. self.modelType_)
	_G["pushSnowBallModel" .. self.activityID_] = self.modelType_
	self.levelType_ = _G["pushSnowBallLevel" .. self.modelType_ .. self.activityID_] or 1

	self:SelectLevel(self.levelType_)
	self.levelAni_:Play("Fx_panelItem_cx 1", 0, 0)
	self.levelAni_:Update(0)
end

function PushTheSnowBallSingleView:SelectLevel(arg_35_1)
	if not self:IsActiveTime((ActivityData:GetActivityData((PushSnowBallData:GetSingleModelActivityIDByModelAndLevel(self.modelType_, arg_35_1))))) then
		return
	end

	self.levelType_ = arg_35_1
	_G["pushSnowBallLevel" .. self.modelType_ .. self.activityID_] = arg_35_1

	for iter_35_0, iter_35_1 in ipairs(self.levelSelectControllerList_) do
		iter_35_1:SetSelectedState(tostring(iter_35_0 == arg_35_1))
	end

	self:RefreshLockState()
	saveData("PushSnowBall", "Level" .. self.modelType_ .. PlayerData:GetPlayerInfo().userID, true)

	if arg_35_1 == 2 then
		manager.redPoint:setTip(RedPointConst.ACTIVITY_PUSH_SNOWBALL_LEVEL_UNLOCK .. self.modelType_, 0)
	end
end

function PushTheSnowBallSingleView:IsActiveTime(arg_36_1)
	if arg_36_1.startTime > manager.time:GetServerTime() then
		ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr2(arg_36_1.startTime, nil, true)))

		return false
	end

	if arg_36_1.stopTime <= manager.time:GetServerTime() then
		ShowTips("TIME_OVER")

		return false
	end

	return true
end

function PushTheSnowBallSingleView:IsActiveTimeWithoutTips(arg_37_1)
	if arg_37_1.startTime > manager.time:GetServerTime() then
		return false
	end

	if arg_37_1.stopTime <= manager.time:GetServerTime() then
		return false
	end

	return true
end

function PushTheSnowBallSingleView:OnExit()
	manager.windowBar:HideBar()

	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end

	manager.redPoint:unbindUIandKey(self.rewardBtn_.transform, RedPointConst.ACTIVITY_PUSH_SNOWBALL_SINGLE_SCORE)
	manager.redPoint:unbindUIandKey(self.deviceBtn_.transform, RedPointConst.ACTIVITY_PUSH_SNOWBALL_DEVICE_UNLOCK)

	if self.modelType_ then
		manager.redPoint:unbindUIandKey(self.hardLevelBtn_.transform, RedPointConst.ACTIVITY_PUSH_SNOWBALL_LEVEL_UNLOCK .. self.modelType_)
	end

	manager.redPoint:unbindUIandKey(self.scoreModelBtn_.transform, RedPointConst.ACTIVITY_PUSH_SNOWBALL_LEVEL_UNLOCK .. 1)
	manager.redPoint:unbindUIandKey(self.bowlingModelBtn_.transform, RedPointConst.ACTIVITY_PUSH_SNOWBALL_LEVEL_UNLOCK .. 2)
	manager.redPoint:unbindUIandKey(self.bossModelBtn_.transform, RedPointConst.ACTIVITY_PUSH_SNOWBALL_LEVEL_UNLOCK .. 3)
	manager.redPoint:unbindUIandKey(self.commonItemGo_.transform, RedPointConst.ACTIVITY_PUSH_SNOWBALL_SINGLE_REWARD)
end

function PushTheSnowBallSingleView:OnTop()
	self:SetWindowBar()
	self:RefreshUI()
end

function PushTheSnowBallSingleView:OnBehind()
	manager.windowBar:HideBar()
end

function PushTheSnowBallSingleView:AddTimer()
	local var_41_0 = ActivityData:GetActivityData(self.activityID_).stopTime
	local var_41_2

	self.leftTimeText_.text = manager.time:GetLostTimeStr2(var_41_0, nil, true)

	if self.taskLeftTimeText_ then
		var_41_2 = ActivityData:GetActivityData(AssignmentCfg[self.weeklyTaskID].activity_id).stopTime
		self.taskLeftTimeText_.text = manager.time:GetLostTimeStr2(var_41_2, nil, true)
	end

	local var_41_3 = PushSnowBallData:GetRefreshTimeStamp()

	self.timer_ = Timer.New(function()
		if manager.time:GetServerTime() > var_41_0 then
			return
		end

		self:RefreshLockState()

		for iter_42_0, iter_42_1 in ipairs(var_41_3) do
			if manager.time:GetServerTime() == iter_42_1 then
				self:RefreshTaskList()
			end
		end

		self.leftTimeText_.text = manager.time:GetLostTimeStr2(var_41_0, nil, true)

		if self.taskLeftTimeText_ then
			self.taskLeftTimeText_.text = manager.time:GetLostTimeStr2(var_41_2, nil, true)
		end
	end, 1, -1)

	self.timer_:Start()
end

function PushTheSnowBallSingleView:Dispose()
	for iter_43_0, iter_43_1 in ipairs(self.taskItemList_) do
		iter_43_1:Dispose()
	end

	self.taskItemList_ = nil

	if self.commonItem_ then
		self.commonItem_:Dispose()

		self.commonItem_ = nil
	end

	PushTheSnowBallSingleView.super.Dispose(self)
end

return PushTheSnowBallSingleView
