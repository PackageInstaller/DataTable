local SummerRaceVehicleDisplayView = import("game.views.activity.Submodule.SummerRace.Pages.SummerRaceVehicleDisplayView")
local SummerRaceBattleRecordItemView = import("game.views.activity.Submodule.SummerRace.Items.SummerRaceBattleRecordItemView")
local var_0_2 = "minigame_activity_5_2"
local var_0_3 = "minigame_activity_5_2_summer_win"
local SummerRaceChallengeResultView = class("SummerRaceChallengeResultView", ReduxView)

local function var_0_5()
	manager.audio:PlayEffect(var_0_2, var_0_3, "")
end

function SummerRaceChallengeResultView:RoundToInt(arg_2_1)
	return math.floor(arg_2_1 + 0.5)
end

function SummerRaceChallengeResultView:BuildRecordListRefreshKey(arg_3_1)
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

function SummerRaceChallengeResultView:RefreshRecordList(arg_4_1)
	self.recordData_ = arg_4_1 or {}

	local var_4_0 = self:BuildRecordListRefreshKey(self.recordData_)

	if self.recordListRefreshKey_ == var_4_0 then
		return
	end

	self.recordListRefreshKey_ = var_4_0

	if self.recordItemList_ then
		self.recordItemList_:StartScroll(#self.recordData_)
	end
end

function SummerRaceChallengeResultView:RefreshRuntimeStateDisplay()
	if self.runtimeState_ == nil then
		self.waveText_.text = ""

		return
	end

	self.waveText_.text = string.format(GetTips("ACTIVITY_TANK_WAVE_PROGRESS"), self.runtimeState_.wave, self.runtimeState_.waveTotal)
end

function SummerRaceChallengeResultView:DetachStateListeners()
	if self.runtimeUpdateHandler_ then
		manager.notify:RemoveListener(SummerRaceData.GetEventRuntimeUpdated(), self.runtimeUpdateHandler_)

		self.runtimeUpdateHandler_ = nil
	end

	if self.settlementUpdateHandler_ then
		manager.notify:RemoveListener(SummerRaceData.GetEventSettlementUpdated(), self.settlementUpdateHandler_)

		self.settlementUpdateHandler_ = nil
	end
end

function SummerRaceChallengeResultView:UIName()
	return "Widget/System/Activity_SummerRace/Activity_SummerRace_BattleUI/Activity_SummerRace_ChallengeResultUI"
end

function SummerRaceChallengeResultView:UIParent()
	return manager.ui.uiPop.transform
end

function SummerRaceChallengeResultView:Init()
	self:BindCfgUI()

	if self.carRootGo_ then
		self.vehicleDisplayView_ = SummerRaceVehicleDisplayView.New(self.carRootGo_)
	end

	if self.recordListGo_ then
		self.recordItemList_ = LuaList.New(handler(self, self.IndexRecordItem), self.recordListGo_, SummerRaceBattleRecordItemView)
	end

	self:AddUIListener()
end

function SummerRaceChallengeResultView:IndexRecordItem(arg_10_1, arg_10_2)
	local var_10_0 = self.recordData_[arg_10_1]

	arg_10_2:SetData(var_10_0, tostring((self.recordData_[arg_10_1] or nil) and (var_10_0.resultState or "none")) ~= "none" and "challenge" or "challengeNode")
end

function SummerRaceChallengeResultView:ReportSettlementOnEnter()
	if self.settlementReportedOnEnter_ == true or self.settlementState_ == nil then
		return
	end

	self.settlementReportedOnEnter_ = true

	SummerRaceAction.ReportSettlement()
end

function SummerRaceChallengeResultView:AddUIListener()
	self:AddBtnListener(self.confirmBtn_, nil, function()
		self:DetachStateListeners()
		SummerRaceAction.LeaveSettlementToMain("challenge")
	end)
	self:AddBtnListener(self.retryBtn_, nil, function()
		self:DetachStateListeners()
		SummerRaceAction.RetrySettlementBattleFromResult("settlementRetry")
	end)
end

function SummerRaceChallengeResultView:OnEnter()
	self:DetachStateListeners()

	self.runtimeState_ = nil
	self.settlementState_ = nil
	self.settlementReportedOnEnter_ = false
	self.resultAudioPlayed_ = false
	self.recordData_ = {}

	self:ResetResultDisplay()

	self.runtimeUpdateHandler_ = handler(self, self.OnRuntimeStateUpdated)
	self.settlementUpdateHandler_ = handler(self, self.OnSettlementStateUpdated)

	manager.notify:RegistListener(SummerRaceData.GetEventRuntimeUpdated(), self.runtimeUpdateHandler_)
	manager.notify:RegistListener(SummerRaceData.GetEventSettlementUpdated(), self.settlementUpdateHandler_)
	SummerRaceData:ReplayRuntimeState(self.runtimeUpdateHandler_)
	SummerRaceData:ReplaySettlementState(self.settlementUpdateHandler_)
	self:ReportSettlementOnEnter()
end

function SummerRaceChallengeResultView:OnExit()
	self:DetachStateListeners()
end

function SummerRaceChallengeResultView:OnRuntimeStateUpdated(arg_17_1)
	self.runtimeState_ = arg_17_1

	self:RefreshRuntimeStateDisplay()
end

function SummerRaceChallengeResultView:OnSettlementStateUpdated(arg_18_1)
	self.settlementState_ = arg_18_1

	self:RefreshResult()
end

function SummerRaceChallengeResultView:RefreshResult()
	if self.settlementState_ == nil then
		return
	end

	if self.resultAudioPlayed_ ~= true then
		self.resultAudioPlayed_ = true

		var_0_5()
	end

	self.rankText_.text = self.settlementState_.score

	self:RefreshRuntimeStateDisplay()
	self:RefreshRecordList(self.settlementState_.records)

	if self.vehicleDisplayView_ then
		self.vehicleDisplayView_:AttachHost(self.carRootGo_)
		self.vehicleDisplayView_:SetData(self.settlementState_.vehicleDisplay)
	end

	if self.newRecordGo_ then
		SetActive(self.newRecordGo_, self.settlementState_.isNewRecord == true)
	end
end

function SummerRaceChallengeResultView:ResetResultDisplay()
	self.rankText_.text = ""
	self.waveText_.text = ""
	self.recordData_ = {}
	self.recordListRefreshKey_ = nil

	if self.vehicleDisplayView_ then
		self.vehicleDisplayView_:AttachHost(self.carRootGo_)
		self.vehicleDisplayView_:SetData(nil)
	end

	if self.newRecordGo_ then
		SetActive(self.newRecordGo_, false)
	end
end

function SummerRaceChallengeResultView:Dispose()
	self:DetachStateListeners()

	if self.recordItemList_ then
		self.recordItemList_:Dispose()

		self.recordItemList_ = nil
	end

	if self.vehicleDisplayView_ then
		self.vehicleDisplayView_:Dispose()

		self.vehicleDisplayView_ = nil
	end

	SummerRaceChallengeResultView.super.Dispose(self)
end

return SummerRaceChallengeResultView
