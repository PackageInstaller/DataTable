local PushTheSnowBallHomeView = class("PushTheSnowBallHomeView", PushSnowBallSingleView)
local var_0_1 = {
	SURVIVAL = 2,
	BOSS = 1
}

function PushTheSnowBallHomeView:UIName()
	return "UI/VersionUI/IndiaUI_2_8/IndiaPushTheSnowballUI/PushTheSnowballTeamModeUI"
end

function PushTheSnowBallHomeView:UIParent()
	return manager.ui.uiMain.transform
end

function PushTheSnowBallHomeView:Init()
	self:InitUI()
	self:AddUIListener()
	self:BindController()

	self.taskItemList_ = {}

	for iter_3_0 = 1, 4 do
		table.insert(self.taskItemList_, (PushSnowBallTeamWinTaskItem.New(self["weeklyTaskItem" .. iter_3_0])))
	end
end

function PushTheSnowBallHomeView:BindController()
	self.rewardController_ = ControllerUtil.GetController(self.transform_, "dailyRewardState")
	self.modelSelectControllerList_ = {}
	self.survivalSelectController_ = ControllerUtil.GetController(self.survivalModelBtn_.transform, "select")
	self.bossSelectController_ = ControllerUtil.GetController(self.bossModelBtn_.transform, "select")

	table.insert(self.modelSelectControllerList_, self.bossSelectController_)
	table.insert(self.modelSelectControllerList_, self.survivalSelectController_)
end

function PushTheSnowBallHomeView:AddUIListener()
	self:AddBtnListener(self.heroBtn_, nil, function()
		JumpTools.OpenPageByJump("pushSnowBallHeroChangePop", {
			type = 2
		})
	end)
	self:AddBtnListener(self.rankBtn_, nil, function()
		JumpTools.OpenPageByJump("pushSnowBallRank")
	end)
	self:AddBtnListener(self.touchHeroBtn_, nil, function()
		self:OnTouchHero()
	end)
	self:AddBtnListener(self.modelDescBtn_, nil, function()
		local var_9_0 = GetTips(PushSnowBallData:GetTeamDescTipsByModelAndSubModel(self.modelType_))

		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = var_9_0,
			key = var_9_0
		})
	end)
	self:AddBtnListener(self.survivalModelBtn_, nil, function()
		self:SelectModel(var_0_1.SURVIVAL)
	end)
	self:AddBtnListener(self.bossModelBtn_, nil, function()
		self:SelectModel(var_0_1.BOSS)
	end)
	self:AddBtnListener(self.startBtn_, nil, function()
		local var_12_0 = PushSnowBallData:GetSelectedBattleModelID()
		local var_12_1 = PushSnowBallData:GetTeamModelActivityIDByModel(self.modelType_)

		PushSnowBallAction.SendStartMatching(PushSnowBallCfg[PushSnowBallCfg.get_id_list_by_activityId[var_12_1][1]].stageId, PushSnowBallCfg[PushSnowBallCfg.get_id_list_by_activityId[var_12_1][1]].mode == 4 and BattleConst.STAGE_TYPE_NEW.PUSH_SNOWBALL_TEAM_BOSS or BattleConst.STAGE_TYPE_NEW.PUSH_SNOWBALL_TEAM_SURVIVAL, var_12_0, var_12_1)
	end)
	self:AddBtnListener(self.dailyRewardBtn_, nil, function()
		JumpTools.OpenPageByJump("pushSnowBallTeamTaskPop")
	end)
end

function PushTheSnowBallHomeView:OnEnter()
	self.modelType_ = _G.PushSnowBallTeamMode or 2
	self.activityID_ = PushSnowBallData:GetTeamActivityID()

	self:AddTimer()
	self:RefreshUI()
	self:SetWindowBar()
	self:SelectModel(_G["pushSnowBallModel" .. self.activityID_] or self.modelType_ or 1)
	manager.redPoint:bindUIandKey(self.dailyRewardBtn_.transform, RedPointConst.ACTIVITY_PUSH_SNOWBALL_TEAM_PARTICIPATE)
end

function PushTheSnowBallHomeView:OnTop()
	self:SetWindowBar()
	self:RefreshUI()
end

function PushTheSnowBallHomeView:OnTaskListChange()
	self:RefreshUI()
end

function PushTheSnowBallHomeView:OnExit()
	manager.windowBar:HideBar()

	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end

	manager.redPoint:unbindUIandKey(self.dailyRewardBtn_.transform, RedPointConst.ACTIVITY_PUSH_SNOWBALL_TEAM_PARTICIPATE)
end

function PushTheSnowBallHomeView:RefreshUI()
	self:RefreshTaskList()
	self:RefreshHeroIcon()
end

function PushTheSnowBallHomeView:RefreshTaskList()
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
			SetActive(self.taskItemList_[iter_19_2].gameObject, false)
		end
	else
		for iter_19_3 = 4, 1, -1 do
			self.taskItemList_[iter_19_3]:SetData(iter_19_3, var_19_1[iter_19_3])
		end
	end

	self.dailyTaskScoreText_.text = PushSnowBallData:GetCompeletedTeamTaskNum() .. "<color=#86443C>/" .. #PushSnowBallData:GetTeamParticipateTaskList() .. "</color>"

	if not PushSnowBallData:GetHasCompeletedTeamTask() then
		self.rewardController_:SetSelectedState("uncomplete")
	elseif not PushSnowBallData:GetHasAllRewardedTeamTask() then
		self.rewardController_:SetSelectedState("unreceive")
	else
		self.rewardController_:SetSelectedState("received")
	end
end

function PushTheSnowBallHomeView:SelectModel(arg_21_1)
	if not self:IsActiveTime((ActivityData:GetActivityData((PushSnowBallData:GetTeamModelActivityIDByModel(arg_21_1))))) then
		return
	end

	self.modelType_ = arg_21_1
	_G.PushSnowBallTeamMode = arg_21_1

	for iter_21_0, iter_21_1 in ipairs(self.modelSelectControllerList_) do
		iter_21_1:SetSelectedState(tostring(iter_21_0 == arg_21_1))
	end
end

function PushTheSnowBallHomeView:AddTimer()
	local var_22_0 = ActivityData:GetActivityData(self.activityID_).stopTime

	self.leftTimeText_.text = manager.time:GetLostTimeStr2(var_22_0, nil, true)
	self.timer_ = Timer.New(function()
		if manager.time:GetServerTime() > var_22_0 then
			return
		end

		self.leftTimeText_.text = manager.time:GetLostTimeStr2(var_22_0, nil, true)
	end, 1, -1)

	self.timer_:Start()
end

return PushTheSnowBallHomeView
