local var_0_0 = class("IslandFishingOPView", import("Mod.Island.Core.View.IslandASynLoadAndCacheSubView"))
local var_0_1 = 0
local var_0_2 = 1
local var_0_3 = 2
local var_0_4 = 3
local var_0_5 = 4
local var_0_6 = 5

function var_0_0.GetUIName(arg_1_0)
	return "IslandFishingOpUI"
end

function var_0_0.FirstFlush(arg_2_0)
	arg_2_0.loadingIdList = {}
	arg_2_0.backBtn = arg_2_0._tf:Find("back")
	arg_2_0.fishContainer = arg_2_0._tf:Find("container")
	arg_2_0.player = arg_2_0:GetView().player
	arg_2_0.escapeTip = arg_2_0._tf:Find("escape_tip")
	arg_2_0.hookedTip = arg_2_0._tf:Find("escape_tip_1")
	arg_2_0.resultTr = arg_2_0._tf:Find("result")
	arg_2_0.resultNewTr = arg_2_0.resultTr:Find("new")
	arg_2_0.resultCupMinTr = arg_2_0.resultTr:Find("cup_min")
	arg_2_0.resultCupMaxTr = arg_2_0.resultTr:Find("cup_max")
	arg_2_0.resultRecordTr = arg_2_0.resultTr:Find("record")
	arg_2_0.resultTxt = arg_2_0.resultTr:Find("Text"):GetComponent(typeof(Text))
	arg_2_0.cg = GetOrAddComponent(arg_2_0._tf, typeof(CanvasGroup))

	setText(arg_2_0._tf:Find("escape_tip/Text"), i18n("island_fishing_tip_escape"))
	setText(arg_2_0._tf:Find("escape_tip_1/Text"), i18n("island_fishing_tip_hooked"))

	arg_2_0.fishingPlayer = IslandFishingPlayer.New(arg_2_0:GetView(), arg_2_0:GetView().player)

	onButton(arg_2_0, arg_2_0.backBtn, function()
		arg_2_0:PauseGame()
		arg_2_0:ShowMsgbox({
			content = i18n("island_fishing_exit"),
			onYes = function()
				arg_2_0:ExitGame()

				return
			end,
			onHide = function()
				arg_2_0:ResumeGame()

				return
			end
		})

		return
	end, SFX_PANEL)

	arg_2_0.state = var_0_1

	return
end

function var_0_0.Flush(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.fishPointId = arg_6_1
	arg_6_0.opBtnLocalPosition = arg_6_2
	arg_6_0.state = var_0_2

	arg_6_0:StartGame(arg_6_1, baitId)

	arg_6_0.startTime = pg.TimeMgr.GetInstance():GetServerTime()

	return
end

function var_0_0.StartGame(arg_7_0, arg_7_1)
	pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildIslandFishingEnter(arg_7_0.fishPointId))
	seriesAsync({
		function(arg_8_0)
			arg_7_0:BlockEvent()
			arg_7_0:TurnToFishPoistion(arg_7_1, arg_8_0)

			return
		end,
		function(arg_9_0)
			arg_7_0:CheckServerBait(arg_9_0)

			return
		end,
		function(arg_10_0)
			arg_7_0:DisableOpView(arg_7_1)
			arg_7_0:GetFishFromServer(arg_7_1, arg_10_0)

			return
		end,
		function(arg_11_0)
			arg_7_0:LoadFishRodModel(arg_11_0)

			return
		end,
		function(arg_12_0)
			arg_7_0:PreloadEffects(arg_7_1, arg_12_0)

			return
		end,
		function(arg_13_0)
			arg_7_0:PlayEffect(IslandFishingEffectMgr.EFFECT_ENTER, IslandFishingEffectMgr.EFFECT_ENTER_TIME)
			arg_7_0:PlayCastAnimation(arg_13_0)

			return
		end,
		function(arg_14_0)
			arg_7_0:UnBlockEvent()
			arg_7_0:PlayEffect(IslandFishingEffectMgr.EFFECT_WAITING)
			arg_7_0:WaitingToBeHooked(arg_14_0)

			return
		end,
		function(arg_15_0)
			if not arg_7_0:IsRunning() and not arg_7_0:IsPausing() then
				return
			end

			arg_7_0:RemoveWaitingToBeHooked()
			arg_7_0:PlayEffect(IslandFishingEffectMgr.EFFECT_HOOKED)
			arg_7_0:PlayHookedAnimation(arg_15_0)

			return
		end,
		function(arg_16_0)
			if not arg_7_0:IsRunning() and not arg_7_0:IsPausing() then
				return
			end

			arg_7_0:PlayEffect(IslandFishingEffectMgr.EFFECT_SHAKE)
			arg_7_0:LoadQteUI(arg_16_0)

			return
		end
	})

	return
end

function var_0_0.PreloadEffects(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0.fishingPlayer:PreloadEffects(arg_17_2)

	return
end

function var_0_0.PlayEffect(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0.fishingPlayer:PlayEffect(arg_18_1, arg_18_2)

	return
end

function var_0_0.ExitGame(arg_19_0)
	arg_19_0:BlockEvent()
	arg_19_0:OnCancel(function()
		arg_19_0:UnBlockEvent()
		arg_19_0:Dispose()

		return
	end)

	return
end

function var_0_0.SwitchToFishingCamrea(arg_21_0, arg_21_1)
	local var_21_0 = pg.island_fish_point[arg_21_1].camera or IslandConst.FISHING_CAMERA_NAME
	local var_21_1 = IslandCameraMgr.instance:GetVirtualCamera(var_21_0)

	var_21_1.Follow = arg_21_0.player._tf
	var_21_1.LookAt = arg_21_0.player._tf

	IslandCameraMgr.instance:ActiveVirtualCamera(var_21_0)

	return
end

function var_0_0.ResetCamrea(arg_22_0)
	IslandCameraMgr.instance:ActiveVirtualCamera(IslandConst.FOLLOW_CAMERA_NAME)

	return
end

function var_0_0.CheckServerBait(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0:GetSelfIsland():GetFishingAgency()

	if not var_23_0:NeedUpdateServerBait() then
		arg_23_1()

		return
	end

	arg_23_0:NotifiyMeditor(IslandBaseMediator.EXCHANGE_LURE, var_23_0:GetBaitId(), arg_23_0.fishPointId, arg_23_1)

	return
end

function var_0_0.GetFishFromServer(arg_24_0, arg_24_1, arg_24_2)
	arg_24_0:NotifiyMeditor(IslandBaseMediator.GO_FISHING, arg_24_1, 0, function(arg_25_0, arg_25_1, arg_25_2)
		if arg_25_0 == 0 and arg_25_1 == 0 then
			arg_24_0:UnBlockEvent()

			arg_24_0.state = var_0_4
		else
			arg_24_0.fishId = arg_25_0
			arg_24_0.weight = arg_25_1
			arg_24_0.cupType = arg_25_2

			arg_24_0:InitArgs(arg_25_0, arg_25_1)
			arg_24_2()
		end

		return
	end)

	return
end

function var_0_0.InitArgs(arg_26_0, arg_26_1, arg_26_2)
	assert(pg.island_fish[arg_26_1], "island_fish>>>>>>>>>>>>" .. arg_26_1)

	arg_26_0.fishId = arg_26_1
	arg_26_0.fishConfig = pg.island_fish[arg_26_1]
	arg_26_0.fishName = pg.island_fish[arg_26_1].name
	arg_26_0.fishWeight = arg_26_2
	arg_26_0.biteTime = math.random(pg.island_fish[arg_26_1].bite_time[1], pg.island_fish[arg_26_1].bite_time[2])

	local var_26_0 = arg_26_0:GetView():GetSelfIsland():GetFishingAgency()

	arg_26_0.isNew = var_26_0:IsNewFish(arg_26_1)
	arg_26_0.isNewRecord = var_26_0:IsNewRecord(arg_26_1, arg_26_2)

	local var_26_1 = var_26_0:GetFishRodId()

	assert(pg.island_fish_rod[var_26_1], "island_fish_rod>>>>>>>>>>>>" .. var_26_1)

	arg_26_0.fishRodId = pg.island_fish_rod[var_26_1].attachment_id
	arg_26_0.rodProfile = pg.island_fish_rod[var_26_1].qte_effect
	arg_26_0.fishPrifile = pg.island_fish[arg_26_1].qte_effect

	if not arg_26_0.rodProfile or arg_26_0.rodProfile == "" then
		arg_26_0.rodProfile = "default"
	end

	if not arg_26_0.fishPrifile or arg_26_0.fishPrifile == "" then
		arg_26_0.fishPrifile = "default"
	end

	arg_26_0.fishingPlayer:InitArgs(arg_26_0.fishPointId, arg_26_0.fishRodId, arg_26_0.fishId)

	return
end

function var_0_0.TurnToFishPoistion(arg_27_0, arg_27_1, arg_27_2)
	arg_27_0.fishingPlayer:TurnToFishPoistion(arg_27_1, arg_27_2)

	return
end

function var_0_0.PlayCastAnimation(arg_28_0, arg_28_1)
	arg_28_0.fishingPlayer:PlayCastAnimation(arg_28_1)

	return
end

function var_0_0.PlayHookedAnimation(arg_29_0, arg_29_1)
	arg_29_0:ShowTip(arg_29_0.hookedTip, 1, arg_29_1)
	arg_29_0.fishingPlayer:PlayHookedAnimation()

	return
end

function var_0_0.PlayHookEndAnimation(arg_30_0, arg_30_1)
	arg_30_0.fishingPlayer:PlayHookEndAnimation(arg_30_1)

	return
end

function var_0_0.PlayFailAnimation(arg_31_0, arg_31_1)
	arg_31_0.fishingPlayer:PlayFailAnimation(arg_31_1)

	return
end

function var_0_0.PlayHookMiddleAnimation(arg_32_0)
	arg_32_0.fishingPlayer:PlayHookMiddleAnimation()

	return
end

function var_0_0.PlayCancelAnimation(arg_33_0, arg_33_1)
	arg_33_0.fishingPlayer:PlayCancelAnimation(arg_33_1)

	return
end

function var_0_0.PlayMovementAnimation(arg_34_0)
	arg_34_0.fishingPlayer:PlayMovementAnimation()

	return
end

function var_0_0.WaitingToBeHooked(arg_35_0, arg_35_1)
	arg_35_0:RemoveWaitingToBeHooked()

	arg_35_0.beitTimer = Timer.New(arg_35_1, arg_35_0.biteTime, 1)

	arg_35_0.beitTimer:Start()

	return
end

function var_0_0.RemoveWaitingToBeHooked(arg_36_0)
	if arg_36_0.beitTimer then
		arg_36_0.beitTimer:Stop()

		arg_36_0.beitTimer = nil
	end

	return
end

function var_0_0.LoadQteUI(arg_37_0, arg_37_1)
	local var_37_0
	local var_37_1

	arg_37_0:BlockEvent()
	seriesAsync({
		function(arg_38_0)
			arg_37_0:AddLoadingID((IslandAssetLoadDispatcher.Instance:Enqueue("island/FishRod/" .. arg_37_0.rodProfile, "", typeof(FishRodProfile), UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_39_0)
				var_37_0 = arg_39_0

				arg_38_0()

				return
			end), true, true)))

			return
		end,
		function(arg_40_0)
			onNextTick(arg_40_0)

			return
		end,
		function(arg_41_0)
			arg_37_0:AddLoadingID((IslandAssetLoadDispatcher.Instance:Enqueue("island/fishingcurve/" .. arg_37_0.fishPrifile, "", typeof(FishMotionProfile), UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_42_0)
				var_37_1 = arg_42_0

				arg_41_0()

				return
			end), true, true)))

			return
		end,
		function(arg_43_0)
			arg_37_0:AddLoadingID((IslandAssetLoadDispatcher.Instance:Enqueue("UI/IslandFishingQteUI", "", typeof(GameObject), UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_44_0)
				arg_37_0:OnLoadQTE(arg_44_0, var_37_1, var_37_0)
				arg_43_0()

				return
			end), true, true)))

			return
		end,
		function(arg_45_0)
			onNextTick(arg_45_0)

			return
		end
	}, function()
		arg_37_0:UpdateQteLayout()

		if arg_37_0:IsPausing() then
			arg_37_0:PauseGame()
		end

		arg_37_0:UnBlockEvent()
		arg_37_1()

		return
	end)

	return
end

function var_0_0.OnLoadQTE(arg_47_0, arg_47_1, arg_47_2, arg_47_3)
	arg_47_0.qteTr = Object.Instantiate(arg_47_1, arg_47_0.fishContainer)
	arg_47_0.clickEffect = arg_47_0.qteTr.transform:Find("fishing_btn/vfx_diaoyuui_fankui")
	arg_47_0.hitEffect = arg_47_0.qteTr.transform:Find("bar/vfx_diaoyuui_mingzhong")
	arg_47_0.getAnim = arg_47_0.qteTr.transform:Find("power"):GetComponent(typeof(Animation))
	arg_47_0.getAnimDft = arg_47_0.qteTr.transform:Find("power"):GetComponent(typeof(DftAniEvent))
	arg_47_0.failedEffect = arg_47_0.qteTr.transform:Find("P_glow_02")
	arg_47_0.failedAnim = arg_47_0.qteTr.transform:Find("energy"):GetComponent(typeof(Animation))
	arg_47_0.failedAnimDft = arg_47_0.qteTr.transform:Find("energy"):GetComponent(typeof(DftAniEvent))
	arg_47_0.qteAim = arg_47_0.qteTr:GetComponent(typeof(Animation))
	arg_47_0.qteAimDft = arg_47_0.qteTr:GetComponent(typeof(DftAniEvent))
	arg_47_0.clickableTip = arg_47_0.qteTr.transform:Find("fishing_btn/vx")

	local var_47_0 = arg_47_0.qteTr:GetComponent(typeof(IslandFishingSliderDriver))

	var_47_0:UpdateFish(arg_47_2)
	var_47_0:UpdateRod(arg_47_3)
	arg_47_0:AddResultListener(var_47_0)

	return
end

function var_0_0.UpdateQteLayout(arg_48_0)
	if not arg_48_0.qteTr then
		return
	end

	local var_48_0 = arg_48_0.qteTr.transform:InverseTransformPoint((arg_48_0._tf:TransformPoint(arg_48_0.opBtnLocalPosition)))

	arg_48_0.qteTr.transform:Find("fishing_btn").localPosition = Vector3(var_48_0.x, var_48_0.y, 0)

	return
end

function var_0_0.UnloadQteUI(arg_49_0, arg_49_1)
	arg_49_0:RemoveResultListener()

	if arg_49_0.qteTr and arg_49_1 then
		arg_49_0.qteAimDft:SetEndEvent(nil)
		arg_49_0.qteAimDft:SetEndEvent(function()
			arg_49_0.qteAimDft:SetEndEvent(nil)
			Object.Destroy(arg_49_0.qteTr)

			arg_49_0.qteTr = nil

			arg_49_1()

			return
		end)
		arg_49_0.qteAim:Play("anim_IslandFishingQteUI_out")
	elseif arg_49_0.qteTr and not arg_49_1 then
		Object.Destroy(arg_49_0.qteTr)

		arg_49_0.qteTr = nil
	elseif arg_49_1 then
		arg_49_1()
	end

	return
end

function var_0_0.AddResultListener(arg_51_0, arg_51_1)
	function arg_51_1.OnSuccess()
		arg_51_0:OnQteSuccess()

		return
	end

	function arg_51_1.OnFailure()
		arg_51_0:OnQteFailed()

		return
	end

	function arg_51_1.OnProgress(arg_54_0)
		arg_51_0:OnQteProgress(arg_54_0)

		return
	end

	function arg_51_1.OnHit(arg_55_0)
		arg_51_0:OnHit(arg_55_0)

		return
	end

	arg_51_0.fishingSliderDriver = arg_51_1

	return
end

function var_0_0.RemoveResultListener(arg_56_0)
	if arg_56_0.fishingSliderDriver then
		arg_56_0.fishingSliderDriver.OnSuccess = nil
		arg_56_0.fishingSliderDriver.OnFailure = nil
		arg_56_0.fishingSliderDriver.OnProgress = nil
		arg_56_0.fishingSliderDriver.OnHit = nil
		arg_56_0.fishingSliderDriver = nil
	end

	return
end

function var_0_0.LoadFishRodModel(arg_57_0, arg_57_1)
	arg_57_0.fishingPlayer:LoadFishRodModel(arg_57_1)

	return
end

function var_0_0.UnLoadFishRodModel(arg_58_0)
	arg_58_0.fishingPlayer:UnLoadFishRodModel(callback)

	return
end

function var_0_0.LoadFishModel(arg_59_0, arg_59_1)
	arg_59_0.fishingPlayer:LoadFishModel(arg_59_1)

	return
end

function var_0_0.UnLoadFishModel(arg_60_0)
	arg_60_0.fishingPlayer:UnLoadFishModel(callback)

	return
end

function var_0_0.NotifyServerResultSuccess(arg_61_0, arg_61_1)
	arg_61_0:NotifiyMeditor(IslandBaseMediator.FISHING_RESULT, IslandConst.FISHING_OP_SUCCESS, arg_61_0.fishPointId, arg_61_0.fishId, arg_61_0.weight, arg_61_0.cupType, arg_61_1)

	return
end

function var_0_0.NotifyServerResultFaild(arg_62_0, arg_62_1)
	arg_62_0:NotifiyMeditor(IslandBaseMediator.FISHING_RESULT, IslandConst.FISHING_OP_FAILD, arg_62_0.fishPointId, arg_62_0.fishId, arg_62_0.weight, arg_62_0.cupType, arg_62_1)

	return
end

function var_0_0.NotifyServerResultCancel(arg_63_0, arg_63_1)
	arg_63_0:NotifiyMeditor(IslandBaseMediator.FISHING_RESULT, IslandConst.FISHING_OP_CANCEL, arg_63_0.fishPointId, arg_63_0.fishId, arg_63_0.weight, arg_63_0.cupType, arg_63_1)

	return
end

function var_0_0.IsRunning(arg_64_0)
	return arg_64_0.state == var_0_2
end

function var_0_0.IsPausing(arg_65_0)
	return arg_65_0.state == var_0_6
end

function var_0_0.PauseGame(arg_66_0)
	arg_66_0.state = var_0_6

	if arg_66_0.fishingSliderDriver then
		arg_66_0.fishingSliderDriver:Pause()
	end

	return
end

function var_0_0.ResumeGame(arg_67_0)
	arg_67_0.state = var_0_2

	if arg_67_0.fishingSliderDriver then
		arg_67_0.fishingSliderDriver:Reseume()
	end

	return
end

function var_0_0.BuildResultData(arg_68_0, arg_68_1)
	if not arg_68_0.fishingSliderDriver then
		return
	end

	local var_68_0 = arg_68_0:GetView():GetSelfIsland():GetFishingAgency()

	pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildIslandFishingResult(arg_68_0.fishPointId, var_68_0:GetFishRodId(), var_68_0:GetBaitId(), arg_68_0.fishId, arg_68_0.fishWeight, arg_68_0.fishingSliderDriver.SuccesCnt, arg_68_0.fishingSliderDriver.FailCnt, math.floor(arg_68_0.fishingSliderDriver.PowerRatio * 100), math.floor(arg_68_0.fishingSliderDriver.Ratio * 100), arg_68_1))

	return
end

function var_0_0.OnQteSuccess(arg_69_0)
	arg_69_0.state = var_0_3

	arg_69_0:BuildResultData(1)
	arg_69_0:BlockEvent()
	seriesAsync({
		function(arg_70_0)
			arg_69_0:PlayGetEffect(arg_70_0)

			return
		end,
		function(arg_71_0)
			arg_69_0:UnloadQteUI(arg_71_0)

			return
		end,
		function(arg_72_0)
			arg_69_0:NotifyServerResultSuccess(arg_72_0)

			return
		end,
		function(arg_73_0)
			arg_69_0:LoadFishModel(arg_73_0)

			return
		end,
		function(arg_74_0)
			arg_69_0:PlayEffect(IslandFishingEffectMgr.EFFECT_LEAVE, IslandFishingEffectMgr.EFFECT_LEAVE_TIME)
			arg_69_0:PlayHookEndAnimation(arg_74_0)

			return
		end,
		function(arg_75_0)
			arg_69_0:WaitForExit(arg_75_0)
			arg_69_0:DisplayResult()

			return
		end
	}, function()
		arg_69_0:UnBlockEvent()
		arg_69_0:Dispose()

		return
	end)

	return
end

function var_0_0.PlayGetEffect(arg_77_0, arg_77_1)
	arg_77_0.getAnimDft:SetEndEvent(nil)
	arg_77_0.getAnimDft:SetEndEvent(function()
		arg_77_0.getAnimDft:SetEndEvent(nil)
		onNextTick(arg_77_1)

		return
	end)
	arg_77_0.getAnim:Play("anim_IslandExchangeUI_power_get")

	return
end

function var_0_0.WaitForExit(arg_79_0, arg_79_1)
	arg_79_0:RemoveWaitForExit()

	arg_79_0.exitTimer = Timer.New(arg_79_1, math.max(0.01, pg.island_set.island_fishing_success_exit_time.key_value_int), 1)

	arg_79_0.exitTimer:Start()

	return
end

function var_0_0.RemoveWaitForExit(arg_80_0)
	if arg_80_0.exitTimer then
		arg_80_0.exitTimer:Stop()

		arg_80_0.exitTimer = nil
	end

	return
end

function var_0_0.OnQteFailed(arg_81_0)
	arg_81_0:BuildResultData(0)
	arg_81_0:PlayEffect(IslandFishingEffectMgr.EFFECT_NORMAL)

	arg_81_0.state = var_0_4

	arg_81_0:ShowTip(arg_81_0.escapeTip)
	arg_81_0:BlockEvent()
	parallelAsync({
		function(arg_82_0)
			arg_81_0:UnloadQteUI(arg_82_0)

			return
		end,
		function(arg_83_0)
			arg_81_0:PlayFailAnimation(arg_83_0)

			return
		end
	}, function()
		arg_81_0:UnBlockEvent()
		arg_81_0:NotifyServerResultFaild(function()
			return
		end)
		arg_81_0:Dispose()

		return
	end)

	return
end

function var_0_0.OnQteProgress(arg_86_0, arg_86_1)
	if arg_86_1 > 0 and not arg_86_0.isFirstClick then
		arg_86_0:PlayHookMiddleAnimation()

		arg_86_0.isFirstClick = true
	end

	return
end

function var_0_0.OnHit(arg_87_0, arg_87_1)
	if not arg_87_1 then
		setActive(arg_87_0.failedEffect, true)
		arg_87_0.failedAnimDft:SetEndEvent(nil)
		arg_87_0.failedAnimDft:SetEndEvent(function()
			arg_87_0.failedAnimDft:SetEndEvent(nil)
			setActive(arg_87_0.failedEffect, false)

			return
		end)
		arg_87_0.failedAnim:Play("anim_IslandExchangeUI_default_energy")
	else
		setActive(arg_87_0.hitEffect, false)
		setActive(arg_87_0.hitEffect, true)
	end

	setActive(arg_87_0.clickEffect, false)
	setActive(arg_87_0.clickEffect, true)
	setActive(arg_87_0.clickableTip, false)

	return
end

function var_0_0.OnCancel(arg_89_0, arg_89_1)
	if arg_89_0.state == var_0_2 or arg_89_0.state == var_0_1 then
		arg_89_0:BuildResultData(2)
		pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildIslandFishingCancel(arg_89_0.fishPointId, IsNil(arg_89_0.qteTr) and 1 or 2))
		arg_89_0:PlayEffect(IslandFishingEffectMgr.EFFECT_NORMAL)

		arg_89_0.state = var_0_5

		parallelAsync({
			function(arg_90_0)
				arg_89_0:UnloadQteUI(arg_90_0)

				return
			end,
			function(arg_91_0)
				arg_89_0:PlayCancelAnimation(arg_91_0)

				return
			end
		}, function()
			arg_89_0:NotifyServerResultCancel(function()
				return
			end)
			arg_89_1()

			return
		end)
	else
		arg_89_0.state = var_0_5

		arg_89_0:Dispose()
	end

	return
end

function var_0_0.DisplayResult(arg_94_0)
	arg_94_0.resultTxt.text = arg_94_0.fishName .. "   " .. arg_94_0.fishWeight / 1000 .. "KG"

	setActive(arg_94_0.resultNewTr, arg_94_0.isNew)
	setActive(arg_94_0.resultCupMaxTr, arg_94_0.cupType == IslandFish.CUP_STATE_MAX)
	setActive(arg_94_0.resultCupMinTr, arg_94_0.cupType == IslandFish.CUP_STATE_MIN)
	setActive(arg_94_0.resultRecordTr, arg_94_0.isNewRecord)
	arg_94_0:ShowTip(arg_94_0.resultTr)

	return
end

function var_0_0.DisableOpView(arg_95_0, arg_95_1)
	arg_95_0:SwitchToFishingCamrea(arg_95_1)
	arg_95_0:GetView():DisablePlayerOp()
	arg_95_0:NotifiyIsland(ISLAND_EX_EVT.ENTER_FISH_POINT)

	return
end

function var_0_0.EnableOpView(arg_96_0)
	arg_96_0:ResetCamrea()
	arg_96_0:GetView():EnablePlayerOp()
	arg_96_0:NotifiyIsland(ISLAND_EX_EVT.EXIT_FISH_POINT)

	return
end

function var_0_0.ShowTip(arg_97_0, arg_97_1, arg_97_2, arg_97_3)
	setActive(arg_97_1, true)
	arg_97_0:RemoveTimer()

	arg_97_0.timer = Timer.New(function()
		arg_97_0:RemoveTimer()
		setActive(arg_97_1, false)

		if arg_97_3 then
			arg_97_3()
		end

		return
	end, arg_97_2 or 3, 1)

	arg_97_0.timer:Start()

	return
end

function var_0_0.RemoveTimer(arg_99_0)
	if arg_99_0.timer then
		arg_99_0.timer:Stop()

		arg_99_0.timer = nil
	end

	return
end

function var_0_0.BlockEvent(arg_100_0)
	arg_100_0.cg.blocksRaycasts = false

	return
end

function var_0_0.UnBlockEvent(arg_101_0)
	arg_101_0.cg.blocksRaycasts = true

	return
end

function var_0_0.AddLoadingID(arg_102_0, arg_102_1)
	table.insert(arg_102_0.loadingIdList, arg_102_1)

	return
end

function var_0_0.OnHide(arg_103_0)
	arg_103_0:Clear()

	return
end

function var_0_0.Clear(arg_104_0)
	local var_104_9000

	arg_104_0:EnableOpView()
	arg_104_0:PlayEffect(IslandFishingEffectMgr.EFFECT_NORMAL)

	for iter_104_0, iter_104_1 in ipairs(arg_104_0.loadingIdList) do
		IslandAssetLoadDispatcher.Instance:Cancel(iter_104_1)
	end

	arg_104_0.loadingIdList = {}

	if arg_104_0.failedAnimDft then
		arg_104_0.failedAnimDft:SetEndEvent(nil)

		arg_104_0.failedAnimDft = nil
	end

	if arg_104_0.getAnimDft then
		arg_104_0.getAnimDft:SetEndEvent(nil)

		arg_104_0.getAnimDft = nil
	end

	if arg_104_0.qteAimDft then
		arg_104_0.qteAimDft:SetEndEvent(nil)

		arg_104_0.qteAimDft = nil
	end

	arg_104_0:UnloadQteUI()
	arg_104_0:UnLoadFishModel()
	arg_104_0:UnLoadFishRodModel()
	setActive(arg_104_0.escapeTip, false)
	setActive(arg_104_0.hookedTip, false)
	setActive(arg_104_0.resultTr, false)
	arg_104_0:RemoveWaitingToBeHooked()
	arg_104_0:RemoveTimer()
	arg_104_0:RemoveWaitForExit()

	arg_104_0.isFirstClick = false

	arg_104_0:PlayMovementAnimation()

	if arg_104_0.fishingPlayer then
		arg_104_0.fishingPlayer:Dispose()

		arg_104_0.fishingPlayer = nil
	end

	arg_104_0.state = var_0_1

	local var_104_0 = pg.TimeMgr.GetInstance()

	pg.GameTrackerMgr.GetInstance().Record(var_104_0, GameTrackerBuilder.BuildIslandFishingExit(arg_104_0.fishPointId, var_104_0.GetServerTime(var_104_9000) - arg_104_0.startTime))

	return
end

function var_0_0.OnDestroy(arg_105_0)
	arg_105_0:Clear()

	return
end

return var_0_0
