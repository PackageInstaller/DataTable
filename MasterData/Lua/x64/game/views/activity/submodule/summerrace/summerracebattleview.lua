local SummerRaceBattleView = class("SummerRaceBattleView", ReduxView)
local var_0_1 = 0.2
local var_0_2 = 0.45
local var_0_3 = 0.9
local var_0_4 = 1.4
local var_0_5 = 0.0005
local var_0_6 = 0.001
local var_0_7 = 0.001
local var_0_8 = 1
local var_0_9 = 2
local var_0_10 = 2
local var_0_11 = 1
local var_0_12 = 10
local var_0_13 = "UI_time_cx"
local var_0_14 = "UI_TimeTextShadow"
local var_0_15 = "Widget/System/Activity_SummerRace/Activity_SummerRace_BattleUI/item/SummerRace_damageText"
local var_0_16 = "Widget/System/Activity_SummerRace/Activity_SummerRace_BattleUI/item/Me"
local var_0_17 = "UI_Me_cx"
local var_0_18 = "UI_Me_xs"
local var_0_19 = 3
local var_0_20 = 8
local var_0_21 = 24
local var_0_22 = 1.2
local var_0_23 = true
local var_0_24 = 0.35
local var_0_25 = {
	timeoutLose = "UI_TimeOutLose_cx",
	lose = "UI_Lose_cx",
	timeoutWin = "UI_TimeOutWin_cx",
	win = "UI_Win_cx"
}

local function var_0_26(arg_1_0)
	if not var_0_23 then
		return
	end
end

local function var_0_27(arg_2_0)
	if arg_2_0 < 0 then
		return 0
	end

	if arg_2_0 > 1 then
		return 1
	end

	return arg_2_0
end

local function var_0_28(arg_3_0)
	return math.floor(arg_3_0 + 0.5)
end

local function var_0_29(arg_4_0, arg_4_1)
	if arg_4_0 == nil or arg_4_0.runtimeAnimatorController == nil then
		return nil
	end

	local var_4_0 = arg_4_0.runtimeAnimatorController.animationClips

	if arg_4_0.runtimeAnimatorController.animationClips == nil then
		return nil
	end

	local var_4_1 = tostring(arg_4_1 or "")

	for iter_4_0 = 0, var_4_0.Length - 1 do
		if var_4_0[iter_4_0] ~= nil then
			if tostring(var_4_0[iter_4_0].name or "") == var_4_1 then
				return tonumber(var_4_0[iter_4_0].length)
			end
		end
	end

	return nil
end

local function var_0_30(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_0 == nil then
		return
	end

	SetActive(arg_5_0, arg_5_1)

	if arg_5_1 ~= true or arg_5_2 == nil then
		return
	end

	local var_5_0 = arg_5_0:GetComponent("Animator")

	if var_5_0 == nil then
		return
	end

	var_5_0.enabled = true

	var_5_0:Rebind()
	var_5_0:Play(arg_5_2, 0, 0)
	var_5_0:Update(0)
end

local function var_0_31(arg_6_0, arg_6_1)
	local var_6_0 = math.max(0, tonumber(arg_6_0) or 0)
	local var_6_1 = math.max(0, tonumber(arg_6_1) or 0)

	if var_6_1 > 0 and var_6_0 >= var_6_1 - var_0_6 then
		return 1
	end

	return var_0_27(var_6_0 - math.floor(var_6_0))
end

local function var_0_32(arg_7_0, arg_7_1)
	local var_7_0 = math.max(0, tonumber(arg_7_0) or 0)
	local var_7_1 = math.max(0, tonumber(arg_7_1) or 0)

	if var_7_1 > 0 and var_7_0 >= var_7_1 - var_0_6 then
		return var_0_28(var_7_1)
	end

	return math.max(0, math.floor(var_7_0 + var_0_6))
end

local function var_0_33(arg_8_0, arg_8_1)
	if arg_8_0 == nil or arg_8_1 == nil or arg_8_1 == "" then
		return nil
	end

	local var_8_0 = arg_8_0:GetComponentsInChildren(typeof(UnityEngine.Transform), true)

	if var_8_0 == nil then
		return nil
	end

	for iter_8_0, iter_8_1 in pairs(var_8_0:ToTable()) do
		if iter_8_1 ~= nil and iter_8_1.name == arg_8_1 then
			return iter_8_1.gameObject
		end
	end

	return nil
end

local function var_0_34(arg_9_0, arg_9_1)
	return (var_0_33(arg_9_0, "head").transform:GetComponent("ControllerExCollection"):GetController("out"))
end

local function var_0_35()
	return PlayerData:GetPlayerInfo().nick
end

function SummerRaceBattleView:UIName()
	return "Widget/System/Activity_SummerRace/Activity_SummerRace_BattleUI/Activity_SummerRace_BattleUI"
end

function SummerRaceBattleView:UIParent()
	return manager.ui.uiMain.transform
end

function SummerRaceBattleView:Init()
	self:BindCfgUI()

	self.timerGo_ = self.timerText_.transform.parent.gameObject
	self.timeAnimator_ = self.timerGo_:GetComponent("Animator")

	local var_13_0 = self.transform_:Find("panel/middle_adapt")

	if var_13_0 then
		self.middleAdaptGo_ = var_13_0.gameObject or nil
	end

	self:BindRuntimePanels()

	self.skillRuntimeSlots_ = {}
	self.skillRuntimeEnergy_ = 0
	self.skillSlotCount_ = -1
	self.countdownPanelState_ = "none"
	self.lastRuntimePhase_ = "None"
	self.enemyIntroBubbleShownWave_ = -1
	self.enemyOverclockBubbleToken_ = 0
	self.lastPlayerEnergy_ = nil
	self.energyCostEffectGo_ = self:ResolveEnergyCostEffectGo()
	self.hpDelayTweens_ = {}
	self.hpDelayTweenTargets_ = {}
	self.damageTextIdlePool_ = {}
	self.damageTextActiveList_ = {}
	self.meLabelShownWave_ = nil
	self.meLabelPendingWave_ = nil
	self.meLabelPendingShow_ = false
	self.onClickSkillSlotHandler_ = handler(self, self.OnClickSkillSlot)

	self:HideSkillBubble(true)
	self:HideEnemyIntroBubble(true)
	self:HideEnergyCostEffect(true)
	self:InitDamageTextPool()
	self:AddUIListener()
end

function SummerRaceBattleView:ResolveEnergyCostEffectGo()
	if self.effectGo_ ~= nil then
		return self.effectGo_
	end

	if self.effetGo_ ~= nil then
		return self.effetGo_
	end

	local var_14_0 = self.transform_:Find("panel/middle_adapt/Player/energy/effect")

	if var_14_0 ~= nil then
		return var_14_0.gameObject
	end

	local var_14_1 = self.transform_:Find("panel/middle_adapt/Player/energy/effet")

	if var_14_1 ~= nil then
		return var_14_1.gameObject
	end

	return var_0_33(self.gameObject_, "effect")
end

function SummerRaceBattleView:BindRuntimePanels()
	self.enemyHeadModeController_ = self.rootControllerEx_:GetController("enemyHeadMode")
	self.energyMaxController_ = self.rootControllerEx_:GetController("energyMax")
	self.challengeController_ = self.rootControllerEx_:GetController("challenge")
	self.timeController_ = self.rootControllerEx_:GetController("time")
	self.enemyAreaBinding_ = {}

	self:BindCfgUI(self.enemyAreaGo_, self.enemyAreaBinding_)

	self.enemyStateController_ = self.enemyAreaBinding_.controllerEx_:GetController("default0")
	self.enemyALabelGo_ = self.enemyAreaBinding_.enemyALabelGo_ or var_0_33(self.enemyAreaBinding_.enemyAGo_, "labelA")
	self.enemyBLabelGo_ = self.enemyAreaBinding_.enemyBLabelGo_ or var_0_33(self.enemyAreaBinding_.enemyBGo_, "labelB")
	self.head2Go_ = self.enemyAreaBinding_.head2Img_.gameObject

	SetActive(self.head2Go_, false)

	self.enemyAHeadOutController_ = var_0_34(self.enemyAreaBinding_.enemyAGo_, "EnemyA")
	self.enemyBHeadOutController_ = var_0_34(self.enemyAreaBinding_.enemyBGo_, "EnemyB")
	self.enemyIntroBubbleGo_ = self.enemyAreaBinding_.enemyIntroBubbleGo_
	self.enemyIntroBubbleText_ = self.enemyAreaBinding_.enemyIntroBubbleText_
	self.winGo_ = self.winGo_ or var_0_33(self.gameObject_, "Win")
	self.loseGo_ = self.loseGo_ or var_0_33(self.gameObject_, "Lose")
	self.timeoutWinGo_ = self.timeOutWinGo_ or var_0_33(self.gameObject_, "TimeOutWin")

	local var_15_0 = self.timeoutLoseGo_

	if not self.timeoutLoseGo_ then
		var_15_0 = self.timeOutLoseGo_

		if not self.timeOutLoseGo_ then
			var_15_0 = var_0_33(self.gameObject_, "TimeOutLose")
			var_15_0 = var_15_0 or var_0_33(self.gameObject_, "TimeoutLose")
		end
	end

	self.timeoutLoseGo_ = var_15_0

	self:SetAllBattleResultBannersVisible(nil)

	self.skillAreaBinding_ = {}

	self:BindCfgUI(self.skillAreaGo_, self.skillAreaBinding_)

	self.skillList_ = LuaList.New(handler(self, self.IndexSkillItem), self.skillAreaBinding_.skillUIList_, SummerRaceBattleSkillItemView)

	self:BindRoundProgressPanel()
end

function SummerRaceBattleView:IndexSkillItem(arg_16_1, arg_16_2)
	arg_16_2:SetClickHandler(self.onClickSkillSlotHandler_)
	arg_16_2:SetData(arg_16_1, self.skillRuntimeSlots_[arg_16_1], self.skillRuntimeEnergy_)
end

function SummerRaceBattleView:BindRoundProgressPanel()
	if self.roundProgressRootGo_ == nil then
		self.roundProgressItems_ = {}
		self.roundProgressItemPool_ = {}

		return
	end

	self.roundProgressItems_ = {}
	self.roundProgressItemPool_ = {}
	self.roundProgressPointGos_ = {}

	if self.roundItemTemplateGo_ ~= nil then
		SetActive(self.roundItemTemplateGo_, false)
	end
end

function SummerRaceBattleView:CreateRoundPoint(arg_18_1, arg_18_2, arg_18_3)
	return {
		go = arg_18_1,
		lightGo = arg_18_2,
		glowGo = arg_18_3
	}
end

function SummerRaceBattleView:SetRoundPointActive(arg_19_1, arg_19_2)
	if arg_19_1 == nil then
		return
	end

	if arg_19_1.lightGo ~= nil then
		SetActive(arg_19_1.lightGo, arg_19_2 == true)
	end

	if arg_19_1.glowGo ~= nil then
		SetActive(arg_19_1.glowGo, arg_19_2 == true)
	end
end

function SummerRaceBattleView:BindRoundProgressItem(arg_20_1)
	local var_20_0 = {}

	self:BindCfgUI(arg_20_1, var_20_0)

	return {
		go = arg_20_1,
		slider = var_20_0.slider_,
		point = self:CreateRoundPoint(var_20_0.pointGo_, var_20_0.lightGo_, var_20_0.glowGo_)
	}
end

function SummerRaceBattleView:GetRoundProgressItem(arg_21_1)
	if self.roundProgressItems_[arg_21_1] ~= nil then
		return self.roundProgressItems_[arg_21_1]
	end

	if self.roundItemTemplateGo_ == nil or self.roundProgressRootGo_ == nil then
		return nil
	end

	local var_21_0 = table.remove(self.roundProgressItemPool_)

	if var_21_0 == nil then
		var_21_0 = Object.Instantiate(self.roundItemTemplateGo_, self.roundProgressRootGo_.transform)
	end

	if self.roundFirstPointGo_ ~= nil then
		self.roundFirstPointGo_.transform:SetSiblingIndex(1)
	end

	var_21_0.transform:SetSiblingIndex(arg_21_1 + 1)

	local var_21_1 = self:BindRoundProgressItem(var_21_0)

	self.roundProgressItems_[arg_21_1] = var_21_1

	return var_21_1
end

function SummerRaceBattleView:EnsureRoundProgressItems(arg_22_1)
	self.roundProgressItems_ = self.roundProgressItems_ or {}
	self.roundProgressItemPool_ = self.roundProgressItemPool_ or {}

	for iter_22_0 = 1, arg_22_1 do
		local var_22_0 = self:GetRoundProgressItem(iter_22_0)

		if var_22_0 ~= nil then
			SetActive(var_22_0.go, true)
		end
	end

	for iter_22_1 = #self.roundProgressItems_, arg_22_1 + 1, -1 do
		self.roundProgressItems_[iter_22_1] = nil

		if self.roundProgressItems_[iter_22_1] ~= nil then
			if self.roundProgressItems_[iter_22_1].slider ~= nil then
				self.roundProgressItems_[iter_22_1].slider.value = 0
			end

			self:SetRoundPointActive(self.roundProgressItems_[iter_22_1].point, false)
			SetActive(self.roundProgressItems_[iter_22_1].go, false)
			table.insert(self.roundProgressItemPool_, self.roundProgressItems_[iter_22_1].go)
		end
	end
end

function SummerRaceBattleView:ResolveRoundProgressPoint(arg_23_1)
	if self.roundProgressPointGos_ == nil then
		self.roundProgressPointGos_ = {}
	end

	if self.roundProgressPointGos_[arg_23_1] ~= nil then
		return self.roundProgressPointGos_[arg_23_1]
	end

	local var_23_0

	if arg_23_1 == 1 then
		var_23_0 = self:CreateRoundPoint(self.roundFirstPointGo_, self.roundFirstLightGo_, self.roundFirstGlowGo_)
	else
		local var_23_1

		if self.roundProgressItems_ then
			var_23_1 = self.roundProgressItems_[arg_23_1 - 1] or nil
		end

		var_23_0 = var_23_1 ~= nil and var_23_1.point or nil
	end

	self.roundProgressPointGos_[arg_23_1] = var_23_0

	return var_23_0
end

function SummerRaceBattleView:SetRoundProgressActivePoint(arg_24_1, arg_24_2)
	local var_24_0 = math.max(1, tonumber(arg_24_2) or 1)
	local var_24_1 = math.max(1, math.min(var_24_0, tonumber(arg_24_1) or 1))

	for iter_24_0 = 1, var_24_0 do
		self:SetRoundPointActive(self:ResolveRoundProgressPoint(iter_24_0), iter_24_0 == var_24_1)
	end
end

function SummerRaceBattleView:StopRoundProgressTween()
	if self.roundProgressTween_ == nil then
		return
	end

	self.roundProgressTween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
	LeanTween.cancel(self.roundProgressTween_.id)

	self.roundProgressTween_ = nil
	self.roundProgressAnimatingToWave_ = nil
end

function SummerRaceBattleView:ResetRoundProgressState()
	self:StopRoundProgressTween()

	self.roundProgressLastWave_ = nil
	self.roundProgressLastWaveTotal_ = nil
	self.roundProgressAnimatingToWave_ = nil
	self.roundProgressPointGos_ = {}

	if self.roundProgressItems_ ~= nil then
		for iter_26_0, iter_26_1 in pairs(self.roundProgressItems_) do
			if iter_26_1.slider ~= nil then
				iter_26_1.slider.value = 0
			end

			self:SetRoundPointActive(iter_26_1.point, false)
			SetActive(iter_26_1.go, false)
			table.insert(self.roundProgressItemPool_, iter_26_1.go)
		end
	end

	self.roundProgressItems_ = {}

	self:SetRoundPointActive(self:CreateRoundPoint(self.roundFirstPointGo_, self.roundFirstLightGo_, self.roundFirstGlowGo_), false)
end

function SummerRaceBattleView:RefreshRoundProgress(arg_27_1, arg_27_2, arg_27_3)
	if self.roundProgressRootGo_ == nil then
		return
	end

	local var_27_0

	if tostring(arg_27_1.mode or "") == SummerRaceConst.MODE.CHALLENGE then
		self:ResetRoundProgressState()

		do return end

		var_27_0 = tonumber(arg_27_3) or 1
	end

	local var_27_1 = math.max(1, var_27_0)
	local var_27_2 = math.max(1, math.min(var_27_1, tonumber(arg_27_2) or 1))
	local var_27_3 = math.max(0, var_27_1 - 1)
	local var_27_4 = self.roundProgressLastWaveTotal_ ~= var_27_1

	self:EnsureRoundProgressItems(var_27_3)

	self.roundProgressPointGos_ = {}

	if self.roundProgressTween_ ~= nil and self.roundProgressAnimatingToWave_ == var_27_2 and self.roundProgressLastWaveTotal_ == var_27_1 then
		return
	end

	for iter_27_0 = 1, var_27_3 do
		if self.roundProgressItems_[iter_27_0] ~= nil and self.roundProgressItems_[iter_27_0].slider ~= nil then
			self.roundProgressItems_[iter_27_0].slider.value = iter_27_0 < var_27_2 and 1 or 0
		end
	end

	local var_27_5 = self.roundProgressLastWave_
	local var_27_6 = not var_27_4 and var_27_5 ~= nil and var_27_2 == var_27_5 + 1 and var_27_5 >= 1 and var_27_5 <= var_27_3 and arg_27_1.phase == "Countdown"

	self:StopRoundProgressTween()

	if var_27_6 then
		local var_27_7 = self.roundProgressItems_[var_27_5]

		if self.roundProgressItems_[var_27_5] ~= nil and self.roundProgressItems_[var_27_5].slider ~= nil then
			self.roundProgressItems_[var_27_5].slider.value = 0

			self:SetRoundProgressActivePoint(var_27_5, var_27_1)

			self.roundProgressAnimatingToWave_ = var_27_2
			self.roundProgressTween_ = LeanTween.value(self.gameObject_, 0, 1, var_0_24):setEase(LeanTweenType.easeOutQuad):setOnUpdate(LuaHelper.FloatAction(function(arg_28_0)
				var_27_7.slider.value = arg_28_0
			end)):setOnComplete(System.Action(function()
				var_27_7.slider.value = 1
				self.roundProgressTween_ = nil
				self.roundProgressAnimatingToWave_ = nil

				self:SetRoundProgressActivePoint(var_27_2, var_27_1)
			end))
		else
			self:SetRoundProgressActivePoint(var_27_2, var_27_1)
		end
	else
		self:SetRoundProgressActivePoint(var_27_2, var_27_1)
	end

	self.roundProgressLastWave_ = var_27_2
	self.roundProgressLastWaveTotal_ = var_27_1
end

function SummerRaceBattleView:AddUIListener()
	return
end

function SummerRaceBattleView:UpdateBar()
	self.windowBarBackHandler_ = self.windowBarBackHandler_ or function()
		self:OpenQuitConfirm()
	end

	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	manager.windowBar:RegistBackCallBack(self.windowBarBackHandler_)
end

function SummerRaceBattleView:CleanupWindowBar()
	if self.windowBarBackHandler_ ~= nil and manager.windowBar:GetLastBackFunc() == self.windowBarBackHandler_ then
		manager.windowBar:HideBar()
	end
end

function SummerRaceBattleView:OpenQuitConfirm()
	if self.quitConfirmOpen_ then
		return
	end

	self.quitConfirmOpen_ = true

	SummerRaceAction.RequestSetPaused(true)
	JumpTools.OpenPageByJump("summerRacePopView", {
		title = GetTips("PROMPT"),
		content = GetTips("ACTIVITY_TANK_BACK"),
		okCb = function()
			self.quitConfirmOpen_ = false

			SummerRaceAction.RequestGiveUpBattle()
		end,
		cancelCb = function()
			self.quitConfirmOpen_ = false

			SummerRaceAction.RequestSetPaused(false)
		end,
		closeCb = function()
			self.quitConfirmOpen_ = false
		end
	})
end

function SummerRaceBattleView:OnClickSkillSlot(arg_38_1)
	if self.skillRuntimeSlots_[arg_38_1].slotType == "weapon" then
		if SummerRaceAction.RequestOverloadWeaponSlot(self.skillRuntimeSlots_[arg_38_1].slotIndex) then
			self:ShowEnergyCostEffect()
			self:ShowOverloadBubble()
		end

		return
	end

	if self.skillRuntimeSlots_[arg_38_1].canUse and SummerRaceAction.RequestUseEquipSlot(self.skillRuntimeSlots_[arg_38_1].slotIndex) then
		self:ShowEnergyCostEffect()
		self:ShowEquipBubble()
	end
end

function SummerRaceBattleView:OnEnter()
	manager.ui:SetMainCamera("summerRaceBattle")
	self:SetSpecialDefeatUiHidden(false)
	self:SetTimeoutResultVisible(nil)
	self:UpdateBar()
	self:ResetRuntimeStateDisplay()

	self.runtimeUpdateHandler_ = handler(self, self.OnRuntimeStateUpdated)

	manager.notify:RegistListener(SummerRaceData.GetEventRuntimeUpdated(), self.runtimeUpdateHandler_)

	self.playerLabelPoseHandler_ = handler(self, self.OnPlayerLabelPoseUpdated)

	manager.notify:RegistListener(SummerRaceData.GetEventPlayerLabelPoseUpdated(), self.playerLabelPoseHandler_)

	self.damageTextHandler_ = handler(self, self.OnDamageText)

	manager.notify:RegistListener(SummerRaceData.GetEventDamageText(), self.damageTextHandler_)
	SummerRaceData:ReplayRuntimeState(self.runtimeUpdateHandler_)
end

function SummerRaceBattleView:OnExit()
	self.quitConfirmOpen_ = false

	self:CleanupWindowBar()

	if self.runtimeUpdateHandler_ then
		manager.notify:RemoveListener(SummerRaceData.GetEventRuntimeUpdated(), self.runtimeUpdateHandler_)

		self.runtimeUpdateHandler_ = nil
	end

	if self.playerLabelPoseHandler_ then
		manager.notify:RemoveListener(SummerRaceData.GetEventPlayerLabelPoseUpdated(), self.playerLabelPoseHandler_)

		self.playerLabelPoseHandler_ = nil
	end

	if self.damageTextHandler_ then
		manager.notify:RemoveListener(SummerRaceData.GetEventDamageText(), self.damageTextHandler_)

		self.damageTextHandler_ = nil
	end

	self:StopAllHpDelayTweens()
	self:ResetRoundProgressState()
	self:HideSkillBubble()
	self:SetTimeoutResultVisible(nil)
	self:RecycleAllDamageTextItems()
	self:HideMeLabel()
	manager.ui:ResetMainCamera()
end

function SummerRaceBattleView:OnRuntimeStateUpdated(arg_41_1)
	self:RefreshByRuntimeState(arg_41_1)
end

function SummerRaceBattleView:OnPlayerLabelPoseUpdated(arg_42_1)
	if self.meLabelPendingShow_ == true then
		if self:ShowMeLabel(arg_42_1) then
			self.meLabelPendingShow_ = false

			if self.meLabelPendingWave_ ~= nil then
				self.meLabelShownWave_ = self.meLabelPendingWave_
			end

			self.meLabelPendingWave_ = nil
		end

		return
	end

	if self.meLabelGo_ ~= nil and self.meLabelActive_ == true then
		self:UpdateMeLabelPosition(arg_42_1)
	end
end

function SummerRaceBattleView:OnDamageText(arg_43_1)
	self:ShowDamageText(arg_43_1)
end

function SummerRaceBattleView:RefreshByRuntimeState(arg_44_1)
	if arg_44_1 == nil then
		self:ResetRuntimeStateDisplay()

		return
	end

	self:RefreshRootControllers(arg_44_1)
	self:RefreshWave(arg_44_1)
	self:RefreshChallengeScore(arg_44_1)
	self:RefreshTimer(arg_44_1)
	self:RefreshPauseState(arg_44_1)
	self:RefreshCountdownPanels(arg_44_1)
	self:RefreshEnemyIntroBubble(arg_44_1)
	self:RefreshMeLabel(arg_44_1)
	self:RefreshEnemyOverclockBubble(arg_44_1)
	self:RefreshPlayerHud(arg_44_1)
	self:RefreshEnemyHud(arg_44_1)
	self:RefreshSkillHud(arg_44_1.skills, arg_44_1.energy)
end

function SummerRaceBattleView:RefreshEnemyIntroBubble(arg_45_1)
	local var_45_1 = tostring(arg_45_1.phase or "")
	local var_45_2 = math.max(0, tonumber(arg_45_1.wave) or 0)

	if self.lastRuntimePhase_ == "Countdown" and var_45_1 == "Battle" and self.enemyIntroBubbleShownWave_ ~= var_45_2 then
		local var_45_4 = tostring(arg_45_1.enemyIntroText or "")

		if var_45_4 ~= "" then
			self.enemyIntroBubbleShownWave_ = var_45_2

			self:ShowEnemyIntroBubble(var_45_4)
		end
	end

	self.lastRuntimePhase_ = var_45_1
end

function SummerRaceBattleView:RefreshEnemyOverclockBubble(arg_46_1)
	local var_46_0 = math.max(0, tonumber(arg_46_1.enemyOverclockBubbleToken) or 0)

	if var_46_0 <= 0 or var_46_0 == self.enemyOverclockBubbleToken_ then
		return
	end

	self.enemyOverclockBubbleToken_ = var_46_0

	local var_46_1 = tostring(arg_46_1.enemyOverclockBubbleText or "")

	if var_46_1 ~= "" then
		self:ShowEnemyIntroBubble(var_46_1)
	end
end

function SummerRaceBattleView:RefreshRootControllers(arg_47_1)
	local var_47_0 = math.max(1, math.floor(tonumber(arg_47_1.enemyCount) or 1))
	local var_47_1 = SummerRaceData:GetRuntimeEnemyHudModels(arg_47_1)
	local var_47_2 = tostring(arg_47_1.mode or "")
	local var_47_3 = var_47_2 == SummerRaceConst.MODE.ONE_VS_TWO_PRACTICE and var_47_0 > 1 or var_47_2 == SummerRaceConst.MODE.SURVIVAL_PRACTICE and #var_47_1 > 1
	local var_47_4 = (var_47_2 == SummerRaceConst.MODE.ONE_VS_TWO_PRACTICE and var_47_0 > 1 or var_47_2 == SummerRaceConst.MODE.SURVIVAL_PRACTICE and #var_47_1 > 1) and (var_47_1[2] or {}).enemyVisible == true

	if var_47_2 == SummerRaceConst.MODE.ONE_VS_TWO_PRACTICE and var_47_0 > 1 or var_47_2 == SummerRaceConst.MODE.SURVIVAL_PRACTICE and #var_47_1 > 1 then
		self.enemyHeadModeController_:SetSelectedState("dual")
	else
		self.enemyHeadModeController_:SetSelectedState("single")
	end

	self:SetEnemyBVisible(var_47_4)
	SetActive(self.enemyALabelGo_, var_47_3)
	SetActive(self.enemyBLabelGo_, var_47_4)
	self.energyMaxController_:SetSelectedState(arg_47_1.maxEnergy > 0 and arg_47_1.energy >= arg_47_1.maxEnergy - var_0_6 and "max" or "normal")

	if self.challengeController_ ~= nil then
		self.challengeController_:SetSelectedState(var_47_2 == SummerRaceConst.MODE.CHALLENGE and "show" or "hide")
	end
end

function SummerRaceBattleView:RefreshWave(arg_48_1)
	local var_48_0 = math.max(0, tonumber(arg_48_1.wave) or 0)
	local var_48_1 = math.max(1, tonumber(arg_48_1.waveTotal) or 1)

	self.waveText_.text = string.format(GetTips("ACTIVITY_TANK_WAVE_PROGRESS"), var_48_0, var_48_1)

	local var_48_2 = 0
	local var_48_3 = math.max(0, tonumber(arg_48_1.enemyMaxHp) or 0)

	if arg_48_1.phase ~= "Countdown" then
		if arg_48_1.enemyAlive == true and var_48_3 > 0 then
			var_48_2 = 1 - var_0_27(math.max(0, tonumber(arg_48_1.enemyHp) or 0) / var_48_3)
		elseif var_48_0 > 0 then
			var_48_2 = 1
		end
	end

	if self.waveProgressSlider_ then
		self.waveProgressSlider_.value = var_0_27((math.max(0, var_48_0 - 1) + var_48_2) / var_48_1)
	end

	self:RefreshRoundProgress(arg_48_1, var_48_0, var_48_1)
end

function SummerRaceBattleView:RefreshChallengeScore(arg_49_1)
	if self.scoreNumText_ == nil then
		return
	end

	local var_49_0

	if tostring(arg_49_1.mode or "") ~= SummerRaceConst.MODE.CHALLENGE then
		self.scoreNumText_.text = ""

		do return end

		var_49_0 = tonumber(arg_49_1.score) or 0
	end

	self.scoreNumText_.text = tostring((math.max(0, math.floor(var_49_0))))
end

function SummerRaceBattleView:RefreshPauseState(arg_50_1)
	if self.pausePanelGo_ then
		SetActive(self.pausePanelGo_, false)
	end

	if self.pauseBtn_ then
		self.pauseBtn_.interactable = arg_50_1.phase ~= "Result"
	end
end

function SummerRaceBattleView:SetCountdownPanelState(arg_51_1)
	if self.countdownPanelState_ == arg_51_1 then
		return
	end

	self.countdownPanelState_ = arg_51_1

	SetActive(self.startPanelGo_, arg_51_1 == "start")
	SetActive(self.readyPanelGo_, arg_51_1 == "ready")
end

function SummerRaceBattleView:RefreshCountdownPanels(arg_52_1)
	local var_52_0

	if arg_52_1.phase ~= "Countdown" then
		self:SetCountdownPanelState("none")

		do return end

		var_52_0 = tonumber(arg_52_1.wave) or 1
	end

	local var_52_1 = string.format(GetTips("ACTIVITY_TANK_WAVE"), (math.max(1, var_52_0)))

	self.readyRoundTextLineText_.text = var_52_1
	self.readyRoundTextText_.text = var_52_1

	if arg_52_1.countdownRemaining > var_0_11 then
		self:SetCountdownPanelState("ready")
	else
		self:SetCountdownPanelState("start")
	end
end

function SummerRaceBattleView:SetTimerVisible(arg_53_1)
	SetActive(self.timerGo_, arg_53_1 == true)
end

function SummerRaceBattleView:SetTimeControllerState(arg_54_1)
	if self.lastTimeState_ == arg_54_1 then
		return
	end

	self.lastTimeState_ = arg_54_1

	if self.timeController_ ~= nil then
		self.timeController_:SetSelectedState(arg_54_1)
	end

	self:PlayTimeAnimatorState(arg_54_1)
end

function SummerRaceBattleView:PlayTimeAnimatorState(arg_55_1)
	if self.timeAnimator_ == nil then
		return
	end

	self.timeAnimator_:Play((arg_55_1 == "red" or nil) and (var_0_14 or var_0_13), -1, 0)
end

local function var_0_36(arg_56_0)
	if tostring(arg_56_0.mode or "") == SummerRaceConst.MODE.SURVIVAL_PRACTICE then
		return true
	end

	local var_56_1 = SummerRaceData:FindRuntimeStageInfoById(arg_56_0.stageId)

	return (tonumber(var_56_1 and var_56_1.timeLimitSeconds) or 0) > 0
end

function SummerRaceBattleView:RefreshTimer(arg_57_1)
	if arg_57_1.phase == "Countdown" then
		self:SetTimerVisible(false)

		self.timerText_.text = ""

		self:SetTimeControllerState("normal")

		return
	end

	self:SetTimerVisible(true)

	local var_57_0 = math.floor((tonumber(arg_57_1.timer) or 0) + 0.5)

	self.timerText_.text = string.format("%02d:%02d", math.floor(var_57_0 / 60), var_57_0 % 60)

	self:SetTimeControllerState(var_0_36(arg_57_1) and var_57_0 <= var_0_12 and "red" or "normal")
end

function SummerRaceBattleView:RefreshPlayerHud(arg_58_1)
	local var_58_0 = math.max(1, arg_58_1.maxHp)
	local var_58_1 = var_0_27(arg_58_1.hp / var_58_0)

	self.playerHpSlider_.value = var_58_1

	self:RefreshDelaySlider("playerHp", self.playerHpDelaySlider_, var_58_1)

	self.playerEnergySlider_.value = var_0_31(arg_58_1.energy, arg_58_1.maxEnergy)
	self.playerHpText_.text = string.format("%d/%d", var_0_28(arg_58_1.hp), var_0_28(var_58_0))
	self.playerEnergyText_.text = string.format("%d", var_0_32(arg_58_1.energy, arg_58_1.maxEnergy))
	self.playerNameText_.text = var_0_35()

	self:RefreshEnergyCostEffect(arg_58_1.energy)
end

function SummerRaceBattleView:RefreshEnergyCostEffect(arg_59_1)
	local var_59_0 = math.max(0, tonumber(arg_59_1) or 0)

	self.lastPlayerEnergy_ = var_59_0

	if self.lastPlayerEnergy_ == nil then
		return
	end

	if var_59_0 < self.lastPlayerEnergy_ - var_0_7 then
		self:ShowEnergyCostEffect()
	end
end

function SummerRaceBattleView:RefreshDelaySlider(arg_60_1, arg_60_2, arg_60_3)
	if arg_60_2 == nil then
		return
	end

	local var_60_0 = arg_60_2.value

	if arg_60_2.value <= arg_60_3 then
		self:StopHpDelayTween(arg_60_1)

		arg_60_2.value = arg_60_3
		self.hpDelayTweenTargets_[arg_60_1] = nil

		return
	end

	if self.hpDelayTweens_[arg_60_1] ~= nil and self.hpDelayTweenTargets_[arg_60_1] ~= nil and math.abs(self.hpDelayTweenTargets_[arg_60_1] - arg_60_3) <= var_0_5 then
		return
	end

	self:StopHpDelayTween(arg_60_1)

	local var_60_1 = var_0_2 + (var_60_0 - arg_60_3) * var_0_3

	if var_0_2 + (var_60_0 - arg_60_3) * var_0_3 > var_0_4 then
		var_60_1 = var_0_4
	end

	self.hpDelayTweenTargets_[arg_60_1] = arg_60_3
	self.hpDelayTweens_[arg_60_1] = LeanTween.value(self.gameObject_, var_60_0, arg_60_3, var_60_1):setDelay(var_0_1):setEase(LeanTweenType.easeOutQuad):setOnUpdate(LuaHelper.FloatAction(function(arg_61_0)
		arg_60_2.value = arg_61_0
	end)):setOnComplete(System.Action(function()
		self.hpDelayTweens_[arg_60_1] = nil
		self.hpDelayTweenTargets_[arg_60_1] = nil
	end))
end

function SummerRaceBattleView:StopHpDelayTween(arg_63_1)
	if self.hpDelayTweens_[arg_63_1] == nil then
		return
	end

	self.hpDelayTweens_[arg_63_1]:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
	LeanTween.cancel(self.hpDelayTweens_[arg_63_1].id)

	self.hpDelayTweens_[arg_63_1] = nil
	self.hpDelayTweenTargets_[arg_63_1] = nil
end

function SummerRaceBattleView:StopAllHpDelayTweens()
	for iter_64_0, iter_64_1 in pairs(self.hpDelayTweens_) do
		self:StopHpDelayTween(iter_64_0)
	end
end

function SummerRaceBattleView:InitDamageTextPool()
	self.damageTextPrefab_ = Asset.Load(var_0_15)

	if self.damageTextPrefab_ == nil then
		error("[SummerRaceBattleView] missing damage text prefab: " .. var_0_15)
	end

	self:EnsureDamageTextLayer()

	for iter_65_0 = 1, var_0_20 do
		self:RecycleDamageTextItem(self:CreateDamageTextItem(), true)
	end
end

function SummerRaceBattleView:EnsureDamageTextLayer()
	if self.damageTextLayerGo_ ~= nil then
		SetActive(self.damageTextLayerGo_, true)
		var_0_26("EnsureLayer reuse activeInHierarchy=" .. tostring(self.damageTextLayerGo_.activeInHierarchy))

		return
	end

	self.damageTextLayerGo_ = GameObject("DamageTextLayer")

	local var_66_0 = self.damageTextLayerGo_:AddComponent(typeof(RectTransform))

	self.damageTextLayerRect_ = var_66_0

	local var_66_1

	if self.panelGo_ then
		var_66_1 = self.panelGo_.transform or self.transform_
	end

	var_66_0:SetParent(var_66_1, false)

	var_66_0.anchorMin = Vector2.New(0, 0)
	var_66_0.anchorMax = Vector2.New(1, 1)
	var_66_0.pivot = Vector2.New(0.5, 0.5)
	var_66_0.offsetMin = Vector2.New(0, 0)
	var_66_0.offsetMax = Vector2.New(0, 0)
	var_66_0.localScale = Vector3.one
	var_66_0.localEulerAngles = Vector3.zero

	self.damageTextLayerGo_.transform:SetAsLastSibling()
	SetActive(self.damageTextLayerGo_, true)
	var_0_26("EnsureLayer create parent=" .. tostring((var_66_1 or nil) and (var_66_1.name or "<nil>")) .. " sibling=" .. tostring(self.damageTextLayerGo_.transform:GetSiblingIndex()) .. " activeInHierarchy=" .. tostring(self.damageTextLayerGo_.activeInHierarchy))
end

function SummerRaceBattleView:CreateDamageTextItem()
	local var_67_0 = Object.Instantiate(self.damageTextPrefab_, self.damageTextLayerRect_)

	SetActive(var_67_0, false)

	return {
		go = var_67_0,
		transform = var_67_0.transform,
		rect = var_67_0.transform:GetComponent(typeof(RectTransform)),
		controller = var_67_0.transform:GetComponent("ControllerExCollection"):GetController("type")
	}
end

function SummerRaceBattleView:AcquireDamageTextItem()
	self:EnsureDamageTextLayer()

	local var_68_0 = table.remove(self.damageTextIdlePool_)

	if var_68_0 ~= nil then
		return var_68_0
	end

	if #self.damageTextActiveList_ >= var_0_21 then
		local var_68_1 = table.remove(self.damageTextActiveList_, 1)

		if var_68_1 ~= nil then
			self:StopDamageTextTimer(var_68_1)

			return var_68_1
		end
	end

	return self:CreateDamageTextItem()
end

function SummerRaceBattleView:ShowDamageText(arg_69_1)
	local var_69_0

	if type(arg_69_1) ~= "table" then
		var_0_26("ShowDamageText ignored invalid payload type=" .. tostring(type(arg_69_1)))

		do return end

		var_69_0 = tonumber(arg_69_1.amount) or 0
	end

	local var_69_1 = math.max(0, math.floor(var_69_0 + 0.5))

	if var_69_1 <= 0 then
		var_0_26("ShowDamageText ignored amount<=0 raw=" .. tostring(arg_69_1.amount))

		return
	end

	local var_69_2 = self:WorldToDamageTextLocalPosition(tonumber(arg_69_1.worldX), tonumber(arg_69_1.worldY), tonumber(arg_69_1.worldZ))

	if var_69_2 == nil then
		var_0_26("ShowDamageText localPos=nil world=(" .. tostring(arg_69_1.worldX) .. "," .. tostring(arg_69_1.worldY) .. ")")

		return
	end

	local var_69_3 = self:AcquireDamageTextItem()

	table.insert(self.damageTextActiveList_, var_69_3)

	local var_69_4 = tostring(arg_69_1.state or "")

	if var_69_4 ~= "me" and var_69_4 ~= "enemy" and var_69_4 ~= "overclock" then
		var_69_4 = "me"
	end

	local var_69_5 = "-" .. tostring(var_69_1)

	var_69_3.controller:SetSelectedState(var_69_4)
	SummerRaceLuaBridge.RequestSetDamageText(var_69_3.go, var_69_5)
	var_69_3.transform:SetParent(self.damageTextLayerRect_, false)
	var_69_3.transform:SetAsLastSibling()

	var_69_3.rect.anchoredPosition = var_69_2
	var_69_3.rect.localScale = Vector3.one
	var_69_3.rect.localEulerAngles = Vector3.zero

	SetActive(var_69_3.go, false)
	SetActive(var_69_3.go, true)

	local var_69_6

	if var_69_3.transform.parent then
		var_69_6 = var_69_3.transform.parent.name or "<nil>"
	end

	local var_69_7 = var_69_3.transform:Find("TextMe")
	local var_69_8 = var_69_3.transform:Find("TextEnemy")
	local var_69_9

	if var_69_7 then
		var_69_9 = var_69_7.gameObject.activeSelf or false

		local var_69_10

		if var_69_8 then
			var_69_10 = var_69_8.gameObject.activeSelf or false
		end
	end

	var_0_26("ShowDamageText spawn amount=" .. tostring(var_69_1) .. " state=" .. tostring(var_69_4) .. " world=(" .. tostring(arg_69_1.worldX) .. "," .. tostring(arg_69_1.worldY) .. ")" .. " local=(" .. tostring(var_69_2.x) .. "," .. tostring(var_69_2.y) .. ")" .. " itemActiveInHierarchy=" .. tostring(var_69_3.go.activeInHierarchy) .. " itemLayer=" .. tostring(var_69_3.go.layer) .. " parent=" .. tostring(var_69_6) .. " textMeActive=" .. tostring(var_69_9) .. " textEnemyActive=" .. tostring(var_69_10) .. " activeCount=" .. tostring(#self.damageTextActiveList_) .. " idleCount=" .. tostring(#self.damageTextIdlePool_))

	var_69_3.timer = Timer.New(function()
		self:RecycleDamageTextItem(var_69_3)
	end, var_0_22, 1)

	var_69_3.timer:Start()
end

function SummerRaceBattleView:WorldToDamageTextLocalPosition(arg_71_1, arg_71_2, arg_71_3)
	if arg_71_1 == nil or arg_71_2 == nil or self.damageTextLayerRect_ == nil then
		var_0_26("WorldToLocal early return worldX=" .. tostring(arg_71_1) .. " worldY=" .. tostring(arg_71_2) .. " layerRectNil=" .. tostring(self.damageTextLayerRect_ == nil))

		return nil
	end

	local var_71_0 = UnityEngine.Camera.main
	local var_71_1

	if manager and manager.ui then
		var_71_1 = manager.ui.canvas or nil

		if var_71_0 == nil or var_71_1 == nil then
			var_0_26("WorldToLocal camera/canvas missing mainCameraNil=" .. tostring(var_71_0 == nil) .. " canvasNil=" .. tostring(var_71_1 == nil))

			return nil
		end
	end

	local var_71_2 = var_71_1:GetComponent(typeof(Canvas))

	if var_71_2 == nil then
		var_0_26("WorldToLocal canvasComponent missing")

		return nil
	end

	local var_71_3 = var_71_2.worldCamera
	local var_71_4 = UnityEngine.RectTransformUtility.WorldToScreenPoint(var_71_0, (Vector3.New(arg_71_1, arg_71_2, arg_71_3 or 0)))
	local var_71_5, var_71_6 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(self.damageTextLayerRect_, var_71_4, var_71_2.worldCamera, nil)

	var_0_26("WorldToLocal camera=" .. tostring(var_71_0.name) .. " uiCamera=" .. tostring((var_71_3 or nil) and (var_71_3.name or "nil")) .. "WorldToLocal world=(" .. tostring(arg_71_1) .. "," .. tostring(arg_71_2) .. "," .. tostring(arg_71_3) .. ")" .. " screen=(" .. tostring(var_71_4.x) .. "," .. tostring(var_71_4.y) .. ")" .. " local=(" .. tostring(var_71_6.x) .. "," .. tostring(var_71_6.y) .. ")" .. " uiCameraNil=" .. tostring(var_71_3 == nil))

	return var_71_6
end

function SummerRaceBattleView:RefreshMeLabel(arg_72_1)
	local var_72_1 = tostring(arg_72_1.phase or "")
	local var_72_2 = math.max(1, math.floor(tonumber(arg_72_1.wave) or 1))

	if self.meLabelLastRuntimePhase_ == "Countdown" and var_72_1 == "Battle" and self.meLabelShownWave_ ~= var_72_2 then
		self.meLabelPendingShow_ = true
		self.meLabelPendingWave_ = var_72_2
	end

	if self.meLabelPendingShow_ == true and self:ShowMeLabel(arg_72_1) then
		self.meLabelPendingShow_ = false
		self.meLabelShownWave_ = self.meLabelPendingWave_ or var_72_2
		self.meLabelPendingWave_ = nil
	end

	if self.meLabelGo_ ~= nil and self.meLabelActive_ == true then
		self:UpdateMeLabelPosition(arg_72_1)
	end

	self.meLabelLastRuntimePhase_ = var_72_1
end

function SummerRaceBattleView:ShowMeLabel(arg_73_1)
	if self.meLabelGo_ == nil then
		local var_73_0 = Asset.Load(var_0_16)

		if var_73_0 == nil then
			return false
		end

		self:EnsureDamageTextLayer()

		self.meLabelGo_ = Object.Instantiate(var_73_0, self.damageTextLayerRect_)
		self.meLabelRect_ = self.meLabelGo_.transform:GetComponent(typeof(RectTransform))
		self.meLabelAnimator_ = self.meLabelGo_.transform:GetComponent("Animator")
		self.meLabelShowAnimDuration_ = var_0_29(self.meLabelAnimator_, var_0_17)
		self.meLabelHideAnimDuration_ = var_0_29(self.meLabelAnimator_, var_0_18)

		SetActive(self.meLabelGo_, false)
	else
		self.meLabelGo_.transform:SetParent(self.damageTextLayerRect_, false)
	end

	local var_73_1 = self:ResolveMeLabelLocalPosition(arg_73_1)

	if var_73_1 == nil then
		return false
	end

	self.meLabelGo_.transform:SetAsLastSibling()

	self.meLabelRect_.localScale = Vector3.one
	self.meLabelRect_.localEulerAngles = Vector3.zero
	self.meLabelRect_.anchoredPosition = var_73_1

	SetActive(self.meLabelGo_, true)

	self.meLabelActive_ = true

	self:PlayMeLabelAnimator(var_0_17)
	self:StopMeLabelTimer()

	self.meLabelTimer_ = Timer.New(function()
		self:HideMeLabel()
	end, math.max(var_0_19, tonumber(self.meLabelShowAnimDuration_) or 0), 1)

	self.meLabelTimer_:Start()

	return true
end

function SummerRaceBattleView:PlayMeLabelAnimator(arg_75_1)
	if self.meLabelAnimator_ == nil or arg_75_1 == nil then
		return
	end

	self.meLabelAnimator_.enabled = true

	self.meLabelAnimator_:Play(arg_75_1, -1, 0)
	self.meLabelAnimator_:Update(0)
end

function SummerRaceBattleView:ResolveMeLabelLocalPosition(arg_76_1)
	if arg_76_1 == nil or arg_76_1.playerLabelWorldX == nil or arg_76_1.playerLabelWorldY == nil then
		return nil
	end

	local var_76_0 = self:WorldToDamageTextLocalPosition(tonumber(arg_76_1.playerLabelWorldX), tonumber(arg_76_1.playerLabelWorldY), tonumber(arg_76_1.playerLabelWorldZ))

	if var_76_0 == nil then
		return nil
	end

	return Vector2.New(var_76_0.x, var_76_0.y + (tonumber(arg_76_1.playerLabelScreenOffsetY) or 150))
end

function SummerRaceBattleView:UpdateMeLabelPosition(arg_77_1)
	if self.meLabelRect_ == nil then
		return false
	end

	local var_77_0 = self:ResolveMeLabelLocalPosition(arg_77_1)

	if var_77_0 == nil then
		return false
	end

	self.meLabelRect_.anchoredPosition = var_77_0

	return true
end

function SummerRaceBattleView:HideMeLabel()
	self:StopMeLabelTimer()

	if self.meLabelGo_ == nil then
		self.meLabelActive_ = false

		return
	end

	self:PlayMeLabelAnimator(var_0_18)

	local var_78_0 = tonumber(self.meLabelHideAnimDuration_) or 0

	if var_78_0 <= 0 then
		self:CompleteMeLabelHide()

		return
	end

	self.meLabelTimer_ = Timer.New(function()
		self:CompleteMeLabelHide()
	end, var_78_0, 1)

	self.meLabelTimer_:Start()
end

function SummerRaceBattleView:CompleteMeLabelHide()
	self:StopMeLabelTimer()

	self.meLabelActive_ = false

	if self.meLabelGo_ ~= nil then
		SetActive(self.meLabelGo_, false)
	end
end

function SummerRaceBattleView:StopMeLabelTimer()
	if self.meLabelTimer_ ~= nil then
		self.meLabelTimer_:Stop()

		self.meLabelTimer_ = nil
	end
end

function SummerRaceBattleView:StopDamageTextTimer(arg_82_1)
	if arg_82_1 ~= nil and arg_82_1.timer ~= nil then
		arg_82_1.timer:Stop()

		arg_82_1.timer = nil
	end
end

function SummerRaceBattleView:RecycleDamageTextItem(arg_83_1, arg_83_2)
	if arg_83_1 == nil then
		return
	end

	self:StopDamageTextTimer(arg_83_1)

	if arg_83_2 ~= true then
		for iter_83_0 = #self.damageTextActiveList_, 1, -1 do
			if self.damageTextActiveList_[iter_83_0] == arg_83_1 then
				table.remove(self.damageTextActiveList_, iter_83_0)

				break
			end
		end
	end

	SetActive(arg_83_1.go, false)
	table.insert(self.damageTextIdlePool_, arg_83_1)
end

function SummerRaceBattleView:RecycleAllDamageTextItems()
	for iter_84_0 = #self.damageTextActiveList_, 1, -1 do
		self:RecycleDamageTextItem(self.damageTextActiveList_[iter_84_0], true)
		table.remove(self.damageTextActiveList_, iter_84_0)
	end
end

function SummerRaceBattleView:DisposeDamageTextPool()
	self:RecycleAllDamageTextItems()
	self:StopMeLabelTimer()

	if self.meLabelGo_ ~= nil then
		Object.Destroy(self.meLabelGo_)

		self.meLabelGo_ = nil
		self.meLabelRect_ = nil
		self.meLabelAnimator_ = nil
		self.meLabelShowAnimDuration_ = nil
		self.meLabelHideAnimDuration_ = nil
		self.meLabelActive_ = false
	end

	for iter_85_0 = #self.damageTextIdlePool_, 1, -1 do
		self:StopDamageTextTimer(self.damageTextIdlePool_[iter_85_0])

		if self.damageTextIdlePool_[iter_85_0].go ~= nil then
			Object.Destroy(self.damageTextIdlePool_[iter_85_0].go)
		end

		self.damageTextIdlePool_[iter_85_0] = nil
	end

	if self.damageTextLayerGo_ ~= nil then
		Object.Destroy(self.damageTextLayerGo_)

		self.damageTextLayerGo_ = nil
		self.damageTextLayerRect_ = nil
	end
end

function SummerRaceBattleView:RefreshEnemyHud(arg_86_1)
	local var_86_0 = math.max(1, arg_86_1.enemyMaxHp)
	local var_86_1 = arg_86_1.enemyName
	local var_86_2 = SummerRaceData:GetRuntimeEnemyAvatarPath(arg_86_1)
	local var_86_3 = SummerRaceData:GetRuntimeEnemyHudModels(arg_86_1)
	local var_86_4 = var_86_3[1] or {}
	local var_86_5 = var_86_3[2] or {}
	local var_86_6 = tostring(arg_86_1.mode or "")
	local var_86_7 = var_86_6 == SummerRaceConst.MODE.ONE_VS_TWO_PRACTICE or var_86_6 == SummerRaceConst.MODE.SURVIVAL_PRACTICE
	local var_86_8 = tostring(var_86_4.enemyName or var_86_1)
	local var_86_9 = tostring(var_86_5.enemyName or "")
	local var_86_10 = tostring(var_86_4.enemyAvatarPath or var_86_2)
	local var_86_11 = tostring(var_86_5.enemyAvatarPath or "")
	local var_86_12 = math.max(0, tonumber(var_86_4.enemyHp) or arg_86_1.enemyHp)
	local var_86_13 = math.max(1, tonumber(var_86_4.enemyMaxHp) or var_86_0)
	local var_86_14 = math.max(0, tonumber(var_86_5.enemyHp) or 0)
	local var_86_15 = math.max(1, tonumber(var_86_5.enemyMaxHp) or var_86_0)
	local var_86_16 = var_0_27(var_86_12 / var_86_13)
	local var_86_17 = var_0_27(var_86_14 / var_86_15)
	local var_86_18 = string.format("%d/%d", var_0_28(var_86_12), var_0_28(var_86_13))
	local var_86_19 = string.format("%d/%d", var_0_28(var_86_14), var_0_28(var_86_15))
	local var_86_20 = SummerRaceData:GetRuntimeTeammateAvatarPath(arg_86_1)

	self.enemyAreaBinding_.enemyANameText_.text = var_86_8
	self.enemyAreaBinding_.enemyBNameText_.text = var_86_9
	self.enemyAreaBinding_.enemyAHeadImg_.spriteSync = var_86_10 ~= "" and var_86_10 or nil
	self.enemyAreaBinding_.enemyBHeadImg_.spriteSync = var_86_11 ~= "" and var_86_11 or nil
	self.enemyAreaBinding_.head2Img_.spriteSync = var_86_20 ~= "" and var_86_20 or nil

	SetActive(self.head2Go_, var_86_20 ~= "")

	if var_86_7 then
		self:SetEnemyHeadOutByController(self.enemyAHeadOutController_, var_86_4.enemyHeadOut == true)
		self:SetEnemyHeadOutByController(self.enemyBHeadOutController_, var_86_5.enemyHeadOut == true)
	else
		self:SetEnemyHeadOut(arg_86_1.enemyHeadOut == true)
	end

	self.enemyAreaBinding_.enemyAHpText_.text = var_86_18
	self.enemyAreaBinding_.enemyBHpText_.text = var_86_19
	self.enemyAreaBinding_.enemyAHpSlider_.value = var_86_16
	self.enemyAreaBinding_.enemyBHpSlider_.value = var_86_17

	self:RefreshDelaySlider("enemyAHp", self.enemyAreaBinding_.enemyAHpDelaySlider_, var_86_16)
	self:RefreshDelaySlider("enemyBHp", self.enemyAreaBinding_.enemyBHpDelaySlider_, var_86_17)
end

function SummerRaceBattleView:RefreshSkillHud(arg_87_1, arg_87_2)
	self.skillRuntimeSlots_ = arg_87_1
	self.skillRuntimeEnergy_ = arg_87_2

	if self.skillSlotCount_ ~= #self.skillRuntimeSlots_ then
		self.skillSlotCount_ = #self.skillRuntimeSlots_

		self.skillList_:StartScroll(#self.skillRuntimeSlots_)
	else
		self.skillList_:Refresh()
	end
end

function SummerRaceBattleView:ShowOverloadBubble()
	local var_88_0

	if SummerRaceConst.BATTLE then
		var_88_0 = SummerRaceConst.BATTLE.OVERLOAD_BUBBLE_TIPS or nil

		local var_88_1

		if var_88_0 then
			var_88_1 = #var_88_0 or 0

			if var_88_1 <= 0 then
				return
			end
		end
	end

	self:ShowSkillBubble((GetTips(var_88_0[math.random(1, var_88_1)])))
end

function SummerRaceBattleView:ShowEquipBubble()
	local var_89_0

	if SummerRaceConst.BATTLE then
		var_89_0 = SummerRaceConst.BATTLE.EQUIP_BUBBLE_TIPS or nil

		local var_89_1

		if var_89_0 then
			var_89_1 = #var_89_0 or 0

			if var_89_1 <= 0 then
				return
			end
		end
	end

	self:ShowSkillBubble((GetTips(var_89_0[math.random(1, var_89_1)])))
end

function SummerRaceBattleView:ShowSkillBubble(arg_90_1, arg_90_2)
	if self.skillBubbleGo_ == nil or self.skillBubbleText_ == nil then
		return
	end

	self:StopSkillBubbleTimer()
	SetActive(self.skillBubbleGo_, false)

	self.skillBubbleText_.text = tostring(arg_90_1 or "")

	if self.skillBubbleText_.text == "" then
		return
	end

	SetActive(self.skillBubbleGo_, true)

	local var_90_0 = tonumber(arg_90_2) or var_0_9

	if var_90_0 <= 0 then
		var_90_0 = var_0_9
	end

	self.skillBubbleTimer_ = Timer.New(function()
		self:HideSkillBubble()
	end, var_90_0, 1)

	self.skillBubbleTimer_:Start()
end

function SummerRaceBattleView:ShowEnemyIntroBubble(arg_92_1)
	if self.enemyIntroBubbleGo_ == nil or self.enemyIntroBubbleText_ == nil then
		return
	end

	self:StopEnemyIntroBubbleTimer()

	self.enemyIntroBubbleText_.text = tostring(arg_92_1 or "")

	SetActive(self.enemyIntroBubbleGo_, self.enemyIntroBubbleText_.text ~= "")

	if self.enemyIntroBubbleText_.text == "" then
		return
	end

	self.enemyIntroBubbleTimer_ = Timer.New(function()
		self:HideEnemyIntroBubble()
	end, var_0_10, 1)

	self.enemyIntroBubbleTimer_:Start()
end

function SummerRaceBattleView:HideSkillBubble(arg_94_1)
	if not arg_94_1 then
		self:StopSkillBubbleTimer()
	end

	if self.skillBubbleText_ then
		self.skillBubbleText_.text = ""
	end

	if self.skillBubbleGo_ then
		SetActive(self.skillBubbleGo_, false)
	end
end

function SummerRaceBattleView:HideEnemyIntroBubble(arg_95_1)
	if not arg_95_1 then
		self:StopEnemyIntroBubbleTimer()
	end

	if self.enemyIntroBubbleText_ then
		self.enemyIntroBubbleText_.text = ""
	end

	if self.enemyIntroBubbleGo_ then
		SetActive(self.enemyIntroBubbleGo_, false)
	end
end

function SummerRaceBattleView:StopSkillBubbleTimer()
	if self.skillBubbleTimer_ ~= nil then
		self.skillBubbleTimer_:Stop()

		self.skillBubbleTimer_ = nil
	end
end

function SummerRaceBattleView:StopEnemyIntroBubbleTimer()
	if self.enemyIntroBubbleTimer_ ~= nil then
		self.enemyIntroBubbleTimer_:Stop()

		self.enemyIntroBubbleTimer_ = nil
	end
end

function SummerRaceBattleView:ShowEnergyCostEffect()
	if self.energyCostEffectGo_ == nil then
		return
	end

	self:StopEnergyCostEffectTimer()
	SetActive(self.energyCostEffectGo_, false)
	SetActive(self.energyCostEffectGo_, true)

	self.energyCostEffectTimer_ = Timer.New(function()
		self:HideEnergyCostEffect()
	end, var_0_8, 1)

	self.energyCostEffectTimer_:Start()
end

function SummerRaceBattleView:HideEnergyCostEffect(arg_100_1)
	if not arg_100_1 then
		self:StopEnergyCostEffectTimer()
	end

	if self.energyCostEffectGo_ ~= nil then
		SetActive(self.energyCostEffectGo_, false)
	end
end

function SummerRaceBattleView:StopEnergyCostEffectTimer()
	if self.energyCostEffectTimer_ ~= nil then
		self.energyCostEffectTimer_:Stop()

		self.energyCostEffectTimer_ = nil
	end
end

function SummerRaceBattleView:ResetRuntimeStateDisplay()
	self:StopAllHpDelayTweens()
	self:ResetRoundProgressState()
	self:HideSkillBubble()
	self:HideEnemyIntroBubble()
	self:HideEnergyCostEffect()
	self.enemyHeadModeController_:SetSelectedState("single")
	self:SetEnemyBVisible(false)
	self.energyMaxController_:SetSelectedState("normal")

	if self.challengeController_ ~= nil then
		self.challengeController_:SetSelectedState("hide")
	end

	self.lastTimeState_ = nil

	self:SetTimeControllerState("normal")

	self.lastRuntimePhase_ = "None"
	self.meLabelLastRuntimePhase_ = "None"
	self.meLabelShownWave_ = nil
	self.meLabelPendingWave_ = nil
	self.meLabelPendingShow_ = false

	self:HideMeLabel()

	self.enemyIntroBubbleShownWave_ = -1
	self.enemyOverclockBubbleToken_ = 0
	self.lastPlayerEnergy_ = nil
	self.waveText_.text = ""

	if self.scoreNumText_ ~= nil then
		self.scoreNumText_.text = ""
	end

	self:SetTimerVisible(false)

	self.timerText_.text = ""
	self.playerHpText_.text = ""
	self.playerEnergyText_.text = ""
	self.playerHpSlider_.value = 0
	self.playerHpDelaySlider_.value = 0
	self.playerEnergySlider_.value = 0

	if self.waveProgressSlider_ then
		self.waveProgressSlider_.value = 0
	end

	if self.pausePanelGo_ then
		SetActive(self.pausePanelGo_, false)
	end

	self:SetCountdownPanelState("none")

	self.readyRoundTextLineText_.text = ""
	self.readyRoundTextText_.text = ""

	self:RefreshEnemyHud({
		enemyHeadOut = false,
		mode = "championship",
		enemyAlive = false,
		enemyMaxHp = 1,
		enemyHp = 0,
		enemyName = ""
	})
	self:RefreshSkillHud({}, 0)
end

function SummerRaceBattleView:SetSpecialDefeatUiHidden(arg_103_1)
	local var_103_0 = arg_103_1 ~= true

	if self.middleAdaptGo_ then
		SetActive(self.middleAdaptGo_, var_103_0)
	end

	if self.damageTextLayerGo_ then
		SetActive(self.damageTextLayerGo_, var_103_0)
	end
end

function SummerRaceBattleView:SetEnemyHeadOut(arg_104_1)
	self:SetEnemyHeadOutByController(self.enemyAHeadOutController_, arg_104_1 == true)
	self:SetEnemyHeadOutByController(self.enemyBHeadOutController_, arg_104_1 == true)
end

function SummerRaceBattleView:SetEnemyHeadOutByController(arg_105_1, arg_105_2)
	if arg_105_1 == nil then
		return
	end

	arg_105_1:SetSelectedState(arg_105_2 == true and "true" or "false")
end

function SummerRaceBattleView:SetEnemyBVisible(arg_106_1)
	self.enemyStateController_:SetSelectedState(arg_106_1 == true and "true" or "false")
end

function SummerRaceBattleView:SetAllBattleResultBannersVisible(arg_107_1)
	var_0_30(self.winGo_, arg_107_1 == "win", var_0_25.win)
	var_0_30(self.loseGo_, arg_107_1 == "lose", var_0_25.lose)
	var_0_30(self.timeoutWinGo_, arg_107_1 == "timeoutWin", var_0_25.timeoutWin)
	var_0_30(self.timeoutLoseGo_, arg_107_1 == "timeoutLose", var_0_25.timeoutLose)
end

function SummerRaceBattleView:SetTimeoutResultVisible(arg_108_1)
	if arg_108_1 == "win" then
		self:SetAllBattleResultBannersVisible("timeoutWin")

		return
	end

	if arg_108_1 == "lose" then
		self:SetAllBattleResultBannersVisible("timeoutLose")

		return
	end

	self:SetAllBattleResultBannersVisible(nil)
end

function SummerRaceBattleView:SetBattleResultVisible(arg_109_1)
	if arg_109_1 == "win" or arg_109_1 == "lose" then
		self:SetAllBattleResultBannersVisible(arg_109_1)

		return
	end

	self:SetAllBattleResultBannersVisible(nil)
end

function SummerRaceBattleView:Dispose()
	self.windowBarBackHandler_ = nil

	self:StopAllHpDelayTweens()
	self:ResetRoundProgressState()
	self:HideSkillBubble()
	self:StopEnemyIntroBubbleTimer()
	self:StopEnergyCostEffectTimer()
	self:SetTimeoutResultVisible(nil)
	self:DisposeDamageTextPool()

	if self.skillList_ then
		self.skillList_:Dispose()

		self.skillList_ = nil
	end

	SummerRaceBattleView.super.Dispose(self)
end

return SummerRaceBattleView
