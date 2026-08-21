local var_0_0 = import("game.views.activity.Submodule.SummerRace.Items.SummerRaceStageNodeItemView")
local var_0_1 = class("SummerRaceTournamentView", ReduxView)

local function var_0_2()
	local var_1_0 = SummerRaceConst.TOURNAMENT_TAB
	local var_1_1 = "plot"

	return {
		{
			stageIndex = 1,
			name = "mian_StageItem_01",
			visualType = "main",
			tabType = var_1_0.NORMAL
		},
		{
			stageIndex = 1,
			name = "plot_StageItem_01",
			visualType = "plot",
			groupKey = var_1_1
		},
		{
			stageIndex = 2,
			name = "main_StageItem_02",
			visualType = "main",
			tabType = var_1_0.NORMAL
		},
		{
			stageIndex = 2,
			name = "plot_StageItem_02",
			visualType = "plot",
			groupKey = var_1_1
		},
		{
			stageIndex = 3,
			name = "main_StageItem_03",
			visualType = "main",
			tabType = var_1_0.NORMAL
		},
		{
			stageIndex = 4,
			name = "main_StageItem_04",
			visualType = "main",
			tabType = var_1_0.NORMAL
		},
		{
			stageIndex = 5,
			name = "main_StageItem_05",
			visualType = "main",
			tabType = var_1_0.NORMAL
		},
		{
			stageIndex = 6,
			name = "boss_StageItem_06",
			visualType = "boss",
			tabType = var_1_0.NORMAL
		},
		{
			stageIndex = 1,
			name = "side_StageItem_01_1",
			visualType = "side",
			tabType = var_1_0.SURVIVAL
		},
		{
			stageIndex = 2,
			name = "side_StageItem_01_2",
			visualType = "side",
			tabType = var_1_0.SURVIVAL
		},
		{
			stageIndex = 3,
			name = "side_StageItem_01_3",
			visualType = "side",
			tabType = var_1_0.SURVIVAL
		},
		{
			stageIndex = 1,
			name = "side_StageItem_02_1",
			visualType = "side",
			tabType = var_1_0.DUEL
		},
		{
			stageIndex = 2,
			name = "side_StageItem_02_2",
			visualType = "side",
			tabType = var_1_0.DUEL
		},
		{
			stageIndex = 3,
			name = "side_StageItem_02_3",
			visualType = "side",
			tabType = var_1_0.DUEL
		}
	}
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

function var_0_1.UIName(arg_6_0)
	return "Widget/System/Activity_SummerRace/Activity_SummerRace_MainUI/Activity_SummerRace_StageUI"
end

function var_0_1.UIParent(arg_7_0)
	return manager.ui.uiMain.transform
end

function var_0_1.Init(arg_8_0)
	arg_8_0:BindViewRuntime()
end

function var_0_1.BindViewRuntime(arg_9_0)
	arg_9_0.stageScrollRect_ = arg_9_0:FindCom(typeof(ScrollRect), "panel/Scroll View")
	arg_9_0.stageRootGo_ = arg_9_0:FindGo("panel/Scroll View/Viewport/Content/stages")
	arg_9_0.stageItemViews_ = {}
	arg_9_0.stageItemViewMap_ = {}
	arg_9_0.stageItemStageIdMap_ = {}
	arg_9_0.stageNodes_ = {}

	if arg_9_0.stageRootGo_ == nil then
		error("[SummerRaceTournamentView] missing stage root: panel/Scroll View/Viewport/Content/stages")
	end

	local var_9_0 = arg_9_0.stageRootGo_.transform
	local var_9_1 = var_9_0.childCount

	for iter_9_0 = 0, var_9_1 - 1 do
		local var_9_2 = var_9_0:GetChild(iter_9_0).gameObject
		local var_9_3 = var_0_0.New(var_9_2)

		arg_9_0.stageItemViews_[#arg_9_0.stageItemViews_ + 1] = var_9_3
		arg_9_0.stageItemViewMap_[var_9_2.name] = var_9_3
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
	local var_12_0 = SummerRaceConst.TOURNAMENT_TAB
	local var_12_1 = {
		[var_12_0.NORMAL] = {},
		[var_12_0.SURVIVAL] = {},
		[var_12_0.DUEL] = {},
		plot = {}
	}

	for iter_12_0 = 1, #arg_12_0 do
		local var_12_2 = arg_12_0[iter_12_0]

		if var_12_2 ~= nil then
			local var_12_3 = var_0_8(var_12_2)

			if var_12_1[var_12_3] ~= nil then
				var_12_1[var_12_3][#var_12_1[var_12_3] + 1] = var_12_2
			end
		end
	end

	for iter_12_1, iter_12_2 in pairs(var_12_1) do
		table.sort(iter_12_2, var_0_7)
	end

	return var_12_1
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
		local var_14_2 = #iter_14_2
		local var_14_3 = var_14_0[iter_14_1] or 0

		if var_14_3 < var_14_2 then
			error(string.format("[SummerRaceTournamentView] stage overflow, group=%s, stages=%d, preset=%d", tostring(iter_14_1), var_14_2, var_14_3))
		end
	end
end

local function var_0_12(arg_15_0, arg_15_1)
	local var_15_0 = {}

	for iter_15_0 = 1, #arg_15_1 do
		local var_15_1 = arg_15_1[iter_15_0]
		local var_15_2 = arg_15_0[var_15_1.groupKey or var_15_1.tabType] or {}

		var_15_0[var_15_1.name] = var_15_2[var_15_1.stageIndex]
	end

	return var_15_0
end

local var_0_13 = 0.1
local var_0_14 = 0.1

function var_0_1.RefreshStageScroll(arg_16_0, arg_16_1)
	if arg_16_0.stageScrollRect_ == nil or arg_16_1 == nil or arg_16_0.stageItemViewMap_ == nil then
		return
	end

	local var_16_0 = arg_16_0.stageItemViewMap_[arg_16_1]

	if var_16_0 == nil or var_16_0.gameObject_ == nil or var_16_0.gameObject_.activeSelf ~= true then
		return
	end

	local var_16_1 = var_0_2()
	local var_16_2
	local var_16_3
	local var_16_4 = var_16_0.transform_.localPosition.x

	for iter_16_0 = 1, #var_16_1 do
		local var_16_5 = arg_16_0.stageItemViewMap_[var_16_1[iter_16_0].name]

		if var_16_5 ~= nil and var_16_5.gameObject_ ~= nil and var_16_5.gameObject_.activeSelf == true then
			local var_16_6 = var_16_5.transform_.localPosition.x

			var_16_2 = var_16_2 == nil and var_16_6 or math.min(var_16_2, var_16_6)
			var_16_3 = var_16_3 == nil and var_16_6 or math.max(var_16_3, var_16_6)
		end
	end

	if var_16_2 == nil or var_16_3 == nil or math.abs(var_16_3 - var_16_2) <= 0.001 then
		arg_16_0.stageScrollRect_.horizontalNormalizedPosition = 0

		return
	end

	arg_16_0.stageScrollRect_.horizontalNormalizedPosition = math.min(1, math.max(0, (var_16_4 - var_16_2) / (var_16_3 - var_16_2)))
end

function var_0_1.RefreshStageScrollByItemIndex(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0.stageItemViews_ and arg_17_0.stageItemViews_[arg_17_1] or nil

	if var_17_0 == nil then
		return
	end

	arg_17_0:RefreshStageScroll(var_17_0.presetName_)
end

function var_0_1.OnEnter(arg_18_0)
	var_0_3(arg_18_0.params_)
	arg_18_0:UpdateBar()

	arg_18_0.outGameUpdateHandler_ = handler(arg_18_0, arg_18_0.RefreshView)
	arg_18_0.stageItemUnlockAnimHandler_ = handler(arg_18_0, arg_18_0.TryPlayPendingStageItemUnlockAnim)

	manager.notify:RegistListener(SummerRaceData.GetEventOutGameUpdated(), arg_18_0.outGameUpdateHandler_)
	manager.notify:RegistListener(SummerRaceData.GetEventStageItemUnlockAnim(), arg_18_0.stageItemUnlockAnimHandler_)
	arg_18_0:RefreshView()
end

function var_0_1.OnEnterOver(arg_19_0)
	if arg_19_0.params_ ~= nil and arg_19_0.params_.playCutScenesExitOnEnter == true then
		arg_19_0.params_.playCutScenesExitOnEnter = nil

		SummerRaceAction.OpenCutScenesPop({
			mode = "exit",
			finishCb = function()
				arg_19_0:SchedulePendingUnlockPop()
			end
		})

		return
	end

	arg_19_0:SchedulePendingUnlockPop()
end

function var_0_1.OnTop(arg_21_0)
	arg_21_0:UpdateBar()

	if arg_21_0.params_ ~= nil and arg_21_0.params_.replayStageUIAnim == true then
		arg_21_0.params_.replayStageUIAnim = nil

		local var_21_0 = arg_21_0.transform_:GetComponent(typeof(Animator))

		var_21_0:Play("UI_Activity_SummerRace_StageUI_cx", -1, 0)
		var_21_0:Update(0)
	end

	arg_21_0:SchedulePendingStageItemUnlockAnimNotify()
end

function var_0_1.UpdateBar(arg_22_0)
	arg_22_0.windowBarBackHandler_ = arg_22_0.windowBarBackHandler_ or function()
		if var_0_4() then
			return
		end

		JumpTools.Back()
	end

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(arg_22_0.windowBarBackHandler_)
end

function var_0_1.OnBehind(arg_24_0)
	return
end

function var_0_1.OnExit(arg_25_0)
	arg_25_0:StopPendingUnlockPopTimer()
	arg_25_0:StopPendingStageItemUnlockAnimNotifyTimer()
	arg_25_0:StopStageItemUnlockAnimTimer()
	arg_25_0:StopStageItemUnlockAnimators()
	var_0_5(arg_25_0)
	var_0_6(arg_25_0)
end

function var_0_1.SchedulePendingUnlockPop(arg_26_0)
	arg_26_0:StopPendingUnlockPopTimer()

	arg_26_0.pendingUnlockPopTimer_ = Timer.New(function()
		arg_26_0:StopPendingUnlockPopTimer()

		if manager.guide ~= nil and manager.guide:IsPlaying() then
			arg_26_0:SchedulePendingUnlockPop()

			return
		end

		local var_27_0, var_27_1 = SummerRaceAction.TryContinuePendingUnlockFlow()

		if var_27_0 == true and var_27_1 == "guide" then
			arg_26_0:SchedulePendingUnlockPop()
		end
	end, 0.1, 1)

	arg_26_0.pendingUnlockPopTimer_:Start()
end

function var_0_1.StopStageItemUnlockAnimTimer(arg_28_0)
	if arg_28_0.stageItemUnlockAnimTimer_ ~= nil then
		arg_28_0.stageItemUnlockAnimTimer_:Stop()

		arg_28_0.stageItemUnlockAnimTimer_ = nil
	end
end

function var_0_1.SchedulePendingStageItemUnlockAnimNotify(arg_29_0)
	arg_29_0:StopPendingStageItemUnlockAnimNotifyTimer()

	if SummerRaceData:HasPendingUnlockPop() == true then
		return
	end

	arg_29_0.pendingStageItemUnlockAnimNotifyTimer_ = Timer.New(function()
		arg_29_0:StopPendingStageItemUnlockAnimNotifyTimer()

		if SummerRaceData:HasPendingUnlockPop() == true then
			return
		end

		SummerRaceData:NotifyPendingStageItemUnlockAnim()
	end, var_0_14, 1)

	arg_29_0.pendingStageItemUnlockAnimNotifyTimer_:Start()
end

function var_0_1.StopPendingStageItemUnlockAnimNotifyTimer(arg_31_0)
	if arg_31_0.pendingStageItemUnlockAnimNotifyTimer_ ~= nil then
		arg_31_0.pendingStageItemUnlockAnimNotifyTimer_:Stop()

		arg_31_0.pendingStageItemUnlockAnimNotifyTimer_ = nil
	end
end

function var_0_1.StopStageItemUnlockAnimators(arg_32_0)
	if arg_32_0.stageItemViews_ == nil then
		return
	end

	for iter_32_0 = 1, #arg_32_0.stageItemViews_ do
		arg_32_0.stageItemViews_[iter_32_0]:StopUnlockAnim()
	end
end

function var_0_1.TryPlayPendingStageItemUnlockAnim(arg_33_0)
	local var_33_0 = SummerRaceData:ConsumePendingStageItemUnlockAnimModelList()

	if #var_33_0 == 0 then
		return false
	end

	arg_33_0:RefreshView()

	local var_33_1 = {}
	local var_33_2

	for iter_33_0 = 1, #var_33_0 do
		local var_33_3 = arg_33_0.stageItemStageIdMap_[tostring(var_33_0[iter_33_0].stageId)]

		if var_33_3 ~= nil then
			var_33_1[#var_33_1 + 1] = var_33_3

			var_33_3:SetUnlockLockVisible(true)

			var_33_2 = var_33_2 or var_33_3.presetName_
		end
	end

	if #var_33_1 == 0 then
		return false
	end

	arg_33_0:RefreshStageScroll(var_33_2)
	arg_33_0:StopStageItemUnlockAnimTimer()

	arg_33_0.stageItemUnlockAnimTimer_ = Timer.New(function()
		arg_33_0:StopStageItemUnlockAnimTimer()

		for iter_34_0 = 1, #var_33_1 do
			var_33_1[iter_34_0]:PlayUnlockAnim()
		end
	end, var_0_13, 1)

	arg_33_0.stageItemUnlockAnimTimer_:Start()

	return true
end

function var_0_1.StopPendingUnlockPopTimer(arg_35_0)
	if arg_35_0.pendingUnlockPopTimer_ ~= nil then
		arg_35_0.pendingUnlockPopTimer_:Stop()

		arg_35_0.pendingUnlockPopTimer_ = nil
	end
end

function var_0_1.OnClickStageItem(arg_36_0, arg_36_1, arg_36_2)
	if var_0_4() or gameContext:IsOpenRoute("summerRaceUnlockPopView") ~= nil or gameContext:IsOpenRoute("summerRaceUnlockBannerView") ~= nil or SummerRaceData:HasPendingUnlockPop() == true then
		return
	end

	if arg_36_2 and arg_36_2.isUnlocked then
		SummerRaceAction.SelectStage(arg_36_2.stageId)

		return
	end

	ShowTips("ACTIVITY_TANK_STAGE_LOCK")
end

function var_0_1.RefreshView(arg_37_0, arg_37_1)
	local var_37_0 = SummerRaceData:GetTournamentPageModel()
	local var_37_1 = var_0_2()
	local var_37_2 = var_0_9(var_37_0.stageNodes or {})
	local var_37_3 = var_0_12(var_37_2, var_37_1)
	local var_37_4 = {}
	local var_37_5

	arg_37_0.stageNodes_ = var_37_0.stageNodes or {}
	arg_37_0.stageItemStageIdMap_ = {}

	var_0_11(var_37_2, var_37_1)

	for iter_37_0 = 1, #var_37_1 do
		local var_37_6 = var_37_1[iter_37_0]
		local var_37_7 = arg_37_0.stageItemViewMap_[var_37_6.name]
		local var_37_8 = var_37_3[var_37_6.name]

		if var_37_7 == nil then
			error("[SummerRaceTournamentView] missing preset stage item: " .. tostring(var_37_6.name))
		end

		if var_37_8 ~= nil then
			var_37_8 = var_0_10(var_37_8)
			var_37_8.nodeVisualType = var_37_6.visualType
		end

		var_37_7:SetData(var_37_8, iter_37_0, handler(arg_37_0, arg_37_0.OnClickStageItem))

		var_37_7.presetName_ = var_37_6.name
		var_37_4[var_37_6.name] = true

		if var_37_8 ~= nil and var_37_8.stageId ~= nil then
			arg_37_0.stageItemStageIdMap_[tostring(var_37_8.stageId)] = var_37_7

			if SummerRaceData:HasPendingStageItemUnlockAnim(var_37_8.stageId) == true then
				var_37_7:SetUnlockLockVisible(true)
			end
		end

		if var_37_8 and var_37_8.isSelected then
			var_37_5 = var_37_6.name
		end
	end

	for iter_37_1, iter_37_2 in pairs(arg_37_0.stageItemViewMap_ or {}) do
		if var_37_4[iter_37_1] ~= true then
			iter_37_2:SetData(nil, 0, handler(arg_37_0, arg_37_0.OnClickStageItem))

			iter_37_2.presetName_ = nil
		end
	end

	if arg_37_1 ~= "championshipEntryClick" then
		arg_37_0:RefreshStageScroll(var_37_5)
	end
end

function var_0_1.Dispose(arg_38_0)
	var_0_5(arg_38_0)
	var_0_6(arg_38_0)
	arg_38_0:StopPendingUnlockPopTimer()
	arg_38_0:StopStageItemUnlockAnimTimer()
	arg_38_0:StopStageItemUnlockAnimators()

	if arg_38_0.stageItemViews_ then
		for iter_38_0 = 1, #arg_38_0.stageItemViews_ do
			arg_38_0.stageItemViews_[iter_38_0]:Dispose()
		end

		arg_38_0.stageItemViews_ = nil
	end

	arg_38_0.stageItemViewMap_ = nil
	arg_38_0.windowBarBackHandler_ = nil

	var_0_1.super.Dispose(arg_38_0)
end

return var_0_1
