local var_0_0 = class("SummerRaceBattleView", ReduxView)
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

	if var_4_0 == nil then
		return nil
	end

	local var_4_1 = tostring(arg_4_1 or "")

	for iter_4_0 = 0, var_4_0.Length - 1 do
		local var_4_2 = var_4_0[iter_4_0]

		if var_4_2 ~= nil and tostring(var_4_2.name or "") == var_4_1 then
			return tonumber(var_4_2.length)
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

function var_0_0.UIName(arg_11_0)
	return "Widget/System/Activity_SummerRace/Activity_SummerRace_BattleUI/Activity_SummerRace_BattleUI"
end

function var_0_0.UIParent(arg_12_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_13_0)
	arg_13_0:BindCfgUI()

	arg_13_0.timerGo_ = arg_13_0.timerText_.transform.parent.gameObject
	arg_13_0.timeAnimator_ = arg_13_0.timerGo_:GetComponent("Animator")

	local var_13_0 = arg_13_0.transform_:Find("panel/middle_adapt")

	arg_13_0.middleAdaptGo_ = var_13_0 and var_13_0.gameObject or nil

	arg_13_0:BindRuntimePanels()

	arg_13_0.skillRuntimeSlots_ = {}
	arg_13_0.skillRuntimeEnergy_ = 0
	arg_13_0.skillSlotCount_ = -1
	arg_13_0.countdownPanelState_ = "none"
	arg_13_0.lastRuntimePhase_ = "None"
	arg_13_0.enemyIntroBubbleShownWave_ = -1
	arg_13_0.enemyOverclockBubbleToken_ = 0
	arg_13_0.lastPlayerEnergy_ = nil
	arg_13_0.energyCostEffectGo_ = arg_13_0:ResolveEnergyCostEffectGo()
	arg_13_0.hpDelayTweens_ = {}
	arg_13_0.hpDelayTweenTargets_ = {}
	arg_13_0.damageTextIdlePool_ = {}
	arg_13_0.damageTextActiveList_ = {}
	arg_13_0.meLabelShownWave_ = nil
	arg_13_0.meLabelPendingWave_ = nil
	arg_13_0.meLabelPendingShow_ = false
	arg_13_0.onClickSkillSlotHandler_ = handler(arg_13_0, arg_13_0.OnClickSkillSlot)

	arg_13_0:HideSkillBubble(true)
	arg_13_0:HideEnemyIntroBubble(true)
	arg_13_0:HideEnergyCostEffect(true)
	arg_13_0:InitDamageTextPool()
	arg_13_0:AddUIListener()
end

function var_0_0.ResolveEnergyCostEffectGo(arg_14_0)
	if arg_14_0.effectGo_ ~= nil then
		return arg_14_0.effectGo_
	end

	if arg_14_0.effetGo_ ~= nil then
		return arg_14_0.effetGo_
	end

	local var_14_0 = arg_14_0.transform_:Find("panel/middle_adapt/Player/energy/effect")

	if var_14_0 ~= nil then
		return var_14_0.gameObject
	end

	local var_14_1 = arg_14_0.transform_:Find("panel/middle_adapt/Player/energy/effet")

	if var_14_1 ~= nil then
		return var_14_1.gameObject
	end

	return var_0_33(arg_14_0.gameObject_, "effect")
end

function var_0_0.BindRuntimePanels(arg_15_0)
	arg_15_0.enemyHeadModeController_ = arg_15_0.rootControllerEx_:GetController("enemyHeadMode")
	arg_15_0.energyMaxController_ = arg_15_0.rootControllerEx_:GetController("energyMax")
	arg_15_0.challengeController_ = arg_15_0.rootControllerEx_:GetController("challenge")
	arg_15_0.timeController_ = arg_15_0.rootControllerEx_:GetController("time")
	arg_15_0.enemyAreaBinding_ = {}

	arg_15_0:BindCfgUI(arg_15_0.enemyAreaGo_, arg_15_0.enemyAreaBinding_)

	arg_15_0.enemyStateController_ = arg_15_0.enemyAreaBinding_.controllerEx_:GetController("default0")
	arg_15_0.enemyALabelGo_ = arg_15_0.enemyAreaBinding_.enemyALabelGo_ or var_0_33(arg_15_0.enemyAreaBinding_.enemyAGo_, "labelA")
	arg_15_0.enemyBLabelGo_ = arg_15_0.enemyAreaBinding_.enemyBLabelGo_ or var_0_33(arg_15_0.enemyAreaBinding_.enemyBGo_, "labelB")
	arg_15_0.head2Go_ = arg_15_0.enemyAreaBinding_.head2Img_.gameObject

	SetActive(arg_15_0.head2Go_, false)

	arg_15_0.enemyAHeadOutController_ = var_0_34(arg_15_0.enemyAreaBinding_.enemyAGo_, "EnemyA")
	arg_15_0.enemyBHeadOutController_ = var_0_34(arg_15_0.enemyAreaBinding_.enemyBGo_, "EnemyB")
	arg_15_0.enemyIntroBubbleGo_ = arg_15_0.enemyAreaBinding_.enemyIntroBubbleGo_
	arg_15_0.enemyIntroBubbleText_ = arg_15_0.enemyAreaBinding_.enemyIntroBubbleText_
	arg_15_0.winGo_ = arg_15_0.winGo_ or var_0_33(arg_15_0.gameObject_, "Win")
	arg_15_0.loseGo_ = arg_15_0.loseGo_ or var_0_33(arg_15_0.gameObject_, "Lose")
	arg_15_0.timeoutWinGo_ = arg_15_0.timeOutWinGo_ or var_0_33(arg_15_0.gameObject_, "TimeOutWin")
	arg_15_0.timeoutLoseGo_ = arg_15_0.timeoutLoseGo_ or arg_15_0.timeOutLoseGo_ or var_0_33(arg_15_0.gameObject_, "TimeOutLose") or var_0_33(arg_15_0.gameObject_, "TimeoutLose")

	arg_15_0:SetAllBattleResultBannersVisible(nil)

	arg_15_0.skillAreaBinding_ = {}

	arg_15_0:BindCfgUI(arg_15_0.skillAreaGo_, arg_15_0.skillAreaBinding_)

	arg_15_0.skillList_ = LuaList.New(handler(arg_15_0, arg_15_0.IndexSkillItem), arg_15_0.skillAreaBinding_.skillUIList_, SummerRaceBattleSkillItemView)

	arg_15_0:BindRoundProgressPanel()
end

function var_0_0.IndexSkillItem(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0.skillRuntimeSlots_[arg_16_1]

	arg_16_2:SetClickHandler(arg_16_0.onClickSkillSlotHandler_)
	arg_16_2:SetData(arg_16_1, var_16_0, arg_16_0.skillRuntimeEnergy_)
end

function var_0_0.BindRoundProgressPanel(arg_17_0)
	if arg_17_0.roundProgressRootGo_ == nil then
		arg_17_0.roundProgressItems_ = {}
		arg_17_0.roundProgressItemPool_ = {}

		return
	end

	arg_17_0.roundProgressItems_ = {}
	arg_17_0.roundProgressItemPool_ = {}
	arg_17_0.roundProgressPointGos_ = {}

	if arg_17_0.roundItemTemplateGo_ ~= nil then
		SetActive(arg_17_0.roundItemTemplateGo_, false)
	end
end

function var_0_0.CreateRoundPoint(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	return {
		go = arg_18_1,
		lightGo = arg_18_2,
		glowGo = arg_18_3
	}
end

function var_0_0.SetRoundPointActive(arg_19_0, arg_19_1, arg_19_2)
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

function var_0_0.BindRoundProgressItem(arg_20_0, arg_20_1)
	local var_20_0 = {}

	arg_20_0:BindCfgUI(arg_20_1, var_20_0)

	return {
		go = arg_20_1,
		slider = var_20_0.slider_,
		point = arg_20_0:CreateRoundPoint(var_20_0.pointGo_, var_20_0.lightGo_, var_20_0.glowGo_)
	}
end

function var_0_0.GetRoundProgressItem(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0.roundProgressItems_[arg_21_1]

	if var_21_0 ~= nil then
		return var_21_0
	end

	if arg_21_0.roundItemTemplateGo_ == nil or arg_21_0.roundProgressRootGo_ == nil then
		return nil
	end

	local var_21_1 = table.remove(arg_21_0.roundProgressItemPool_)

	if var_21_1 == nil then
		var_21_1 = Object.Instantiate(arg_21_0.roundItemTemplateGo_, arg_21_0.roundProgressRootGo_.transform)
	end

	if arg_21_0.roundFirstPointGo_ ~= nil then
		arg_21_0.roundFirstPointGo_.transform:SetSiblingIndex(1)
	end

	var_21_1.transform:SetSiblingIndex(arg_21_1 + 1)

	local var_21_2 = arg_21_0:BindRoundProgressItem(var_21_1)

	arg_21_0.roundProgressItems_[arg_21_1] = var_21_2

	return var_21_2
end

function var_0_0.EnsureRoundProgressItems(arg_22_0, arg_22_1)
	arg_22_0.roundProgressItems_ = arg_22_0.roundProgressItems_ or {}
	arg_22_0.roundProgressItemPool_ = arg_22_0.roundProgressItemPool_ or {}

	for iter_22_0 = 1, arg_22_1 do
		local var_22_0 = arg_22_0:GetRoundProgressItem(iter_22_0)

		if var_22_0 ~= nil then
			SetActive(var_22_0.go, true)
		end
	end

	for iter_22_1 = #arg_22_0.roundProgressItems_, arg_22_1 + 1, -1 do
		local var_22_1 = arg_22_0.roundProgressItems_[iter_22_1]

		arg_22_0.roundProgressItems_[iter_22_1] = nil

		if var_22_1 ~= nil then
			if var_22_1.slider ~= nil then
				var_22_1.slider.value = 0
			end

			arg_22_0:SetRoundPointActive(var_22_1.point, false)
			SetActive(var_22_1.go, false)
			table.insert(arg_22_0.roundProgressItemPool_, var_22_1.go)
		end
	end
end

function var_0_0.ResolveRoundProgressPoint(arg_23_0, arg_23_1)
	if arg_23_0.roundProgressPointGos_ == nil then
		arg_23_0.roundProgressPointGos_ = {}
	end

	if arg_23_0.roundProgressPointGos_[arg_23_1] ~= nil then
		return arg_23_0.roundProgressPointGos_[arg_23_1]
	end

	local var_23_0

	if arg_23_1 == 1 then
		var_23_0 = arg_23_0:CreateRoundPoint(arg_23_0.roundFirstPointGo_, arg_23_0.roundFirstLightGo_, arg_23_0.roundFirstGlowGo_)
	else
		local var_23_1 = arg_23_0.roundProgressItems_ and arg_23_0.roundProgressItems_[arg_23_1 - 1] or nil

		var_23_0 = var_23_1 ~= nil and var_23_1.point or nil
	end

	arg_23_0.roundProgressPointGos_[arg_23_1] = var_23_0

	return var_23_0
end

function var_0_0.SetRoundProgressActivePoint(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = math.max(1, tonumber(arg_24_2) or 1)
	local var_24_1 = math.max(1, math.min(var_24_0, tonumber(arg_24_1) or 1))

	for iter_24_0 = 1, var_24_0 do
		arg_24_0:SetRoundPointActive(arg_24_0:ResolveRoundProgressPoint(iter_24_0), iter_24_0 == var_24_1)
	end
end

function var_0_0.StopRoundProgressTween(arg_25_0)
	if arg_25_0.roundProgressTween_ == nil then
		return
	end

	arg_25_0.roundProgressTween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
	LeanTween.cancel(arg_25_0.roundProgressTween_.id)

	arg_25_0.roundProgressTween_ = nil
	arg_25_0.roundProgressAnimatingToWave_ = nil
end

function var_0_0.ResetRoundProgressState(arg_26_0)
	arg_26_0:StopRoundProgressTween()

	arg_26_0.roundProgressLastWave_ = nil
	arg_26_0.roundProgressLastWaveTotal_ = nil
	arg_26_0.roundProgressAnimatingToWave_ = nil
	arg_26_0.roundProgressPointGos_ = {}

	if arg_26_0.roundProgressItems_ ~= nil then
		for iter_26_0, iter_26_1 in pairs(arg_26_0.roundProgressItems_) do
			if iter_26_1.slider ~= nil then
				iter_26_1.slider.value = 0
			end

			arg_26_0:SetRoundPointActive(iter_26_1.point, false)
			SetActive(iter_26_1.go, false)
			table.insert(arg_26_0.roundProgressItemPool_, iter_26_1.go)
		end
	end

	arg_26_0.roundProgressItems_ = {}

	arg_26_0:SetRoundPointActive(arg_26_0:CreateRoundPoint(arg_26_0.roundFirstPointGo_, arg_26_0.roundFirstLightGo_, arg_26_0.roundFirstGlowGo_), false)
end

function var_0_0.RefreshRoundProgress(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	if arg_27_0.roundProgressRootGo_ == nil then
		return
	end

	if tostring(arg_27_1.mode or "") == SummerRaceConst.MODE.CHALLENGE then
		arg_27_0:ResetRoundProgressState()

		return
	end

	local var_27_0 = math.max(1, tonumber(arg_27_3) or 1)
	local var_27_1 = math.max(1, math.min(var_27_0, tonumber(arg_27_2) or 1))
	local var_27_2 = math.max(0, var_27_0 - 1)
	local var_27_3 = arg_27_0.roundProgressLastWaveTotal_ ~= var_27_0

	arg_27_0:EnsureRoundProgressItems(var_27_2)

	arg_27_0.roundProgressPointGos_ = {}

	if arg_27_0.roundProgressTween_ ~= nil and arg_27_0.roundProgressAnimatingToWave_ == var_27_1 and arg_27_0.roundProgressLastWaveTotal_ == var_27_0 then
		return
	end

	for iter_27_0 = 1, var_27_2 do
		local var_27_4 = arg_27_0.roundProgressItems_[iter_27_0]

		if var_27_4 ~= nil and var_27_4.slider ~= nil then
			if iter_27_0 < var_27_1 then
				var_27_4.slider.value = 1
			else
				var_27_4.slider.value = 0
			end
		end
	end

	local var_27_5 = arg_27_0.roundProgressLastWave_
	local var_27_6 = not var_27_3 and var_27_5 ~= nil and var_27_1 == var_27_5 + 1 and var_27_5 >= 1 and var_27_5 <= var_27_2 and arg_27_1.phase == "Countdown"

	arg_27_0:StopRoundProgressTween()

	if var_27_6 then
		local var_27_7 = arg_27_0.roundProgressItems_[var_27_5]

		if var_27_7 ~= nil and var_27_7.slider ~= nil then
			var_27_7.slider.value = 0

			arg_27_0:SetRoundProgressActivePoint(var_27_5, var_27_0)

			arg_27_0.roundProgressAnimatingToWave_ = var_27_1
			arg_27_0.roundProgressTween_ = LeanTween.value(arg_27_0.gameObject_, 0, 1, var_0_24):setEase(LeanTweenType.easeOutQuad):setOnUpdate(LuaHelper.FloatAction(function(arg_28_0)
				var_27_7.slider.value = arg_28_0
			end)):setOnComplete(System.Action(function()
				var_27_7.slider.value = 1
				arg_27_0.roundProgressTween_ = nil
				arg_27_0.roundProgressAnimatingToWave_ = nil

				arg_27_0:SetRoundProgressActivePoint(var_27_1, var_27_0)
			end))
		else
			arg_27_0:SetRoundProgressActivePoint(var_27_1, var_27_0)
		end
	else
		arg_27_0:SetRoundProgressActivePoint(var_27_1, var_27_0)
	end

	arg_27_0.roundProgressLastWave_ = var_27_1
	arg_27_0.roundProgressLastWaveTotal_ = var_27_0
end

function var_0_0.AddUIListener(arg_30_0)
	return
end

function var_0_0.UpdateBar(arg_31_0)
	arg_31_0.windowBarBackHandler_ = arg_31_0.windowBarBackHandler_ or function()
		arg_31_0:OpenQuitConfirm()
	end

	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	manager.windowBar:RegistBackCallBack(arg_31_0.windowBarBackHandler_)
end

function var_0_0.CleanupWindowBar(arg_33_0)
	if arg_33_0.windowBarBackHandler_ ~= nil and manager.windowBar:GetLastBackFunc() == arg_33_0.windowBarBackHandler_ then
		manager.windowBar:HideBar()
	end
end

function var_0_0.OpenQuitConfirm(arg_34_0)
	if arg_34_0.quitConfirmOpen_ then
		return
	end

	arg_34_0.quitConfirmOpen_ = true

	SummerRaceAction.RequestSetPaused(true)
	JumpTools.OpenPageByJump("summerRacePopView", {
		title = GetTips("PROMPT"),
		content = GetTips("ACTIVITY_TANK_BACK"),
		okCb = function()
			arg_34_0.quitConfirmOpen_ = false

			SummerRaceAction.RequestGiveUpBattle()
		end,
		cancelCb = function()
			arg_34_0.quitConfirmOpen_ = false

			SummerRaceAction.RequestSetPaused(false)
		end,
		closeCb = function()
			arg_34_0.quitConfirmOpen_ = false
		end
	})
end

function var_0_0.OnClickSkillSlot(arg_38_0, arg_38_1)
	local var_38_0 = arg_38_0.skillRuntimeSlots_[arg_38_1]
	local var_38_1 = var_38_0.displayLabel

	if var_38_0.slotType == "weapon" then
		if SummerRaceAction.RequestOverloadWeaponSlot(var_38_0.slotIndex) then
			arg_38_0:ShowEnergyCostEffect()
			arg_38_0:ShowOverloadBubble()
		end

		return
	end

	if var_38_0.canUse and SummerRaceAction.RequestUseEquipSlot(var_38_0.slotIndex) then
		arg_38_0:ShowEnergyCostEffect()
		arg_38_0:ShowEquipBubble()
	end
end

function var_0_0.OnEnter(arg_39_0)
	manager.ui:SetMainCamera("summerRaceBattle")
	arg_39_0:SetSpecialDefeatUiHidden(false)
	arg_39_0:SetTimeoutResultVisible(nil)
	arg_39_0:UpdateBar()
	arg_39_0:ResetRuntimeStateDisplay()

	arg_39_0.runtimeUpdateHandler_ = handler(arg_39_0, arg_39_0.OnRuntimeStateUpdated)

	manager.notify:RegistListener(SummerRaceData.GetEventRuntimeUpdated(), arg_39_0.runtimeUpdateHandler_)

	arg_39_0.playerLabelPoseHandler_ = handler(arg_39_0, arg_39_0.OnPlayerLabelPoseUpdated)

	manager.notify:RegistListener(SummerRaceData.GetEventPlayerLabelPoseUpdated(), arg_39_0.playerLabelPoseHandler_)

	arg_39_0.damageTextHandler_ = handler(arg_39_0, arg_39_0.OnDamageText)

	manager.notify:RegistListener(SummerRaceData.GetEventDamageText(), arg_39_0.damageTextHandler_)
	SummerRaceData:ReplayRuntimeState(arg_39_0.runtimeUpdateHandler_)
end

function var_0_0.OnExit(arg_40_0)
	arg_40_0.quitConfirmOpen_ = false

	arg_40_0:CleanupWindowBar()

	if arg_40_0.runtimeUpdateHandler_ then
		manager.notify:RemoveListener(SummerRaceData.GetEventRuntimeUpdated(), arg_40_0.runtimeUpdateHandler_)

		arg_40_0.runtimeUpdateHandler_ = nil
	end

	if arg_40_0.playerLabelPoseHandler_ then
		manager.notify:RemoveListener(SummerRaceData.GetEventPlayerLabelPoseUpdated(), arg_40_0.playerLabelPoseHandler_)

		arg_40_0.playerLabelPoseHandler_ = nil
	end

	if arg_40_0.damageTextHandler_ then
		manager.notify:RemoveListener(SummerRaceData.GetEventDamageText(), arg_40_0.damageTextHandler_)

		arg_40_0.damageTextHandler_ = nil
	end

	arg_40_0:StopAllHpDelayTweens()
	arg_40_0:ResetRoundProgressState()
	arg_40_0:HideSkillBubble()
	arg_40_0:SetTimeoutResultVisible(nil)
	arg_40_0:RecycleAllDamageTextItems()
	arg_40_0:HideMeLabel()
	manager.ui:ResetMainCamera()
end

function var_0_0.OnRuntimeStateUpdated(arg_41_0, arg_41_1)
	arg_41_0:RefreshByRuntimeState(arg_41_1)
end

function var_0_0.OnPlayerLabelPoseUpdated(arg_42_0, arg_42_1)
	if arg_42_0.meLabelPendingShow_ == true then
		local var_42_0 = arg_42_0.meLabelPendingWave_

		if arg_42_0:ShowMeLabel(arg_42_1) then
			arg_42_0.meLabelPendingShow_ = false

			if var_42_0 ~= nil then
				arg_42_0.meLabelShownWave_ = var_42_0
			end

			arg_42_0.meLabelPendingWave_ = nil
		end

		return
	end

	if arg_42_0.meLabelGo_ ~= nil and arg_42_0.meLabelActive_ == true then
		arg_42_0:UpdateMeLabelPosition(arg_42_1)
	end
end

function var_0_0.OnDamageText(arg_43_0, arg_43_1)
	arg_43_0:ShowDamageText(arg_43_1)
end

function var_0_0.RefreshByRuntimeState(arg_44_0, arg_44_1)
	if arg_44_1 == nil then
		arg_44_0:ResetRuntimeStateDisplay()

		return
	end

	arg_44_0:RefreshRootControllers(arg_44_1)
	arg_44_0:RefreshWave(arg_44_1)
	arg_44_0:RefreshChallengeScore(arg_44_1)
	arg_44_0:RefreshTimer(arg_44_1)
	arg_44_0:RefreshPauseState(arg_44_1)
	arg_44_0:RefreshCountdownPanels(arg_44_1)
	arg_44_0:RefreshEnemyIntroBubble(arg_44_1)
	arg_44_0:RefreshMeLabel(arg_44_1)
	arg_44_0:RefreshEnemyOverclockBubble(arg_44_1)
	arg_44_0:RefreshPlayerHud(arg_44_1)
	arg_44_0:RefreshEnemyHud(arg_44_1)
	arg_44_0:RefreshSkillHud(arg_44_1.skills, arg_44_1.energy)
end

function var_0_0.RefreshEnemyIntroBubble(arg_45_0, arg_45_1)
	local var_45_0 = tostring(arg_45_1.phase or "")
	local var_45_1 = math.max(0, tonumber(arg_45_1.wave) or 0)
	local var_45_2 = arg_45_0.lastRuntimePhase_ == "Countdown" and var_45_0 == "Battle"
	local var_45_3 = arg_45_0.enemyIntroBubbleShownWave_ ~= var_45_1

	if var_45_2 and var_45_3 then
		local var_45_4 = tostring(arg_45_1.enemyIntroText or "")

		if var_45_4 ~= "" then
			arg_45_0.enemyIntroBubbleShownWave_ = var_45_1

			arg_45_0:ShowEnemyIntroBubble(var_45_4)
		end
	end

	arg_45_0.lastRuntimePhase_ = var_45_0
end

function var_0_0.RefreshEnemyOverclockBubble(arg_46_0, arg_46_1)
	local var_46_0 = math.max(0, tonumber(arg_46_1.enemyOverclockBubbleToken) or 0)

	if var_46_0 <= 0 or var_46_0 == arg_46_0.enemyOverclockBubbleToken_ then
		return
	end

	arg_46_0.enemyOverclockBubbleToken_ = var_46_0

	local var_46_1 = tostring(arg_46_1.enemyOverclockBubbleText or "")

	if var_46_1 ~= "" then
		arg_46_0:ShowEnemyIntroBubble(var_46_1)
	end
end

function var_0_0.RefreshRootControllers(arg_47_0, arg_47_1)
	local var_47_0 = math.max(1, math.floor(tonumber(arg_47_1.enemyCount) or 1))
	local var_47_1 = SummerRaceData:GetRuntimeEnemyHudModels(arg_47_1)
	local var_47_2 = tostring(arg_47_1.mode or "")
	local var_47_3 = var_47_2 == SummerRaceConst.MODE.ONE_VS_TWO_PRACTICE
	local var_47_4 = var_47_2 == SummerRaceConst.MODE.SURVIVAL_PRACTICE
	local var_47_5 = var_47_1[2] or {}
	local var_47_6 = var_47_3 and var_47_0 > 1 or var_47_4 and #var_47_1 > 1
	local var_47_7 = var_47_6 and var_47_5.enemyVisible == true

	if var_47_6 then
		arg_47_0.enemyHeadModeController_:SetSelectedState("dual")
	else
		arg_47_0.enemyHeadModeController_:SetSelectedState("single")
	end

	arg_47_0:SetEnemyBVisible(var_47_7)
	SetActive(arg_47_0.enemyALabelGo_, var_47_6)
	SetActive(arg_47_0.enemyBLabelGo_, var_47_7)

	local var_47_8 = arg_47_1.maxEnergy
	local var_47_9 = var_47_8 > 0 and arg_47_1.energy >= var_47_8 - var_0_6

	arg_47_0.energyMaxController_:SetSelectedState(var_47_9 and "max" or "normal")

	if arg_47_0.challengeController_ ~= nil then
		arg_47_0.challengeController_:SetSelectedState(var_47_2 == SummerRaceConst.MODE.CHALLENGE and "show" or "hide")
	end
end

function var_0_0.RefreshWave(arg_48_0, arg_48_1)
	local var_48_0 = math.max(0, tonumber(arg_48_1.wave) or 0)
	local var_48_1 = math.max(1, tonumber(arg_48_1.waveTotal) or 1)

	arg_48_0.waveText_.text = string.format(GetTips("ACTIVITY_TANK_WAVE_PROGRESS"), var_48_0, var_48_1)

	local var_48_2 = math.max(0, var_48_0 - 1)
	local var_48_3 = 0
	local var_48_4 = math.max(0, tonumber(arg_48_1.enemyMaxHp) or 0)
	local var_48_5 = math.max(0, tonumber(arg_48_1.enemyHp) or 0)

	if arg_48_1.phase ~= "Countdown" then
		if arg_48_1.enemyAlive == true and var_48_4 > 0 then
			var_48_3 = 1 - var_0_27(var_48_5 / var_48_4)
		elseif var_48_0 > 0 then
			var_48_3 = 1
		end
	end

	local var_48_6 = var_0_27((var_48_2 + var_48_3) / var_48_1)

	if arg_48_0.waveProgressSlider_ then
		arg_48_0.waveProgressSlider_.value = var_48_6
	end

	arg_48_0:RefreshRoundProgress(arg_48_1, var_48_0, var_48_1)
end

function var_0_0.RefreshChallengeScore(arg_49_0, arg_49_1)
	if arg_49_0.scoreNumText_ == nil then
		return
	end

	if tostring(arg_49_1.mode or "") ~= SummerRaceConst.MODE.CHALLENGE then
		arg_49_0.scoreNumText_.text = ""

		return
	end

	local var_49_0 = math.max(0, math.floor(tonumber(arg_49_1.score) or 0))

	arg_49_0.scoreNumText_.text = tostring(var_49_0)
end

function var_0_0.RefreshPauseState(arg_50_0, arg_50_1)
	if arg_50_0.pausePanelGo_ then
		SetActive(arg_50_0.pausePanelGo_, false)
	end

	if arg_50_0.pauseBtn_ then
		arg_50_0.pauseBtn_.interactable = arg_50_1.phase ~= "Result"
	end
end

function var_0_0.SetCountdownPanelState(arg_51_0, arg_51_1)
	if arg_51_0.countdownPanelState_ == arg_51_1 then
		return
	end

	arg_51_0.countdownPanelState_ = arg_51_1

	SetActive(arg_51_0.startPanelGo_, arg_51_1 == "start")
	SetActive(arg_51_0.readyPanelGo_, arg_51_1 == "ready")
end

function var_0_0.RefreshCountdownPanels(arg_52_0, arg_52_1)
	if arg_52_1.phase ~= "Countdown" then
		arg_52_0:SetCountdownPanelState("none")

		return
	end

	local var_52_0 = math.max(1, tonumber(arg_52_1.wave) or 1)
	local var_52_1 = string.format(GetTips("ACTIVITY_TANK_WAVE"), var_52_0)

	arg_52_0.readyRoundTextLineText_.text = var_52_1
	arg_52_0.readyRoundTextText_.text = var_52_1

	if arg_52_1.countdownRemaining > var_0_11 then
		arg_52_0:SetCountdownPanelState("ready")
	else
		arg_52_0:SetCountdownPanelState("start")
	end
end

function var_0_0.SetTimerVisible(arg_53_0, arg_53_1)
	SetActive(arg_53_0.timerGo_, arg_53_1 == true)
end

function var_0_0.SetTimeControllerState(arg_54_0, arg_54_1)
	if arg_54_0.lastTimeState_ == arg_54_1 then
		return
	end

	arg_54_0.lastTimeState_ = arg_54_1

	if arg_54_0.timeController_ ~= nil then
		arg_54_0.timeController_:SetSelectedState(arg_54_1)
	end

	arg_54_0:PlayTimeAnimatorState(arg_54_1)
end

function var_0_0.PlayTimeAnimatorState(arg_55_0, arg_55_1)
	if arg_55_0.timeAnimator_ == nil then
		return
	end

	local var_55_0 = arg_55_1 == "red" and var_0_14 or var_0_13

	arg_55_0.timeAnimator_:Play(var_55_0, -1, 0)
end

local function var_0_36(arg_56_0)
	if tostring(arg_56_0.mode or "") == SummerRaceConst.MODE.SURVIVAL_PRACTICE then
		return true
	end

	local var_56_0 = SummerRaceData:FindRuntimeStageInfoById(arg_56_0.stageId)

	return (tonumber(var_56_0 and var_56_0.timeLimitSeconds) or 0) > 0
end

function var_0_0.RefreshTimer(arg_57_0, arg_57_1)
	if arg_57_1.phase == "Countdown" then
		arg_57_0:SetTimerVisible(false)

		arg_57_0.timerText_.text = ""

		arg_57_0:SetTimeControllerState("normal")

		return
	end

	arg_57_0:SetTimerVisible(true)

	local var_57_0 = math.floor((tonumber(arg_57_1.timer) or 0) + 0.5)
	local var_57_1 = math.floor(var_57_0 / 60)
	local var_57_2 = var_57_0 % 60

	arg_57_0.timerText_.text = string.format("%02d:%02d", var_57_1, var_57_2)

	local var_57_3 = var_0_36(arg_57_1) and var_57_0 <= var_0_12 and "red" or "normal"

	arg_57_0:SetTimeControllerState(var_57_3)
end

function var_0_0.RefreshPlayerHud(arg_58_0, arg_58_1)
	local var_58_0 = arg_58_1.hp
	local var_58_1 = math.max(1, arg_58_1.maxHp)
	local var_58_2 = arg_58_1.energy
	local var_58_3 = arg_58_1.maxEnergy
	local var_58_4 = var_0_27(var_58_0 / var_58_1)

	arg_58_0.playerHpSlider_.value = var_58_4

	arg_58_0:RefreshDelaySlider("playerHp", arg_58_0.playerHpDelaySlider_, var_58_4)

	arg_58_0.playerEnergySlider_.value = var_0_31(var_58_2, var_58_3)
	arg_58_0.playerHpText_.text = string.format("%d/%d", var_0_28(var_58_0), var_0_28(var_58_1))
	arg_58_0.playerEnergyText_.text = string.format("%d", var_0_32(var_58_2, var_58_3))
	arg_58_0.playerNameText_.text = var_0_35()

	arg_58_0:RefreshEnergyCostEffect(var_58_2)
end

function var_0_0.RefreshEnergyCostEffect(arg_59_0, arg_59_1)
	local var_59_0 = math.max(0, tonumber(arg_59_1) or 0)
	local var_59_1 = arg_59_0.lastPlayerEnergy_

	arg_59_0.lastPlayerEnergy_ = var_59_0

	if var_59_1 == nil then
		return
	end

	if var_59_0 < var_59_1 - var_0_7 then
		arg_59_0:ShowEnergyCostEffect()
	end
end

function var_0_0.RefreshDelaySlider(arg_60_0, arg_60_1, arg_60_2, arg_60_3)
	if arg_60_2 == nil then
		return
	end

	local var_60_0 = arg_60_2.value

	if var_60_0 <= arg_60_3 then
		arg_60_0:StopHpDelayTween(arg_60_1)

		arg_60_2.value = arg_60_3
		arg_60_0.hpDelayTweenTargets_[arg_60_1] = nil

		return
	end

	local var_60_1 = arg_60_0.hpDelayTweens_[arg_60_1]
	local var_60_2 = arg_60_0.hpDelayTweenTargets_[arg_60_1]

	if var_60_1 ~= nil and var_60_2 ~= nil and math.abs(var_60_2 - arg_60_3) <= var_0_5 then
		return
	end

	arg_60_0:StopHpDelayTween(arg_60_1)

	local var_60_3 = var_0_2 + (var_60_0 - arg_60_3) * var_0_3

	if var_60_3 > var_0_4 then
		var_60_3 = var_0_4
	end

	arg_60_0.hpDelayTweenTargets_[arg_60_1] = arg_60_3
	arg_60_0.hpDelayTweens_[arg_60_1] = LeanTween.value(arg_60_0.gameObject_, var_60_0, arg_60_3, var_60_3):setDelay(var_0_1):setEase(LeanTweenType.easeOutQuad):setOnUpdate(LuaHelper.FloatAction(function(arg_61_0)
		arg_60_2.value = arg_61_0
	end)):setOnComplete(System.Action(function()
		arg_60_0.hpDelayTweens_[arg_60_1] = nil
		arg_60_0.hpDelayTweenTargets_[arg_60_1] = nil
	end))
end

function var_0_0.StopHpDelayTween(arg_63_0, arg_63_1)
	local var_63_0 = arg_63_0.hpDelayTweens_[arg_63_1]

	if var_63_0 == nil then
		return
	end

	var_63_0:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
	LeanTween.cancel(var_63_0.id)

	arg_63_0.hpDelayTweens_[arg_63_1] = nil
	arg_63_0.hpDelayTweenTargets_[arg_63_1] = nil
end

function var_0_0.StopAllHpDelayTweens(arg_64_0)
	for iter_64_0, iter_64_1 in pairs(arg_64_0.hpDelayTweens_) do
		arg_64_0:StopHpDelayTween(iter_64_0)
	end
end

function var_0_0.InitDamageTextPool(arg_65_0)
	arg_65_0.damageTextPrefab_ = Asset.Load(var_0_15)

	if arg_65_0.damageTextPrefab_ == nil then
		error("[SummerRaceBattleView] missing damage text prefab: " .. var_0_15)
	end

	arg_65_0:EnsureDamageTextLayer()

	for iter_65_0 = 1, var_0_20 do
		local var_65_0 = arg_65_0:CreateDamageTextItem()

		arg_65_0:RecycleDamageTextItem(var_65_0, true)
	end
end

function var_0_0.EnsureDamageTextLayer(arg_66_0)
	if arg_66_0.damageTextLayerGo_ ~= nil then
		SetActive(arg_66_0.damageTextLayerGo_, true)
		var_0_26("EnsureLayer reuse activeInHierarchy=" .. tostring(arg_66_0.damageTextLayerGo_.activeInHierarchy))

		return
	end

	arg_66_0.damageTextLayerGo_ = GameObject("DamageTextLayer")

	local var_66_0 = arg_66_0.damageTextLayerGo_:AddComponent(typeof(RectTransform))

	arg_66_0.damageTextLayerRect_ = var_66_0

	local var_66_1 = arg_66_0.panelGo_ and arg_66_0.panelGo_.transform or arg_66_0.transform_

	var_66_0:SetParent(var_66_1, false)

	var_66_0.anchorMin = Vector2.New(0, 0)
	var_66_0.anchorMax = Vector2.New(1, 1)
	var_66_0.pivot = Vector2.New(0.5, 0.5)
	var_66_0.offsetMin = Vector2.New(0, 0)
	var_66_0.offsetMax = Vector2.New(0, 0)
	var_66_0.localScale = Vector3.one
	var_66_0.localEulerAngles = Vector3.zero

	arg_66_0.damageTextLayerGo_.transform:SetAsLastSibling()
	SetActive(arg_66_0.damageTextLayerGo_, true)

	local var_66_2 = var_66_1 and var_66_1.name or "<nil>"

	var_0_26("EnsureLayer create parent=" .. tostring(var_66_2) .. " sibling=" .. tostring(arg_66_0.damageTextLayerGo_.transform:GetSiblingIndex()) .. " activeInHierarchy=" .. tostring(arg_66_0.damageTextLayerGo_.activeInHierarchy))
end

function var_0_0.CreateDamageTextItem(arg_67_0)
	local var_67_0 = Object.Instantiate(arg_67_0.damageTextPrefab_, arg_67_0.damageTextLayerRect_)
	local var_67_1 = var_67_0.transform
	local var_67_2 = var_67_1:GetComponent(typeof(RectTransform))
	local var_67_3 = var_67_1:GetComponent("ControllerExCollection"):GetController("type")
	local var_67_4 = {
		go = var_67_0,
		transform = var_67_1,
		rect = var_67_2,
		controller = var_67_3
	}

	SetActive(var_67_0, false)

	return var_67_4
end

function var_0_0.AcquireDamageTextItem(arg_68_0)
	arg_68_0:EnsureDamageTextLayer()

	local var_68_0 = table.remove(arg_68_0.damageTextIdlePool_)

	if var_68_0 ~= nil then
		return var_68_0
	end

	if #arg_68_0.damageTextActiveList_ >= var_0_21 then
		local var_68_1 = table.remove(arg_68_0.damageTextActiveList_, 1)

		if var_68_1 ~= nil then
			arg_68_0:StopDamageTextTimer(var_68_1)

			return var_68_1
		end
	end

	return arg_68_0:CreateDamageTextItem()
end

function var_0_0.ShowDamageText(arg_69_0, arg_69_1)
	if type(arg_69_1) ~= "table" then
		var_0_26("ShowDamageText ignored invalid payload type=" .. tostring(type(arg_69_1)))

		return
	end

	local var_69_0 = math.max(0, math.floor((tonumber(arg_69_1.amount) or 0) + 0.5))

	if var_69_0 <= 0 then
		var_0_26("ShowDamageText ignored amount<=0 raw=" .. tostring(arg_69_1.amount))

		return
	end

	local var_69_1 = arg_69_0:WorldToDamageTextLocalPosition(tonumber(arg_69_1.worldX), tonumber(arg_69_1.worldY), tonumber(arg_69_1.worldZ))

	if var_69_1 == nil then
		var_0_26("ShowDamageText localPos=nil world=(" .. tostring(arg_69_1.worldX) .. "," .. tostring(arg_69_1.worldY) .. ")")

		return
	end

	local var_69_2 = arg_69_0:AcquireDamageTextItem()

	table.insert(arg_69_0.damageTextActiveList_, var_69_2)

	local var_69_3 = tostring(arg_69_1.state or "")

	if var_69_3 ~= "me" and var_69_3 ~= "enemy" and var_69_3 ~= "overclock" then
		var_69_3 = "me"
	end

	local var_69_4 = "-" .. tostring(var_69_0)

	var_69_2.controller:SetSelectedState(var_69_3)
	SummerRaceLuaBridge.RequestSetDamageText(var_69_2.go, var_69_4)
	var_69_2.transform:SetParent(arg_69_0.damageTextLayerRect_, false)
	var_69_2.transform:SetAsLastSibling()

	var_69_2.rect.anchoredPosition = var_69_1
	var_69_2.rect.localScale = Vector3.one
	var_69_2.rect.localEulerAngles = Vector3.zero

	SetActive(var_69_2.go, false)
	SetActive(var_69_2.go, true)

	local var_69_5 = var_69_2.transform.parent and var_69_2.transform.parent.name or "<nil>"
	local var_69_6 = var_69_2.transform:Find("TextMe")
	local var_69_7 = var_69_2.transform:Find("TextEnemy")
	local var_69_8 = var_69_6 and var_69_6.gameObject.activeSelf or false
	local var_69_9 = var_69_7 and var_69_7.gameObject.activeSelf or false

	var_0_26("ShowDamageText spawn amount=" .. tostring(var_69_0) .. " state=" .. tostring(var_69_3) .. " world=(" .. tostring(arg_69_1.worldX) .. "," .. tostring(arg_69_1.worldY) .. ")" .. " local=(" .. tostring(var_69_1.x) .. "," .. tostring(var_69_1.y) .. ")" .. " itemActiveInHierarchy=" .. tostring(var_69_2.go.activeInHierarchy) .. " itemLayer=" .. tostring(var_69_2.go.layer) .. " parent=" .. tostring(var_69_5) .. " textMeActive=" .. tostring(var_69_8) .. " textEnemyActive=" .. tostring(var_69_9) .. " activeCount=" .. tostring(#arg_69_0.damageTextActiveList_) .. " idleCount=" .. tostring(#arg_69_0.damageTextIdlePool_))

	var_69_2.timer = Timer.New(function()
		arg_69_0:RecycleDamageTextItem(var_69_2)
	end, var_0_22, 1)

	var_69_2.timer:Start()
end

function var_0_0.WorldToDamageTextLocalPosition(arg_71_0, arg_71_1, arg_71_2, arg_71_3)
	if arg_71_1 == nil or arg_71_2 == nil or arg_71_0.damageTextLayerRect_ == nil then
		var_0_26("WorldToLocal early return worldX=" .. tostring(arg_71_1) .. " worldY=" .. tostring(arg_71_2) .. " layerRectNil=" .. tostring(arg_71_0.damageTextLayerRect_ == nil))

		return nil
	end

	local var_71_0 = UnityEngine.Camera.main
	local var_71_1 = manager and manager.ui and manager.ui.canvas or nil

	if var_71_0 == nil or var_71_1 == nil then
		var_0_26("WorldToLocal camera/canvas missing mainCameraNil=" .. tostring(var_71_0 == nil) .. " canvasNil=" .. tostring(var_71_1 == nil))

		return nil
	end

	local var_71_2 = var_71_1:GetComponent(typeof(Canvas))

	if var_71_2 == nil then
		var_0_26("WorldToLocal canvasComponent missing")

		return nil
	end

	local var_71_3 = var_71_2.worldCamera
	local var_71_4 = Vector3.New(arg_71_1, arg_71_2, arg_71_3 or 0)
	local var_71_5 = UnityEngine.RectTransformUtility.WorldToScreenPoint(var_71_0, var_71_4)
	local var_71_6, var_71_7 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(arg_71_0.damageTextLayerRect_, var_71_5, var_71_3, nil)

	var_0_26("WorldToLocal camera=" .. tostring(var_71_0.name) .. " uiCamera=" .. tostring(var_71_3 and var_71_3.name or "nil") .. "WorldToLocal world=(" .. tostring(arg_71_1) .. "," .. tostring(arg_71_2) .. "," .. tostring(arg_71_3) .. ")" .. " screen=(" .. tostring(var_71_5.x) .. "," .. tostring(var_71_5.y) .. ")" .. " local=(" .. tostring(var_71_7.x) .. "," .. tostring(var_71_7.y) .. ")" .. " uiCameraNil=" .. tostring(var_71_3 == nil))

	return var_71_7
end

function var_0_0.RefreshMeLabel(arg_72_0, arg_72_1)
	local var_72_0 = tostring(arg_72_1.phase or "")
	local var_72_1 = math.max(1, math.floor(tonumber(arg_72_1.wave) or 1))

	if arg_72_0.meLabelLastRuntimePhase_ == "Countdown" and var_72_0 == "Battle" and arg_72_0.meLabelShownWave_ ~= var_72_1 then
		arg_72_0.meLabelPendingShow_ = true
		arg_72_0.meLabelPendingWave_ = var_72_1
	end

	if arg_72_0.meLabelPendingShow_ == true and arg_72_0:ShowMeLabel(arg_72_1) then
		arg_72_0.meLabelPendingShow_ = false
		arg_72_0.meLabelShownWave_ = arg_72_0.meLabelPendingWave_ or var_72_1
		arg_72_0.meLabelPendingWave_ = nil
	end

	if arg_72_0.meLabelGo_ ~= nil and arg_72_0.meLabelActive_ == true then
		arg_72_0:UpdateMeLabelPosition(arg_72_1)
	end

	arg_72_0.meLabelLastRuntimePhase_ = var_72_0
end

function var_0_0.ShowMeLabel(arg_73_0, arg_73_1)
	if arg_73_0.meLabelGo_ == nil then
		local var_73_0 = Asset.Load(var_0_16)

		if var_73_0 == nil then
			return false
		end

		arg_73_0:EnsureDamageTextLayer()

		arg_73_0.meLabelGo_ = Object.Instantiate(var_73_0, arg_73_0.damageTextLayerRect_)
		arg_73_0.meLabelRect_ = arg_73_0.meLabelGo_.transform:GetComponent(typeof(RectTransform))
		arg_73_0.meLabelAnimator_ = arg_73_0.meLabelGo_.transform:GetComponent("Animator")
		arg_73_0.meLabelShowAnimDuration_ = var_0_29(arg_73_0.meLabelAnimator_, var_0_17)
		arg_73_0.meLabelHideAnimDuration_ = var_0_29(arg_73_0.meLabelAnimator_, var_0_18)

		SetActive(arg_73_0.meLabelGo_, false)
	else
		arg_73_0.meLabelGo_.transform:SetParent(arg_73_0.damageTextLayerRect_, false)
	end

	local var_73_1 = arg_73_0:ResolveMeLabelLocalPosition(arg_73_1)

	if var_73_1 == nil then
		return false
	end

	arg_73_0.meLabelGo_.transform:SetAsLastSibling()

	arg_73_0.meLabelRect_.localScale = Vector3.one
	arg_73_0.meLabelRect_.localEulerAngles = Vector3.zero
	arg_73_0.meLabelRect_.anchoredPosition = var_73_1

	SetActive(arg_73_0.meLabelGo_, true)

	arg_73_0.meLabelActive_ = true

	arg_73_0:PlayMeLabelAnimator(var_0_17)
	arg_73_0:StopMeLabelTimer()

	arg_73_0.meLabelTimer_ = Timer.New(function()
		arg_73_0:HideMeLabel()
	end, math.max(var_0_19, tonumber(arg_73_0.meLabelShowAnimDuration_) or 0), 1)

	arg_73_0.meLabelTimer_:Start()

	return true
end

function var_0_0.PlayMeLabelAnimator(arg_75_0, arg_75_1)
	if arg_75_0.meLabelAnimator_ == nil or arg_75_1 == nil then
		return
	end

	arg_75_0.meLabelAnimator_.enabled = true

	arg_75_0.meLabelAnimator_:Play(arg_75_1, -1, 0)
	arg_75_0.meLabelAnimator_:Update(0)
end

function var_0_0.ResolveMeLabelLocalPosition(arg_76_0, arg_76_1)
	if arg_76_1 == nil or arg_76_1.playerLabelWorldX == nil or arg_76_1.playerLabelWorldY == nil then
		return nil
	end

	local var_76_0 = arg_76_0:WorldToDamageTextLocalPosition(tonumber(arg_76_1.playerLabelWorldX), tonumber(arg_76_1.playerLabelWorldY), tonumber(arg_76_1.playerLabelWorldZ))

	if var_76_0 == nil then
		return nil
	end

	local var_76_1 = tonumber(arg_76_1.playerLabelScreenOffsetY) or 150

	return Vector2.New(var_76_0.x, var_76_0.y + var_76_1)
end

function var_0_0.UpdateMeLabelPosition(arg_77_0, arg_77_1)
	if arg_77_0.meLabelRect_ == nil then
		return false
	end

	local var_77_0 = arg_77_0:ResolveMeLabelLocalPosition(arg_77_1)

	if var_77_0 == nil then
		return false
	end

	arg_77_0.meLabelRect_.anchoredPosition = var_77_0

	return true
end

function var_0_0.HideMeLabel(arg_78_0)
	arg_78_0:StopMeLabelTimer()

	if arg_78_0.meLabelGo_ == nil then
		arg_78_0.meLabelActive_ = false

		return
	end

	arg_78_0:PlayMeLabelAnimator(var_0_18)

	local var_78_0 = tonumber(arg_78_0.meLabelHideAnimDuration_) or 0

	if var_78_0 <= 0 then
		arg_78_0:CompleteMeLabelHide()

		return
	end

	arg_78_0.meLabelTimer_ = Timer.New(function()
		arg_78_0:CompleteMeLabelHide()
	end, var_78_0, 1)

	arg_78_0.meLabelTimer_:Start()
end

function var_0_0.CompleteMeLabelHide(arg_80_0)
	arg_80_0:StopMeLabelTimer()

	arg_80_0.meLabelActive_ = false

	if arg_80_0.meLabelGo_ ~= nil then
		SetActive(arg_80_0.meLabelGo_, false)
	end
end

function var_0_0.StopMeLabelTimer(arg_81_0)
	if arg_81_0.meLabelTimer_ ~= nil then
		arg_81_0.meLabelTimer_:Stop()

		arg_81_0.meLabelTimer_ = nil
	end
end

function var_0_0.StopDamageTextTimer(arg_82_0, arg_82_1)
	if arg_82_1 ~= nil and arg_82_1.timer ~= nil then
		arg_82_1.timer:Stop()

		arg_82_1.timer = nil
	end
end

function var_0_0.RecycleDamageTextItem(arg_83_0, arg_83_1, arg_83_2)
	if arg_83_1 == nil then
		return
	end

	arg_83_0:StopDamageTextTimer(arg_83_1)

	if arg_83_2 ~= true then
		for iter_83_0 = #arg_83_0.damageTextActiveList_, 1, -1 do
			if arg_83_0.damageTextActiveList_[iter_83_0] == arg_83_1 then
				table.remove(arg_83_0.damageTextActiveList_, iter_83_0)

				break
			end
		end
	end

	SetActive(arg_83_1.go, false)
	table.insert(arg_83_0.damageTextIdlePool_, arg_83_1)
end

function var_0_0.RecycleAllDamageTextItems(arg_84_0)
	for iter_84_0 = #arg_84_0.damageTextActiveList_, 1, -1 do
		arg_84_0:RecycleDamageTextItem(arg_84_0.damageTextActiveList_[iter_84_0], true)
		table.remove(arg_84_0.damageTextActiveList_, iter_84_0)
	end
end

function var_0_0.DisposeDamageTextPool(arg_85_0)
	arg_85_0:RecycleAllDamageTextItems()
	arg_85_0:StopMeLabelTimer()

	if arg_85_0.meLabelGo_ ~= nil then
		Object.Destroy(arg_85_0.meLabelGo_)

		arg_85_0.meLabelGo_ = nil
		arg_85_0.meLabelRect_ = nil
		arg_85_0.meLabelAnimator_ = nil
		arg_85_0.meLabelShowAnimDuration_ = nil
		arg_85_0.meLabelHideAnimDuration_ = nil
		arg_85_0.meLabelActive_ = false
	end

	for iter_85_0 = #arg_85_0.damageTextIdlePool_, 1, -1 do
		local var_85_0 = arg_85_0.damageTextIdlePool_[iter_85_0]

		arg_85_0:StopDamageTextTimer(var_85_0)

		if var_85_0.go ~= nil then
			Object.Destroy(var_85_0.go)
		end

		arg_85_0.damageTextIdlePool_[iter_85_0] = nil
	end

	if arg_85_0.damageTextLayerGo_ ~= nil then
		Object.Destroy(arg_85_0.damageTextLayerGo_)

		arg_85_0.damageTextLayerGo_ = nil
		arg_85_0.damageTextLayerRect_ = nil
	end
end

function var_0_0.RefreshEnemyHud(arg_86_0, arg_86_1)
	local var_86_0 = arg_86_1.enemyHp
	local var_86_1 = math.max(1, arg_86_1.enemyMaxHp)
	local var_86_2 = arg_86_1.enemyName
	local var_86_3 = SummerRaceData:GetRuntimeEnemyAvatarPath(arg_86_1)
	local var_86_4 = SummerRaceData:GetRuntimeEnemyHudModels(arg_86_1)
	local var_86_5 = var_86_4[1] or {}
	local var_86_6 = var_86_4[2] or {}
	local var_86_7 = tostring(arg_86_1.mode or "")
	local var_86_8 = var_86_7 == SummerRaceConst.MODE.ONE_VS_TWO_PRACTICE or var_86_7 == SummerRaceConst.MODE.SURVIVAL_PRACTICE
	local var_86_9 = tostring(var_86_5.enemyName or var_86_2)
	local var_86_10 = tostring(var_86_6.enemyName or "")
	local var_86_11 = tostring(var_86_5.enemyAvatarPath or var_86_3)
	local var_86_12 = tostring(var_86_6.enemyAvatarPath or "")
	local var_86_13 = math.max(0, tonumber(var_86_5.enemyHp) or var_86_0)
	local var_86_14 = math.max(1, tonumber(var_86_5.enemyMaxHp) or var_86_1)
	local var_86_15 = math.max(0, tonumber(var_86_6.enemyHp) or 0)
	local var_86_16 = math.max(1, tonumber(var_86_6.enemyMaxHp) or var_86_1)
	local var_86_17 = var_0_27(var_86_13 / var_86_14)
	local var_86_18 = var_0_27(var_86_15 / var_86_16)
	local var_86_19 = string.format("%d/%d", var_0_28(var_86_13), var_0_28(var_86_14))
	local var_86_20 = string.format("%d/%d", var_0_28(var_86_15), var_0_28(var_86_16))
	local var_86_21 = SummerRaceData:GetRuntimeTeammateAvatarPath(arg_86_1)

	arg_86_0.enemyAreaBinding_.enemyANameText_.text = var_86_9
	arg_86_0.enemyAreaBinding_.enemyBNameText_.text = var_86_10
	arg_86_0.enemyAreaBinding_.enemyAHeadImg_.spriteSync = var_86_11 ~= "" and var_86_11 or nil
	arg_86_0.enemyAreaBinding_.enemyBHeadImg_.spriteSync = var_86_12 ~= "" and var_86_12 or nil
	arg_86_0.enemyAreaBinding_.head2Img_.spriteSync = var_86_21 ~= "" and var_86_21 or nil

	SetActive(arg_86_0.head2Go_, var_86_21 ~= "")

	if var_86_8 then
		arg_86_0:SetEnemyHeadOutByController(arg_86_0.enemyAHeadOutController_, var_86_5.enemyHeadOut == true)
		arg_86_0:SetEnemyHeadOutByController(arg_86_0.enemyBHeadOutController_, var_86_6.enemyHeadOut == true)
	else
		arg_86_0:SetEnemyHeadOut(arg_86_1.enemyHeadOut == true)
	end

	arg_86_0.enemyAreaBinding_.enemyAHpText_.text = var_86_19
	arg_86_0.enemyAreaBinding_.enemyBHpText_.text = var_86_20
	arg_86_0.enemyAreaBinding_.enemyAHpSlider_.value = var_86_17
	arg_86_0.enemyAreaBinding_.enemyBHpSlider_.value = var_86_18

	arg_86_0:RefreshDelaySlider("enemyAHp", arg_86_0.enemyAreaBinding_.enemyAHpDelaySlider_, var_86_17)
	arg_86_0:RefreshDelaySlider("enemyBHp", arg_86_0.enemyAreaBinding_.enemyBHpDelaySlider_, var_86_18)
end

function var_0_0.RefreshSkillHud(arg_87_0, arg_87_1, arg_87_2)
	arg_87_0.skillRuntimeSlots_ = arg_87_1
	arg_87_0.skillRuntimeEnergy_ = arg_87_2

	local var_87_0 = #arg_87_0.skillRuntimeSlots_

	if arg_87_0.skillSlotCount_ ~= var_87_0 then
		arg_87_0.skillSlotCount_ = var_87_0

		arg_87_0.skillList_:StartScroll(var_87_0)
	else
		arg_87_0.skillList_:Refresh()
	end
end

function var_0_0.ShowOverloadBubble(arg_88_0)
	local var_88_0 = SummerRaceConst.BATTLE and SummerRaceConst.BATTLE.OVERLOAD_BUBBLE_TIPS or nil
	local var_88_1 = var_88_0 and #var_88_0 or 0

	if var_88_1 <= 0 then
		return
	end

	local var_88_2 = math.random(1, var_88_1)
	local var_88_3 = GetTips(var_88_0[var_88_2])

	arg_88_0:ShowSkillBubble(var_88_3)
end

function var_0_0.ShowEquipBubble(arg_89_0)
	local var_89_0 = SummerRaceConst.BATTLE and SummerRaceConst.BATTLE.EQUIP_BUBBLE_TIPS or nil
	local var_89_1 = var_89_0 and #var_89_0 or 0

	if var_89_1 <= 0 then
		return
	end

	local var_89_2 = math.random(1, var_89_1)
	local var_89_3 = GetTips(var_89_0[var_89_2])

	arg_89_0:ShowSkillBubble(var_89_3)
end

function var_0_0.ShowSkillBubble(arg_90_0, arg_90_1, arg_90_2)
	if arg_90_0.skillBubbleGo_ == nil or arg_90_0.skillBubbleText_ == nil then
		return
	end

	arg_90_0:StopSkillBubbleTimer()
	SetActive(arg_90_0.skillBubbleGo_, false)

	arg_90_0.skillBubbleText_.text = tostring(arg_90_1 or "")

	if arg_90_0.skillBubbleText_.text == "" then
		return
	end

	SetActive(arg_90_0.skillBubbleGo_, true)

	local var_90_0 = tonumber(arg_90_2) or var_0_9

	if var_90_0 <= 0 then
		var_90_0 = var_0_9
	end

	arg_90_0.skillBubbleTimer_ = Timer.New(function()
		arg_90_0:HideSkillBubble()
	end, var_90_0, 1)

	arg_90_0.skillBubbleTimer_:Start()
end

function var_0_0.ShowEnemyIntroBubble(arg_92_0, arg_92_1)
	if arg_92_0.enemyIntroBubbleGo_ == nil or arg_92_0.enemyIntroBubbleText_ == nil then
		return
	end

	arg_92_0:StopEnemyIntroBubbleTimer()

	arg_92_0.enemyIntroBubbleText_.text = tostring(arg_92_1 or "")

	SetActive(arg_92_0.enemyIntroBubbleGo_, arg_92_0.enemyIntroBubbleText_.text ~= "")

	if arg_92_0.enemyIntroBubbleText_.text == "" then
		return
	end

	arg_92_0.enemyIntroBubbleTimer_ = Timer.New(function()
		arg_92_0:HideEnemyIntroBubble()
	end, var_0_10, 1)

	arg_92_0.enemyIntroBubbleTimer_:Start()
end

function var_0_0.HideSkillBubble(arg_94_0, arg_94_1)
	if not arg_94_1 then
		arg_94_0:StopSkillBubbleTimer()
	end

	if arg_94_0.skillBubbleText_ then
		arg_94_0.skillBubbleText_.text = ""
	end

	if arg_94_0.skillBubbleGo_ then
		SetActive(arg_94_0.skillBubbleGo_, false)
	end
end

function var_0_0.HideEnemyIntroBubble(arg_95_0, arg_95_1)
	if not arg_95_1 then
		arg_95_0:StopEnemyIntroBubbleTimer()
	end

	if arg_95_0.enemyIntroBubbleText_ then
		arg_95_0.enemyIntroBubbleText_.text = ""
	end

	if arg_95_0.enemyIntroBubbleGo_ then
		SetActive(arg_95_0.enemyIntroBubbleGo_, false)
	end
end

function var_0_0.StopSkillBubbleTimer(arg_96_0)
	if arg_96_0.skillBubbleTimer_ ~= nil then
		arg_96_0.skillBubbleTimer_:Stop()

		arg_96_0.skillBubbleTimer_ = nil
	end
end

function var_0_0.StopEnemyIntroBubbleTimer(arg_97_0)
	if arg_97_0.enemyIntroBubbleTimer_ ~= nil then
		arg_97_0.enemyIntroBubbleTimer_:Stop()

		arg_97_0.enemyIntroBubbleTimer_ = nil
	end
end

function var_0_0.ShowEnergyCostEffect(arg_98_0)
	if arg_98_0.energyCostEffectGo_ == nil then
		return
	end

	arg_98_0:StopEnergyCostEffectTimer()
	SetActive(arg_98_0.energyCostEffectGo_, false)
	SetActive(arg_98_0.energyCostEffectGo_, true)

	arg_98_0.energyCostEffectTimer_ = Timer.New(function()
		arg_98_0:HideEnergyCostEffect()
	end, var_0_8, 1)

	arg_98_0.energyCostEffectTimer_:Start()
end

function var_0_0.HideEnergyCostEffect(arg_100_0, arg_100_1)
	if not arg_100_1 then
		arg_100_0:StopEnergyCostEffectTimer()
	end

	if arg_100_0.energyCostEffectGo_ ~= nil then
		SetActive(arg_100_0.energyCostEffectGo_, false)
	end
end

function var_0_0.StopEnergyCostEffectTimer(arg_101_0)
	if arg_101_0.energyCostEffectTimer_ ~= nil then
		arg_101_0.energyCostEffectTimer_:Stop()

		arg_101_0.energyCostEffectTimer_ = nil
	end
end

function var_0_0.ResetRuntimeStateDisplay(arg_102_0)
	arg_102_0:StopAllHpDelayTweens()
	arg_102_0:ResetRoundProgressState()
	arg_102_0:HideSkillBubble()
	arg_102_0:HideEnemyIntroBubble()
	arg_102_0:HideEnergyCostEffect()
	arg_102_0.enemyHeadModeController_:SetSelectedState("single")
	arg_102_0:SetEnemyBVisible(false)
	arg_102_0.energyMaxController_:SetSelectedState("normal")

	if arg_102_0.challengeController_ ~= nil then
		arg_102_0.challengeController_:SetSelectedState("hide")
	end

	arg_102_0.lastTimeState_ = nil

	arg_102_0:SetTimeControllerState("normal")

	arg_102_0.lastRuntimePhase_ = "None"
	arg_102_0.meLabelLastRuntimePhase_ = "None"
	arg_102_0.meLabelShownWave_ = nil
	arg_102_0.meLabelPendingWave_ = nil
	arg_102_0.meLabelPendingShow_ = false

	arg_102_0:HideMeLabel()

	arg_102_0.enemyIntroBubbleShownWave_ = -1
	arg_102_0.enemyOverclockBubbleToken_ = 0
	arg_102_0.lastPlayerEnergy_ = nil
	arg_102_0.waveText_.text = ""

	if arg_102_0.scoreNumText_ ~= nil then
		arg_102_0.scoreNumText_.text = ""
	end

	arg_102_0:SetTimerVisible(false)

	arg_102_0.timerText_.text = ""
	arg_102_0.playerHpText_.text = ""
	arg_102_0.playerEnergyText_.text = ""
	arg_102_0.playerHpSlider_.value = 0
	arg_102_0.playerHpDelaySlider_.value = 0
	arg_102_0.playerEnergySlider_.value = 0

	if arg_102_0.waveProgressSlider_ then
		arg_102_0.waveProgressSlider_.value = 0
	end

	if arg_102_0.pausePanelGo_ then
		SetActive(arg_102_0.pausePanelGo_, false)
	end

	arg_102_0:SetCountdownPanelState("none")

	arg_102_0.readyRoundTextLineText_.text = ""
	arg_102_0.readyRoundTextText_.text = ""

	arg_102_0:RefreshEnemyHud({
		enemyHeadOut = false,
		mode = "championship",
		enemyAlive = false,
		enemyMaxHp = 1,
		enemyHp = 0,
		enemyName = ""
	})
	arg_102_0:RefreshSkillHud({}, 0)
end

function var_0_0.SetSpecialDefeatUiHidden(arg_103_0, arg_103_1)
	local var_103_0 = arg_103_1 ~= true

	if arg_103_0.middleAdaptGo_ then
		SetActive(arg_103_0.middleAdaptGo_, var_103_0)
	end

	if arg_103_0.damageTextLayerGo_ then
		SetActive(arg_103_0.damageTextLayerGo_, var_103_0)
	end
end

function var_0_0.SetEnemyHeadOut(arg_104_0, arg_104_1)
	arg_104_0:SetEnemyHeadOutByController(arg_104_0.enemyAHeadOutController_, arg_104_1 == true)
	arg_104_0:SetEnemyHeadOutByController(arg_104_0.enemyBHeadOutController_, arg_104_1 == true)
end

function var_0_0.SetEnemyHeadOutByController(arg_105_0, arg_105_1, arg_105_2)
	if arg_105_1 == nil then
		return
	end

	local var_105_0 = arg_105_2 == true and "true" or "false"

	arg_105_1:SetSelectedState(var_105_0)
end

function var_0_0.SetEnemyBVisible(arg_106_0, arg_106_1)
	local var_106_0 = arg_106_1 == true and "true" or "false"

	arg_106_0.enemyStateController_:SetSelectedState(var_106_0)
end

function var_0_0.SetAllBattleResultBannersVisible(arg_107_0, arg_107_1)
	var_0_30(arg_107_0.winGo_, arg_107_1 == "win", var_0_25.win)
	var_0_30(arg_107_0.loseGo_, arg_107_1 == "lose", var_0_25.lose)
	var_0_30(arg_107_0.timeoutWinGo_, arg_107_1 == "timeoutWin", var_0_25.timeoutWin)
	var_0_30(arg_107_0.timeoutLoseGo_, arg_107_1 == "timeoutLose", var_0_25.timeoutLose)
end

function var_0_0.SetTimeoutResultVisible(arg_108_0, arg_108_1)
	if arg_108_1 == "win" then
		arg_108_0:SetAllBattleResultBannersVisible("timeoutWin")

		return
	end

	if arg_108_1 == "lose" then
		arg_108_0:SetAllBattleResultBannersVisible("timeoutLose")

		return
	end

	arg_108_0:SetAllBattleResultBannersVisible(nil)
end

function var_0_0.SetBattleResultVisible(arg_109_0, arg_109_1)
	if arg_109_1 == "win" or arg_109_1 == "lose" then
		arg_109_0:SetAllBattleResultBannersVisible(arg_109_1)

		return
	end

	arg_109_0:SetAllBattleResultBannersVisible(nil)
end

function var_0_0.Dispose(arg_110_0)
	arg_110_0.windowBarBackHandler_ = nil

	arg_110_0:StopAllHpDelayTweens()
	arg_110_0:ResetRoundProgressState()
	arg_110_0:HideSkillBubble()
	arg_110_0:StopEnemyIntroBubbleTimer()
	arg_110_0:StopEnergyCostEffectTimer()
	arg_110_0:SetTimeoutResultVisible(nil)
	arg_110_0:DisposeDamageTextPool()

	if arg_110_0.skillList_ then
		arg_110_0.skillList_:Dispose()

		arg_110_0.skillList_ = nil
	end

	var_0_0.super.Dispose(arg_110_0)
end

return var_0_0
