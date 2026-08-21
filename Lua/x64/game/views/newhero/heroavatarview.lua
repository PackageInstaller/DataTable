local var_0_0 = class("HeroAvatarView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.handler_ = arg_1_1
	arg_1_0.gameObject_ = arg_1_2
	arg_1_0.transform_ = arg_1_2.transform
	arg_1_0.isShowInteractive_ = false
	arg_1_0.isEnterToThisView = true

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0.playable_ = arg_3_0:FindCom(typeof(PlayableDirector), "")
	arg_3_0.backGo_ = arg_3_0:FindGo("back")
	arg_3_0.cameraPosOffSet_ = Vector3.zero
	arg_3_0.cameraRotateOffSet_ = Vector3.zero
end

function var_0_0.SetShowInteractive(arg_4_0, arg_4_1)
	arg_4_0.isShowInteractive_ = arg_4_1

	if arg_4_1 then
		if arg_4_0.interactionTimer_ then
			arg_4_0.interactionTimer_:Reset()
		end

		if arg_4_0.timer_ then
			arg_4_0.timer_:Reset()
		end
	end
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddDragListener(arg_5_0.backGo_, function()
		if arg_5_0.heroModel_ then
			arg_5_0.startRot_ = arg_5_0.rotateNode_.localEulerAngles
		else
			arg_5_0.startRot_ = Vector3.zero
		end

		arg_5_0.lastRotateY_ = nil
		arg_5_0.lastDeltaX_ = 0
	end, function(arg_7_0, arg_7_1)
		if arg_5_0.heroModel_ then
			local var_7_0 = arg_5_0.lastRotateY_ or arg_5_0.rotateNode_.localEulerAngles.y
			local var_7_1 = var_7_0 + (arg_7_0 - (arg_5_0.lastDeltaX_ or 0)) * HeroConst.ROTATE_RATIO - var_7_0
			local var_7_2 = var_7_1

			if var_7_1 < -HeroConst.MAX_RORATE_ANGLE then
				var_7_2 = -HeroConst.MAX_RORATE_ANGLE
			elseif var_7_1 > HeroConst.MAX_RORATE_ANGLE then
				var_7_2 = HeroConst.MAX_RORATE_ANGLE
			end

			arg_5_0.lastRotateY_ = var_7_0 + var_7_2
			arg_5_0.lastDeltaX_ = arg_7_0
			arg_5_0.rotateNode_.localRotation = Quaternion.RotateTowards(arg_5_0.rotateNode_.localRotation, Quaternion.Euler(arg_5_0.startRot_.x, var_7_0 + var_7_2, arg_5_0.startRot_.z), HeroConst.MAX_RORATE_ANGLE)
		end
	end)
end

function var_0_0.SetSkinId(arg_8_0, arg_8_1)
	if arg_8_0.skinId_ == arg_8_1 then
		return
	end

	arg_8_0:Finish()

	local var_8_0 = SkinCfg[arg_8_1].hero

	manager.audio:AddCue("voice", string.format("vo_sys_%d", var_8_0), true)
	arg_8_0:LoadModel(arg_8_1)

	arg_8_0.isShow_ = true
	arg_8_0.skinId_ = arg_8_1

	local var_8_1 = arg_8_0.interactiveSkinId_ == nil

	arg_8_0.interactiveSkinId_ = arg_8_1

	if not arg_8_0.isShowInteractive_ then
		return
	end

	HeroTools.StopTalk()

	if arg_8_0.talkDelayTimer_ then
		arg_8_0.talkDelayTimer_:Stop()

		arg_8_0.talkDelayTimer_ = nil
	end

	arg_8_0.playingInteraction_ = false

	if var_8_1 then
		if arg_8_0.isEnterToThisView then
			arg_8_0.isEnterToThisView = false

			arg_8_0:PlayInteractionAnimation("roleChange")
		end
	else
		if arg_8_0.interactionTimer_ then
			arg_8_0.interactionTimer_:Stop()

			arg_8_0.interactionTimer_ = nil
		end

		arg_8_0.interactionTimer_ = TimeTools.StartAfterSeconds(1, handler(arg_8_0, arg_8_0.PlayInteractionAnimation), {
			"roleChange"
		})
	end

	if arg_8_0.timer_ then
		arg_8_0.timer_:Reset()
	end
end

function var_0_0.PlayChangeRoleInteraction(arg_9_0)
	arg_9_0:PlayInteractionAnimation("roleChange")
end

function var_0_0.SetCameraToPage(arg_10_0, arg_10_1)
	local var_10_0 = CameraCfg[arg_10_1]

	manager.ui.mainCamera.transform.localPosition = Vector3(var_10_0.position[1], var_10_0.position[2], var_10_0.position[3])
	manager.ui.mainCamera.transform.localEulerAngles = Vector3(var_10_0.rotate[1], var_10_0.rotate[2], var_10_0.rotate[3])
	manager.ui.mainCameraCom_.fieldOfView = var_10_0.fieldOfView
end

function var_0_0.ShowHeroModel(arg_11_0, arg_11_1)
	arg_11_0.isShow_ = arg_11_1

	if arg_11_0.heroModel_ then
		SetActive(arg_11_0.heroModel_, arg_11_1)
		manager.resourcePool:ResetBlendShapes(arg_11_0.heroModel_)
	end

	SetActive(arg_11_0.backGo_, arg_11_1)
end

function var_0_0.GetHeroModelIsShow(arg_12_0)
	return arg_12_0.isShow_
end

function var_0_0.SwitchCameraToWeapon(arg_13_0)
	local var_13_0 = CameraCfg.hero2

	manager.ui.mainCamera.transform.localPosition = Vector3(var_13_0.position[1], var_13_0.position[2], var_13_0.position[3])
	manager.ui.mainCamera.transform.localEulerAngles = Vector3(var_13_0.rotate[1], var_13_0.rotate[2], var_13_0.rotate[3])
	manager.ui.mainCameraCom_.fieldOfView = var_13_0.fieldOfView
end

function var_0_0.SwitchCameraToCurrentHero(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0.go_

	if var_14_0 == nil then
		return
	end

	local var_14_1 = var_14_0:GetComponent("UIPoseMoveController")

	var_14_0.transform.localPosition = var_14_1:GetInitPosition()
	var_14_0.transform.localEulerAngles = var_14_1:GetInitRotation()
	var_14_0.transform.localScale = Vector3(1, 1, 1)

	if arg_14_1 then
		local var_14_2 = var_14_1:GetTweenTime()
		local var_14_3 = manager.ui.mainCamera
		local var_14_4 = var_14_3.transform.localPosition.x
		local var_14_5 = var_14_3.transform.localPosition.y
		local var_14_6 = var_14_3.transform.localPosition.z
		local var_14_7 = var_14_3.transform.localEulerAngles.x
		local var_14_8 = var_14_3.transform.localEulerAngles.y
		local var_14_9 = var_14_3.transform.localEulerAngles.z
		local var_14_10 = manager.ui.mainCameraCom_.fieldOfView
		local var_14_11 = var_14_1:GetCameraPosition() + arg_14_0.cameraPosOffSet_
		local var_14_12 = var_14_1:GetCameraRotation() + arg_14_0.cameraRotateOffSet_
		local var_14_13 = var_14_11.x
		local var_14_14 = var_14_11.y
		local var_14_15 = var_14_11.z
		local var_14_16 = var_14_12.x
		local var_14_17 = var_14_12.y
		local var_14_18 = var_14_12.z
		local var_14_19 = var_14_1:GetCameraFOV()

		arg_14_0:RemoveTween()

		arg_14_0.tweenValue_ = LeanTween.value(0, 1, var_14_2):setOnUpdate(LuaHelper.FloatAction(function(arg_15_0)
			local var_15_0 = Vector3(Mathf.Lerp(var_14_4, var_14_13, arg_15_0), Mathf.Lerp(var_14_5, var_14_14, arg_15_0), Mathf.Lerp(var_14_6, var_14_15, arg_15_0))
			local var_15_1 = Vector3(Mathf.Lerp(var_14_7, var_14_16, arg_15_0), Mathf.Lerp(var_14_8, var_14_17, arg_15_0), Mathf.Lerp(var_14_9, var_14_18, arg_15_0))
			local var_15_2 = Mathf.Lerp(var_14_10, var_14_19, arg_15_0)

			var_14_3.transform.localPosition = var_15_0
			var_14_3.transform.localEulerAngles = var_15_1
			manager.ui.mainCameraCom_.fieldOfView = var_15_2
		end)):setOnComplete(LuaHelper.VoidAction(function()
			arg_14_0:RemoveTween()
		end)):setEase(LeanTweenType.easeOutQuad)
	else
		manager.ui.mainCamera.transform.localPosition = var_14_1:GetCameraPosition() + arg_14_0.cameraPosOffSet_
		manager.ui.mainCamera.transform.localEulerAngles = var_14_1:GetCameraRotation() + arg_14_0.cameraRotateOffSet_
		manager.ui.mainCameraCom_.fieldOfView = var_14_1:GetCameraFOV()
	end
end

function var_0_0.SetCameraOffset(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0.cameraPosOffSet_ = arg_17_1
	arg_17_0.cameraRotateOffSet_ = arg_17_2
end

function var_0_0.ClearOffset(arg_18_0)
	arg_18_0.cameraPosOffSet_ = Vector3.zero
	arg_18_0.cameraRotateOffSet_ = Vector3.zero
end

function var_0_0.RemoveTween(arg_19_0)
	if arg_19_0.tweenValue_ then
		arg_19_0.tweenValue_:setOnComplete(nil):setOnUpdate(nil):setEase(nil)
		LeanTween.cancel(arg_19_0.tweenValue_.id)

		arg_19_0.tweenValue_ = nil
	end
end

function var_0_0.Finish(arg_20_0)
	if arg_20_0.animator_ then
		if arg_20_0.playable_ then
			arg_20_0.playable_:Stop()
		end

		local var_20_0 = arg_20_0.animator_.gameObject:GetComponent("LipSync")

		if var_20_0 then
			var_20_0:ResetEmotion(0)
		end
	end

	arg_20_0.skinId_ = nil

	if arg_20_0.heroModel_ then
		arg_20_0:RefreshActive()
		manager.resourcePool:DestroyOrReturn(arg_20_0.heroModel_, ASSET_TYPE.TPOSE)

		arg_20_0.heroModel_ = nil
		arg_20_0.animator_ = nil
		arg_20_0.weapomNode_ = nil
		arg_20_0.weapomNode2_ = nil
		arg_20_0.weapomNode3_ = nil
	end
end

function var_0_0.RefreshActive(arg_21_0)
	if arg_21_0.weapomNode_ then
		SetActive(arg_21_0.weapomNode_, true)
	end

	if arg_21_0.weapomNode2_ then
		SetActive(arg_21_0.weapomNode2_, true)
	end

	if arg_21_0.weapomNode3_ then
		SetActive(arg_21_0.weapomNode3_, true)
	end
end

function var_0_0.LoadModel(arg_22_0, arg_22_1)
	local var_22_0 = SkinCfg[arg_22_1]
	local var_22_1 = manager.resourcePool:Get("Char/" .. var_22_0.modelId, ASSET_TYPE.TPOSE)

	arg_22_0.go_ = var_22_1

	local var_22_2 = var_22_1:GetComponent("UIPoseMoveController")

	var_22_1.transform.localPosition = var_22_2:GetInitPosition()
	var_22_1.transform.localEulerAngles = var_22_2:GetInitRotation()
	var_22_1.transform.localScale = Vector3(1, 1, 1)

	arg_22_0:SwitchCameraToCurrentHero(arg_22_0.isShow_)
	arg_22_0:InitModel(var_22_1, var_22_0.id)
end

function var_0_0.InitModel(arg_23_0, arg_23_1, arg_23_2)
	arg_23_0.heroModel_ = arg_23_1

	local var_23_0 = SkinCfg[arg_23_2]

	arg_23_0.animator_ = arg_23_0:FindCom(typeof(Animator), "", arg_23_0.heroModel_.transform)

	local var_23_1 = arg_23_0:FindTrs(string.format("%dui/%dui_tpose", arg_23_2, arg_23_2), arg_23_0.heroModel_.transform)

	if var_23_1 then
		if arg_23_0.animator_ == nil then
			arg_23_0.animator_ = arg_23_0:FindCom(typeof(Animator), "", var_23_1)
		end

		HeroTools.SetHeroModelWeaponActivity(var_23_1, true)
	end

	arg_23_0.rotateNode_ = arg_23_0:FindTrs(string.format("%dui", arg_23_2), arg_23_0.heroModel_.transform)
	arg_23_0.rotateNode_.localEulerAngles = Vector3.zero

	if arg_23_0.animator_ then
		arg_23_0:PlayAction("ui_stand")
	end

	if not arg_23_0.firstAppeared_ then
		arg_23_0.firstAppeared_ = true

		arg_23_0:PlayEffect()
	else
		arg_23_0:PlayEffect()
	end
end

function var_0_0.PlayEffect(arg_24_0)
	manager.audio:PlayUIAudioByVoice("hero_change")
	LuaForUtil.PlayEffect(arg_24_0.heroModel_.transform, "Effect/tongyong/fx_appear_UI", Vector3(0, 0, 0), Vector3(1, 1, 1), Vector3(0, 0, 0), Vector3(0, 0, 0), false, 1, 0, 0.8)
end

function var_0_0.TimerToPlayMainAnimation(arg_25_0)
	if arg_25_0.timer_ == nil then
		arg_25_0.timer_ = Timer.New(function()
			arg_25_0:PlayInteractionAnimation("roleIdle")
		end, 30, -1)
	end

	arg_25_0.timer_:Start()
end

function var_0_0.ResetTimer(arg_27_0)
	if arg_27_0.timer_ then
		arg_27_0.timer_:Reset()
	end
end

function var_0_0.StopTimer(arg_28_0)
	if arg_28_0.timer_ then
		arg_28_0.timer_:Stop()

		arg_28_0.timer_ = nil
	end
end

function var_0_0.OnPlayHeroSound(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	if arg_29_0.curTalkHeroId_ == arg_29_1 and arg_29_0.curTalkType_ == arg_29_2 and arg_29_0.systemType_ == arg_29_3 then
		return
	end

	arg_29_0:PlayAction("ui_stand")
end

function var_0_0.OnEnter(arg_30_0)
	arg_30_0.pause_ = false

	arg_30_0:TimerToPlayMainAnimation()

	arg_30_0.handler_ = handler(arg_30_0, arg_30_0.OnPlayHeroSound)

	manager.notify:RegistListener(HERO_SOUND_PLAY, arg_30_0.handler_)
end

function var_0_0.OnExit(arg_31_0)
	arg_31_0:RemoveTween()
	manager.notify:RemoveListener(HERO_SOUND_PLAY, arg_31_0.handler_)

	if arg_31_0.interactionTimer_ then
		arg_31_0.interactionTimer_:Stop()

		arg_31_0.interactionTimer_ = nil
	end

	arg_31_0.handler_ = nil
	arg_31_0.isShow_ = false
	arg_31_0.firstAppeared_ = false
	arg_31_0.playingInteraction_ = false
	arg_31_0.interactiveSkinId_ = nil
	arg_31_0.pause_ = true

	AnimatorTools.Stop()
	arg_31_0:Finish()
	arg_31_0:StopTimer()

	if arg_31_0.isShowInteractive_ then
		HeroTools.StopTalk()
	end

	arg_31_0:ClearOffset()
end

function var_0_0.OnTop(arg_32_0)
	print("OnTop")

	arg_32_0.pause_ = false
end

function var_0_0.OnBehind(arg_33_0)
	print("OnBehind")

	arg_33_0.pause_ = true
end

function var_0_0.PlayAction(arg_34_0, arg_34_1)
	if arg_34_0.animator_ == nil then
		return
	end

	AnimatorTools.CrossFade(arg_34_0.animator_, arg_34_1)
end

function var_0_0.PlayInteractionAnimation(arg_35_0, arg_35_1)
	if not arg_35_0.isShowInteractive_ then
		return
	end

	if arg_35_0.pause_ then
		return
	end

	if arg_35_0.interactionTimer_ then
		arg_35_0.interactionTimer_:Stop()

		arg_35_0.interactionTimer_ = nil
	end

	local var_35_0 = SkinCfg[arg_35_0.interactiveSkinId_].hero
	local var_35_1 = HeroTools.GetOldInteractionCfg(skinID)

	if var_35_1 and var_35_1[arg_35_1 .. "_talk"] ~= nil and #var_35_1[arg_35_1 .. "_talk"] > 0 then
		local var_35_2 = #var_35_1[arg_35_1] > 0

		if #var_35_1[arg_35_1 .. "_talk"] == 1 then
			arg_35_0:PlaySpecialAnimation(var_35_2 and var_35_1[arg_35_1][1] or nil, var_35_1[arg_35_1 .. "_talk"][1], var_35_1[arg_35_1 .. "_delay"][1])
		else
			local var_35_3 = arg_35_0:RandomIndexOfInteractionType(arg_35_1 .. "_talk")

			arg_35_0:PlaySpecialAnimation(var_35_2 and var_35_1[arg_35_1][var_35_3] or nil, var_35_1[arg_35_1 .. "_talk"][var_35_3], var_35_1[arg_35_1 .. "_delay"][var_35_3])
		end
	else
		print(string.format("%d这个皮肤没有配置%s的声音，请检查hero_interaction表", arg_35_0.interactiveSkinId_, arg_35_1))
	end
end

function var_0_0.RandomIndexOfInteractionType(arg_36_0, arg_36_1)
	local var_36_0 = tostring(arg_36_0.interactiveSkinId_) .. "_" .. arg_36_1

	if not arg_36_0.lastRandom_ then
		arg_36_0.lastRandom_ = {}
	end

	local var_36_1 = SkinCfg[arg_36_0.interactiveSkinId_].hero
	local var_36_2 = HeroTools.GetOldInteractionCfg(skinID)
	local var_36_3 = arg_36_0.lastRandom_[var_36_0] or 0
	local var_36_4 = {}
	local var_36_5 = {}

	for iter_36_0, iter_36_1 in ipairs(var_36_2[arg_36_1]) do
		if iter_36_0 ~= var_36_3 then
			table.insert(var_36_4, iter_36_1)
			table.insert(var_36_5, iter_36_0)
		end
	end

	local var_36_6 = #var_36_5
	local var_36_7 = math.round(math.random(var_36_6))

	arg_36_0.lastRandom_[var_36_0] = var_36_7

	return var_36_7
end

function var_0_0.PlaySpecialAnimation(arg_37_0, arg_37_1, arg_37_2, arg_37_3)
	if arg_37_0.playingInteraction_ then
		return
	end

	if arg_37_0.interactionTimer_ then
		arg_37_0.interactionTimer_:Reset()
	end

	if arg_37_0.timer_ then
		arg_37_0.timer_:Reset()
	end

	if arg_37_0.animator_ ~= nil and arg_37_1 ~= nil then
		AnimatorTools.PlayAnimationWithCallback(arg_37_0.animator_, arg_37_1, handler(arg_37_0, arg_37_0.OnPlaySpecialCallback))

		arg_37_0.playingInteraction_ = true
	else
		arg_37_0.playingInteraction_ = false
	end

	arg_37_0.curTalkHeroId_ = SkinCfg[arg_37_0.interactiveSkinId_].hero
	arg_37_0.curTalkType_ = arg_37_2
	arg_37_0.systemType_ = 1

	local var_37_0 = string.split(arg_37_0.curTalkType_, "_")

	print(string.format("播放%d的%s动作，声音为%s， 延迟为 %d 毫秒", arg_37_0.skinId_, tostring(arg_37_1), tostring(arg_37_2), arg_37_3))

	local var_37_1

	if arg_37_0.animator_ then
		var_37_1 = arg_37_0.animator_.transform
	end

	if arg_37_3 > 0 then
		if arg_37_0.talkDelayTimer_ then
			arg_37_0.talkDelayTimer_:Stop()

			arg_37_0.talkDelayTimer_ = nil
		end

		arg_37_0.talkDelayTimer_ = Timer.New(function()
			HeroTools.PlayTalk(var_37_0[1], var_37_0[2], nil, var_37_1)
		end, arg_37_3 / 1000)

		arg_37_0.talkDelayTimer_:Start()
	else
		HeroTools.PlayTalk(var_37_0[1], var_37_0[2], nil, var_37_1)
	end
end

function var_0_0.OnPlaySpecialCallback(arg_39_0)
	arg_39_0.playingInteraction_ = false

	arg_39_0:PlayAction("ui_stand")
end

function var_0_0.OnMainHomeViewTop(arg_40_0)
	arg_40_0.isEnterToThisView = true
end

function var_0_0.Dispose(arg_41_0)
	arg_41_0:RemoveAllListeners()
	arg_41_0:Finish()
	var_0_0.super.Dispose(arg_41_0)
end

return var_0_0
