local SpShootGameInfoView = class("SpShootGameInfoView", ReduxView)
local var_0_1 = 0.016666666666666666

function SpShootGameInfoView:UIName()
	return "Widget/Version/ShashwatUI_3_6/ShashwatUI_3_6_kaliUI/ShashwatUI_3_6_kailiShootUI"
end

function SpShootGameInfoView:UIParent()
	return manager.ui.uiMain.transform
end

function SpShootGameInfoView:OnCtor()
	return
end

function SpShootGameInfoView:Init()
	self:InitUI()
	self:AddUIListener()
end

function SpShootGameInfoView:InitUI()
	self:BindCfgUI()

	self.textController_ = self.shashwatui_3_6_kailishootuiControllerexcollection_:GetController("textmark")
	self.btnStateController_ = self.shashwatui_3_6_kailishootuiControllerexcollection_:GetController("btn")
	self.skillStateController_ = self.shashwatui_3_6_kailishootuiControllerexcollection_:GetController("btn2")
	self.startTimeStateController_ = self.shashwatui_3_6_kailishootuiControllerexcollection_:GetController("startTime")
	self.resStateController_ = self.shashwatui_3_6_kailishootuiControllerexcollection_:GetController("redState")

	self:RegisterEvents()
end

function SpShootGameInfoView:OnEnter()
	self.maxCD = ShootGameToLuaBridge.GetMaxCd()
	self.maxAnger = ShootGameToLuaBridge.GetMaxAnger()
	self.costAnger = ShootGameToLuaBridge.GetCostAnger()

	SpShootGameBridge:SetHitEffect(false)
	SpShootGameBridge:StopPlayable()
	SetActive(self.scoregroupGo_, false)

	self.score = 0

	self:ResetTime()
end

function SpShootGameInfoView:OnTop()
	self:RefreshBar()
end

function SpShootGameInfoView:OnExit()
	manager.windowBar:HideBar()
	self:StopTime()
	self:StopLeanTween()
	self:RemoveAllEventListener()
end

function SpShootGameInfoView:RefreshBar()
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		ShootGameToLuaBridge.PauseGame()
		self.startTimeStateController_:SetSelectedState("hide" or "show")

		self.pauseGameFlag = true

		ShowMessageBox({
			isTop = true,
			title = GetTips("PROMPT"),
			content = GetTips("BLISTER_TASK_DES2"),
			OkCallback = function()
				local var_11_0 = "activity_combat_over"
				local var_11_1 = {
					stage_id = 0,
					result = 3
				}

				if self.params_ then
					var_11_1.activity_id = self.params_.activityID or ActivityConst.ACTIVITY_3_6_KALI_SHOOTGAME
				end

				var_11_1.score = self.score
				var_11_1.other_data = string.format("[[enemy_hit_num,%s],[friend_hit_num,%s]]", ShootGameToLuaBridge.GetEnemyHit(), ShootGameToLuaBridge.GetFriendHit())
				var_11_1.reward_list = {}
				var_11_1.use_seconds = string.format("%d", ShootGameToLuaBridge.GetMaxTime() - ShootGameToLuaBridge.GetCurTime())

				SDKTools.SendMessageToSDK(var_11_0, var_11_1)
				DestroyLua()
				LuaExchangeHelper.GoToMain()
			end,
			CancelCallback = function()
				ShootGameToLuaBridge.PauseGame()

				self.pauseGameFlag = false

				self.startTimeStateController_:SetSelectedState(self.showPrepareTime <= 0 and "hide" or "show")
			end
		})
	end)
end

function SpShootGameInfoView:SetPosition(arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	local var_13_0, var_13_1 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(arg_13_4.parent, UnityEngine.RectTransformUtility.WorldToScreenPoint(manager.ui.mainCameraCom_, Vector3.New(arg_13_1, arg_13_2, arg_13_3)), manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera, nil)

	arg_13_4.localPosition = Vector3.New(var_13_1.x, var_13_1.y + 240, var_13_1.z)
end

function SpShootGameInfoView:RegisterEvents()
	self:RegistEventListener(ACTIVITY_KALI_UPDATE_SHOOTSCORE, function(arg_15_0, arg_15_1)
		self:UpdateScore(arg_15_0, arg_15_1)
	end)
end

function SpShootGameInfoView:UpdateScore(arg_16_1, arg_16_2)
	if arg_16_2 >= 0 then
		self.textController_:SetSelectedState("green")

		if arg_16_1 >= 10 then
			manager.audio:PlayEffect("minigame_activity_3_6", "minigame_activity_3_6_1156_shoot_plus")
		else
			manager.audio:PlayEffect("minigame_activity_3_6", "minigame_activity_3_6_1156_shoot_normal")
		end
	else
		self.textController_:SetSelectedState("red")
		manager.audio:PlayEffect("minigame_activity_3_6", "minigame_activity_3_6_1156_shoot_wrong")
	end

	SetActive(self.scoregroupGo_, true)

	if arg_16_2 > 0 then
		SetActive(self.effectGo, false)
		SetActive(self.effectGo, true)
	end

	self.scoregroupAni_:Update(0)
	AnimatorTools.PlayAnimationWithCallback(self.scoregroupAni_, "UI_scoreGroup_cx", function()
		SetActive(self.scoregroupGo_, false)
	end)

	if arg_16_2 > 0 then
		self.textnumText_.text = "+" .. arg_16_2 or arg_16_2
	end

	self.score = Mathf.Clamp(arg_16_1 + arg_16_2, 0, 9999)
	self.textpointsText_.text = self.score

	if arg_16_2 < 0 then
		SpShootGameBridge:SetHitEffect(false)
		SpShootGameBridge:SetHitEffect(true)
	end
end

function SpShootGameInfoView:AddUIListener()
	self:AddBtnListener(self.shootbtnBtn_, nil, function()
		self.nowCd = ShootGameToLuaBridge.GetNowCd()

		if self.nowCd <= 0 then
			SpShootGameBridge:PlayAni("fabo_R", function()
				return
			end)

			self.shoot1 = TimeTools.StartAfterSeconds(0.1, function()
				SpShootGameBridge:SetBool(false)
			end, {})

			manager.audio:PlayEffect("minigame_activity_3_6", "minigame_activity_3_6_1156_shoot_attack")
			ShootGameToLuaBridge.Shoot()

			self.playTime = self.playTime + 1
		end
	end)
	self:AddBtnListener(self.btnskillBtn_, nil, function()
		self.NowAnger = ShootGameToLuaBridge.GetAnger()

		if self.NowAnger < self.costAnger then
			-- block empty
		else
			SpShootGameBridge:SetSkillEffect()

			self.timeSkill = TimeTools.StartAfterSeconds(0.2, function()
				manager.audio:PlayEffect("minigame_activity_3_6", "minigame_activity_3_6_1156_shoot_power")
				ShootGameToLuaBridge.PlaySkill()
			end, {})
		end
	end)
end

function SpShootGameInfoView:ResetTime()
	self.playTime = 1

	self:StopTime()

	self.showPrepareTime = 2
	self.gameTime = 0
	self.lastfillAmount = 0
	self.isShowTips = false

	self.startTimeStateController_:SetSelectedState("show")

	self.texttimeText_.text = manager.time:DescCDTime4(self.gameTime)
	self.textpointsText_.text = 0

	self:UpdateSkill(0)

	self.textText_.text = string.format("%d", self.showPrepareTime)
	self.updateTimer_ = Timer.New(function()
		if not self.pauseGameFlag and self.showPrepareTime <= 0 then
			self.startTimeStateController_:SetSelectedState("hide")
			self:UpdateLogic(var_0_1)
		end
	end, var_0_1, -1)
	self.prepareTimer_ = Timer.New(function()
		self:StopLeanTween()
		self:StartTween()

		if not self.pauseGameFlag then
			self:ShowPrepareTime(1)
		end
	end, 1, -1)

	self.prepareTimer_:Start()
	self:StartTween()
end

function SpShootGameInfoView:StartTween()
	self.sliderImg_.fillAmount = 1
	self.imageTween1_ = LeanTween.value(1, 0, 1):setOnUpdate(LuaHelper.FloatAction(function(arg_28_0)
		self.sliderImg_.fillAmount = arg_28_0
	end))
	self.image1Img_.alpha = 0
	self.tweenValue_ = LeanTween.value(0, 1, 0.1):setOnUpdate(LuaHelper.FloatAction(function(arg_29_0)
		self.image1Img_.alpha = arg_29_0
	end))
end

function SpShootGameInfoView:StopLeanTween()
	if self.tweenValue_ then
		self.tweenValue_:setOnComplete(nil):setEase(nil)
		LeanTween.cancel(self.tweenValue_.id)

		self.tweenValue_ = nil
	end

	if self.imageTween1_ then
		self.imageTween1_:setOnComplete(nil):setEase(nil)
		LeanTween.cancel(self.imageTween1_.id)

		self.imageTween1_ = nil
	end
end

function SpShootGameInfoView:ShowPrepareTime(arg_31_1)
	self.showPrepareTime = Mathf.Clamp(self.showPrepareTime - arg_31_1, 0, 99)
	self.textText_.text = string.format("%d", self.showPrepareTime)

	if self.showPrepareTime <= 0 then
		self.prepareTimer_:Stop()

		self.prepareTimer_ = nil

		self.updateTimer_:Start()
		SpShootGameBridge.StartGame()
	end
end

function SpShootGameInfoView:UpdateLogic(arg_32_1)
	self.nowCd = ShootGameToLuaBridge.GetNowCd()
	self.NowAnger = ShootGameToLuaBridge.GetAnger()

	self:UpdateCD(1 - self.nowCd / self.maxCD)
	self:UpdateSkill(self.NowAnger / self.maxAnger)

	self.gameTime = ShootGameToLuaBridge.GetCurTime()

	if self.gameTime <= 17 and not self.isShowTips then
		ShowTips(GetTips("SP_KALI_SHOOT_TIPS"))

		self.isShowTips = true
	end

	if self.gameTime <= 10 then
		self.ndtimeAni_:Play("UI_ndtime_cx")
		self.resStateController_:SetSelectedState("red")
	else
		self.ndtimeAni_:Play("UI_ndtime_idle")
		self.resStateController_:SetSelectedState("normal")
	end

	self.texttimeText_.text = manager.time:DescCDTime4(self.gameTime)

	SpShootGameBridge:CheckEffectEnd()
end

function SpShootGameInfoView:StopTime()
	if self.updateTimer_ then
		self.updateTimer_:Stop()

		self.updateTimer_ = nil
	end

	if self.prepareTimer_ then
		self.prepareTimer_:Stop()

		self.prepareTimer_ = nil
	end

	if self.timeSkill then
		self.timeSkill:Stop()

		self.timeSkill = nil
	end

	if self.shoot1 then
		self.shoot1:Stop()

		self.shoot1 = nil
	end
end

function SpShootGameInfoView:UpdateCD(arg_34_1)
	self.ray_pTrs_.rotation = Quaternion.Euler(0, 0, arg_34_1 * 360)

	self.btnStateController_:SetSelectedState(arg_34_1 == 1 and "completely" or "powerimg")

	self.powerimgImg_.fillAmount = arg_34_1
end

function SpShootGameInfoView:UpdateSkill(arg_35_1)
	self.ray_pTrs_.rotation = Quaternion.Euler(0, 0, arg_35_1 * 360)

	self.skillStateController_:SetSelectedState(arg_35_1 == 1 and "completely" or "powerimg")

	if not self.lastfillAmount or self.lastfillAmount ~= arg_35_1 then
		if self.fillAmountTween and self.lastfillAmount then
			self:Stoptween()

			self.completelyImg_.fillAmount = self.lastfillAmount
		end

		self.fillAmountTween = LeanTween.value(self.completelyImg_.fillAmount, arg_35_1, 0.3):setOnUpdate(LuaHelper.FloatAction(function(arg_36_0)
			self.completelyImg_.fillAmount = arg_36_0
		end)):setOnComplete(LuaHelper.VoidAction(function()
			self:Stoptween()
		end)):setEase(LeanTweenType.easeOutCubic)
	end

	self.lastfillAmount = arg_35_1
	self.powerimgImg2_.fillAmount = arg_35_1 <= 1 and 1 or 0
end

function SpShootGameInfoView:Dispose()
	SpShootGameInfoView.super.Dispose(self)
	AnimatorTools.Stop()
	self:Stoptween()
end

function SpShootGameInfoView:Stoptween()
	if self.fillAmountTween then
		self.fillAmountTween:setOnComplete(nil):setOnUpdate(nil):setEase(nil)
		LeanTween.cancel(self.fillAmountTween.id)

		self.fillAmountTween = nil
	end
end

return SpShootGameInfoView
