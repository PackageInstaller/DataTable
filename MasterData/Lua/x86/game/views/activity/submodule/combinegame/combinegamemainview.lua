local CombineGameMainView = class("CombineGameMainView", ReduxView)

function CombineGameMainView:UIName()
	return "UI/VersionUI/IndiaUI_2_8/IndiaKf/IndiaKfModeUI_2"
end

function CombineGameMainView:UIParent()
	return manager.ui.uiMain.transform
end

function CombineGameMainView:Init()
	self:InitUI()
	self:AddUIListener()
end

function CombineGameMainView:InitUI()
	self:BindCfgUI()

	self.dailyController = ControllerUtil.GetController(self.dailyGo_.transform, "daily")
	self.endlessController = ControllerUtil.GetController(self.endlessGo_.transform, "endless")
	self.rewardController = ControllerUtil.GetController(self.dailyGo_.transform, "reward")
end

function CombineGameMainView:AddUIListener()
	self:AddBtnListener(self.poolBtn_, nil, function()
		JumpTools.GoToSystem("/CombineGamePoolView")
	end)
	self:AddBtnListener(self.taskBtn_, nil, function()
		JumpTools.GoToSystem("CombineGameTaskView")
	end)
	self:AddBtnListener(self.factorBtn_, nil, function()
		JumpTools.GoToSystem("CombineGameWatchFactorView", {
			id = self.endlessId
		})
	end)
	self:AddBtnListener(self.roleBtn_, nil, function()
		JumpTools.GoToSystem("CombineGameRoleView", {
			lv = 999
		})
	end)
	self:AddBtnListener(self.tutorialBtn_, nil, function()
		JumpTools.GoToSystem("/CombineGameTeachView")
	end)
	self:AddBtnListener(self.dailyBtn_, nil, function()
		if self.isLock then
			ShowTips(string.format(GetTips("ACTIVITY_COMBINE_GAME_OPEN_LIMIT_TIPS"), GetI18NText(ActivityCombineLevelCfg[self.idList[1]].name)))

			return
		end

		JumpTools.GoToSystem("/CombineGameDailyView")
	end)
	self:AddBtnListener(self.endlessBtn_, nil, function()
		if self.isLock then
			ShowTips(string.format(GetTips("ACTIVITY_COMBINE_GAME_OPEN_LIMIT_TIPS"), GetI18NText(ActivityCombineLevelCfg[self.idList[1]].name)))

			return
		end

		JumpTools.GoToSystem("/CombineGameEndlessView")
	end)
	self:AddBtnListener(self.tipsBtn_, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("ACTIVITY_COMBINE_GAME_DESC")
		})
	end)
end

function CombineGameMainView:OnEnter()
	self.activityId = CombineGameData:GetDataByPara("activityId")

	if not ActivityData:GetActivityIsOpen(self.activityId) then
		gameContext:Go("/home", nil, nil, true)
		ShowTips("TIME_OVER")

		return
	end

	self:UpdateView()
	self:BindRedPoint()
end

function CombineGameMainView:UpdateView()
	local var_15_0 = ActivityData:GetActivityData(CombineGameData:GetDataByPara("activityId"))

	self.startTime_ = var_15_0.startTime
	self.stopTime_ = var_15_0.stopTime
	self.remainTime_.text = manager.time:GetLostTimeStr2(self.stopTime_, nil, true)
	self.timer_ = Timer.New(function()
		self.remainTime_.text = manager.time:GetLostTimeStr2(self.stopTime_, nil, true)
	end, 1, -1)

	self.timer_:Start()

	self.idList = {}

	for iter_15_0, iter_15_1 in ipairs(ActivityCombineLevelCfg.all) do
		if ActivityCombineLevelCfg[iter_15_0].type == CombineGameConst.TypeConst.TEACH then
			table.insert(self.idList, iter_15_0)
		end

		if ActivityCombineLevelCfg[iter_15_0].type == CombineGameConst.TypeConst.ENDLESS then
			self.endlessId = iter_15_0
		end
	end

	local var_15_1 = CombineGameData:GetDataByPara("stageDataTable")

	self.isLock = false

	for iter_15_2, iter_15_3 in ipairs(self.idList) do
		if var_15_1[iter_15_3] ~= true then
			self.isLock = true
		end
	end

	self.id = CombineGameData:GetDataByPara("nowDay")
	self.cfg = ActivityCombineLevelCfg[self.id]

	local var_15_3 = CombineGameData:GetDataByPara("stageDataTable")[self.id]

	self.dailyController:SetSelectedState(self.isLock and "false" or "true")
	self.endlessController:SetSelectedState(self.isLock and "false" or "true")
	self.rewardController:SetSelectedState(var_15_3 and "true" or "false")

	self.techTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_MODE_NAME_1")
	self.dailyTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_MODE_NAME_2")
	self.endlessTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_MODE_NAME_3")
	self.poolTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_POOL_NAME")
	self.factorTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_FACTOR")
	self.titleName_.text = GetTips("ACTIVITY_COMBINE_GAME_NAME")
	self.titleDesc_.text = GetTips("ACTIVITY_COMBINE_GAME_CONTENT")
	self.dailyLockTxt_.text = string.format(GetTips("ACTIVITY_COMBINE_GAME_OPEN_LIMIT_TIPS"), GetI18NText(ActivityCombineLevelCfg[self.idList[1]].name))
	self.endlessLockTxt_.text = string.format(GetTips("ACTIVITY_COMBINE_GAME_OPEN_LIMIT_TIPS"), GetI18NText(ActivityCombineLevelCfg[self.idList[1]].name))
end

function CombineGameMainView:BindRedPoint()
	manager.redPoint:bindUIandKey(self.dailyBtn_.transform, string.format("%s%s_DAILY", ActivityTools.GetRedPointKey(self.activityId), self.activityId), {
		x = 360,
		y = 225
	})
	manager.redPoint:bindUIandKey(self.tutorialBtn_.transform, string.format("%s%s_TEACH", ActivityTools.GetRedPointKey(self.activityId), self.activityId), {
		x = 170,
		y = 225
	})
	manager.redPoint:bindUIandKey(self.poolBtn_.transform, RedPointConst.ACTIVITY_SPRING_COMBINE_GAME_POOL, {
		x = 110,
		y = 35
	})
	manager.redPoint:bindUIandKey(self.taskBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_TASK, ActivityConst.SPRING_FESTIVAL_ACTIVITY_V2_COMBINE_GAME_TASK), {
		x = 110,
		y = 35
	})
end

function CombineGameMainView:UnbindRedPoint()
	manager.redPoint:unbindUIandKey(self.dailyBtn_.transform, string.format("%s%s_DAILY", ActivityTools.GetRedPointKey(self.activityId), self.activityId))
	manager.redPoint:unbindUIandKey(self.tutorialBtn_.transform, string.format("%s%s_TEACH", ActivityTools.GetRedPointKey(self.activityId), self.activityId))
	manager.redPoint:unbindUIandKey(self.poolBtn_.transform, RedPointConst.ACTIVITY_SPRING_COMBINE_GAME_POOL)
	manager.redPoint:unbindUIandKey(self.taskBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_TASK, ActivityConst.SPRING_FESTIVAL_ACTIVITY_V2_COMBINE_GAME_TASK))
end

function CombineGameMainView:OnCombineGameRefresh()
	self.id = CombineGameData:GetDataByPara("nowDay")

	self:UpdateView()
end

function CombineGameMainView:OnExit()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end

	self:UnbindRedPoint()
	manager.windowBar:HideBar()
end

function CombineGameMainView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function CombineGameMainView:Dispose()
	CombineGameMainView.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return CombineGameMainView
