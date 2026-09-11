local WaterPipeGameStageView = class("WaterPipeGameStageView", ReduxView)

function WaterPipeGameStageView:UIName()
	return "Widget/Version/BaichaoUI_3_9/BaichaoUI_3_9_WaterPipeUI/WaterPipeGameStageView"
end

function WaterPipeGameStageView:UIParent()
	return manager.ui.uiMain.transform
end

function WaterPipeGameStageView:Init()
	self:InitUI()
end

function WaterPipeGameStageView:InitUI()
	self:BindCfgUI()

	self.eventItemList = {}
end

function WaterPipeGameStageView:SendSDK(arg_5_1)
	local var_5_1 = "["
	local var_5_2 = 0

	for iter_5_0, iter_5_1 in pairs(self.eventDataList) do
		local var_5_3 = iter_5_1:GetSDKStr()

		if var_5_3 then
			var_5_1 = var_5_2 == 0 and string.format("%s%s", var_5_1, var_5_3) or string.format("%s,%s", var_5_1, var_5_3)
			var_5_2 = var_5_2 + 1
		end
	end

	SDKTools.SendMessageToSDK("activity_combat_over", {
		activity_id = WaterPipeData:GetMainActivityID(),
		stage_id = self.stageID,
		result = arg_5_1 and 1 or 3,
		use_seconds = math.floor(WaterPipeBrige.GetUseTimes() + 0.5),
		other_data = var_5_1 .. "]"
	})
end

function WaterPipeGameStageView:AddEventListeners()
	self:RegistEventListener(WATER_PIPE_EVENT_INIT, function(arg_7_0)
		self:InitWaterPipeTaskList(arg_7_0)
	end)
	self:RegistEventListener(WATER_PIPE_EVENT_UPDATE, function(arg_8_0)
		self:UpdateWaterPipeTaskList(arg_8_0)
	end)
	self:RegistEventListener(WATER_PIPE_GAME_SETTLE, function()
		self:SettleWaterPipe()
	end)
	self:RegistEventListener(WATER_PIPE_GAME_PERFORMANCE, function()
		self:OnOpenPerformance()
	end)
end

function WaterPipeGameStageView:OnOpenPerformance()
	self.isOpenPerformance = true

	self:AddPerformancePopTimer()
end

function WaterPipeGameStageView:StopPerformancePopTimer()
	if self.performanceTimer then
		self.performanceTimer:Stop()

		self.performanceTimer = nil
	end
end

function WaterPipeGameStageView:AddPerformancePopTimer()
	self:StopPerformancePopTimer()
	SetActive(self.routeplanningGo_, true)

	self.performanceTimer = Timer.New(function()
		if self.routeplanningAni_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 then
			SetActive(self.routeplanningGo_, false)
			WaterPipeBrige.PlayHeroBeginMove()
			self:StopPerformancePopTimer()
		end
	end, 1, -1)

	self.performanceTimer:Start()
end

function WaterPipeGameStageView:SettleWaterPipe()
	local var_15_0 = ActivityData:GetActivityData(ActivityWaterPipeStageCfg[self.stageID].activity_id)

	if not var_15_0 or not var_15_0:IsActivitying() then
		ShowTips("TIME_OVER")
		self:Back()

		return
	end

	self:SendSDK(true)
	WaterPipeAction:FinishWaterPipeStage(self.stageID, WaterPipeData:GetMainActivityID(), WaterPipeBrige.GetUseTimes(), function()
		JumpTools.OpenPageByJump("waterPipeLetterPopView", {
			isSettle = true,
			stageID = self.stageID,
			closeCallback = function()
				JumpTools.OpenPageByJump("/waterPipeSelectView", {
					finishStageID = self.stageID
				})
			end
		})
	end)
end

function WaterPipeGameStageView:InitWaterPipeTaskList(arg_18_1)
	for iter_18_0, iter_18_1 in pairs(self.eventItemList) do
		SetActive(iter_18_1.gameObject_, false)
	end

	self.eventDataList = {}

	for iter_18_2 = 0, arg_18_1.Length - 1 do
		if arg_18_1[iter_18_2] and arg_18_1[iter_18_2] > 0 then
			local var_18_0 = self.eventItemList[1]

			if not self.eventItemList[1] then
				var_18_0 = self:CreateEventItem()

				table.insert(self.eventItemList, var_18_0)
			end

			SetActive(var_18_0.gameObject_, true)
			var_18_0:RefreshUI(arg_18_1[iter_18_2])

			self.eventDataList[iter_18_2] = var_18_0
		end
	end

	if ActivityWaterPipeStageCfg[self.stageID].event_sort and #ActivityWaterPipeStageCfg[self.stageID].event_sort > 0 then
		for iter_18_3, iter_18_4 in pairs(self.eventItemList) do
			local var_18_2 = table.indexof(ActivityWaterPipeStageCfg[self.stageID].event_sort, (iter_18_4:GetEventID()))

			if var_18_2 then
				iter_18_4:SetOrder(var_18_2)
			end
		end

		for iter_18_5, iter_18_6 in pairs(self.eventItemList) do
			iter_18_6:SetSiblingIndex()
		end

		for iter_18_7, iter_18_8 in pairs(self.eventItemList) do
			iter_18_8:SetSiblingIndex()
		end
	end
end

function WaterPipeGameStageView:UpdateWaterPipeTaskList(arg_19_1)
	for iter_19_0 = 0, arg_19_1.Length - 1 do
		if self.eventDataList[iter_19_0] then
			self.eventDataList[iter_19_0]:ChangeState(arg_19_1[iter_19_0])
		end
	end
end

function WaterPipeGameStageView:CreateEventItem()
	return WaterPipeGameEventItem.New((GameObject.Instantiate(self.eventItemGo_, self.eventlistTrs_)))
end

function WaterPipeGameStageView:OnEnter()
	self:AddEventListeners()

	local var_21_0 = self.params_.stageID or 1

	self.isOpenPerformance = false

	SetActive(self.routeplanningGo_, false)

	self.stageID = var_21_0
	self.titleText_.text = ActivityWaterPipeStageCfg[var_21_0].stage_title

	WaterPipeBrige.StartGame(ActivityWaterPipeStageCfg[var_21_0].stage_id, ActivityWaterPipeStageCfg[var_21_0].event_sort, self.stageGo_)

	self.routeTxt_.text = GetTips("ACTIVITY_WATER_PIPE_FINISH_TIP")
end

function WaterPipeGameStageView:OnExit()
	self:StopPerformancePopTimer()
	WaterPipeBrige.ExitGame()
	self:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function WaterPipeGameStageView:OnTop()
	self:RefreshBar()
end

function WaterPipeGameStageView:RefreshBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		INFO_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		if self.isOpenPerformance then
			return
		end

		ShowMessageBox({
			content = GetTips("ACTIVITY_WATER_PIPE_END"),
			OkCallback = function()
				self:SendSDK(false)
				self:Back()
			end
		})
	end)

	if GameSetting.new_year_water_pipe_describe then
		local var_24_0 = GameSetting.new_year_water_pipe_describe.value or {}

		if not getData(string.format("water_pipe_%s", WaterPipeData:GetMainActivityID()), "first") then
			JumpTools.OpenPageByJump("gameHelpPro", {
				isPrefab = true,
				pages = var_24_0
			})
			saveData(string.format("water_pipe_%s", WaterPipeData:GetMainActivityID()), "first", true)
		end
	end

	manager.windowBar:RegistInfoCallBack(function()
		if self.isOpenPerformance then
			return
		end

		JumpTools.OpenPageByJump("gameHelpPro", {
			isPrefab = true,
			pages = var_24_0
		})
	end)
end

function WaterPipeGameStageView:Dispose()
	WaterPipeBrige.DisposeGame()

	for iter_28_0, iter_28_1 in pairs(self.eventItemList) do
		if iter_28_1 then
			iter_28_1:Dispose()

			iter_28_1 = nil
		end
	end

	WaterPipeGameStageView.super.Dispose(self)
end

return WaterPipeGameStageView
