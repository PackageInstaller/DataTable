local var_0_0 = require("cjson")
local var_0_1 = class("FishingGameView", ReduxView)

function var_0_1.UIName(arg_1_0)
	return "UI/Fishing/Game/FishingGameUI"
end

function var_0_1.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_1.OnCtor(arg_3_0)
	return
end

function var_0_1.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_1.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.bubbleNumController_ = ControllerUtil.GetController(arg_5_0.gameObject_.transform, "bubbleNum")
	arg_5_0.buffController_ = ControllerUtil.GetController(arg_5_0.gameObject_.transform, "buff")
	arg_5_0.pauseController_ = ControllerUtil.GetController(arg_5_0.gameObject_.transform, "pause")
	arg_5_0.hook_ = FishHook.New(arg_5_0.hookGo_)
	arg_5_0.roleSpine_ = arg_5_0.roleGo_:GetComponent("Spine.Unity.SkeletonGraphic")
	arg_5_0.waterSpine_ = arg_5_0.seaWeaterGo_:GetComponent("Spine.Unity.SkeletonGraphic")

	arg_5_0:PlayRoleAnimation("idle", true)
end

function var_0_1.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.hookBtn_, nil, function()
		if arg_6_0.hook_ then
			arg_6_0.hook_:StartHooking()
		end
	end)
	FishGameManager.GetInstance():SetPauseHandler(handler(arg_6_0, arg_6_0.OnPause))
	FishGameManager.GetInstance():SetContinueHandler(handler(arg_6_0, arg_6_0.OnContinue))
	FishGameManager.GetInstance():SetScoreChangeHandler(handler(arg_6_0, arg_6_0.OnScoreChange))
	FishGameManager.GetInstance():SetScoreAddHandler(handler(arg_6_0, arg_6_0.OnScoreAdd))
	FishGameManager.GetInstance():AddBuffHandler(handler(arg_6_0, arg_6_0.OnBuffChange))
	arg_6_0:AddBtnListener(arg_6_0.pauseBtn_, nil, function()
		FishGameManager.GetInstance():Pause()
	end)
	arg_6_0:AddBtnListener(arg_6_0.continueBtn_, nil, function()
		FishGameManager.GetInstance():Continue()
	end)
	arg_6_0:AddBtnListener(arg_6_0.exitBtn_, nil, function()
		arg_6_0.pauseController_:SetSelectedState("false")
		manager.audio:PlayEffect("minigame_fishing", "fishing_stopall", "")
		arg_6_0:Back()
	end)

	arg_6_0.onAnimationCompleteHandler_ = handler(arg_6_0, arg_6_0.OnAnimationComplete)
	arg_6_0.roleSpine_.AnimationState.Complete = arg_6_0.roleSpine_.AnimationState.Complete + arg_6_0.onAnimationCompleteHandler_
end

function var_0_1.OnAnimationComplete(arg_11_0, arg_11_1)
	if arg_11_1.Animation.Name == "PushButton" then
		arg_11_0:PlayRoleAnimation("look", true)
	end
end

function var_0_1.PlayRoleAnimation(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_0.curName_ ~= nil and arg_12_0.curName_ == arg_12_1 then
		return
	end

	arg_12_0.curName_ = arg_12_1

	arg_12_0.roleSpine_.AnimationState:SetAnimation(0, arg_12_1, arg_12_2)
end

function var_0_1.AddEventListeners(arg_13_0)
	return
end

function var_0_1.OnPause(arg_14_0)
	arg_14_0.pauseController_:SetSelectedState("true")

	arg_14_0.roleSpine_.AnimationState.TimeScale = 0
	arg_14_0.waterSpine_.AnimationState.TimeScale = 0
end

function var_0_1.OnContinue(arg_15_0)
	arg_15_0.pauseController_:SetSelectedState("false")

	arg_15_0.roleSpine_.AnimationState.TimeScale = 1
	arg_15_0.waterSpine_.AnimationState.TimeScale = 1
end

function var_0_1.OnScoreChange(arg_16_0)
	local var_16_0 = tonumber(arg_16_0.scoreLabel_.text)
	local var_16_1 = FishGameManager.GetInstance():GetScore()

	arg_16_0.tween_ = LeanTween.value(0, 1, 0.5):setOnUpdate(LuaHelper.FloatAction(function(arg_17_0)
		local var_17_0 = var_16_0 or 0
		local var_17_1 = var_16_1
		local var_17_2 = math.floor(var_17_0 + (var_17_1 - var_17_0) * arg_17_0)

		arg_16_0.scoreLabel_.text = tostring(var_17_2)
		arg_16_0.scoreLabelAnimation_.text = tostring(var_17_2)
	end)):setOnComplete(LuaHelper.VoidAction(function()
		if arg_16_0.tween_ then
			arg_16_0.tween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)

			arg_16_0.tween_ = nil
		end

		arg_16_0.scoreLabel_.text = tostring(FishGameManager.GetInstance():GetScore())
		arg_16_0.scoreLabelAnimation_.text = tostring(FishGameManager.GetInstance():GetScore())

		arg_16_0.scoreAnimator_:Play("fishing_scoring", -1, 0)
	end)):setEase(LeanTweenType.easeOutQuad)

	arg_16_0.bubbleNumController_:SetSelectedIndex(FishGameManager.GetInstance():GetTreasureLimitNum())
end

function var_0_1.OnScoreAdd(arg_19_0, arg_19_1)
	SetActive(arg_19_0.scoreGo_, true)
	arg_19_0.goalAnimator_:Play("FishGoal", -1, 0)

	arg_19_0.scoreAddLabel_.text = arg_19_1

	manager.audio:PlayEffect("minigame_fishing", "fishing_gain", "")
end

function var_0_1.OnBuffChange(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	if arg_20_2 == 1 then
		arg_20_0.curBuff_ = arg_20_1
		arg_20_0.curBuffMilliseconds_ = 20

		SetActive(arg_20_0.buffGo_, true)

		arg_20_0.buffNameLabel_.text = GetTips("ACTIVITY_FISHING_BUFF_NAME_" .. arg_20_1)
		arg_20_0.buffDescLabel_.text = GetTips("ACTIVITY_FISHING_BUFF_DESC_" .. arg_20_1)
		arg_20_0.buffProgress_.fillAmount = 1

		arg_20_0.buffController_:SetSelectedState(tostring(arg_20_1))

		if arg_20_1 == 1 then
			arg_20_0.doubleAnimator_:Play("ef_ui_buff_double", -1, 0)
		elseif arg_20_1 == 3 then
			arg_20_0.timeAnimator_:Play("ef_ui_buff_double", -1, 0)
		end
	elseif arg_20_2 == 0 then
		arg_20_0.buffController_:SetSelectedState("0")

		arg_20_0.curBuff_ = 0
		arg_20_0.curBuffMilliseconds_ = 0
		arg_20_0.buffProgress_.fillAmount = 0

		SetActive(arg_20_0.buffGo_, false)
	elseif arg_20_2 == 2 then
		if arg_20_0.curBuffMilliseconds_ > 0 then
			arg_20_0.curBuffMilliseconds_ = arg_20_0.curBuffMilliseconds_ - Time.deltaTime
		end

		if arg_20_0.curBuffMilliseconds_ < 0 then
			arg_20_0.curBuffMilliseconds_ = 0
		end

		arg_20_0.buffProgress_.fillAmount = arg_20_0.curBuffMilliseconds_ / 20
	end
end

function var_0_1.OnTop(arg_21_0)
	arg_21_0:UpdateBar()
end

function var_0_1.UpdateBar(arg_22_0)
	return
end

function var_0_1.RegisterEvents(arg_23_0)
	return
end

function var_0_1.OnEnter(arg_24_0)
	arg_24_0:AddEventListeners()

	local var_24_0 = AssetEx.LoadText("Fishing/fishData.json")

	arg_24_0.fishData_ = var_0_0.decode(var_24_0)

	FishGameManager.GetInstance():Init(arg_24_0, arg_24_0.container_)
	FishGameManager.GetInstance():SetHook(arg_24_0.hook_)

	local var_24_1 = math.random(1, arg_24_0.fishData_.levelNum)
	local var_24_2 = arg_24_0.fishData_.LevelInfos[var_24_1].fishes

	for iter_24_0, iter_24_1 in ipairs(var_24_2) do
		local var_24_3 = Asset.Load("UI/Fishing/Game/Fishes/" .. iter_24_1.fishId)
		local var_24_4 = Object.Instantiate(var_24_3, arg_24_0.container_)

		var_24_4.transform.localPosition = Vector2(iter_24_1.posX + var_24_4.transform.rect.width / 2, -iter_24_1.posY - var_24_4.transform.rect.height / 2)
		var_24_4.transform.localScale = Vector3.New(iter_24_1.scaleX / 1000, iter_24_1.scaleY / 1000, 0)

		local var_24_5 = FishItem.New(var_24_4)

		var_24_5:SetData(iter_24_1)
		FishGameManager.GetInstance():AddFish(var_24_5)
	end

	arg_24_0:RegisterEvents()
	SetActive(arg_24_0.buffGo_, false)

	arg_24_0.scoreLabel_.text = "0"
	arg_24_0.scoreLabelAnimation_.text = "0"

	FishGameManager.GetInstance():Start()
	manager.audio:PlayBGM("bgm_activity_1_2_summer1_minigame_fishing", "bgm_activity_1_2_summer1_minigame_fishing", "bgm_activity_1_2_summer1_minigame_fishing.awb")
	manager.audio:PlayEffect("minigame_fishing", "fishing_wave", "")

	arg_24_0.levelId_ = arg_24_0.fishData_.LevelInfos[var_24_1].levelId
	arg_24_0.oriFrame_ = GameLocalData:GetCommonModule("userSetting").frame or PictureQualitySettingCfg[5].frame

	if arg_24_0.oriFrame_ ~= 1 then
		SettingAction.ChangePicSetting("frame", 1)
	end
end

local var_0_2 = "notPlayed"

function var_0_1.Update(arg_25_0)
	if arg_25_0.end_ then
		arg_25_0.roleSpine_.AnimationState.TimeScale = 0
		arg_25_0.waterSpine_.AnimationState.TimeScale = 0

		return
	end

	local var_25_0 = FishGameManager.GetInstance():GetStatus()

	if var_25_0 == "cast" then
		if var_0_2 == "notPlayed" then
			arg_25_0:PlayRoleAnimation("PushButton", false)

			var_0_2 = "playing"
		end
	elseif var_25_0 == "catch" then
		var_0_2 = "notPlayed"

		arg_25_0:PlayRoleAnimation("Happy", true)
	elseif var_25_0 == "fail" then
		var_0_2 = "notPlayed"

		arg_25_0:PlayRoleAnimation("Sad", true)
	elseif var_25_0 == "idle" then
		var_0_2 = "notPlayed"

		arg_25_0:PlayRoleAnimation("idle", true)
	end

	local var_25_1 = FishGameManager.GetInstance():GetSeconds()

	if var_25_1 < 0 then
		var_25_1 = 0
	end

	arg_25_0.countdownLabel_.text = tostring(math.floor(var_25_1))

	if FishGameManager.GetInstance():GetIsEnd() then
		arg_25_0.end_ = true

		if ActivityTools.ActivityOpenCheckByMessageBox(ActivityConst.SUMMER_FISHING, function()
			JumpTools.OpenPageByJump("/fishingEnter", {
				activityId = ActivityConst.SUMMER_FISHING
			})
		end) then
			FishingAction.EndingFishing(ActivityConst.SUMMER_FISHING, FishGameManager.GetInstance():GetScore(), FishGameManager.GetInstance():GetTreasureNum(), function(arg_27_0, arg_27_1)
				local var_27_0 = {}

				for iter_27_0, iter_27_1 in ipairs(arg_27_1) do
					local var_27_1 = {
						id = iter_27_1.id,
						num = iter_27_1.num,
						len = iter_27_1.length
					}

					table.insert(var_27_0, var_27_1)
				end

				JumpTools.OpenPageByJump("fishEnding", {
					score = FishGameManager.GetInstance():GetScore(),
					gainScore = arg_27_0,
					fishes = var_27_0,
					callback = function()
						arg_25_0:Back()
					end
				})
			end)
		end
	end

	arg_25_0.bubbleNumController_:SetSelectedIndex(FishGameManager.GetInstance():GetTreasureLimitNum())
end

function var_0_1.GetBubbleTarget(arg_29_0)
	if FishGameManager.GetInstance():GetTreasureLimitNum() == 1 then
		return arg_29_0.iconTransform1_
	end

	return arg_29_0.iconTransform2_
end

function var_0_1.AppearBubble(arg_30_0, arg_30_1)
	arg_30_0[string.format("iconTransform%d_", arg_30_1)]:GetComponent(typeof(CanvasGroup)).alpha = 1
end

function var_0_1.OnExit(arg_31_0)
	arg_31_0:RemoveAllEventListener()
	FishGameManager.GetInstance():Dispose()
	manager.windowBar:HideBar()
	manager.audio:StopEffect()

	if arg_31_0.oriFrame_ and arg_31_0.oriFrame_ ~= 1 then
		SettingAction.ChangePicSetting("frame", arg_31_0.oriFrame_)
	end
end

function var_0_1.OnMainHomeViewTop(arg_32_0)
	return
end

function var_0_1.Cacheable(arg_33_0)
	return false
end

function var_0_1.Dispose(arg_34_0)
	AnimatorTools.Stop()
	FishGameManager.GetInstance():Dispose()

	arg_34_0.roleSpine_.AnimationState.Complete = arg_34_0.roleSpine_.AnimationState.Complete - arg_34_0.onAnimationCompleteHandler_

	if arg_34_0.tween_ then
		arg_34_0.tween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(arg_34_0.tween_.id)

		arg_34_0.tween_ = nil
	end

	var_0_1.super.Dispose(arg_34_0)
end

return var_0_1
