class = var_0_10000

local var_0_0 = "IslandFishingOPView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("Mod.Island.Core.View.IslandASynLoadAndCacheSubView"))
local var_0_2 = 0
local var_0_3 = 1
local var_0_4 = 2
local var_0_5 = 3
local var_0_6 = 4
local var_0_7 = 5

function var_0_1.GetUIName(arg_1_0)
	return "IslandFishingOpUI"
end

function var_0_1.FirstFlush(arg_2_0)
	arg_2_0.loadingIdList = {}

	local var_2_0 = arg_2_0._tf

	arg_2_0.backBtn = var_1.Find(var_2_0, "back")

	local var_2_1 = arg_2_0._tf

	arg_2_0.fishContainer = var_1.Find(var_2_1, "container")
	arg_2_0.player = arg_2_0:GetView().player

	local var_2_2 = arg_2_0._tf

	arg_2_0.escapeTip = var_1.Find(var_2_2, "escape_tip")

	local var_2_3 = arg_2_0._tf

	arg_2_0.hookedTip = var_1.Find(var_2_3, "escape_tip_1")

	local var_2_4 = arg_2_0._tf

	arg_2_0.resultTr = var_1.Find(var_2_4, "result")

	local var_2_5 = arg_2_0.resultTr

	arg_2_0.resultNewTr = var_1.Find(var_2_5, "new")

	local var_2_6 = arg_2_0.resultTr

	arg_2_0.resultCupMinTr = var_1.Find(var_2_6, "cup_min")

	local var_2_7 = arg_2_0.resultTr

	arg_2_0.resultCupMaxTr = var_1.Find(var_2_7, "cup_max")

	local var_2_8 = arg_2_0.resultTr

	arg_2_0.resultRecordTr = var_1.Find(var_2_8, "record")

	local var_2_9 = arg_2_0.resultTr
	local var_2_10 = var_1.Find(var_2_9, "Text")
	local var_2_11 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.resultTxt = var_2_11(var_2_10, var_3(var_1_10004))
	GetOrAddComponent = var_1

	local var_2_12 = arg_2_0._tf

	typeof = var_3
	CanvasGroup = var_1_10004
	arg_2_0.cg = var_1(var_2_12, var_3(var_1_10004))
	setText = var_1

	local var_2_13 = arg_2_0._tf
	local var_2_14 = var_2.Find(var_2_13, "escape_tip/Text")

	i18n = var_2_13

	var_1(var_2_14, var_2_13("island_fishing_tip_escape"))

	setText = var_1

	local var_2_15 = arg_2_0._tf
	local var_2_16 = var_2.Find(var_2_15, "escape_tip_1/Text")

	i18n = var_2_15

	var_1(var_2_16, var_2_15("island_fishing_tip_hooked"))

	IslandFishingPlayer = var_1
	arg_2_0.fishingPlayer = var_1.New(arg_2_0:GetView(), arg_2_0:GetView().player)
	onButton = var_1

	local var_2_17 = arg_2_0
	local var_2_18 = arg_2_0.backBtn

	local function var_2_19()
		local var_3_0 = arg_2_0

		var_0.PauseGame(var_3_0)

		local var_3_1 = arg_2_0
		local var_3_2 = var_0.ShowMsgbox
		local var_3_3 = {}

		i18n = var_2_10003
		var_3_3.content = var_2_10003("island_fishing_exit")

		function var_3_3.onYes()
			local var_4_0 = arg_2_0

			var_0.ExitGame(var_4_0)

			return
		end

		function var_3_3.onHide()
			local var_5_0 = arg_2_0

			var_0.ResumeGame(var_5_0)

			return
		end

		var_3_2(var_3_1, var_3_3)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_2_17, var_2_18, var_2_19, var_1_10005)

	arg_2_0.state = var_0_2

	return
end

function var_0_1.Flush(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.fishPointId = arg_6_1
	arg_6_0.opBtnLocalPosition = arg_6_2
	arg_6_0.state = var_0_3

	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0.StartGame
	local var_6_2 = arg_6_1

	baitId = var_1_10006

	var_6_1(var_6_0, var_6_2, var_1_10006)

	pg = var_6_1

	local var_6_3 = var_6_1.TimeMgr.GetInstance()

	arg_6_0.startTime = var_3.GetServerTime(var_6_3)

	return
end

function var_0_1.StartGame(arg_7_0, arg_7_1)
	pg = var_1_10002

	local var_7_0 = var_1_10002.GameTrackerMgr.GetInstance()
	local var_7_1 = var_2.Record

	GameTrackerBuilder = var_1_10004

	var_7_1(var_7_0, var_1_10004.BuildIslandFishingEnter(arg_7_0.fishPointId))

	seriesAsync = var_7_1

	var_7_1({
		function(arg_8_0)
			local var_8_0 = arg_7_0

			var_1.BlockEvent(var_8_0)

			local var_8_1 = arg_7_0

			var_1.TurnToFishPoistion(var_8_1, arg_7_1, arg_8_0)

			return
		end,
		function(arg_9_0)
			local var_9_0 = arg_7_0

			var_1.CheckServerBait(var_9_0, arg_9_0)

			return
		end,
		function(arg_10_0)
			local var_10_0 = arg_7_0

			var_1.DisableOpView(var_10_0, arg_7_1)

			local var_10_1 = arg_7_0

			var_1.GetFishFromServer(var_10_1, arg_7_1, arg_10_0)

			return
		end,
		function(arg_11_0)
			local var_11_0 = arg_7_0

			var_1.LoadFishRodModel(var_11_0, arg_11_0)

			return
		end,
		function(arg_12_0)
			local var_12_0 = arg_7_0

			var_1.PreloadEffects(var_12_0, arg_7_1, arg_12_0)

			return
		end,
		function(arg_13_0)
			local var_13_0 = arg_7_0
			local var_13_1 = var_1.PlayEffect

			IslandFishingEffectMgr = var_2_10003

			local var_13_2 = var_2_10003.EFFECT_ENTER

			IslandFishingEffectMgr = var_2_10004

			var_13_1(var_13_0, var_13_2, var_2_10004.EFFECT_ENTER_TIME)

			local var_13_3 = arg_7_0

			var_1.PlayCastAnimation(var_13_3, arg_13_0)

			return
		end,
		function(arg_14_0)
			local var_14_0 = arg_7_0

			var_1.UnBlockEvent(var_14_0)

			local var_14_1 = arg_7_0
			local var_14_2 = var_1.PlayEffect

			IslandFishingEffectMgr = var_2_10003

			var_14_2(var_14_1, var_2_10003.EFFECT_WAITING)

			local var_14_3 = arg_7_0

			var_1.WaitingToBeHooked(var_14_3, arg_14_0)

			return
		end,
		function(arg_15_0)
			local var_15_0 = arg_7_0

			if not var_1.IsRunning(var_15_0) then
				local var_15_1 = arg_7_0

				if not var_1.IsPausing(var_15_1) then
					return
				end
			end

			local var_15_2 = arg_7_0

			var_1.RemoveWaitingToBeHooked(var_15_2)

			local var_15_3 = arg_7_0
			local var_15_4 = var_1.PlayEffect

			IslandFishingEffectMgr = var_2_10003

			var_15_4(var_15_3, var_2_10003.EFFECT_HOOKED)

			local var_15_5 = arg_7_0

			var_1.PlayHookedAnimation(var_15_5, arg_15_0)

			return
		end,
		function(arg_16_0)
			local var_16_0 = arg_7_0

			if not var_1.IsRunning(var_16_0) then
				local var_16_1 = arg_7_0

				if not var_1.IsPausing(var_16_1) then
					return
				end
			end

			local var_16_2 = arg_7_0
			local var_16_3 = var_1.PlayEffect

			IslandFishingEffectMgr = var_2_10003

			var_16_3(var_16_2, var_2_10003.EFFECT_SHAKE)

			local var_16_4 = arg_7_0

			var_1.LoadQteUI(var_16_4, arg_16_0)

			return
		end
	})

	return
end

function var_0_1.PreloadEffects(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_0.fishingPlayer

	var_3.PreloadEffects(var_17_0, arg_17_2)

	return
end

function var_0_1.PlayEffect(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_0.fishingPlayer

	var_3.PlayEffect(var_18_0, arg_18_1, arg_18_2)

	return
end

function var_0_1.ExitGame(arg_19_0)
	arg_19_0:BlockEvent()
	arg_19_0:OnCancel(function()
		local var_20_0 = arg_19_0

		var_0.UnBlockEvent(var_20_0)

		local var_20_1 = arg_19_0

		var_0.Dispose(var_20_1)

		return
	end)

	return
end

function var_0_1.SwitchToFishingCamrea(arg_21_0, arg_21_1)
	pg = var_1_10002

	local var_21_0

	if not var_1_10002.island_fish_point[arg_21_1].camera then
		IslandConst = var_21_0
		var_21_0 = var_21_0.FISHING_CAMERA_NAME
	end

	IslandCameraMgr = var_1_10003

	local var_21_1 = var_1_10003.instance
	local var_21_2 = var_3.GetVirtualCamera(var_21_1, var_21_0)

	var_21_2.Follow = arg_21_0.player._tf
	var_21_2.LookAt = arg_21_0.player._tf
	IslandCameraMgr = var_4

	local var_21_3 = var_4.instance

	var_4.ActiveVirtualCamera(var_21_3, var_21_0)

	return
end

function var_0_1.ResetCamrea(arg_22_0)
	IslandCameraMgr = var_1_10001

	local var_22_0 = var_1_10001.instance
	local var_22_1 = var_1.ActiveVirtualCamera

	IslandConst = var_1_10003

	var_22_1(var_22_0, var_1_10003.FOLLOW_CAMERA_NAME)

	return
end

function var_0_1.CheckServerBait(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0:GetSelfIsland()
	local var_23_1 = var_2.GetFishingAgency(var_23_0)

	if not var_2.NeedUpdateServerBait(var_23_1) then
		arg_23_1()

		return
	end

	local var_23_2 = arg_23_0
	local var_23_3 = arg_23_0.NotifiyMeditor

	IslandBaseMediator = var_1_10006

	var_23_3(var_23_2, var_1_10006.EXCHANGE_LURE, var_2:GetBaitId(), arg_23_0.fishPointId, arg_23_1)

	return
end

function var_0_1.GetFishFromServer(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = arg_24_0
	local var_24_1 = arg_24_0.NotifiyMeditor

	IslandBaseMediator = var_1_10005

	var_24_1(var_24_0, var_1_10005.GO_FISHING, arg_24_1, 0, function(arg_25_0, arg_25_1, arg_25_2)
		if arg_25_0 == 0 and arg_25_1 == 0 then
			local var_25_0 = arg_24_0

			var_3.UnBlockEvent(var_25_0)

			arg_24_0.state = var_0_5
		else
			arg_24_0.fishId = arg_25_0
			arg_24_0.weight = arg_25_1
			arg_24_0.cupType = arg_25_2

			local var_25_1 = arg_24_0

			var_3.InitArgs(var_25_1, arg_25_0, arg_25_1)
			arg_24_2()
		end

		return
	end)

	return
end

function var_0_1.InitArgs(arg_26_0, arg_26_1, arg_26_2)
	pg = var_1_10003

	local var_26_0 = var_1_10003.island_fish[arg_26_1]

	assert = var_1_10004

	var_1_10004(var_26_0, "island_fish>>>>>>>>>>>>" .. arg_26_1)

	arg_26_0.fishId = arg_26_1
	arg_26_0.fishConfig = var_26_0
	arg_26_0.fishName = var_26_0.name
	arg_26_0.fishWeight = arg_26_2

	local var_26_1 = var_26_0.bite_time[1]
	local var_26_2 = var_26_0.bite_time[2]

	math = var_6
	arg_26_0.biteTime = var_6.random(var_26_1, var_26_2)

	local var_26_3 = arg_26_0:GetView()
	local var_26_4 = var_6.GetSelfIsland(var_26_3)
	local var_26_5 = var_6.GetFishingAgency(var_26_4)

	arg_26_0.isNew = var_6.IsNewFish(var_26_5, arg_26_1)
	arg_26_0.isNewRecord = var_6:IsNewRecord(arg_26_1, arg_26_2)

	local var_26_6 = var_6
	local var_26_7 = var_6.GetFishRodId(var_26_6)

	assert = var_26_6
	pg = var_9

	var_26_6(var_9.island_fish_rod[var_26_7], "island_fish_rod>>>>>>>>>>>>" .. var_26_7)

	pg = var_26_6
	arg_26_0.fishRodId = var_26_6.island_fish_rod[var_26_7].attachment_id
	pg = var_8
	arg_26_0.rodProfile = var_8.island_fish_rod[var_26_7].qte_effect
	arg_26_0.fishPrifile = var_26_0.qte_effect

	if not arg_26_0.rodProfile or arg_26_0.rodProfile == "" then
		arg_26_0.rodProfile = "default"
	end

	if not arg_26_0.fishPrifile or arg_26_0.fishPrifile == "" then
		arg_26_0.fishPrifile = "default"
	end

	local var_26_8 = arg_26_0.fishingPlayer

	var_8.InitArgs(var_26_8, arg_26_0.fishPointId, arg_26_0.fishRodId, arg_26_0.fishId)

	return
end

function var_0_1.TurnToFishPoistion(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = arg_27_0.fishingPlayer

	var_3.TurnToFishPoistion(var_27_0, arg_27_1, arg_27_2)

	return
end

function var_0_1.PlayCastAnimation(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_0.fishingPlayer

	var_2.PlayCastAnimation(var_28_0, arg_28_1)

	return
end

function var_0_1.PlayHookedAnimation(arg_29_0, arg_29_1)
	arg_29_0:ShowTip(arg_29_0.hookedTip, 1, arg_29_1)

	local var_29_0 = arg_29_0.fishingPlayer

	var_2.PlayHookedAnimation(var_29_0)

	return
end

function var_0_1.PlayHookEndAnimation(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_0.fishingPlayer

	var_2.PlayHookEndAnimation(var_30_0, arg_30_1)

	return
end

function var_0_1.PlayFailAnimation(arg_31_0, arg_31_1)
	local var_31_0 = arg_31_0.fishingPlayer

	var_2.PlayFailAnimation(var_31_0, arg_31_1)

	return
end

function var_0_1.PlayHookMiddleAnimation(arg_32_0)
	local var_32_0 = arg_32_0.fishingPlayer

	var_1.PlayHookMiddleAnimation(var_32_0)

	return
end

function var_0_1.PlayCancelAnimation(arg_33_0, arg_33_1)
	local var_33_0 = arg_33_0.fishingPlayer

	var_2.PlayCancelAnimation(var_33_0, arg_33_1)

	return
end

function var_0_1.PlayMovementAnimation(arg_34_0)
	local var_34_0 = arg_34_0.fishingPlayer

	var_1.PlayMovementAnimation(var_34_0)

	return
end

function var_0_1.WaitingToBeHooked(arg_35_0, arg_35_1)
	arg_35_0:RemoveWaitingToBeHooked()

	Timer = var_2
	arg_35_0.beitTimer = var_2.New(arg_35_1, arg_35_0.biteTime, 1)

	local var_35_0 = arg_35_0.beitTimer

	var_2.Start(var_35_0)

	return
end

function var_0_1.RemoveWaitingToBeHooked(arg_36_0)
	if arg_36_0.beitTimer then
		local var_36_0 = arg_36_0.beitTimer

		var_1.Stop(var_36_0)

		arg_36_0.beitTimer = nil
	end

	return
end

function var_0_1.LoadQteUI(arg_37_0, arg_37_1)
	local var_37_0
	local var_37_1

	arg_37_0:BlockEvent()

	seriesAsync = var_4

	var_4({
		function(arg_38_0)
			IslandAssetLoadDispatcher = var_2_10001

			local var_38_0 = var_2_10001.Instance
			local var_38_1 = var_1.Enqueue
			local var_38_2 = "island/FishRod/" .. arg_37_0.rodProfile
			local var_38_3 = ""

			typeof = var_2_10005
			FishRodProfile = var_2_10006

			local var_38_4 = var_2_10005(var_2_10006)

			UnityEngine = var_2_10006

			local var_38_5 = var_38_1(var_38_0, var_38_2, var_38_3, var_38_4, var_2_10006.Events.UnityAction_UnityEngine_Object(function(arg_39_0)
				var_37_0 = arg_39_0

				arg_38_0()

				return
			end), true, true)
			local var_38_6 = arg_37_0

			var_2.AddLoadingID(var_38_6, var_38_5)

			return
		end,
		function(arg_40_0)
			onNextTick = var_2_10001

			var_2_10001(arg_40_0)

			return
		end,
		function(arg_41_0)
			IslandAssetLoadDispatcher = var_2_10001

			local var_41_0 = var_2_10001.Instance
			local var_41_1 = var_1.Enqueue
			local var_41_2 = "island/fishingcurve/" .. arg_37_0.fishPrifile
			local var_41_3 = ""

			typeof = var_2_10005
			FishMotionProfile = var_2_10006

			local var_41_4 = var_2_10005(var_2_10006)

			UnityEngine = var_2_10006

			local var_41_5 = var_41_1(var_41_0, var_41_2, var_41_3, var_41_4, var_2_10006.Events.UnityAction_UnityEngine_Object(function(arg_42_0)
				var_37_1 = arg_42_0

				arg_41_0()

				return
			end), true, true)
			local var_41_6 = arg_37_0

			var_2.AddLoadingID(var_41_6, var_41_5)

			return
		end,
		function(arg_43_0)
			IslandAssetLoadDispatcher = var_2_10001

			local var_43_0 = var_2_10001.Instance
			local var_43_1 = var_1.Enqueue
			local var_43_2 = "UI/IslandFishingQteUI"
			local var_43_3 = ""

			typeof = var_2_10005
			GameObject = var_2_10006

			local var_43_4 = var_2_10005(var_2_10006)

			UnityEngine = var_2_10006

			local var_43_5 = var_43_1(var_43_0, var_43_2, var_43_3, var_43_4, var_2_10006.Events.UnityAction_UnityEngine_Object(function(arg_44_0)
				local var_44_0 = arg_37_0

				var_1.OnLoadQTE(var_44_0, arg_44_0, var_37_1, var_37_0)
				arg_43_0()

				return
			end), true, true)
			local var_43_6 = arg_37_0

			var_2.AddLoadingID(var_43_6, var_43_5)

			return
		end,
		function(arg_45_0)
			onNextTick = var_2_10001

			var_2_10001(arg_45_0)

			return
		end
	}, function()
		local var_46_0 = arg_37_0

		var_0.UpdateQteLayout(var_46_0)

		local var_46_1 = arg_37_0

		if var_0.IsPausing(var_46_1) then
			local var_46_2 = arg_37_0

			var_0.PauseGame(var_46_2)
		end

		local var_46_3 = arg_37_0

		var_0.UnBlockEvent(var_46_3)
		arg_37_1()

		return
	end)

	return
end

function var_0_1.OnLoadQTE(arg_47_0, arg_47_1, arg_47_2, arg_47_3)
	Object = var_1_10004
	arg_47_0.qteTr = var_1_10004.Instantiate(arg_47_1, arg_47_0.fishContainer)

	local var_47_0 = arg_47_0.qteTr.transform

	arg_47_0.clickEffect = var_5.Find(var_47_0, "fishing_btn/vfx_diaoyuui_fankui")

	local var_47_1 = arg_47_0.qteTr.transform

	arg_47_0.hitEffect = var_5.Find(var_47_1, "bar/vfx_diaoyuui_mingzhong")

	local var_47_2 = arg_47_0.qteTr.transform
	local var_47_3 = var_5.Find(var_47_2, "power")
	local var_47_4 = var_5.GetComponent

	typeof = var_7
	Animation = var_1_10008
	arg_47_0.getAnim = var_47_4(var_47_3, var_7(var_1_10008))

	local var_47_5 = arg_47_0.qteTr.transform
	local var_47_6 = var_5.Find(var_47_5, "power")
	local var_47_7 = var_5.GetComponent

	typeof = var_7
	DftAniEvent = var_1_10008
	arg_47_0.getAnimDft = var_47_7(var_47_6, var_7(var_1_10008))

	local var_47_8 = arg_47_0.qteTr.transform

	arg_47_0.failedEffect = var_5.Find(var_47_8, "P_glow_02")

	local var_47_9 = arg_47_0.qteTr.transform
	local var_47_10 = var_5.Find(var_47_9, "energy")
	local var_47_11 = var_5.GetComponent

	typeof = var_7
	Animation = var_1_10008
	arg_47_0.failedAnim = var_47_11(var_47_10, var_7(var_1_10008))

	local var_47_12 = arg_47_0.qteTr.transform
	local var_47_13 = var_5.Find(var_47_12, "energy")
	local var_47_14 = var_5.GetComponent

	typeof = var_7
	DftAniEvent = var_1_10008
	arg_47_0.failedAnimDft = var_47_14(var_47_13, var_7(var_1_10008))

	local var_47_15 = arg_47_0.qteTr
	local var_47_16 = var_5.GetComponent

	typeof = var_7
	Animation = var_1_10008
	arg_47_0.qteAim = var_47_16(var_47_15, var_7(var_1_10008))

	local var_47_17 = arg_47_0.qteTr
	local var_47_18 = var_5.GetComponent

	typeof = var_7
	DftAniEvent = var_1_10008
	arg_47_0.qteAimDft = var_47_18(var_47_17, var_7(var_1_10008))

	local var_47_19 = arg_47_0.qteTr.transform

	arg_47_0.clickableTip = var_5.Find(var_47_19, "fishing_btn/vx")

	local var_47_20 = arg_47_0.qteTr
	local var_47_21 = var_5.GetComponent

	typeof = var_7
	IslandFishingSliderDriver = var_1_10008

	local var_47_22 = var_47_21(var_47_20, var_7(var_1_10008))

	var_5.UpdateFish(var_47_22, arg_47_2)
	var_5:UpdateRod(arg_47_3)
	arg_47_0:AddResultListener(var_5)

	return
end

function var_0_1.UpdateQteLayout(arg_48_0)
	if not arg_48_0.qteTr then
		return
	end

	local var_48_0 = arg_48_0._tf
	local var_48_1 = var_1.TransformPoint(var_48_0, arg_48_0.opBtnLocalPosition)
	local var_48_2 = arg_48_0.qteTr.transform
	local var_48_3 = var_2.InverseTransformPoint(var_48_2, var_48_1)
	local var_48_4 = arg_48_0.qteTr.transform
	local var_48_5 = var_3.Find(var_48_4, "fishing_btn")

	Vector3 = var_48_4
	var_48_5.localPosition = var_48_4(var_48_3.x, var_48_3.y, 0)

	return
end

function var_0_1.UnloadQteUI(arg_49_0, arg_49_1)
	arg_49_0:RemoveResultListener()

	if arg_49_0.qteTr and arg_49_1 then
		local var_49_0 = arg_49_0.qteAimDft

		var_2.SetEndEvent(var_49_0, nil)

		local var_49_1 = arg_49_0.qteAimDft

		var_2.SetEndEvent(var_49_1, function()
			local var_50_0 = arg_49_0.qteAimDft

			var_0.SetEndEvent(var_50_0, nil)

			Object = var_0

			var_0.Destroy(arg_49_0.qteTr)

			arg_49_0.qteTr = nil

			arg_49_1()

			return
		end)

		local var_49_2 = arg_49_0.qteAim

		var_2.Play(var_49_2, "anim_IslandFishingQteUI_out")
	elseif arg_49_0.qteTr and not arg_49_1 then
		Object = var_2

		var_2.Destroy(arg_49_0.qteTr)

		arg_49_0.qteTr = nil
	elseif arg_49_1 then
		arg_49_1()
	end

	return
end

function var_0_1.AddResultListener(arg_51_0, arg_51_1)
	function arg_51_1.OnSuccess()
		local var_52_0 = arg_51_0

		var_0.OnQteSuccess(var_52_0)

		return
	end

	function arg_51_1.OnFailure()
		local var_53_0 = arg_51_0

		var_0.OnQteFailed(var_53_0)

		return
	end

	function arg_51_1.OnProgress(arg_54_0)
		local var_54_0 = arg_51_0

		var_1.OnQteProgress(var_54_0, arg_54_0)

		return
	end

	function arg_51_1.OnHit(arg_55_0)
		local var_55_0 = arg_51_0

		var_1.OnHit(var_55_0, arg_55_0)

		return
	end

	arg_51_0.fishingSliderDriver = arg_51_1

	return
end

function var_0_1.RemoveResultListener(arg_56_0)
	if arg_56_0.fishingSliderDriver then
		local var_56_0 = arg_56_0.fishingSliderDriver

		var_56_0.OnSuccess = nil
		var_56_0.OnFailure = nil
		var_56_0.OnProgress = nil
		var_56_0.OnHit = nil
		arg_56_0.fishingSliderDriver = nil
	end

	return
end

function var_0_1.LoadFishRodModel(arg_57_0, arg_57_1)
	local var_57_0 = arg_57_0.fishingPlayer

	var_2.LoadFishRodModel(var_57_0, arg_57_1)

	return
end

function var_0_1.UnLoadFishRodModel(arg_58_0)
	local var_58_0 = arg_58_0.fishingPlayer
	local var_58_1 = var_1.UnLoadFishRodModel

	callback = var_1_10003

	var_58_1(var_58_0, var_1_10003)

	return
end

function var_0_1.LoadFishModel(arg_59_0, arg_59_1)
	local var_59_0 = arg_59_0.fishingPlayer

	var_2.LoadFishModel(var_59_0, arg_59_1)

	return
end

function var_0_1.UnLoadFishModel(arg_60_0)
	local var_60_0 = arg_60_0.fishingPlayer
	local var_60_1 = var_1.UnLoadFishModel

	callback = var_1_10003

	var_60_1(var_60_0, var_1_10003)

	return
end

function var_0_1.NotifyServerResultSuccess(arg_61_0, arg_61_1)
	local var_61_0 = arg_61_0
	local var_61_1 = arg_61_0.NotifiyMeditor

	IslandBaseMediator = var_1_10004

	local var_61_2 = var_1_10004.FISHING_RESULT

	IslandConst = var_1_10005

	var_61_1(var_61_0, var_61_2, var_1_10005.FISHING_OP_SUCCESS, arg_61_0.fishPointId, arg_61_0.fishId, arg_61_0.weight, arg_61_0.cupType, arg_61_1)

	return
end

function var_0_1.NotifyServerResultFaild(arg_62_0, arg_62_1)
	local var_62_0 = arg_62_0
	local var_62_1 = arg_62_0.NotifiyMeditor

	IslandBaseMediator = var_1_10004

	local var_62_2 = var_1_10004.FISHING_RESULT

	IslandConst = var_1_10005

	var_62_1(var_62_0, var_62_2, var_1_10005.FISHING_OP_FAILD, arg_62_0.fishPointId, arg_62_0.fishId, arg_62_0.weight, arg_62_0.cupType, arg_62_1)

	return
end

function var_0_1.NotifyServerResultCancel(arg_63_0, arg_63_1)
	local var_63_0 = arg_63_0
	local var_63_1 = arg_63_0.NotifiyMeditor

	IslandBaseMediator = var_1_10004

	local var_63_2 = var_1_10004.FISHING_RESULT

	IslandConst = var_1_10005

	var_63_1(var_63_0, var_63_2, var_1_10005.FISHING_OP_CANCEL, arg_63_0.fishPointId, arg_63_0.fishId, arg_63_0.weight, arg_63_0.cupType, arg_63_1)

	return
end

function var_0_1.IsRunning(arg_64_0)
	return arg_64_0.state == var_0_3
end

function var_0_1.IsPausing(arg_65_0)
	return arg_65_0.state == var_0_7
end

function var_0_1.PauseGame(arg_66_0)
	arg_66_0.state = var_0_7

	if arg_66_0.fishingSliderDriver then
		local var_66_0 = arg_66_0.fishingSliderDriver

		var_1.Pause(var_66_0)
	end

	return
end

function var_0_1.ResumeGame(arg_67_0)
	arg_67_0.state = var_0_3

	if arg_67_0.fishingSliderDriver then
		local var_67_0 = arg_67_0.fishingSliderDriver

		var_1.Reseume(var_67_0)
	end

	return
end

function var_0_1.BuildResultData(arg_68_0, arg_68_1)
	if not arg_68_0.fishingSliderDriver then
		return
	end

	local var_68_0 = arg_68_0:GetView()
	local var_68_1 = var_2.GetSelfIsland(var_68_0)
	local var_68_2 = var_2.GetFishingAgency(var_68_1)
	local var_68_3 = var_2.GetFishRodId(var_68_2)
	local var_68_4 = var_2:GetBaitId()
	local var_68_5 = arg_68_0.fishingSliderDriver.SuccesCnt
	local var_68_6 = arg_68_0.fishingSliderDriver.FailCnt

	math = var_1_10007

	local var_68_7 = var_1_10007.floor(arg_68_0.fishingSliderDriver.PowerRatio * 100)

	math = var_8

	local var_68_8 = var_8.floor(arg_68_0.fishingSliderDriver.Ratio * 100)

	pg = var_9

	local var_68_9 = var_9.GameTrackerMgr.GetInstance()
	local var_68_10 = var_9.Record

	GameTrackerBuilder = var_1_10011

	var_68_10(var_68_9, var_1_10011.BuildIslandFishingResult(arg_68_0.fishPointId, var_68_3, var_68_4, arg_68_0.fishId, arg_68_0.fishWeight, var_68_5, var_68_6, var_68_7, var_68_8, arg_68_1))

	return
end

function var_0_1.OnQteSuccess(arg_69_0)
	arg_69_0.state = var_0_4

	arg_69_0:BuildResultData(1)
	arg_69_0:BlockEvent()

	seriesAsync = var_1

	var_1({
		function(arg_70_0)
			local var_70_0 = arg_69_0

			var_1.PlayGetEffect(var_70_0, arg_70_0)

			return
		end,
		function(arg_71_0)
			local var_71_0 = arg_69_0

			var_1.UnloadQteUI(var_71_0, arg_71_0)

			return
		end,
		function(arg_72_0)
			local var_72_0 = arg_69_0

			var_1.NotifyServerResultSuccess(var_72_0, arg_72_0)

			return
		end,
		function(arg_73_0)
			local var_73_0 = arg_69_0

			var_1.LoadFishModel(var_73_0, arg_73_0)

			return
		end,
		function(arg_74_0)
			local var_74_0 = arg_69_0
			local var_74_1 = var_1.PlayEffect

			IslandFishingEffectMgr = var_2_10003

			local var_74_2 = var_2_10003.EFFECT_LEAVE

			IslandFishingEffectMgr = var_2_10004

			var_74_1(var_74_0, var_74_2, var_2_10004.EFFECT_LEAVE_TIME)

			local var_74_3 = arg_69_0

			var_1.PlayHookEndAnimation(var_74_3, arg_74_0)

			return
		end,
		function(arg_75_0)
			local var_75_0 = arg_69_0

			var_1.WaitForExit(var_75_0, arg_75_0)

			local var_75_1 = arg_69_0

			var_1.DisplayResult(var_75_1)

			return
		end
	}, function()
		local var_76_0 = arg_69_0

		var_0.UnBlockEvent(var_76_0)

		local var_76_1 = arg_69_0

		var_0.Dispose(var_76_1)

		return
	end)

	return
end

function var_0_1.PlayGetEffect(arg_77_0, arg_77_1)
	local var_77_0 = arg_77_0.getAnimDft

	var_2.SetEndEvent(var_77_0, nil)

	local var_77_1 = arg_77_0.getAnimDft

	var_2.SetEndEvent(var_77_1, function()
		local var_78_0 = arg_77_0.getAnimDft

		var_0.SetEndEvent(var_78_0, nil)

		onNextTick = var_0

		var_0(arg_77_1)

		return
	end)

	local var_77_2 = arg_77_0.getAnim

	var_2.Play(var_77_2, "anim_IslandExchangeUI_power_get")

	return
end

function var_0_1.WaitForExit(arg_79_0, arg_79_1)
	local var_79_0 = arg_79_0

	arg_79_0.RemoveWaitForExit(var_79_0)

	pg = var_2

	local var_79_1 = var_2.island_set.island_fishing_success_exit_time.key_value_int

	Timer = var_79_0

	local var_79_2 = var_79_0.New
	local var_79_3 = arg_79_1

	math = var_1_10005
	arg_79_0.exitTimer = var_79_2(var_79_3, var_1_10005.max(0.01, var_79_1), 1)

	local var_79_4 = arg_79_0.exitTimer

	var_3.Start(var_79_4)

	return
end

function var_0_1.RemoveWaitForExit(arg_80_0)
	if arg_80_0.exitTimer then
		local var_80_0 = arg_80_0.exitTimer

		var_1.Stop(var_80_0)

		arg_80_0.exitTimer = nil
	end

	return
end

function var_0_1.OnQteFailed(arg_81_0)
	arg_81_0:BuildResultData(0)

	local var_81_0 = arg_81_0
	local var_81_1 = arg_81_0.PlayEffect

	IslandFishingEffectMgr = var_3

	var_81_1(var_81_0, var_3.EFFECT_NORMAL)

	arg_81_0.state = var_0_5

	arg_81_0:ShowTip(arg_81_0.escapeTip)
	arg_81_0:BlockEvent()

	parallelAsync = var_1

	var_1({
		function(arg_82_0)
			local var_82_0 = arg_81_0

			var_1.UnloadQteUI(var_82_0, arg_82_0)

			return
		end,
		function(arg_83_0)
			local var_83_0 = arg_81_0

			var_1.PlayFailAnimation(var_83_0, arg_83_0)

			return
		end
	}, function()
		local var_84_0 = arg_81_0

		var_0.UnBlockEvent(var_84_0)

		local var_84_1 = arg_81_0

		var_0.NotifyServerResultFaild(var_84_1, function()
			return
		end)

		local var_84_2 = arg_81_0

		var_0.Dispose(var_84_2)

		return
	end)

	return
end

function var_0_1.OnQteProgress(arg_86_0, arg_86_1)
	if arg_86_1 > 0 and not arg_86_0.isFirstClick then
		arg_86_0:PlayHookMiddleAnimation()

		arg_86_0.isFirstClick = true
	end

	return
end

function var_0_1.OnHit(arg_87_0, arg_87_1)
	if not arg_87_1 then
		setActive = var_1_10002

		var_1_10002(arg_87_0.failedEffect, true)

		local var_87_0 = arg_87_0.failedAnimDft

		var_1_10002.SetEndEvent(var_87_0, nil)

		local var_87_1 = arg_87_0.failedAnimDft

		var_1_10002.SetEndEvent(var_87_1, function()
			local var_88_0 = arg_87_0.failedAnimDft

			var_0.SetEndEvent(var_88_0, nil)

			setActive = var_0

			var_0(arg_87_0.failedEffect, false)

			return
		end)

		local var_87_2 = arg_87_0.failedAnim

		var_1_10002.Play(var_87_2, "anim_IslandExchangeUI_default_energy")
	else
		setActive = var_1_10002

		var_1_10002(arg_87_0.hitEffect, false)

		setActive = var_1_10002

		var_1_10002(arg_87_0.hitEffect, true)
	end

	setActive = var_1_10002

	var_1_10002(arg_87_0.clickEffect, false)

	setActive = var_1_10002

	var_1_10002(arg_87_0.clickEffect, true)

	setActive = var_1_10002

	var_1_10002(arg_87_0.clickableTip, false)

	return
end

function var_0_1.OnCancel(arg_89_0, arg_89_1)
	if arg_89_0.state == var_0_3 or arg_89_0.state == var_0_2 then
		arg_89_0:BuildResultData(2)

		pg = var_2

		local var_89_0 = var_2.GameTrackerMgr.GetInstance()
		local var_89_1 = var_2.Record

		GameTrackerBuilder = var_4

		local var_89_2 = var_4.BuildIslandFishingCancel
		local var_89_3 = arg_89_0.fishPointId

		IsNil = var_1_10006

		var_89_1(var_89_0, var_89_2(var_89_3, var_1_10006(arg_89_0.qteTr) and 1 or 2))

		local var_89_4 = arg_89_0
		local var_89_5 = arg_89_0.PlayEffect

		IslandFishingEffectMgr = var_4

		var_89_5(var_89_4, var_4.EFFECT_NORMAL)

		arg_89_0.state = var_0_6
		parallelAsync = var_2

		var_2({
			function(arg_90_0)
				local var_90_0 = arg_89_0

				var_1.UnloadQteUI(var_90_0, arg_90_0)

				return
			end,
			function(arg_91_0)
				local var_91_0 = arg_89_0

				var_1.PlayCancelAnimation(var_91_0, arg_91_0)

				return
			end
		}, function()
			local var_92_0 = arg_89_0

			var_0.NotifyServerResultCancel(var_92_0, function()
				return
			end)
			arg_89_1()

			return
		end)
	else
		arg_89_0.state = var_0_6

		arg_89_0:Dispose()
	end

	return
end

function var_0_1.DisplayResult(arg_94_0)
	local var_94_0 = arg_94_0.resultTxt

	var_94_0.text = arg_94_0.fishName .. "   " .. arg_94_0.fishWeight / 1000 .. "KG"
	setActive = var_94_0

	var_94_0(arg_94_0.resultNewTr, arg_94_0.isNew)

	setActive = var_94_0

	local var_94_1 = arg_94_0.resultCupMaxTr
	local var_94_2 = arg_94_0.cupType

	IslandFish = var_4

	var_94_0(var_94_1, var_94_2 == var_4.CUP_STATE_MAX)

	setActive = var_94_0

	local var_94_3 = arg_94_0.resultCupMinTr
	local var_94_4 = arg_94_0.cupType

	IslandFish = var_4

	var_94_0(var_94_3, var_94_4 == var_4.CUP_STATE_MIN)

	setActive = var_94_0

	var_94_0(arg_94_0.resultRecordTr, arg_94_0.isNewRecord)
	arg_94_0:ShowTip(arg_94_0.resultTr)

	return
end

function var_0_1.DisableOpView(arg_95_0, arg_95_1)
	arg_95_0:SwitchToFishingCamrea(arg_95_1)

	local var_95_0 = arg_95_0:GetView()

	var_2.DisablePlayerOp(var_95_0)

	local var_95_1 = arg_95_0
	local var_95_2 = arg_95_0.NotifiyIsland

	ISLAND_EX_EVT = var_4

	var_95_2(var_95_1, var_4.ENTER_FISH_POINT)

	return
end

function var_0_1.EnableOpView(arg_96_0)
	arg_96_0:ResetCamrea()

	local var_96_0 = arg_96_0:GetView()

	var_1.EnablePlayerOp(var_96_0)

	local var_96_1 = arg_96_0
	local var_96_2 = arg_96_0.NotifiyIsland

	ISLAND_EX_EVT = var_1_10003

	var_96_2(var_96_1, var_1_10003.EXIT_FISH_POINT)

	return
end

function var_0_1.ShowTip(arg_97_0, arg_97_1, arg_97_2, arg_97_3)
	setActive = var_1_10004

	var_1_10004(arg_97_1, true)
	arg_97_0:RemoveTimer()

	Timer = var_4
	arg_97_0.timer = var_4.New(function()
		local var_98_0 = arg_97_0

		var_0.RemoveTimer(var_98_0)

		setActive = var_0

		var_0(arg_97_1, false)

		if arg_97_3 then
			arg_97_3()
		end

		return
	end, arg_97_2 or 3, 1)

	local var_97_0 = arg_97_0.timer

	var_4.Start(var_97_0)

	return
end

function var_0_1.RemoveTimer(arg_99_0)
	if arg_99_0.timer then
		local var_99_0 = arg_99_0.timer

		var_1.Stop(var_99_0)

		arg_99_0.timer = nil
	end

	return
end

function var_0_1.BlockEvent(arg_100_0)
	arg_100_0.cg.blocksRaycasts = false

	return
end

function var_0_1.UnBlockEvent(arg_101_0)
	arg_101_0.cg.blocksRaycasts = true

	return
end

function var_0_1.AddLoadingID(arg_102_0, arg_102_1)
	table = var_1_10002

	var_1_10002.insert(arg_102_0.loadingIdList, arg_102_1)

	return
end

function var_0_1.OnHide(arg_103_0)
	arg_103_0:Clear()

	return
end

function var_0_1.Clear(arg_104_0)
	arg_104_0:EnableOpView()

	local var_104_0 = arg_104_0
	local var_104_1 = arg_104_0.PlayEffect

	IslandFishingEffectMgr = var_1_10003

	var_104_1(var_104_0, var_1_10003.EFFECT_NORMAL)

	ipairs = var_104_1

	for iter_104_0, iter_104_1 in var_104_1(arg_104_0.loadingIdList) do
		IslandAssetLoadDispatcher = var_1_10006

		local var_104_2 = var_1_10006.Instance

		var_1_10006.Cancel(var_104_2, iter_104_1)
	end

	arg_104_0.loadingIdList = {}

	if arg_104_0.failedAnimDft then
		local var_104_3 = arg_104_0.failedAnimDft

		var_1.SetEndEvent(var_104_3, nil)

		arg_104_0.failedAnimDft = nil
	end

	if arg_104_0.getAnimDft then
		local var_104_4 = arg_104_0.getAnimDft

		var_1.SetEndEvent(var_104_4, nil)

		arg_104_0.getAnimDft = nil
	end

	if arg_104_0.qteAimDft then
		local var_104_5 = arg_104_0.qteAimDft

		var_1.SetEndEvent(var_104_5, nil)

		arg_104_0.qteAimDft = nil
	end

	arg_104_0:UnloadQteUI()
	arg_104_0:UnLoadFishModel()
	arg_104_0:UnLoadFishRodModel()

	setActive = var_1

	var_1(arg_104_0.escapeTip, false)

	setActive = var_1

	var_1(arg_104_0.hookedTip, false)

	setActive = var_1

	var_1(arg_104_0.resultTr, false)
	arg_104_0:RemoveWaitingToBeHooked()
	arg_104_0:RemoveTimer()
	arg_104_0:RemoveWaitForExit()

	arg_104_0.isFirstClick = false

	arg_104_0:PlayMovementAnimation()

	if arg_104_0.fishingPlayer then
		local var_104_6 = arg_104_0.fishingPlayer

		var_1.Dispose(var_104_6)

		arg_104_0.fishingPlayer = nil
	end

	arg_104_0.state = var_0_2
	pg = var_1

	local var_104_7 = var_1.TimeMgr.GetInstance()
	local var_104_8 = var_1.GetServerTime(var_104_7) - arg_104_0.startTime

	pg = var_3

	local var_104_9 = var_3.GameTrackerMgr.GetInstance()
	local var_104_10 = var_3.Record

	GameTrackerBuilder = iter_104_1

	var_104_10(var_104_9, iter_104_1.BuildIslandFishingExit(arg_104_0.fishPointId, var_104_8))

	return
end

function var_0_1.OnDestroy(arg_105_0)
	arg_105_0:Clear()

	return
end

return var_0_1
