local IslandFishingOPView = class("IslandFishingOPView", import("Mod.Island.Core.View.IslandASynLoadAndCacheSubView"))
local var_0_1 = 0
local var_0_2 = 1
local var_0_3 = 2
local var_0_4 = 3
local var_0_5 = 4
local var_0_6 = 5

function IslandFishingOPView:GetUIName()
	return "IslandFishingOpUI"
end

function IslandFishingOPView:FirstFlush()
	self.loadingIdList = {}
	self.backBtn = self._tf:Find("back")
	self.fishContainer = self._tf:Find("container")
	self.player = self:GetView().player
	self.escapeTip = self._tf:Find("escape_tip")
	self.hookedTip = self._tf:Find("escape_tip_1")
	self.resultTr = self._tf:Find("result")
	self.resultNewTr = self.resultTr:Find("new")
	self.resultCupMinTr = self.resultTr:Find("cup_min")
	self.resultCupMaxTr = self.resultTr:Find("cup_max")
	self.resultRecordTr = self.resultTr:Find("record")
	self.resultTxt = self.resultTr:Find("Text"):GetComponent(typeof(Text))
	self.cg = GetOrAddComponent(self._tf, typeof(CanvasGroup))

	setText(self._tf:Find("escape_tip/Text"), i18n("island_fishing_tip_escape"))
	setText(self._tf:Find("escape_tip_1/Text"), i18n("island_fishing_tip_hooked"))

	self.fishingPlayer = IslandFishingPlayer.New(self:GetView(), self:GetView().player)

	onButton(self, self.backBtn, function()
		self:PauseGame()
		self:ShowMsgbox({
			content = i18n("island_fishing_exit"),
			onYes = function()
				self:ExitGame()

				return
			end,
			onHide = function()
				self:ResumeGame()

				return
			end
		})

		return
	end, SFX_PANEL)

	self.state = var_0_1

	return
end

function IslandFishingOPView:Flush(arg_6_1, arg_6_2)
	self.fishPointId = arg_6_1
	self.opBtnLocalPosition = arg_6_2
	self.state = var_0_2

	self:StartGame(arg_6_1, baitId)

	self.startTime = pg.TimeMgr.GetInstance():GetServerTime()

	return
end

function IslandFishingOPView:StartGame(arg_7_1)
	pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildIslandFishingEnter(self.fishPointId))
	seriesAsync({
		function(arg_8_0)
			self:BlockEvent()
			self:TurnToFishPoistion(arg_7_1, arg_8_0)

			return
		end,
		function(arg_9_0)
			self:CheckServerBait(arg_9_0)

			return
		end,
		function(arg_10_0)
			self:DisableOpView(arg_7_1)
			self:GetFishFromServer(arg_7_1, arg_10_0)

			return
		end,
		function(arg_11_0)
			self:LoadFishRodModel(arg_11_0)

			return
		end,
		function(arg_12_0)
			self:PreloadEffects(arg_7_1, arg_12_0)

			return
		end,
		function(arg_13_0)
			self:PlayEffect(IslandFishingEffectMgr.EFFECT_ENTER, IslandFishingEffectMgr.EFFECT_ENTER_TIME)
			self:PlayCastAnimation(arg_13_0)

			return
		end,
		function(arg_14_0)
			self:UnBlockEvent()
			self:PlayEffect(IslandFishingEffectMgr.EFFECT_WAITING)
			self:WaitingToBeHooked(arg_14_0)

			return
		end,
		function(arg_15_0)
			if not self:IsRunning() and not self:IsPausing() then
				return
			end

			self:RemoveWaitingToBeHooked()
			self:PlayEffect(IslandFishingEffectMgr.EFFECT_HOOKED)
			self:PlayHookedAnimation(arg_15_0)

			return
		end,
		function(arg_16_0)
			if not self:IsRunning() and not self:IsPausing() then
				return
			end

			self:PlayEffect(IslandFishingEffectMgr.EFFECT_SHAKE)
			self:LoadQteUI(arg_16_0)

			return
		end
	})

	return
end

function IslandFishingOPView:PreloadEffects(arg_17_1, arg_17_2)
	self.fishingPlayer:PreloadEffects(arg_17_2)

	return
end

function IslandFishingOPView:PlayEffect(arg_18_1, arg_18_2)
	self.fishingPlayer:PlayEffect(arg_18_1, arg_18_2)

	return
end

function IslandFishingOPView:ExitGame()
	self:BlockEvent()
	self:OnCancel(function()
		self:UnBlockEvent()
		self:Dispose()

		return
	end)

	return
end

function IslandFishingOPView:SwitchToFishingCamrea(arg_21_1)
	local var_21_0 = pg.island_fish_point[arg_21_1].camera or IslandConst.FISHING_CAMERA_NAME
	local var_21_1 = IslandCameraMgr.instance:GetVirtualCamera(var_21_0)

	var_21_1.Follow = self.player._tf
	var_21_1.LookAt = self.player._tf

	IslandCameraMgr.instance:ActiveVirtualCamera(var_21_0)

	return
end

function IslandFishingOPView:ResetCamrea()
	IslandCameraMgr.instance:ActiveVirtualCamera(IslandConst.FOLLOW_CAMERA_NAME)

	return
end

function IslandFishingOPView:CheckServerBait(arg_23_1)
	local var_23_0 = self:GetSelfIsland():GetFishingAgency()

	if not var_23_0:NeedUpdateServerBait() then
		arg_23_1()

		return
	end

	self:NotifiyMeditor(IslandBaseMediator.EXCHANGE_LURE, var_23_0:GetBaitId(), self.fishPointId, arg_23_1)

	return
end

function IslandFishingOPView:GetFishFromServer(arg_24_1, arg_24_2)
	self:NotifiyMeditor(IslandBaseMediator.GO_FISHING, arg_24_1, 0, function(arg_25_0, arg_25_1, arg_25_2)
		if arg_25_0 == 0 and arg_25_1 == 0 then
			self:UnBlockEvent()

			self.state = var_0_4
		else
			self.fishId = arg_25_0
			self.weight = arg_25_1
			self.cupType = arg_25_2

			self:InitArgs(arg_25_0, arg_25_1)
			arg_24_2()
		end

		return
	end)

	return
end

function IslandFishingOPView:InitArgs(arg_26_1, arg_26_2)
	assert(pg.island_fish[arg_26_1], "island_fish>>>>>>>>>>>>" .. arg_26_1)

	self.fishId = arg_26_1
	self.fishConfig = pg.island_fish[arg_26_1]
	self.fishName = pg.island_fish[arg_26_1].name
	self.fishWeight = arg_26_2
	self.biteTime = math.random(pg.island_fish[arg_26_1].bite_time[1], pg.island_fish[arg_26_1].bite_time[2])

	local var_26_0 = self:GetView():GetSelfIsland():GetFishingAgency()

	self.isNew = var_26_0:IsNewFish(arg_26_1)
	self.isNewRecord = var_26_0:IsNewRecord(arg_26_1, arg_26_2)

	local var_26_1 = var_26_0:GetFishRodId()

	assert(pg.island_fish_rod[var_26_1], "island_fish_rod>>>>>>>>>>>>" .. var_26_1)

	self.fishRodId = pg.island_fish_rod[var_26_1].attachment_id
	self.rodProfile = pg.island_fish_rod[var_26_1].qte_effect
	self.fishPrifile = pg.island_fish[arg_26_1].qte_effect

	if not self.rodProfile or self.rodProfile == "" then
		self.rodProfile = "default"
	end

	if not self.fishPrifile or self.fishPrifile == "" then
		self.fishPrifile = "default"
	end

	self.fishingPlayer:InitArgs(self.fishPointId, self.fishRodId, self.fishId)

	return
end

function IslandFishingOPView:TurnToFishPoistion(arg_27_1, arg_27_2)
	self.fishingPlayer:TurnToFishPoistion(arg_27_1, arg_27_2)

	return
end

function IslandFishingOPView:PlayCastAnimation(arg_28_1)
	self.fishingPlayer:PlayCastAnimation(arg_28_1)

	return
end

function IslandFishingOPView:PlayHookedAnimation(arg_29_1)
	self:ShowTip(self.hookedTip, 1, arg_29_1)
	self.fishingPlayer:PlayHookedAnimation()

	return
end

function IslandFishingOPView:PlayHookEndAnimation(arg_30_1)
	self.fishingPlayer:PlayHookEndAnimation(arg_30_1)

	return
end

function IslandFishingOPView:PlayFailAnimation(arg_31_1)
	self.fishingPlayer:PlayFailAnimation(arg_31_1)

	return
end

function IslandFishingOPView:PlayHookMiddleAnimation()
	self.fishingPlayer:PlayHookMiddleAnimation()

	return
end

function IslandFishingOPView:PlayCancelAnimation(arg_33_1)
	self.fishingPlayer:PlayCancelAnimation(arg_33_1)

	return
end

function IslandFishingOPView:PlayMovementAnimation()
	self.fishingPlayer:PlayMovementAnimation()

	return
end

function IslandFishingOPView:WaitingToBeHooked(arg_35_1)
	self:RemoveWaitingToBeHooked()

	self.beitTimer = Timer.New(arg_35_1, self.biteTime, 1)

	self.beitTimer:Start()

	return
end

function IslandFishingOPView:RemoveWaitingToBeHooked()
	if self.beitTimer then
		self.beitTimer:Stop()

		self.beitTimer = nil
	end

	return
end

function IslandFishingOPView:LoadQteUI(arg_37_1)
	local var_37_0
	local var_37_1

	self:BlockEvent()
	seriesAsync({
		function(arg_38_0)
			self:AddLoadingID((IslandAssetLoadDispatcher.Instance:Enqueue("island/FishRod/" .. self.rodProfile, "", typeof(FishRodProfile), UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_39_0)
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
			self:AddLoadingID((IslandAssetLoadDispatcher.Instance:Enqueue("island/fishingcurve/" .. self.fishPrifile, "", typeof(FishMotionProfile), UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_42_0)
				var_37_1 = arg_42_0

				arg_41_0()

				return
			end), true, true)))

			return
		end,
		function(arg_43_0)
			self:AddLoadingID((IslandAssetLoadDispatcher.Instance:Enqueue("UI/IslandFishingQteUI", "", typeof(GameObject), UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_44_0)
				self:OnLoadQTE(arg_44_0, var_37_1, var_37_0)
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
		self:UpdateQteLayout()

		if self:IsPausing() then
			self:PauseGame()
		end

		self:UnBlockEvent()
		arg_37_1()

		return
	end)

	return
end

function IslandFishingOPView:OnLoadQTE(arg_47_1, arg_47_2, arg_47_3)
	self.qteTr = Object.Instantiate(arg_47_1, self.fishContainer)
	self.clickEffect = self.qteTr.transform:Find("fishing_btn/vfx_diaoyuui_fankui")
	self.hitEffect = self.qteTr.transform:Find("bar/vfx_diaoyuui_mingzhong")
	self.getAnim = self.qteTr.transform:Find("power"):GetComponent(typeof(Animation))
	self.getAnimDft = self.qteTr.transform:Find("power"):GetComponent(typeof(DftAniEvent))
	self.failedEffect = self.qteTr.transform:Find("P_glow_02")
	self.failedAnim = self.qteTr.transform:Find("energy"):GetComponent(typeof(Animation))
	self.failedAnimDft = self.qteTr.transform:Find("energy"):GetComponent(typeof(DftAniEvent))
	self.qteAim = self.qteTr:GetComponent(typeof(Animation))
	self.qteAimDft = self.qteTr:GetComponent(typeof(DftAniEvent))
	self.clickableTip = self.qteTr.transform:Find("fishing_btn/vx")

	local var_47_0 = self.qteTr:GetComponent(typeof(IslandFishingSliderDriver))

	var_47_0:UpdateFish(arg_47_2)
	var_47_0:UpdateRod(arg_47_3)
	self:AddResultListener(var_47_0)

	return
end

function IslandFishingOPView:UpdateQteLayout()
	if not self.qteTr then
		return
	end

	local var_48_0 = self.qteTr.transform:InverseTransformPoint((self._tf:TransformPoint(self.opBtnLocalPosition)))

	self.qteTr.transform:Find("fishing_btn").localPosition = Vector3(var_48_0.x, var_48_0.y, 0)

	return
end

function IslandFishingOPView:UnloadQteUI(arg_49_1)
	self:RemoveResultListener()

	if self.qteTr and arg_49_1 then
		self.qteAimDft:SetEndEvent(nil)
		self.qteAimDft:SetEndEvent(function()
			self.qteAimDft:SetEndEvent(nil)
			Object.Destroy(self.qteTr)

			self.qteTr = nil

			arg_49_1()

			return
		end)
		self.qteAim:Play("anim_IslandFishingQteUI_out")
	elseif self.qteTr and not arg_49_1 then
		Object.Destroy(self.qteTr)

		self.qteTr = nil
	elseif arg_49_1 then
		arg_49_1()
	end

	return
end

function IslandFishingOPView:AddResultListener(arg_51_1)
	function arg_51_1.OnSuccess()
		self:OnQteSuccess()

		return
	end

	function arg_51_1.OnFailure()
		self:OnQteFailed()

		return
	end

	function arg_51_1.OnProgress(arg_54_0)
		self:OnQteProgress(arg_54_0)

		return
	end

	function arg_51_1.OnHit(arg_55_0)
		self:OnHit(arg_55_0)

		return
	end

	self.fishingSliderDriver = arg_51_1

	return
end

function IslandFishingOPView:RemoveResultListener()
	if self.fishingSliderDriver then
		self.fishingSliderDriver.OnSuccess = nil
		self.fishingSliderDriver.OnFailure = nil
		self.fishingSliderDriver.OnProgress = nil
		self.fishingSliderDriver.OnHit = nil
		self.fishingSliderDriver = nil
	end

	return
end

function IslandFishingOPView:LoadFishRodModel(arg_57_1)
	self.fishingPlayer:LoadFishRodModel(arg_57_1)

	return
end

function IslandFishingOPView:UnLoadFishRodModel()
	self.fishingPlayer:UnLoadFishRodModel(callback)

	return
end

function IslandFishingOPView:LoadFishModel(arg_59_1)
	self.fishingPlayer:LoadFishModel(arg_59_1)

	return
end

function IslandFishingOPView:UnLoadFishModel()
	self.fishingPlayer:UnLoadFishModel(callback)

	return
end

function IslandFishingOPView:NotifyServerResultSuccess(arg_61_1)
	self:NotifiyMeditor(IslandBaseMediator.FISHING_RESULT, IslandConst.FISHING_OP_SUCCESS, self.fishPointId, self.fishId, self.weight, self.cupType, arg_61_1)

	return
end

function IslandFishingOPView:NotifyServerResultFaild(arg_62_1)
	self:NotifiyMeditor(IslandBaseMediator.FISHING_RESULT, IslandConst.FISHING_OP_FAILD, self.fishPointId, self.fishId, self.weight, self.cupType, arg_62_1)

	return
end

function IslandFishingOPView:NotifyServerResultCancel(arg_63_1)
	self:NotifiyMeditor(IslandBaseMediator.FISHING_RESULT, IslandConst.FISHING_OP_CANCEL, self.fishPointId, self.fishId, self.weight, self.cupType, arg_63_1)

	return
end

function IslandFishingOPView:IsRunning()
	return self.state == var_0_2
end

function IslandFishingOPView:IsPausing()
	return self.state == var_0_6
end

function IslandFishingOPView:PauseGame()
	self.state = var_0_6

	if self.fishingSliderDriver then
		self.fishingSliderDriver:Pause()
	end

	return
end

function IslandFishingOPView:ResumeGame()
	self.state = var_0_2

	if self.fishingSliderDriver then
		self.fishingSliderDriver:Reseume()
	end

	return
end

function IslandFishingOPView:BuildResultData(arg_68_1)
	if not self.fishingSliderDriver then
		return
	end

	local var_68_0 = self:GetView():GetSelfIsland():GetFishingAgency()

	pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildIslandFishingResult(self.fishPointId, var_68_0:GetFishRodId(), var_68_0:GetBaitId(), self.fishId, self.fishWeight, self.fishingSliderDriver.SuccesCnt, self.fishingSliderDriver.FailCnt, math.floor(self.fishingSliderDriver.PowerRatio * 100), math.floor(self.fishingSliderDriver.Ratio * 100), arg_68_1))

	return
end

function IslandFishingOPView:OnQteSuccess()
	self.state = var_0_3

	self:BuildResultData(1)
	self:BlockEvent()
	seriesAsync({
		function(arg_70_0)
			self:PlayGetEffect(arg_70_0)

			return
		end,
		function(arg_71_0)
			self:UnloadQteUI(arg_71_0)

			return
		end,
		function(arg_72_0)
			self:NotifyServerResultSuccess(arg_72_0)

			return
		end,
		function(arg_73_0)
			self:LoadFishModel(arg_73_0)

			return
		end,
		function(arg_74_0)
			self:PlayEffect(IslandFishingEffectMgr.EFFECT_LEAVE, IslandFishingEffectMgr.EFFECT_LEAVE_TIME)
			self:PlayHookEndAnimation(arg_74_0)

			return
		end,
		function(arg_75_0)
			self:WaitForExit(arg_75_0)
			self:DisplayResult()

			return
		end
	}, function()
		self:UnBlockEvent()
		self:Dispose()

		return
	end)

	return
end

function IslandFishingOPView:PlayGetEffect(arg_77_1)
	self.getAnimDft:SetEndEvent(nil)
	self.getAnimDft:SetEndEvent(function()
		self.getAnimDft:SetEndEvent(nil)
		onNextTick(arg_77_1)

		return
	end)
	self.getAnim:Play("anim_IslandExchangeUI_power_get")

	return
end

function IslandFishingOPView:WaitForExit(arg_79_1)
	self:RemoveWaitForExit()

	self.exitTimer = Timer.New(arg_79_1, math.max(0.01, pg.island_set.island_fishing_success_exit_time.key_value_int), 1)

	self.exitTimer:Start()

	return
end

function IslandFishingOPView:RemoveWaitForExit()
	if self.exitTimer then
		self.exitTimer:Stop()

		self.exitTimer = nil
	end

	return
end

function IslandFishingOPView:OnQteFailed()
	self:BuildResultData(0)
	self:PlayEffect(IslandFishingEffectMgr.EFFECT_NORMAL)

	self.state = var_0_4

	self:ShowTip(self.escapeTip)
	self:BlockEvent()
	parallelAsync({
		function(arg_82_0)
			self:UnloadQteUI(arg_82_0)

			return
		end,
		function(arg_83_0)
			self:PlayFailAnimation(arg_83_0)

			return
		end
	}, function()
		self:UnBlockEvent()
		self:NotifyServerResultFaild(function()
			return
		end)
		self:Dispose()

		return
	end)

	return
end

function IslandFishingOPView:OnQteProgress(arg_86_1)
	if arg_86_1 > 0 and not self.isFirstClick then
		self:PlayHookMiddleAnimation()

		self.isFirstClick = true
	end

	return
end

function IslandFishingOPView:OnHit(arg_87_1)
	if not arg_87_1 then
		setActive(self.failedEffect, true)
		self.failedAnimDft:SetEndEvent(nil)
		self.failedAnimDft:SetEndEvent(function()
			self.failedAnimDft:SetEndEvent(nil)
			setActive(self.failedEffect, false)

			return
		end)
		self.failedAnim:Play("anim_IslandExchangeUI_default_energy")
	else
		setActive(self.hitEffect, false)
		setActive(self.hitEffect, true)
	end

	setActive(self.clickEffect, false)
	setActive(self.clickEffect, true)
	setActive(self.clickableTip, false)

	return
end

function IslandFishingOPView:OnCancel(arg_89_1)
	if self.state == var_0_2 or self.state == var_0_1 then
		self:BuildResultData(2)
		pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildIslandFishingCancel(self.fishPointId, IsNil(self.qteTr) and 1 or 2))
		self:PlayEffect(IslandFishingEffectMgr.EFFECT_NORMAL)

		self.state = var_0_5

		parallelAsync({
			function(arg_90_0)
				self:UnloadQteUI(arg_90_0)

				return
			end,
			function(arg_91_0)
				self:PlayCancelAnimation(arg_91_0)

				return
			end
		}, function()
			self:NotifyServerResultCancel(function()
				return
			end)
			arg_89_1()

			return
		end)
	else
		self.state = var_0_5

		self:Dispose()
	end

	return
end

function IslandFishingOPView:DisplayResult()
	self.resultTxt.text = self.fishName .. "   " .. self.fishWeight / 1000 .. "KG"

	setActive(self.resultNewTr, self.isNew)
	setActive(self.resultCupMaxTr, self.cupType == IslandFish.CUP_STATE_MAX)
	setActive(self.resultCupMinTr, self.cupType == IslandFish.CUP_STATE_MIN)
	setActive(self.resultRecordTr, self.isNewRecord)
	self:ShowTip(self.resultTr)

	return
end

function IslandFishingOPView:DisableOpView(arg_95_1)
	self:SwitchToFishingCamrea(arg_95_1)
	self:GetView():DisablePlayerOp()
	self:NotifiyIsland(ISLAND_EX_EVT.ENTER_FISH_POINT)

	return
end

function IslandFishingOPView:EnableOpView()
	self:ResetCamrea()
	self:GetView():EnablePlayerOp()
	self:NotifiyIsland(ISLAND_EX_EVT.EXIT_FISH_POINT)

	return
end

function IslandFishingOPView:ShowTip(arg_97_1, arg_97_2, arg_97_3)
	setActive(arg_97_1, true)
	self:RemoveTimer()

	self.timer = Timer.New(function()
		self:RemoveTimer()
		setActive(arg_97_1, false)

		if arg_97_3 then
			arg_97_3()
		end

		return
	end, arg_97_2 or 3, 1)

	self.timer:Start()

	return
end

function IslandFishingOPView:RemoveTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function IslandFishingOPView:BlockEvent()
	self.cg.blocksRaycasts = false

	return
end

function IslandFishingOPView:UnBlockEvent()
	self.cg.blocksRaycasts = true

	return
end

function IslandFishingOPView:AddLoadingID(arg_102_1)
	table.insert(self.loadingIdList, arg_102_1)

	return
end

function IslandFishingOPView:OnHide()
	self:Clear()

	return
end

function IslandFishingOPView:Clear()
	self:EnableOpView()
	self:PlayEffect(IslandFishingEffectMgr.EFFECT_NORMAL)

	for iter_104_0, iter_104_1 in ipairs(self.loadingIdList) do
		IslandAssetLoadDispatcher.Instance:Cancel(iter_104_1)
	end

	self.loadingIdList = {}

	if self.failedAnimDft then
		self.failedAnimDft:SetEndEvent(nil)

		self.failedAnimDft = nil
	end

	if self.getAnimDft then
		self.getAnimDft:SetEndEvent(nil)

		self.getAnimDft = nil
	end

	if self.qteAimDft then
		self.qteAimDft:SetEndEvent(nil)

		self.qteAimDft = nil
	end

	self:UnloadQteUI()
	self:UnLoadFishModel()
	self:UnLoadFishRodModel()
	setActive(self.escapeTip, false)
	setActive(self.hookedTip, false)
	setActive(self.resultTr, false)
	self:RemoveWaitingToBeHooked()
	self:RemoveTimer()
	self:RemoveWaitForExit()

	self.isFirstClick = false

	self:PlayMovementAnimation()

	if self.fishingPlayer then
		self.fishingPlayer:Dispose()

		self.fishingPlayer = nil
	end

	self.state = var_0_1

	local var_104_0 = pg.TimeMgr.GetInstance()

	pg.GameTrackerMgr.GetInstance().Record(var_104_0, GameTrackerBuilder.BuildIslandFishingExit(self.fishPointId, var_104_0:GetServerTime() - self.startTime))

	return
end

function IslandFishingOPView:OnDestroy()
	self:Clear()

	return
end

return IslandFishingOPView
