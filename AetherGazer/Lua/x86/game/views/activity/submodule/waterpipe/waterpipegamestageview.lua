local var_0_0 = class("WaterPipeGameStageView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/BaichaoUI_3_9/BaichaoUI_3_9_WaterPipeUI/WaterPipeGameStageView"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.eventItemList = {}
end

function var_0_0.SendSDK(arg_5_0, arg_5_1)
	local var_5_0 = ActivityWaterPipeStageCfg[arg_5_0.stageID]
	local var_5_1 = "["
	local var_5_2 = 0

	for iter_5_0, iter_5_1 in pairs(arg_5_0.eventDataList) do
		local var_5_3 = iter_5_1:GetSDKStr()

		if var_5_3 then
			if var_5_2 == 0 then
				var_5_1 = string.format("%s%s", var_5_1, var_5_3)
			else
				var_5_1 = string.format("%s,%s", var_5_1, var_5_3)
			end

			var_5_2 = var_5_2 + 1
		end
	end

	local var_5_4 = var_5_1 .. "]"

	SDKTools.SendMessageToSDK("activity_combat_over", {
		activity_id = WaterPipeData:GetMainActivityID(),
		stage_id = arg_5_0.stageID,
		result = arg_5_1 and 1 or 3,
		use_seconds = math.floor(WaterPipeBrige.GetUseTimes() + 0.5),
		other_data = var_5_4
	})
end

function var_0_0.AddEventListeners(arg_6_0)
	arg_6_0:RegistEventListener(WATER_PIPE_EVENT_INIT, function(arg_7_0)
		arg_6_0:InitWaterPipeTaskList(arg_7_0)
	end)
	arg_6_0:RegistEventListener(WATER_PIPE_EVENT_UPDATE, function(arg_8_0)
		arg_6_0:UpdateWaterPipeTaskList(arg_8_0)
	end)
	arg_6_0:RegistEventListener(WATER_PIPE_GAME_SETTLE, function()
		arg_6_0:SettleWaterPipe()
	end)
	arg_6_0:RegistEventListener(WATER_PIPE_GAME_PERFORMANCE, function()
		arg_6_0:OnOpenPerformance()
	end)
end

function var_0_0.OnOpenPerformance(arg_11_0)
	arg_11_0.isOpenPerformance = true

	arg_11_0:AddPerformancePopTimer()
end

function var_0_0.StopPerformancePopTimer(arg_12_0)
	if arg_12_0.performanceTimer then
		arg_12_0.performanceTimer:Stop()

		arg_12_0.performanceTimer = nil
	end
end

function var_0_0.AddPerformancePopTimer(arg_13_0)
	arg_13_0:StopPerformancePopTimer()
	SetActive(arg_13_0.routeplanningGo_, true)

	arg_13_0.performanceTimer = Timer.New(function()
		if arg_13_0.routeplanningAni_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 then
			SetActive(arg_13_0.routeplanningGo_, false)
			WaterPipeBrige.PlayHeroBeginMove()
			arg_13_0:StopPerformancePopTimer()
		end
	end, 1, -1)

	arg_13_0.performanceTimer:Start()
end

function var_0_0.SettleWaterPipe(arg_15_0)
	local var_15_0 = ActivityWaterPipeStageCfg[arg_15_0.stageID]
	local var_15_1 = ActivityData:GetActivityData(var_15_0.activity_id)

	if not var_15_1 or not var_15_1:IsActivitying() then
		ShowTips("TIME_OVER")
		arg_15_0:Back()

		return
	end

	arg_15_0:SendSDK(true)

	local var_15_2 = WaterPipeBrige.GetUseTimes()

	WaterPipeAction:FinishWaterPipeStage(arg_15_0.stageID, WaterPipeData:GetMainActivityID(), var_15_2, function()
		JumpTools.OpenPageByJump("waterPipeLetterPopView", {
			isSettle = true,
			stageID = arg_15_0.stageID,
			closeCallback = function()
				JumpTools.OpenPageByJump("/waterPipeSelectView", {
					finishStageID = arg_15_0.stageID
				})
			end
		})
	end)
end

function var_0_0.InitWaterPipeTaskList(arg_18_0, arg_18_1)
	local var_18_0 = 1

	for iter_18_0, iter_18_1 in pairs(arg_18_0.eventItemList) do
		SetActive(iter_18_1.gameObject_, false)
	end

	arg_18_0.eventDataList = {}

	for iter_18_2 = 0, arg_18_1.Length - 1 do
		if arg_18_1[iter_18_2] and arg_18_1[iter_18_2] > 0 then
			local var_18_1 = arg_18_0.eventItemList[var_18_0]

			if not var_18_1 then
				var_18_1 = arg_18_0:CreateEventItem()

				table.insert(arg_18_0.eventItemList, var_18_1)
			end

			var_18_0 = var_18_0 + 1

			SetActive(var_18_1.gameObject_, true)
			var_18_1:RefreshUI(arg_18_1[iter_18_2])

			arg_18_0.eventDataList[iter_18_2] = var_18_1
		end
	end

	local var_18_2 = ActivityWaterPipeStageCfg[arg_18_0.stageID].event_sort

	if var_18_2 and #var_18_2 > 0 then
		for iter_18_3, iter_18_4 in pairs(arg_18_0.eventItemList) do
			local var_18_3 = iter_18_4:GetEventID()
			local var_18_4 = table.indexof(var_18_2, var_18_3)

			if var_18_4 then
				iter_18_4:SetOrder(var_18_4)
			end
		end

		for iter_18_5, iter_18_6 in pairs(arg_18_0.eventItemList) do
			iter_18_6:SetSiblingIndex()
		end

		for iter_18_7, iter_18_8 in pairs(arg_18_0.eventItemList) do
			iter_18_8:SetSiblingIndex()
		end
	end
end

function var_0_0.UpdateWaterPipeTaskList(arg_19_0, arg_19_1)
	for iter_19_0 = 0, arg_19_1.Length - 1 do
		if arg_19_0.eventDataList[iter_19_0] then
			arg_19_0.eventDataList[iter_19_0]:ChangeState(arg_19_1[iter_19_0])
		end
	end
end

function var_0_0.CreateEventItem(arg_20_0)
	local var_20_0 = GameObject.Instantiate(arg_20_0.eventItemGo_, arg_20_0.eventlistTrs_)

	return WaterPipeGameEventItem.New(var_20_0)
end

function var_0_0.OnEnter(arg_21_0)
	arg_21_0:AddEventListeners()

	local var_21_0 = arg_21_0.params_.stageID or 1

	arg_21_0.isOpenPerformance = false

	SetActive(arg_21_0.routeplanningGo_, false)

	arg_21_0.stageID = var_21_0
	arg_21_0.titleText_.text = ActivityWaterPipeStageCfg[var_21_0].stage_title

	local var_21_1 = ActivityWaterPipeStageCfg[var_21_0].event_sort

	WaterPipeBrige.StartGame(ActivityWaterPipeStageCfg[var_21_0].stage_id, var_21_1, arg_21_0.stageGo_)

	arg_21_0.routeTxt_.text = GetTips("ACTIVITY_WATER_PIPE_FINISH_TIP")
end

function var_0_0.OnExit(arg_22_0)
	arg_22_0:StopPerformancePopTimer()
	WaterPipeBrige.ExitGame()
	arg_22_0:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function var_0_0.OnTop(arg_23_0)
	arg_23_0:RefreshBar()
end

function var_0_0.RefreshBar(arg_24_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		INFO_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		if arg_24_0.isOpenPerformance then
			return
		end

		ShowMessageBox({
			content = GetTips("ACTIVITY_WATER_PIPE_END"),
			OkCallback = function()
				arg_24_0:SendSDK(false)
				arg_24_0:Back()
			end
		})
	end)

	local var_24_0 = GameSetting.new_year_water_pipe_describe and GameSetting.new_year_water_pipe_describe.value or {}

	if not getData(string.format("water_pipe_%s", WaterPipeData:GetMainActivityID()), "first") then
		JumpTools.OpenPageByJump("gameHelpPro", {
			isPrefab = true,
			pages = var_24_0
		})
		saveData(string.format("water_pipe_%s", WaterPipeData:GetMainActivityID()), "first", true)
	end

	manager.windowBar:RegistInfoCallBack(function()
		if arg_24_0.isOpenPerformance then
			return
		end

		JumpTools.OpenPageByJump("gameHelpPro", {
			isPrefab = true,
			pages = var_24_0
		})
	end)
end

function var_0_0.Dispose(arg_28_0)
	WaterPipeBrige.DisposeGame()

	for iter_28_0, iter_28_1 in pairs(arg_28_0.eventItemList) do
		if iter_28_1 then
			iter_28_1:Dispose()

			iter_28_1 = nil
		end
	end

	var_0_0.super.Dispose(arg_28_0)
end

return var_0_0
