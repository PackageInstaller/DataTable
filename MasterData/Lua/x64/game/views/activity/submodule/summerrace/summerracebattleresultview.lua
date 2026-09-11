local SummerRaceVehicleDisplayView = import("game.views.activity.Submodule.SummerRace.Pages.SummerRaceVehicleDisplayView")
local SummerRaceBattleRecordItemView = import("game.views.activity.Submodule.SummerRace.Items.SummerRaceBattleRecordItemView")
local var_0_2 = "重新挑战该轮"
local var_0_3 = "minigame_activity_5_2"
local var_0_4 = "minigame_activity_5_2_summer_win"
local var_0_5 = "minigame_activity_5_2_summer_fail"
local SummerRaceBattleResultView = class("SummerRaceBattleResultView", ReduxView)

local function var_0_7(arg_1_0)
	manager.audio:PlayEffect(var_0_3, (arg_1_0 or nil) and (var_0_4 or var_0_5), "")
end

function SummerRaceBattleResultView:ResolveSettlementStageName(arg_2_1)
	if type(arg_2_1) ~= "table" then
		return ""
	end

	local var_2_0 = ActivityTankCfg[tonumber(arg_2_1.stageId) or arg_2_1.stageId]

	if ActivityTankCfg[tonumber(arg_2_1.stageId) or arg_2_1.stageId] == nil or var_2_0.name == nil then
		return ""
	end

	return GetI18NText(var_2_0.name)
end

function SummerRaceBattleResultView:ResolveSettlementRankText(arg_3_1)
	local var_3_0

	if type(arg_3_1) == "table" then
		var_3_0 = arg_3_1.records or nil

		if type(var_3_0) ~= "table" or #var_3_0 == 0 then
			return ""
		end
	end

	local var_3_1 = 0

	for iter_3_0 = 1, #var_3_0 do
		if var_3_0[iter_3_0] then
			if tostring(var_3_0[iter_3_0].resultState or "none") == "win" then
				var_3_1 = var_3_1 + 1
			end
		end
	end

	return string.format(GetI18NText(GetTips("ACTIVITY_TANK_RANKING_TIPS")), tostring((math.max(1, #var_3_0 - var_3_1 + 1))))
end

function SummerRaceBattleResultView:BuildRecordListRefreshKey(arg_4_1)
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

function SummerRaceBattleResultView:RefreshRecordList(arg_5_1)
	self.recordData_ = arg_5_1 or {}

	local var_5_0 = self:BuildRecordListRefreshKey(self.recordData_)

	if self.recordListRefreshKey_ == var_5_0 then
		return
	end

	self.recordListRefreshKey_ = var_5_0

	if self.recordItemList_ then
		self.recordItemList_:StartScroll(#self.recordData_)
	end
end

function SummerRaceBattleResultView:DetachStateListeners()
	if self.runtimeUpdateHandler_ then
		manager.notify:RemoveListener(SummerRaceData.GetEventRuntimeUpdated(), self.runtimeUpdateHandler_)

		self.runtimeUpdateHandler_ = nil
	end

	if self.settlementUpdateHandler_ then
		manager.notify:RemoveListener(SummerRaceData.GetEventSettlementUpdated(), self.settlementUpdateHandler_)

		self.settlementUpdateHandler_ = nil
	end
end

function SummerRaceBattleResultView:UIName()
	return "Widget/System/Activity_SummerRace/Activity_SummerRace_BattleUI/Activity_SummerRace_BattleResultUI"
end

function SummerRaceBattleResultView:UIParent()
	return manager.ui.uiPop.transform
end

function SummerRaceBattleResultView:Init()
	self:BindCfgUI()

	if self.carRootGo_ then
		self.vehicleDisplayView_ = SummerRaceVehicleDisplayView.New(self.carRootGo_)
	end

	if self.recordListGo_ then
		self.recordItemList_ = LuaList.New(handler(self, self.IndexRecordItem), self.recordListGo_, SummerRaceBattleRecordItemView)
	end

	self.resultCon_ = self.resultConEx_:GetController("default0")
	self.stageTypeCon_ = self.resultConEx_:GetController("stageText")

	self:AddUIListener()
end

function SummerRaceBattleResultView:IndexRecordItem(arg_10_1, arg_10_2)
	arg_10_2:SetData(self.recordData_[arg_10_1])
end

function SummerRaceBattleResultView:ShouldReportSettlement()
	if type(self.settlementState_) ~= "table" then
		return true
	end

	return self.settlementState_.mode == SummerRaceConst.MODE.CHALLENGE or self.settlementState_.isWin == true
end

function SummerRaceBattleResultView:ReportSettlementOnEnter()
	if self.settlementReportedOnEnter_ == true or self.settlementState_ == nil then
		return
	end

	self.settlementReportedOnEnter_ = true

	SummerRaceAction.ReportSettlement()
end

function SummerRaceBattleResultView:AddUIListener()
	self:AddBtnListener(self.confirmBtn_, nil, function()
		self:DetachStateListeners()
		SummerRaceAction.LeaveBattleToMain()
	end)
	self:AddBtnListener(self.retryBtn_, nil, function()
		self:DetachStateListeners()
		SummerRaceAction.RetrySettlementBattleFromResult("settlementRetry")
	end)
end

function SummerRaceBattleResultView:SetRetryButtonVisible(arg_16_1)
	if self.retryBtn_ == nil or self.retryBtn_.gameObject == nil then
		return
	end

	SetActive(self.retryBtn_.gameObject, arg_16_1 == true)
end

function SummerRaceBattleResultView:SetRetryButtonText(arg_17_1)
	if self.retryBtn_ == nil or self.retryBtn_.gameObject == nil then
		return
	end

	if self.retryText_ == nil then
		self.retryText_ = self.retryBtn_.gameObject:GetComponentInChildren(typeof(Text))
	end

	if self.retryText_ ~= nil then
		self.retryText_.text = arg_17_1 or ""
	end
end

function SummerRaceBattleResultView:OnEnter()
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

function SummerRaceBattleResultView:OnExit()
	self:DetachStateListeners()
end

function SummerRaceBattleResultView:OnRuntimeStateUpdated(arg_20_1)
	self.runtimeState_ = arg_20_1
end

function SummerRaceBattleResultView:OnSettlementStateUpdated(arg_21_1)
	self.settlementState_ = arg_21_1

	self:RefreshResult()
end

function SummerRaceBattleResultView:RefreshResult()
	if self.settlementState_ == nil then
		return
	end

	if self.resultAudioPlayed_ ~= true then
		self.resultAudioPlayed_ = true

		var_0_7(self.settlementState_.mode == SummerRaceConst.MODE.CHALLENGE or self.settlementState_.isWin == true)
	end

	self.resultCon_:SetSelectedState(self.settlementState_.isWin and "win" or "lose")
	self:SetRetryButtonVisible(self.settlementState_.isWin ~= true and self.settlementState_.mode ~= SummerRaceConst.MODE.CHALLENGE)
	self:SetRetryButtonText(var_0_2)

	self.stageNameText_.text = self:ResolveSettlementStageName(self.settlementState_)
	self.failStageNameText_.text = self:ResolveSettlementStageName(self.settlementState_)
	self.rankText_.text = self:ResolveSettlementRankText(self.settlementState_)

	self:RefreshRecordList(self.settlementState_.records)
	self.stageTypeCon_:SetSelectedState(tonumber(ActivityTankCfg[tonumber(self.settlementState_.stageId) or self.settlementState_.stageId] and ActivityTankCfg[tonumber(self.settlementState_.stageId) or self.settlementState_.stageId].mode_type) == 1 and "main" or "side")

	if self.vehicleDisplayView_ then
		self.vehicleDisplayView_:AttachHost(self.carRootGo_)
		self.vehicleDisplayView_:SetData(self.settlementState_.vehicleDisplay)
	end
end

function SummerRaceBattleResultView:ResetResultDisplay()
	self.stageNameText_.text = ""
	self.recordData_ = {}
	self.recordListRefreshKey_ = nil

	self:SetRetryButtonVisible(false)
	self:SetRetryButtonText(var_0_2)

	if self.vehicleDisplayView_ then
		self.vehicleDisplayView_:AttachHost(self.carRootGo_)
		self.vehicleDisplayView_:SetData(nil)
	end
end

function SummerRaceBattleResultView:Dispose()
	self:DetachStateListeners()

	if self.recordItemList_ then
		self.recordItemList_:Dispose()

		self.recordItemList_ = nil
	end

	if self.vehicleDisplayView_ then
		self.vehicleDisplayView_:Dispose()

		self.vehicleDisplayView_ = nil
	end

	SummerRaceBattleResultView.super.Dispose(self)
end

return SummerRaceBattleResultView
