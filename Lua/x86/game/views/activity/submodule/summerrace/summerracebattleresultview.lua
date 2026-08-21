local var_0_0 = import("game.views.activity.Submodule.SummerRace.Pages.SummerRaceVehicleDisplayView")
local var_0_1 = import("game.views.activity.Submodule.SummerRace.Items.SummerRaceBattleRecordItemView")
local var_0_2 = "重新挑战该轮"
local var_0_3 = "minigame_activity_5_2"
local var_0_4 = "minigame_activity_5_2_summer_win"
local var_0_5 = "minigame_activity_5_2_summer_fail"
local var_0_6 = class("SummerRaceBattleResultView", ReduxView)

local function var_0_7(arg_1_0)
	manager.audio:PlayEffect(var_0_3, arg_1_0 and var_0_4 or var_0_5, "")
end

function var_0_6.ResolveSettlementStageName(arg_2_0, arg_2_1)
	if type(arg_2_1) ~= "table" then
		return ""
	end

	local var_2_0 = tonumber(arg_2_1.stageId) or arg_2_1.stageId
	local var_2_1 = ActivityTankCfg[var_2_0]

	if var_2_1 == nil or var_2_1.name == nil then
		return ""
	end

	return GetI18NText(var_2_1.name)
end

function var_0_6.ResolveSettlementRankText(arg_3_0, arg_3_1)
	local var_3_0 = type(arg_3_1) == "table" and arg_3_1.records or nil

	if type(var_3_0) ~= "table" or #var_3_0 == 0 then
		return ""
	end

	local var_3_1 = 0

	for iter_3_0 = 1, #var_3_0 do
		if tostring(var_3_0[iter_3_0] and var_3_0[iter_3_0].resultState or "none") == "win" then
			var_3_1 = var_3_1 + 1
		end
	end

	local var_3_2 = math.max(1, #var_3_0 - var_3_1 + 1)

	return string.format(GetI18NText(GetTips("ACTIVITY_TANK_RANKING_TIPS")), tostring(var_3_2))
end

function var_0_6.BuildRecordListRefreshKey(arg_4_0, arg_4_1)
	if type(arg_4_1) ~= "table" or #arg_4_1 == 0 then
		return "0"
	end

	local var_4_0 = {
		tostring(#arg_4_1)
	}

	for iter_4_0 = 1, #arg_4_1 do
		local var_4_1 = arg_4_1[iter_4_0] or {}

		var_4_0[#var_4_0 + 1] = tostring(var_4_1.waveIndex or "")
		var_4_0[#var_4_0 + 1] = tostring(var_4_1.waveText or "")
		var_4_0[#var_4_0 + 1] = tostring(var_4_1.enemyName or "")
		var_4_0[#var_4_0 + 1] = tostring(var_4_1.timeText or "")
		var_4_0[#var_4_0 + 1] = tostring(var_4_1.resultState or "")
		var_4_0[#var_4_0 + 1] = tostring(var_4_1.enemyAvatarPath or "")
	end

	return table.concat(var_4_0, "|")
end

function var_0_6.RefreshRecordList(arg_5_0, arg_5_1)
	arg_5_0.recordData_ = arg_5_1 or {}

	local var_5_0 = arg_5_0:BuildRecordListRefreshKey(arg_5_0.recordData_)

	if arg_5_0.recordListRefreshKey_ == var_5_0 then
		return
	end

	arg_5_0.recordListRefreshKey_ = var_5_0

	if arg_5_0.recordItemList_ then
		arg_5_0.recordItemList_:StartScroll(#arg_5_0.recordData_)
	end
end

function var_0_6.DetachStateListeners(arg_6_0)
	if arg_6_0.runtimeUpdateHandler_ then
		manager.notify:RemoveListener(SummerRaceData.GetEventRuntimeUpdated(), arg_6_0.runtimeUpdateHandler_)

		arg_6_0.runtimeUpdateHandler_ = nil
	end

	if arg_6_0.settlementUpdateHandler_ then
		manager.notify:RemoveListener(SummerRaceData.GetEventSettlementUpdated(), arg_6_0.settlementUpdateHandler_)

		arg_6_0.settlementUpdateHandler_ = nil
	end
end

function var_0_6.UIName(arg_7_0)
	return "Widget/System/Activity_SummerRace/Activity_SummerRace_BattleUI/Activity_SummerRace_BattleResultUI"
end

function var_0_6.UIParent(arg_8_0)
	return manager.ui.uiPop.transform
end

function var_0_6.Init(arg_9_0)
	arg_9_0:BindCfgUI()

	if arg_9_0.carRootGo_ then
		arg_9_0.vehicleDisplayView_ = var_0_0.New(arg_9_0.carRootGo_)
	end

	if arg_9_0.recordListGo_ then
		arg_9_0.recordItemList_ = LuaList.New(handler(arg_9_0, arg_9_0.IndexRecordItem), arg_9_0.recordListGo_, var_0_1)
	end

	arg_9_0.resultCon_ = arg_9_0.resultConEx_:GetController("default0")
	arg_9_0.stageTypeCon_ = arg_9_0.resultConEx_:GetController("stageText")

	arg_9_0:AddUIListener()
end

function var_0_6.IndexRecordItem(arg_10_0, arg_10_1, arg_10_2)
	arg_10_2:SetData(arg_10_0.recordData_[arg_10_1])
end

function var_0_6.ShouldReportSettlement(arg_11_0)
	local var_11_0 = arg_11_0.settlementState_

	if type(var_11_0) ~= "table" then
		return true
	end

	return var_11_0.mode == SummerRaceConst.MODE.CHALLENGE or var_11_0.isWin == true
end

function var_0_6.ReportSettlementOnEnter(arg_12_0)
	if arg_12_0.settlementReportedOnEnter_ == true or arg_12_0.settlementState_ == nil then
		return
	end

	arg_12_0.settlementReportedOnEnter_ = true

	SummerRaceAction.ReportSettlement()
end

function var_0_6.AddUIListener(arg_13_0)
	arg_13_0:AddBtnListener(arg_13_0.confirmBtn_, nil, function()
		arg_13_0:DetachStateListeners()
		SummerRaceAction.LeaveBattleToMain()
	end)
	arg_13_0:AddBtnListener(arg_13_0.retryBtn_, nil, function()
		arg_13_0:DetachStateListeners()
		SummerRaceAction.RetrySettlementBattleFromResult("settlementRetry")
	end)
end

function var_0_6.SetRetryButtonVisible(arg_16_0, arg_16_1)
	if arg_16_0.retryBtn_ == nil or arg_16_0.retryBtn_.gameObject == nil then
		return
	end

	SetActive(arg_16_0.retryBtn_.gameObject, arg_16_1 == true)
end

function var_0_6.SetRetryButtonText(arg_17_0, arg_17_1)
	if arg_17_0.retryBtn_ == nil or arg_17_0.retryBtn_.gameObject == nil then
		return
	end

	if arg_17_0.retryText_ == nil then
		arg_17_0.retryText_ = arg_17_0.retryBtn_.gameObject:GetComponentInChildren(typeof(Text))
	end

	if arg_17_0.retryText_ ~= nil then
		arg_17_0.retryText_.text = arg_17_1 or ""
	end
end

function var_0_6.OnEnter(arg_18_0)
	arg_18_0:DetachStateListeners()

	arg_18_0.runtimeState_ = nil
	arg_18_0.settlementState_ = nil
	arg_18_0.settlementReportedOnEnter_ = false
	arg_18_0.resultAudioPlayed_ = false
	arg_18_0.recordData_ = {}

	arg_18_0:ResetResultDisplay()

	arg_18_0.runtimeUpdateHandler_ = handler(arg_18_0, arg_18_0.OnRuntimeStateUpdated)
	arg_18_0.settlementUpdateHandler_ = handler(arg_18_0, arg_18_0.OnSettlementStateUpdated)

	manager.notify:RegistListener(SummerRaceData.GetEventRuntimeUpdated(), arg_18_0.runtimeUpdateHandler_)
	manager.notify:RegistListener(SummerRaceData.GetEventSettlementUpdated(), arg_18_0.settlementUpdateHandler_)
	SummerRaceData:ReplayRuntimeState(arg_18_0.runtimeUpdateHandler_)
	SummerRaceData:ReplaySettlementState(arg_18_0.settlementUpdateHandler_)
	arg_18_0:ReportSettlementOnEnter()
end

function var_0_6.OnExit(arg_19_0)
	arg_19_0:DetachStateListeners()
end

function var_0_6.OnRuntimeStateUpdated(arg_20_0, arg_20_1)
	arg_20_0.runtimeState_ = arg_20_1
end

function var_0_6.OnSettlementStateUpdated(arg_21_0, arg_21_1)
	arg_21_0.settlementState_ = arg_21_1

	arg_21_0:RefreshResult()
end

function var_0_6.RefreshResult(arg_22_0)
	local var_22_0 = arg_22_0.settlementState_

	if var_22_0 == nil then
		return
	end

	local var_22_1 = var_22_0.mode == SummerRaceConst.MODE.CHALLENGE or var_22_0.isWin == true

	if arg_22_0.resultAudioPlayed_ ~= true then
		arg_22_0.resultAudioPlayed_ = true

		var_0_7(var_22_1)
	end

	arg_22_0.resultCon_:SetSelectedState(var_22_0.isWin and "win" or "lose")
	arg_22_0:SetRetryButtonVisible(var_22_0.isWin ~= true and var_22_0.mode ~= SummerRaceConst.MODE.CHALLENGE)
	arg_22_0:SetRetryButtonText(var_0_2)

	arg_22_0.stageNameText_.text = arg_22_0:ResolveSettlementStageName(var_22_0)
	arg_22_0.failStageNameText_.text = arg_22_0:ResolveSettlementStageName(var_22_0)
	arg_22_0.rankText_.text = arg_22_0:ResolveSettlementRankText(var_22_0)

	arg_22_0:RefreshRecordList(var_22_0.records)

	local var_22_2 = ActivityTankCfg[tonumber(var_22_0.stageId) or var_22_0.stageId]

	arg_22_0.stageTypeCon_:SetSelectedState(tonumber(var_22_2 and var_22_2.mode_type) == 1 and "main" or "side")

	if arg_22_0.vehicleDisplayView_ then
		arg_22_0.vehicleDisplayView_:AttachHost(arg_22_0.carRootGo_)
		arg_22_0.vehicleDisplayView_:SetData(var_22_0.vehicleDisplay)
	end
end

function var_0_6.ResetResultDisplay(arg_23_0)
	arg_23_0.stageNameText_.text = ""
	arg_23_0.recordData_ = {}
	arg_23_0.recordListRefreshKey_ = nil

	arg_23_0:SetRetryButtonVisible(false)
	arg_23_0:SetRetryButtonText(var_0_2)

	if arg_23_0.vehicleDisplayView_ then
		arg_23_0.vehicleDisplayView_:AttachHost(arg_23_0.carRootGo_)
		arg_23_0.vehicleDisplayView_:SetData(nil)
	end
end

function var_0_6.Dispose(arg_24_0)
	arg_24_0:DetachStateListeners()

	if arg_24_0.recordItemList_ then
		arg_24_0.recordItemList_:Dispose()

		arg_24_0.recordItemList_ = nil
	end

	if arg_24_0.vehicleDisplayView_ then
		arg_24_0.vehicleDisplayView_:Dispose()

		arg_24_0.vehicleDisplayView_ = nil
	end

	var_0_6.super.Dispose(arg_24_0)
end

return var_0_6
