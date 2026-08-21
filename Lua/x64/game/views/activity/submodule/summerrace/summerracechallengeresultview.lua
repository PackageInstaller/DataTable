local var_0_0 = import("game.views.activity.Submodule.SummerRace.Pages.SummerRaceVehicleDisplayView")
local var_0_1 = import("game.views.activity.Submodule.SummerRace.Items.SummerRaceBattleRecordItemView")
local var_0_2 = "minigame_activity_5_2"
local var_0_3 = "minigame_activity_5_2_summer_win"
local var_0_4 = class("SummerRaceChallengeResultView", ReduxView)

local function var_0_5()
	manager.audio:PlayEffect(var_0_2, var_0_3, "")
end

function var_0_4.RoundToInt(arg_2_0, arg_2_1)
	return math.floor(arg_2_1 + 0.5)
end

function var_0_4.BuildRecordListRefreshKey(arg_3_0, arg_3_1)
	if type(arg_3_1) ~= "table" or #arg_3_1 == 0 then
		return "0"
	end

	local var_3_0 = {
		tostring(#arg_3_1)
	}

	for iter_3_0 = 1, #arg_3_1 do
		local var_3_1 = arg_3_1[iter_3_0] or {}

		var_3_0[#var_3_0 + 1] = tostring(var_3_1.waveIndex or "")
		var_3_0[#var_3_0 + 1] = tostring(var_3_1.waveText or "")
		var_3_0[#var_3_0 + 1] = tostring(var_3_1.enemyName or "")
		var_3_0[#var_3_0 + 1] = tostring(var_3_1.timeText or "")
		var_3_0[#var_3_0 + 1] = tostring(var_3_1.resultState or "")
		var_3_0[#var_3_0 + 1] = tostring(var_3_1.enemyAvatarPath or "")
	end

	return table.concat(var_3_0, "|")
end

function var_0_4.RefreshRecordList(arg_4_0, arg_4_1)
	arg_4_0.recordData_ = arg_4_1 or {}

	local var_4_0 = arg_4_0:BuildRecordListRefreshKey(arg_4_0.recordData_)

	if arg_4_0.recordListRefreshKey_ == var_4_0 then
		return
	end

	arg_4_0.recordListRefreshKey_ = var_4_0

	if arg_4_0.recordItemList_ then
		arg_4_0.recordItemList_:StartScroll(#arg_4_0.recordData_)
	end
end

function var_0_4.RefreshRuntimeStateDisplay(arg_5_0)
	local var_5_0 = arg_5_0.runtimeState_

	if var_5_0 == nil then
		arg_5_0.waveText_.text = ""

		return
	end

	arg_5_0.waveText_.text = string.format(GetTips("ACTIVITY_TANK_WAVE_PROGRESS"), var_5_0.wave, var_5_0.waveTotal)
end

function var_0_4.DetachStateListeners(arg_6_0)
	if arg_6_0.runtimeUpdateHandler_ then
		manager.notify:RemoveListener(SummerRaceData.GetEventRuntimeUpdated(), arg_6_0.runtimeUpdateHandler_)

		arg_6_0.runtimeUpdateHandler_ = nil
	end

	if arg_6_0.settlementUpdateHandler_ then
		manager.notify:RemoveListener(SummerRaceData.GetEventSettlementUpdated(), arg_6_0.settlementUpdateHandler_)

		arg_6_0.settlementUpdateHandler_ = nil
	end
end

function var_0_4.UIName(arg_7_0)
	return "Widget/System/Activity_SummerRace/Activity_SummerRace_BattleUI/Activity_SummerRace_ChallengeResultUI"
end

function var_0_4.UIParent(arg_8_0)
	return manager.ui.uiPop.transform
end

function var_0_4.Init(arg_9_0)
	arg_9_0:BindCfgUI()

	if arg_9_0.carRootGo_ then
		arg_9_0.vehicleDisplayView_ = var_0_0.New(arg_9_0.carRootGo_)
	end

	if arg_9_0.recordListGo_ then
		arg_9_0.recordItemList_ = LuaList.New(handler(arg_9_0, arg_9_0.IndexRecordItem), arg_9_0.recordListGo_, var_0_1)
	end

	arg_9_0:AddUIListener()
end

function var_0_4.IndexRecordItem(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0.recordData_[arg_10_1]
	local var_10_1 = tostring(var_10_0 and var_10_0.resultState or "none") ~= "none" and "challenge" or "challengeNode"

	arg_10_2:SetData(var_10_0, var_10_1)
end

function var_0_4.ReportSettlementOnEnter(arg_11_0)
	if arg_11_0.settlementReportedOnEnter_ == true or arg_11_0.settlementState_ == nil then
		return
	end

	arg_11_0.settlementReportedOnEnter_ = true

	SummerRaceAction.ReportSettlement()
end

function var_0_4.AddUIListener(arg_12_0)
	arg_12_0:AddBtnListener(arg_12_0.confirmBtn_, nil, function()
		arg_12_0:DetachStateListeners()
		SummerRaceAction.LeaveSettlementToMain("challenge")
	end)
	arg_12_0:AddBtnListener(arg_12_0.retryBtn_, nil, function()
		arg_12_0:DetachStateListeners()
		SummerRaceAction.RetrySettlementBattleFromResult("settlementRetry")
	end)
end

function var_0_4.OnEnter(arg_15_0)
	arg_15_0:DetachStateListeners()

	arg_15_0.runtimeState_ = nil
	arg_15_0.settlementState_ = nil
	arg_15_0.settlementReportedOnEnter_ = false
	arg_15_0.resultAudioPlayed_ = false
	arg_15_0.recordData_ = {}

	arg_15_0:ResetResultDisplay()

	arg_15_0.runtimeUpdateHandler_ = handler(arg_15_0, arg_15_0.OnRuntimeStateUpdated)
	arg_15_0.settlementUpdateHandler_ = handler(arg_15_0, arg_15_0.OnSettlementStateUpdated)

	manager.notify:RegistListener(SummerRaceData.GetEventRuntimeUpdated(), arg_15_0.runtimeUpdateHandler_)
	manager.notify:RegistListener(SummerRaceData.GetEventSettlementUpdated(), arg_15_0.settlementUpdateHandler_)
	SummerRaceData:ReplayRuntimeState(arg_15_0.runtimeUpdateHandler_)
	SummerRaceData:ReplaySettlementState(arg_15_0.settlementUpdateHandler_)
	arg_15_0:ReportSettlementOnEnter()
end

function var_0_4.OnExit(arg_16_0)
	arg_16_0:DetachStateListeners()
end

function var_0_4.OnRuntimeStateUpdated(arg_17_0, arg_17_1)
	arg_17_0.runtimeState_ = arg_17_1

	arg_17_0:RefreshRuntimeStateDisplay()
end

function var_0_4.OnSettlementStateUpdated(arg_18_0, arg_18_1)
	arg_18_0.settlementState_ = arg_18_1

	arg_18_0:RefreshResult()
end

function var_0_4.RefreshResult(arg_19_0)
	local var_19_0 = arg_19_0.settlementState_

	if var_19_0 == nil then
		return
	end

	if arg_19_0.resultAudioPlayed_ ~= true then
		arg_19_0.resultAudioPlayed_ = true

		var_0_5()
	end

	arg_19_0.rankText_.text = var_19_0.score

	arg_19_0:RefreshRuntimeStateDisplay()
	arg_19_0:RefreshRecordList(var_19_0.records)

	if arg_19_0.vehicleDisplayView_ then
		arg_19_0.vehicleDisplayView_:AttachHost(arg_19_0.carRootGo_)
		arg_19_0.vehicleDisplayView_:SetData(var_19_0.vehicleDisplay)
	end

	if arg_19_0.newRecordGo_ then
		SetActive(arg_19_0.newRecordGo_, var_19_0.isNewRecord == true)
	end
end

function var_0_4.ResetResultDisplay(arg_20_0)
	arg_20_0.rankText_.text = ""
	arg_20_0.waveText_.text = ""
	arg_20_0.recordData_ = {}
	arg_20_0.recordListRefreshKey_ = nil

	if arg_20_0.vehicleDisplayView_ then
		arg_20_0.vehicleDisplayView_:AttachHost(arg_20_0.carRootGo_)
		arg_20_0.vehicleDisplayView_:SetData(nil)
	end

	if arg_20_0.newRecordGo_ then
		SetActive(arg_20_0.newRecordGo_, false)
	end
end

function var_0_4.Dispose(arg_21_0)
	arg_21_0:DetachStateListeners()

	if arg_21_0.recordItemList_ then
		arg_21_0.recordItemList_:Dispose()

		arg_21_0.recordItemList_ = nil
	end

	if arg_21_0.vehicleDisplayView_ then
		arg_21_0.vehicleDisplayView_:Dispose()

		arg_21_0.vehicleDisplayView_ = nil
	end

	var_0_4.super.Dispose(arg_21_0)
end

return var_0_4
