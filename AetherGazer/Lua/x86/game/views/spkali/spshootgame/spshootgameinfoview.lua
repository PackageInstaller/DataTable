local var_0_0 = class("SpShootGameInfoView", ReduxView)
local var_0_1 = 0.016666666666666666

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/ShashwatUI_3_6/ShashwatUI_3_6_kaliUI/ShashwatUI_3_6_kailiShootUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.textController_ = arg_5_0.shashwatui_3_6_kailishootuiControllerexcollection_:GetController("textmark")
	arg_5_0.btnStateController_ = arg_5_0.shashwatui_3_6_kailishootuiControllerexcollection_:GetController("btn")
	arg_5_0.skillStateController_ = arg_5_0.shashwatui_3_6_kailishootuiControllerexcollection_:GetController("btn2")
	arg_5_0.startTimeStateController_ = arg_5_0.shashwatui_3_6_kailishootuiControllerexcollection_:GetController("startTime")
	arg_5_0.resStateController_ = arg_5_0.shashwatui_3_6_kailishootuiControllerexcollection_:GetController("redState")

	arg_5_0:RegisterEvents()
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0.maxCD = ShootGameToLuaBridge.GetMaxCd()
	arg_6_0.maxAnger = ShootGameToLuaBridge.GetMaxAnger()
	arg_6_0.costAnger = ShootGameToLuaBridge.GetCostAnger()

	SpShootGameBridge:SetHitEffect(false)
	SpShootGameBridge:StopPlayable()
	SetActive(arg_6_0.scoregroupGo_, false)

	arg_6_0.score = 0

	arg_6_0:ResetTime()
end

function var_0_0.OnTop(arg_7_0)
	arg_7_0:RefreshBar()
end

function var_0_0.OnExit(arg_8_0)
	manager.windowBar:HideBar()
	arg_8_0:StopTime()
	arg_8_0:StopLeanTween()
	arg_8_0:RemoveAllEventListener()
end

function var_0_0.RefreshBar(arg_9_0)
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		ShootGameToLuaBridge.PauseGame()
		arg_9_0.startTimeStateController_:SetSelectedState("hide" or "show")

		arg_9_0.pauseGameFlag = true

		ShowMessageBox({
			isTop = true,
			title = GetTips("PROMPT"),
			content = GetTips("BLISTER_TASK_DES2"),
			OkCallback = function()
				local var_11_0 = string.format("[[enemy_hit_num,%s],[friend_hit_num,%s]]", ShootGameToLuaBridge.GetEnemyHit(), ShootGameToLuaBridge.GetFriendHit())

				SDKTools.SendMessageToSDK("activity_combat_over", {
					stage_id = 0,
					result = 3,
					activity_id = arg_9_0.params_ and arg_9_0.params_.activityID or ActivityConst.ACTIVITY_3_6_KALI_SHOOTGAME,
					score = arg_9_0.score,
					other_data = var_11_0,
					reward_list = {},
					use_seconds = string.format("%d", ShootGameToLuaBridge.GetMaxTime() - ShootGameToLuaBridge.GetCurTime())
				})
				DestroyLua()
				LuaExchangeHelper.GoToMain()
			end,
			CancelCallback = function()
				ShootGameToLuaBridge.PauseGame()

				arg_9_0.pauseGameFlag = false

				arg_9_0.startTimeStateController_:SetSelectedState(arg_9_0.showPrepareTime <= 0 and "hide" or "show")
			end
		})
	end)
end

function var_0_0.SetPosition(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	local var_13_0 = manager.ui.mainCameraCom_
	local var_13_1 = manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera
	local var_13_2 = UnityEngine.RectTransformUtility.WorldToScreenPoint(var_13_0, Vector3.New(arg_13_1, arg_13_2, arg_13_3))
	local var_13_3, var_13_4 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(arg_13_4.parent, var_13_2, var_13_1, nil)

	arg_13_4.localPosition = Vector3.New(var_13_4.x, var_13_4.y + 240, var_13_4.z)
end

function var_0_0.RegisterEvents(arg_14_0)
	arg_14_0:RegistEventListener(ACTIVITY_KALI_UPDATE_SHOOTSCORE, function(arg_15_0, arg_15_1)
		arg_14_0:UpdateScore(arg_15_0, arg_15_1)
	end)
end

function var_0_0.UpdateScore(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_2 >= 0 then
		arg_16_0.textController_:SetSelectedState("green")

		if arg_16_1 >= 10 then
			manager.audio:PlayEffect("minigame_activity_3_6", "minigame_activity_3_6_1156_shoot_plus")
		else
			manager.audio:PlayEffect("minigame_activity_3_6", "minigame_activity_3_6_1156_shoot_normal")
		end
	else
		arg_16_0.textController_:SetSelectedState("red")
		manager.audio:PlayEffect("minigame_activity_3_6", "minigame_activity_3_6_1156_shoot_wrong")
	end

	SetActive(arg_16_0.scoregroupGo_, true)

	if arg_16_2 > 0 then
		SetActive(arg_16_0.effectGo, false)
		SetActive(arg_16_0.effectGo, true)
	end

	arg_16_0.scoregroupAni_:Update(0)
	AnimatorTools.PlayAnimationWithCallback(arg_16_0.scoregroupAni_, "UI_scoreGroup_cx", function()
		SetActive(arg_16_0.scoregroupGo_, false)
	end)

	arg_16_0.textnumText_.text = arg_16_2 > 0 and "+" .. arg_16_2 or arg_16_2
	arg_16_0.score = Mathf.Clamp(arg_16_1 + arg_16_2, 0, 9999)
	arg_16_0.textpointsText_.text = arg_16_0.score

	if arg_16_2 < 0 then
		SpShootGameBridge:SetHitEffect(false)
		SpShootGameBridge:SetHitEffect(true)
	end
end

function var_0_0.AddUIListener(arg_18_0)
	arg_18_0:AddBtnListener(arg_18_0.shootbtnBtn_, nil, function()
		arg_18_0.nowCd = ShootGameToLuaBridge.GetNowCd()

		if arg_18_0.nowCd <= 0 then
			SpShootGameBridge:PlayAni("fabo_R", function()
				return
			end)

			arg_18_0.shoot1 = TimeTools.StartAfterSeconds(0.1, function()
				SpShootGameBridge:SetBool(false)
			end, {})

			manager.audio:PlayEffect("minigame_activity_3_6", "minigame_activity_3_6_1156_shoot_attack")
			ShootGameToLuaBridge.Shoot()

			arg_18_0.playTime = arg_18_0.playTime + 1
		end
	end)
	arg_18_0:AddBtnListener(arg_18_0.btnskillBtn_, nil, function()
		arg_18_0.NowAnger = ShootGameToLuaBridge.GetAnger()

		if arg_18_0.NowAnger < arg_18_0.costAnger then
			-- block empty
		else
			SpShootGameBridge:SetSkillEffect()

			arg_18_0.timeSkill = TimeTools.StartAfterSeconds(0.2, function()
				manager.audio:PlayEffect("minigame_activity_3_6", "minigame_activity_3_6_1156_shoot_power")
				ShootGameToLuaBridge.PlaySkill()
			end, {})
		end
	end)
end

function var_0_0.ResetTime(arg_24_0)
	arg_24_0.playTime = 1

	arg_24_0:StopTime()

	arg_24_0.showPrepareTime = 2
	arg_24_0.gameTime = 0
	arg_24_0.lastfillAmount = 0
	arg_24_0.isShowTips = false

	arg_24_0.startTimeStateController_:SetSelectedState("show")

	arg_24_0.texttimeText_.text = manager.time:DescCDTime4(arg_24_0.gameTime)
	arg_24_0.textpointsText_.text = 0

	arg_24_0:UpdateSkill(0)

	arg_24_0.textText_.text = string.format("%d", arg_24_0.showPrepareTime)
	arg_24_0.updateTimer_ = Timer.New(function()
		if not arg_24_0.pauseGameFlag and arg_24_0.showPrepareTime <= 0 then
			arg_24_0.startTimeStateController_:SetSelectedState("hide")
			arg_24_0:UpdateLogic(var_0_1)
		end
	end, var_0_1, -1)
	arg_24_0.prepareTimer_ = Timer.New(function()
		arg_24_0:StopLeanTween()
		arg_24_0:StartTween()

		if not arg_24_0.pauseGameFlag then
			arg_24_0:ShowPrepareTime(1)
		end
	end, 1, -1)

	arg_24_0.prepareTimer_:Start()
	arg_24_0:StartTween()
end

function var_0_0.StartTween(arg_27_0)
	arg_27_0.sliderImg_.fillAmount = 1
	arg_27_0.imageTween1_ = LeanTween.value(1, 0, 1):setOnUpdate(LuaHelper.FloatAction(function(arg_28_0)
		arg_27_0.sliderImg_.fillAmount = arg_28_0
	end))
	arg_27_0.image1Img_.alpha = 0
	arg_27_0.tweenValue_ = LeanTween.value(0, 1, 0.1):setOnUpdate(LuaHelper.FloatAction(function(arg_29_0)
		arg_27_0.image1Img_.alpha = arg_29_0
	end))
end

function var_0_0.StopLeanTween(arg_30_0)
	if arg_30_0.tweenValue_ then
		arg_30_0.tweenValue_:setOnComplete(nil):setEase(nil)
		LeanTween.cancel(arg_30_0.tweenValue_.id)

		arg_30_0.tweenValue_ = nil
	end

	if arg_30_0.imageTween1_ then
		arg_30_0.imageTween1_:setOnComplete(nil):setEase(nil)
		LeanTween.cancel(arg_30_0.imageTween1_.id)

		arg_30_0.imageTween1_ = nil
	end
end

function var_0_0.ShowPrepareTime(arg_31_0, arg_31_1)
	arg_31_0.showPrepareTime = Mathf.Clamp(arg_31_0.showPrepareTime - arg_31_1, 0, 99)
	arg_31_0.textText_.text = string.format("%d", arg_31_0.showPrepareTime)

	if arg_31_0.showPrepareTime <= 0 then
		arg_31_0.prepareTimer_:Stop()

		arg_31_0.prepareTimer_ = nil

		arg_31_0.updateTimer_:Start()
		SpShootGameBridge.StartGame()
	end
end

function var_0_0.UpdateLogic(arg_32_0, arg_32_1)
	arg_32_0.nowCd = ShootGameToLuaBridge.GetNowCd()
	arg_32_0.NowAnger = ShootGameToLuaBridge.GetAnger()

	local var_32_0 = arg_32_0.nowCd / arg_32_0.maxCD

	arg_32_0:UpdateCD(1 - var_32_0)

	local var_32_1 = arg_32_0.NowAnger / arg_32_0.maxAnger

	arg_32_0:UpdateSkill(var_32_1)

	arg_32_0.gameTime = ShootGameToLuaBridge.GetCurTime()

	if arg_32_0.gameTime <= 17 and not arg_32_0.isShowTips then
		ShowTips(GetTips("SP_KALI_SHOOT_TIPS"))

		arg_32_0.isShowTips = true
	end

	if arg_32_0.gameTime <= 10 then
		arg_32_0.ndtimeAni_:Play("UI_ndtime_cx")
		arg_32_0.resStateController_:SetSelectedState("red")
	else
		arg_32_0.ndtimeAni_:Play("UI_ndtime_idle")
		arg_32_0.resStateController_:SetSelectedState("normal")
	end

	arg_32_0.texttimeText_.text = manager.time:DescCDTime4(arg_32_0.gameTime)

	SpShootGameBridge:CheckEffectEnd()
end

function var_0_0.StopTime(arg_33_0)
	if arg_33_0.updateTimer_ then
		arg_33_0.updateTimer_:Stop()

		arg_33_0.updateTimer_ = nil
	end

	if arg_33_0.prepareTimer_ then
		arg_33_0.prepareTimer_:Stop()

		arg_33_0.prepareTimer_ = nil
	end

	if arg_33_0.timeSkill then
		arg_33_0.timeSkill:Stop()

		arg_33_0.timeSkill = nil
	end

	if arg_33_0.shoot1 then
		arg_33_0.shoot1:Stop()

		arg_33_0.shoot1 = nil
	end
end

function var_0_0.UpdateCD(arg_34_0, arg_34_1)
	arg_34_0.ray_pTrs_.rotation = Quaternion.Euler(0, 0, arg_34_1 * 360)

	arg_34_0.btnStateController_:SetSelectedState(arg_34_1 == 1 and "completely" or "powerimg")

	arg_34_0.powerimgImg_.fillAmount = arg_34_1
end

function var_0_0.UpdateSkill(arg_35_0, arg_35_1)
	arg_35_0.ray_pTrs_.rotation = Quaternion.Euler(0, 0, arg_35_1 * 360)

	arg_35_0.skillStateController_:SetSelectedState(arg_35_1 == 1 and "completely" or "powerimg")

	if not arg_35_0.lastfillAmount or arg_35_0.lastfillAmount ~= arg_35_1 then
		if arg_35_0.fillAmountTween and arg_35_0.lastfillAmount then
			arg_35_0:Stoptween()

			arg_35_0.completelyImg_.fillAmount = arg_35_0.lastfillAmount
		end

		arg_35_0.fillAmountTween = LeanTween.value(arg_35_0.completelyImg_.fillAmount, arg_35_1, 0.3):setOnUpdate(LuaHelper.FloatAction(function(arg_36_0)
			arg_35_0.completelyImg_.fillAmount = arg_36_0
		end)):setOnComplete(LuaHelper.VoidAction(function()
			arg_35_0:Stoptween()
		end)):setEase(LeanTweenType.easeOutCubic)
	end

	arg_35_0.lastfillAmount = arg_35_1
	arg_35_0.powerimgImg2_.fillAmount = arg_35_1 <= 1 and 1 or 0
end

function var_0_0.Dispose(arg_38_0)
	var_0_0.super.Dispose(arg_38_0)
	AnimatorTools.Stop()
	arg_38_0:Stoptween()
end

function var_0_0.Stoptween(arg_39_0)
	if arg_39_0.fillAmountTween then
		arg_39_0.fillAmountTween:setOnComplete(nil):setOnUpdate(nil):setEase(nil)
		LeanTween.cancel(arg_39_0.fillAmountTween.id)

		arg_39_0.fillAmountTween = nil
	end
end

return var_0_0
