local cjson = require("cjson")
local FishingGameView = class("FishingGameView", ReduxView)

function FishingGameView:UIName()
	return "UI/Fishing/Game/FishingGameUI"
end

function FishingGameView:UIParent()
	return manager.ui.uiMain.transform
end

function FishingGameView:OnCtor()
	return
end

function FishingGameView:Init()
	self:InitUI()
	self:AddUIListener()
end

function FishingGameView:InitUI()
	self:BindCfgUI()

	self.bubbleNumController_ = ControllerUtil.GetController(self.gameObject_.transform, "bubbleNum")
	self.buffController_ = ControllerUtil.GetController(self.gameObject_.transform, "buff")
	self.pauseController_ = ControllerUtil.GetController(self.gameObject_.transform, "pause")
	self.hook_ = FishHook.New(self.hookGo_)
	self.roleSpine_ = self.roleGo_:GetComponent("Spine.Unity.SkeletonGraphic")
	self.waterSpine_ = self.seaWeaterGo_:GetComponent("Spine.Unity.SkeletonGraphic")

	self:PlayRoleAnimation("idle", true)
end

function FishingGameView:AddUIListener()
	self:AddBtnListener(self.hookBtn_, nil, function()
		if self.hook_ then
			self.hook_:StartHooking()
		end
	end)
	FishGameManager.GetInstance():SetPauseHandler(handler(self, self.OnPause))
	FishGameManager.GetInstance():SetContinueHandler(handler(self, self.OnContinue))
	FishGameManager.GetInstance():SetScoreChangeHandler(handler(self, self.OnScoreChange))
	FishGameManager.GetInstance():SetScoreAddHandler(handler(self, self.OnScoreAdd))
	FishGameManager.GetInstance():AddBuffHandler(handler(self, self.OnBuffChange))
	self:AddBtnListener(self.pauseBtn_, nil, function()
		FishGameManager.GetInstance():Pause()
	end)
	self:AddBtnListener(self.continueBtn_, nil, function()
		FishGameManager.GetInstance():Continue()
	end)
	self:AddBtnListener(self.exitBtn_, nil, function()
		self.pauseController_:SetSelectedState("false")
		manager.audio:PlayEffect("minigame_fishing", "fishing_stopall", "")
		self:Back()
	end)

	self.onAnimationCompleteHandler_ = handler(self, self.OnAnimationComplete)
	self.roleSpine_.AnimationState.Complete = self.roleSpine_.AnimationState.Complete + self.onAnimationCompleteHandler_
end

function FishingGameView:OnAnimationComplete(arg_11_1)
	if arg_11_1.Animation.Name == "PushButton" then
		self:PlayRoleAnimation("look", true)
	end
end

function FishingGameView:PlayRoleAnimation(arg_12_1, arg_12_2)
	if self.curName_ ~= nil and self.curName_ == arg_12_1 then
		return
	end

	self.curName_ = arg_12_1

	self.roleSpine_.AnimationState:SetAnimation(0, arg_12_1, arg_12_2)
end

function FishingGameView:AddEventListeners()
	return
end

function FishingGameView:OnPause()
	self.pauseController_:SetSelectedState("true")

	self.roleSpine_.AnimationState.TimeScale = 0
	self.waterSpine_.AnimationState.TimeScale = 0
end

function FishingGameView:OnContinue()
	self.pauseController_:SetSelectedState("false")

	self.roleSpine_.AnimationState.TimeScale = 1
	self.waterSpine_.AnimationState.TimeScale = 1
end

function FishingGameView:OnScoreChange()
	local var_16_0 = tonumber(self.scoreLabel_.text)
	local var_16_1 = FishGameManager.GetInstance():GetScore()

	self.tween_ = LeanTween.value(0, 1, 0.5):setOnUpdate(LuaHelper.FloatAction(function(arg_17_0)
		local var_17_0 = var_16_0 or 0
		local var_17_1 = math.floor(var_17_0 + (var_16_1 - var_17_0) * arg_17_0)

		self.scoreLabel_.text = tostring(var_17_1)
		self.scoreLabelAnimation_.text = tostring(var_17_1)
	end)):setOnComplete(LuaHelper.VoidAction(function()
		if self.tween_ then
			self.tween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)

			self.tween_ = nil
		end

		self.scoreLabel_.text = tostring(FishGameManager.GetInstance():GetScore())
		self.scoreLabelAnimation_.text = tostring(FishGameManager.GetInstance():GetScore())

		self.scoreAnimator_:Play("fishing_scoring", -1, 0)
	end)):setEase(LeanTweenType.easeOutQuad)

	self.bubbleNumController_:SetSelectedIndex(FishGameManager.GetInstance():GetTreasureLimitNum())
end

function FishingGameView:OnScoreAdd(arg_19_1)
	SetActive(self.scoreGo_, true)
	self.goalAnimator_:Play("FishGoal", -1, 0)

	self.scoreAddLabel_.text = arg_19_1

	manager.audio:PlayEffect("minigame_fishing", "fishing_gain", "")
end

function FishingGameView:OnBuffChange(arg_20_1, arg_20_2, arg_20_3)
	if arg_20_2 == 1 then
		self.curBuff_ = arg_20_1
		self.curBuffMilliseconds_ = 20

		SetActive(self.buffGo_, true)

		self.buffNameLabel_.text = GetTips("ACTIVITY_FISHING_BUFF_NAME_" .. arg_20_1)
		self.buffDescLabel_.text = GetTips("ACTIVITY_FISHING_BUFF_DESC_" .. arg_20_1)
		self.buffProgress_.fillAmount = 1

		self.buffController_:SetSelectedState(tostring(arg_20_1))

		if arg_20_1 == 1 then
			self.doubleAnimator_:Play("ef_ui_buff_double", -1, 0)
		elseif arg_20_1 == 3 then
			self.timeAnimator_:Play("ef_ui_buff_double", -1, 0)
		end
	elseif arg_20_2 == 0 then
		self.buffController_:SetSelectedState("0")

		self.curBuff_ = 0
		self.curBuffMilliseconds_ = 0
		self.buffProgress_.fillAmount = 0

		SetActive(self.buffGo_, false)
	elseif arg_20_2 == 2 then
		if self.curBuffMilliseconds_ > 0 then
			self.curBuffMilliseconds_ = self.curBuffMilliseconds_ - Time.deltaTime
		end

		if self.curBuffMilliseconds_ < 0 then
			self.curBuffMilliseconds_ = 0
		end

		self.buffProgress_.fillAmount = self.curBuffMilliseconds_ / 20
	end
end

function FishingGameView:OnTop()
	self:UpdateBar()
end

function FishingGameView:UpdateBar()
	return
end

function FishingGameView:RegisterEvents()
	return
end

function FishingGameView:OnEnter()
	self:AddEventListeners()

	self.fishData_ = cjson.decode((AssetEx.LoadText("Fishing/fishData.json")))

	FishGameManager.GetInstance():Init(self, self.container_)
	FishGameManager.GetInstance():SetHook(self.hook_)

	local var_24_0 = math.random(1, self.fishData_.levelNum)

	for iter_24_0, iter_24_1 in ipairs(self.fishData_.LevelInfos[var_24_0].fishes) do
		local var_24_1 = Object.Instantiate(Asset.Load("UI/Fishing/Game/Fishes/" .. iter_24_1.fishId), self.container_)

		var_24_1.transform.localPosition = Vector2(iter_24_1.posX + var_24_1.transform.rect.width / 2, -iter_24_1.posY - var_24_1.transform.rect.height / 2)
		var_24_1.transform.localScale = Vector3.New(iter_24_1.scaleX / 1000, iter_24_1.scaleY / 1000, 0)

		local var_24_2 = FishItem.New(var_24_1)

		var_24_2:SetData(iter_24_1)
		FishGameManager.GetInstance():AddFish(var_24_2)
	end

	self:RegisterEvents()
	SetActive(self.buffGo_, false)

	self.scoreLabel_.text = "0"
	self.scoreLabelAnimation_.text = "0"

	FishGameManager.GetInstance():Start()
	manager.audio:PlayBGM("bgm_activity_1_2_summer1_minigame_fishing", "bgm_activity_1_2_summer1_minigame_fishing", "bgm_activity_1_2_summer1_minigame_fishing.awb")
	manager.audio:PlayEffect("minigame_fishing", "fishing_wave", "")

	self.levelId_ = self.fishData_.LevelInfos[var_24_0].levelId
	self.oriFrame_ = GameLocalData:GetCommonModule("userSetting").frame or PictureQualitySettingCfg[5].frame

	if self.oriFrame_ ~= 1 then
		SettingAction.ChangePicSetting("frame", 1)
	end
end

local var_0_2 = "notPlayed"

function FishingGameView:Update()
	if self.end_ then
		self.roleSpine_.AnimationState.TimeScale = 0
		self.waterSpine_.AnimationState.TimeScale = 0

		return
	end

	local var_25_0 = FishGameManager.GetInstance():GetStatus()

	if var_25_0 == "cast" then
		if var_0_2 == "notPlayed" then
			self:PlayRoleAnimation("PushButton", false)

			var_0_2 = "playing"
		end
	elseif var_25_0 == "catch" then
		var_0_2 = "notPlayed"

		self:PlayRoleAnimation("Happy", true)
	elseif var_25_0 == "fail" then
		var_0_2 = "notPlayed"

		self:PlayRoleAnimation("Sad", true)
	elseif var_25_0 == "idle" then
		var_0_2 = "notPlayed"

		self:PlayRoleAnimation("idle", true)
	end

	local var_25_1 = FishGameManager.GetInstance():GetSeconds()

	if var_25_1 < 0 then
		var_25_1 = 0
	end

	self.countdownLabel_.text = tostring(math.floor(var_25_1))

	if FishGameManager.GetInstance():GetIsEnd() then
		self.end_ = true

		if ActivityTools.ActivityOpenCheckByMessageBox(ActivityConst.SUMMER_FISHING, function()
			JumpTools.OpenPageByJump("/fishingEnter", {
				activityId = ActivityConst.SUMMER_FISHING
			})
		end) then
			FishingAction.EndingFishing(ActivityConst.SUMMER_FISHING, FishGameManager.GetInstance():GetScore(), FishGameManager.GetInstance():GetTreasureNum(), function(arg_27_0, arg_27_1)
				local var_27_0 = {}

				for iter_27_0, iter_27_1 in ipairs(arg_27_1) do
					table.insert(var_27_0, {
						id = iter_27_1.id,
						num = iter_27_1.num,
						len = iter_27_1.length
					})
				end

				local var_27_1 = {}

				var_27_1.score = FishGameManager.GetInstance():GetScore()
				var_27_1.gainScore = arg_27_0
				var_27_1.fishes = var_27_0

				function var_27_1.callback()
					self:Back()
				end

				JumpTools.OpenPageByJump("fishEnding", var_27_1)
			end)
		end
	end

	self.bubbleNumController_:SetSelectedIndex(FishGameManager.GetInstance():GetTreasureLimitNum())
end

function FishingGameView:GetBubbleTarget()
	if FishGameManager.GetInstance():GetTreasureLimitNum() == 1 then
		return self.iconTransform1_
	end

	return self.iconTransform2_
end

function FishingGameView:AppearBubble(arg_30_1)
	self[string.format("iconTransform%d_", arg_30_1)]:GetComponent(typeof(CanvasGroup)).alpha = 1
end

function FishingGameView:OnExit()
	self:RemoveAllEventListener()
	FishGameManager.GetInstance():Dispose()
	manager.windowBar:HideBar()
	manager.audio:StopEffect()

	if self.oriFrame_ and self.oriFrame_ ~= 1 then
		SettingAction.ChangePicSetting("frame", self.oriFrame_)
	end
end

function FishingGameView:OnMainHomeViewTop()
	return
end

function FishingGameView:Cacheable()
	return false
end

function FishingGameView:Dispose()
	AnimatorTools.Stop()
	FishGameManager.GetInstance():Dispose()

	self.roleSpine_.AnimationState.Complete = self.roleSpine_.AnimationState.Complete - self.onAnimationCompleteHandler_

	if self.tween_ then
		self.tween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(self.tween_.id)

		self.tween_ = nil
	end

	FishingGameView.super.Dispose(self)
end

return FishingGameView
