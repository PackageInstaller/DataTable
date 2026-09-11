local SummerRaceStageNodeItemView = import("game.views.activity.Submodule.SummerRace.Items.SummerRaceStageNodeItemView")
local SummerRaceTournamentView = class("SummerRaceTournamentView", ReduxView)

local function var_0_2()
	local var_1_0 = {
		{
			stageIndex = 1,
			name = "mian_StageItem_01",
			visualType = "main",
			tabType = SummerRaceConst.TOURNAMENT_TAB.NORMAL
		}
	}
	local var_1_1 = {
		stageIndex = 1,
		name = "plot_StageItem_01",
		visualType = "plot"
	}

	var_1_1.groupKey = "plot"
	var_1_0[2] = var_1_1
	var_1_0[3] = {
		stageIndex = 2,
		name = "main_StageItem_02",
		visualType = "main",
		tabType = SummerRaceConst.TOURNAMENT_TAB.NORMAL
	}
	var_1_0[4] = {
		stageIndex = 2,
		name = "plot_StageItem_02",
		visualType = "plot",
		groupKey = "plot"
	}
	var_1_0[5] = {
		stageIndex = 3,
		name = "main_StageItem_03",
		visualType = "main",
		tabType = SummerRaceConst.TOURNAMENT_TAB.NORMAL
	}
	var_1_0[6] = {
		stageIndex = 4,
		name = "main_StageItem_04",
		visualType = "main",
		tabType = SummerRaceConst.TOURNAMENT_TAB.NORMAL
	}
	var_1_0[7] = {
		stageIndex = 5,
		name = "main_StageItem_05",
		visualType = "main",
		tabType = SummerRaceConst.TOURNAMENT_TAB.NORMAL
	}
	var_1_0[8] = {
		stageIndex = 6,
		name = "boss_StageItem_06",
		visualType = "boss",
		tabType = SummerRaceConst.TOURNAMENT_TAB.NORMAL
	}
	var_1_0[9] = {
		stageIndex = 1,
		name = "side_StageItem_01_1",
		visualType = "side",
		tabType = SummerRaceConst.TOURNAMENT_TAB.SURVIVAL
	}
	var_1_0[10] = {
		stageIndex = 2,
		name = "side_StageItem_01_2",
		visualType = "side",
		tabType = SummerRaceConst.TOURNAMENT_TAB.SURVIVAL
	}
	var_1_0[11] = {
		stageIndex = 3,
		name = "side_StageItem_01_3",
		visualType = "side",
		tabType = SummerRaceConst.TOURNAMENT_TAB.SURVIVAL
	}
	var_1_0[12] = {
		stageIndex = 1,
		name = "side_StageItem_02_1",
		visualType = "side",
		tabType = SummerRaceConst.TOURNAMENT_TAB.DUEL
	}
	var_1_0[13] = {
		stageIndex = 2,
		name = "side_StageItem_02_2",
		visualType = "side",
		tabType = SummerRaceConst.TOURNAMENT_TAB.DUEL
	}
	var_1_0[14] = {
		stageIndex = 3,
		name = "side_StageItem_02_3",
		visualType = "side",
		tabType = SummerRaceConst.TOURNAMENT_TAB.DUEL
	}

	return var_1_0
end

local function var_0_3(arg_2_0)
	if arg_2_0 == nil then
		return
	end

	if arg_2_0.tabType ~= nil then
		SummerRaceData:SetTournamentTab(arg_2_0.tabType, true)
	end
end

local function var_0_4()
	return gameContext:IsOpenRoute("summerRaceCutScenesPopView") ~= nil
end

local function var_0_5(arg_4_0)
	if arg_4_0.outGameUpdateHandler_ then
		manager.notify:RemoveListener(SummerRaceData.GetEventOutGameUpdated(), arg_4_0.outGameUpdateHandler_)

		arg_4_0.outGameUpdateHandler_ = nil
	end

	if arg_4_0.stageItemUnlockAnimHandler_ then
		manager.notify:RemoveListener(SummerRaceData.GetEventStageItemUnlockAnim(), arg_4_0.stageItemUnlockAnimHandler_)

		arg_4_0.stageItemUnlockAnimHandler_ = nil
	end
end

local function var_0_6(arg_5_0)
	if arg_5_0.windowBarBackHandler_ ~= nil and manager.windowBar:GetLastBackFunc() == arg_5_0.windowBarBackHandler_ then
		manager.windowBar:HideBar()
	end
end

function SummerRaceTournamentView:UIName()
	return "Widget/System/Activity_SummerRace/Activity_SummerRace_MainUI/Activity_SummerRace_StageUI"
end

function SummerRaceTournamentView:UIParent()
	return manager.ui.uiMain.transform
end

function SummerRaceTournamentView:Init()
	self:BindViewRuntime()
end

function SummerRaceTournamentView:BindViewRuntime()
	self.stageScrollRect_ = self:FindCom(typeof(ScrollRect), "panel/Scroll View")
	self.stageRootGo_ = self:FindGo("panel/Scroll View/Viewport/Content/stages")
	self.stageItemViews_ = {}
	self.stageItemViewMap_ = {}
	self.stageItemStageIdMap_ = {}
	self.stageNodes_ = {}

	if self.stageRootGo_ == nil then
		error("[SummerRaceTournamentView] missing stage root: panel/Scroll View/Viewport/Content/stages")
	end

	local var_9_0 = self.stageRootGo_.transform

	for iter_9_0 = 0, self.stageRootGo_.transform.childCount - 1 do
		local var_9_1 = var_9_0:GetChild(iter_9_0).gameObject
		local var_9_2 = SummerRaceStageNodeItemView.New(var_9_1)

		self.stageItemViews_[#self.stageItemViews_ + 1] = var_9_2
		self.stageItemViewMap_[var_9_1.name] = var_9_2
	end
end

local function var_0_7(arg_10_0, arg_10_1)
	local var_10_0 = tonumber(arg_10_0 and arg_10_0.stageIndex) or math.huge
	local var_10_1 = tonumber(arg_10_1 and arg_10_1.stageIndex) or math.huge

	if var_10_0 ~= var_10_1 then
		return var_10_0 < var_10_1
	end

	local var_10_2 = tonumber(arg_10_0 and arg_10_0.sort) or math.huge
	local var_10_3 = tonumber(arg_10_1 and arg_10_1.sort) or math.huge

	if var_10_2 ~= var_10_3 then
		return var_10_2 < var_10_3
	end

	return (tonumber(arg_10_0 and arg_10_0.stageId) or math.huge) < (tonumber(arg_10_1 and arg_10_1.stageId) or math.huge)
end

local function var_0_8(arg_11_0)
	if arg_11_0 == nil then
		return nil
	end

	if tostring(arg_11_0.nodeType or "") == "plot" then
		return "plot"
	end

	return arg_11_0.tabType or SummerRaceConst.STAGE_MODE_TO_TAB[tonumber(arg_11_0.modeType) or 0]
end

local function var_0_9(arg_12_0)
	local var_12_0 = {
		[SummerRaceConst.TOURNAMENT_TAB.NORMAL] = {},
		[SummerRaceConst.TOURNAMENT_TAB.SURVIVAL] = {},
		[SummerRaceConst.TOURNAMENT_TAB.DUEL] = {},
		plot = {}
	}

	for iter_12_0 = 1, #arg_12_0 do
		if arg_12_0[iter_12_0] ~= nil then
			local var_12_1 = var_0_8(arg_12_0[iter_12_0])

			if var_12_0[var_12_1] ~= nil then
				var_12_0[var_12_1][#var_12_0[var_12_1] + 1] = arg_12_0[iter_12_0]
			end
		end
	end

	for iter_12_1, iter_12_2 in pairs(var_12_0) do
		table.sort(iter_12_2, var_0_7)
	end

	return var_12_0
end

local function var_0_10(arg_13_0)
	if type(arg_13_0) ~= "table" then
		return arg_13_0
	end

	local var_13_0 = {}

	for iter_13_0, iter_13_1 in pairs(arg_13_0) do
		var_13_0[iter_13_0] = iter_13_1
	end

	return var_13_0
end

local function var_0_11(arg_14_0, arg_14_1)
	local var_14_0 = {}

	for iter_14_0 = 1, #arg_14_1 do
		local var_14_1 = arg_14_1[iter_14_0].groupKey or arg_14_1[iter_14_0].tabType

		var_14_0[var_14_1] = (var_14_0[var_14_1] or 0) + 1
	end

	for iter_14_1, iter_14_2 in pairs(arg_14_0) do
		local var_14_2 = var_14_0[iter_14_1] or 0

		if var_14_2 < #iter_14_2 then
			error(string.format("[SummerRaceTournamentView] stage overflow, group=%s, stages=%d, preset=%d", tostring(iter_14_1), #iter_14_2, var_14_2))
		end
	end
end

local function var_0_12(arg_15_0, arg_15_1)
	local var_15_0 = {}

	for iter_15_0 = 1, #arg_15_1 do
		var_15_0[arg_15_1[iter_15_0].name] = (arg_15_0[arg_15_1[iter_15_0].groupKey or arg_15_1[iter_15_0].tabType] or {})[arg_15_1[iter_15_0].stageIndex]
	end

	return var_15_0
end

local var_0_13 = 0.1
local var_0_14 = 0.1

function SummerRaceTournamentView:RefreshStageScroll(arg_16_1)
	if self.stageScrollRect_ == nil or arg_16_1 == nil or self.stageItemViewMap_ == nil then
		return
	end

	local var_16_0 = self.stageItemViewMap_[arg_16_1]

	if self.stageItemViewMap_[arg_16_1] == nil or var_16_0.gameObject_ == nil or var_16_0.gameObject_.activeSelf ~= true then
		return
	end

	local var_16_1 = var_0_2()
	local var_16_2
	local var_16_3

	for iter_16_0 = 1, #var_16_1 do
		if self.stageItemViewMap_[var_16_1[iter_16_0].name] ~= nil and self.stageItemViewMap_[var_16_1[iter_16_0].name].gameObject_ ~= nil and self.stageItemViewMap_[var_16_1[iter_16_0].name].gameObject_.activeSelf == true then
			local var_16_4 = self.stageItemViewMap_[var_16_1[iter_16_0].name].transform_.localPosition.x

			var_16_2 = var_16_2 == nil and var_16_4 or math.min(var_16_2, var_16_4)
			var_16_3 = var_16_3 == nil and var_16_4 or math.max(var_16_3, var_16_4)
		end
	end

	if var_16_2 == nil or var_16_3 == nil or math.abs(var_16_3 - var_16_2) <= 0.001 then
		self.stageScrollRect_.horizontalNormalizedPosition = 0

		return
	end

	self.stageScrollRect_.horizontalNormalizedPosition = math.min(1, math.max(0, (var_16_0.transform_.localPosition.x - var_16_2) / (var_16_3 - var_16_2)))
end

function SummerRaceTournamentView:RefreshStageScrollByItemIndex(arg_17_1)
	local var_17_0

	if self.stageItemViews_ then
		var_17_0 = self.stageItemViews_[arg_17_1] or nil

		if var_17_0 == nil then
			return
		end
	end

	self:RefreshStageScroll(var_17_0.presetName_)
end

function SummerRaceTournamentView:OnEnter()
	var_0_3(self.params_)
	self:UpdateBar()

	self.outGameUpdateHandler_ = handler(self, self.RefreshView)
	self.stageItemUnlockAnimHandler_ = handler(self, self.TryPlayPendingStageItemUnlockAnim)

	manager.notify:RegistListener(SummerRaceData.GetEventOutGameUpdated(), self.outGameUpdateHandler_)
	manager.notify:RegistListener(SummerRaceData.GetEventStageItemUnlockAnim(), self.stageItemUnlockAnimHandler_)
	self:RefreshView()
end

function SummerRaceTournamentView:OnEnterOver()
	if self.params_ ~= nil and self.params_.playCutScenesExitOnEnter == true then
		self.params_.playCutScenesExitOnEnter = nil

		SummerRaceAction.OpenCutScenesPop({
			mode = "exit",
			finishCb = function()
				self:SchedulePendingUnlockPop()
			end
		})

		return
	end

	self:SchedulePendingUnlockPop()
end

function SummerRaceTournamentView:OnTop()
	self:UpdateBar()

	if self.params_ ~= nil and self.params_.replayStageUIAnim == true then
		self.params_.replayStageUIAnim = nil

		local var_21_0 = self.transform_:GetComponent(typeof(Animator))

		var_21_0:Play("UI_Activity_SummerRace_StageUI_cx", -1, 0)
		var_21_0:Update(0)
	end

	self:SchedulePendingStageItemUnlockAnimNotify()
end

function SummerRaceTournamentView:UpdateBar()
	self.windowBarBackHandler_ = self.windowBarBackHandler_ or function()
		if var_0_4() then
			return
		end

		JumpTools.Back()
	end

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(self.windowBarBackHandler_)
end

function SummerRaceTournamentView:OnBehind()
	return
end

function SummerRaceTournamentView:OnExit()
	self:StopPendingUnlockPopTimer()
	self:StopPendingStageItemUnlockAnimNotifyTimer()
	self:StopStageItemUnlockAnimTimer()
	self:StopStageItemUnlockAnimators()
	var_0_5(self)
	var_0_6(self)
end

function SummerRaceTournamentView:SchedulePendingUnlockPop()
	self:StopPendingUnlockPopTimer()

	self.pendingUnlockPopTimer_ = Timer.New(function()
		self:StopPendingUnlockPopTimer()

		if manager.guide ~= nil and manager.guide:IsPlaying() then
			self:SchedulePendingUnlockPop()

			return
		end

		local var_27_0, var_27_1 = SummerRaceAction.TryContinuePendingUnlockFlow()

		if var_27_0 == true and var_27_1 == "guide" then
			self:SchedulePendingUnlockPop()
		end
	end, 0.1, 1)

	self.pendingUnlockPopTimer_:Start()
end

function SummerRaceTournamentView:StopStageItemUnlockAnimTimer()
	if self.stageItemUnlockAnimTimer_ ~= nil then
		self.stageItemUnlockAnimTimer_:Stop()

		self.stageItemUnlockAnimTimer_ = nil
	end
end

function SummerRaceTournamentView:SchedulePendingStageItemUnlockAnimNotify()
	self:StopPendingStageItemUnlockAnimNotifyTimer()

	if SummerRaceData:HasPendingUnlockPop() == true then
		return
	end

	self.pendingStageItemUnlockAnimNotifyTimer_ = Timer.New(function()
		self:StopPendingStageItemUnlockAnimNotifyTimer()

		if SummerRaceData:HasPendingUnlockPop() == true then
			return
		end

		SummerRaceData:NotifyPendingStageItemUnlockAnim()
	end, var_0_14, 1)

	self.pendingStageItemUnlockAnimNotifyTimer_:Start()
end

function SummerRaceTournamentView:StopPendingStageItemUnlockAnimNotifyTimer()
	if self.pendingStageItemUnlockAnimNotifyTimer_ ~= nil then
		self.pendingStageItemUnlockAnimNotifyTimer_:Stop()

		self.pendingStageItemUnlockAnimNotifyTimer_ = nil
	end
end

function SummerRaceTournamentView:StopStageItemUnlockAnimators()
	if self.stageItemViews_ == nil then
		return
	end

	for iter_32_0 = 1, #self.stageItemViews_ do
		self.stageItemViews_[iter_32_0]:StopUnlockAnim()
	end
end

function SummerRaceTournamentView:TryPlayPendingStageItemUnlockAnim()
	local var_33_0 = SummerRaceData:ConsumePendingStageItemUnlockAnimModelList()

	if #var_33_0 == 0 then
		return false
	end

	self:RefreshView()

	local var_33_1 = {}
	local var_33_2

	for iter_33_0 = 1, #var_33_0 do
		local var_33_3 = self.stageItemStageIdMap_[tostring(var_33_0[iter_33_0].stageId)]

		if var_33_3 ~= nil then
			var_33_1[#var_33_1 + 1] = var_33_3

			var_33_3:SetUnlockLockVisible(true)

			var_33_2 = var_33_2 or var_33_3.presetName_
		end
	end

	if #var_33_1 == 0 then
		return false
	end

	self:RefreshStageScroll(var_33_2)
	self:StopStageItemUnlockAnimTimer()

	self.stageItemUnlockAnimTimer_ = Timer.New(function()
		self:StopStageItemUnlockAnimTimer()

		for iter_34_0 = 1, #var_33_1 do
			var_33_1[iter_34_0]:PlayUnlockAnim()
		end
	end, var_0_13, 1)

	self.stageItemUnlockAnimTimer_:Start()

	return true
end

function SummerRaceTournamentView:StopPendingUnlockPopTimer()
	if self.pendingUnlockPopTimer_ ~= nil then
		self.pendingUnlockPopTimer_:Stop()

		self.pendingUnlockPopTimer_ = nil
	end
end

function SummerRaceTournamentView:OnClickStageItem(arg_36_1, arg_36_2)
	if var_0_4() or gameContext:IsOpenRoute("summerRaceUnlockPopView") ~= nil or gameContext:IsOpenRoute("summerRaceUnlockBannerView") ~= nil or SummerRaceData:HasPendingUnlockPop() == true then
		return
	end

	if arg_36_2 and arg_36_2.isUnlocked then
		SummerRaceAction.SelectStage(arg_36_2.stageId)

		return
	end

	ShowTips("ACTIVITY_TANK_STAGE_LOCK")
end

function SummerRaceTournamentView:RefreshView(arg_37_1)
	local var_37_0 = SummerRaceData:GetTournamentPageModel()
	local var_37_1 = var_0_2()
	local var_37_2 = var_0_9(var_37_0.stageNodes or {})
	local var_37_3 = var_0_12(var_37_2, var_37_1)
	local var_37_4 = {}
	local var_37_5

	self.stageNodes_ = var_37_0.stageNodes or {}
	self.stageItemStageIdMap_ = {}

	var_0_11(var_37_2, var_37_1)

	for iter_37_0 = 1, #var_37_1 do
		local var_37_6 = var_37_3[var_37_1[iter_37_0].name]

		if self.stageItemViewMap_[var_37_1[iter_37_0].name] == nil then
			error("[SummerRaceTournamentView] missing preset stage item: " .. tostring(var_37_1[iter_37_0].name))
		end

		if var_37_6 ~= nil then
			var_37_6 = var_0_10(var_37_6)
			var_37_6.nodeVisualType = var_37_1[iter_37_0].visualType
		end

		self.stageItemViewMap_[var_37_1[iter_37_0].name]:SetData(var_37_6, iter_37_0, handler(self, self.OnClickStageItem))

		self.stageItemViewMap_[var_37_1[iter_37_0].name].presetName_ = var_37_1[iter_37_0].name
		var_37_4[var_37_1[iter_37_0].name] = true

		if var_37_6 ~= nil and var_37_6.stageId ~= nil then
			self.stageItemStageIdMap_[tostring(var_37_6.stageId)] = self.stageItemViewMap_[var_37_1[iter_37_0].name]

			if SummerRaceData:HasPendingStageItemUnlockAnim(var_37_6.stageId) == true then
				self.stageItemViewMap_[var_37_1[iter_37_0].name]:SetUnlockLockVisible(true)
			end
		end

		if var_37_6 and var_37_6.isSelected then
			var_37_5 = var_37_1[iter_37_0].name
		end
	end

	for iter_37_1, iter_37_2 in pairs(self.stageItemViewMap_ or {}) do
		if var_37_4[iter_37_1] ~= true then
			iter_37_2:SetData(nil, 0, handler(self, self.OnClickStageItem))

			iter_37_2.presetName_ = nil
		end
	end

	if arg_37_1 ~= "championshipEntryClick" then
		self:RefreshStageScroll(var_37_5)
	end
end

function SummerRaceTournamentView:Dispose()
	var_0_5(self)
	var_0_6(self)
	self:StopPendingUnlockPopTimer()
	self:StopStageItemUnlockAnimTimer()
	self:StopStageItemUnlockAnimators()

	if self.stageItemViews_ then
		for iter_38_0 = 1, #self.stageItemViews_ do
			self.stageItemViews_[iter_38_0]:Dispose()
		end

		self.stageItemViews_ = nil
	end

	self.stageItemViewMap_ = nil
	self.windowBarBackHandler_ = nil

	SummerRaceTournamentView.super.Dispose(self)
end

return SummerRaceTournamentView
