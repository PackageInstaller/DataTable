local HeroAvatarView = class("HeroAvatarView", ReduxView)

function HeroAvatarView:OnCtor(arg_1_1, arg_1_2)
	self.handler_ = arg_1_1
	self.gameObject_ = arg_1_2
	self.transform_ = arg_1_2.transform
	self.isShowInteractive_ = false
	self.isEnterToThisView = true

	self:Init()
end

function HeroAvatarView:Init()
	self:InitUI()
	self:AddUIListener()
end

function HeroAvatarView:InitUI()
	self.playable_ = self:FindCom(typeof(PlayableDirector), "")
	self.backGo_ = self:FindGo("back")
	self.cameraPosOffSet_ = Vector3.zero
	self.cameraRotateOffSet_ = Vector3.zero
end

function HeroAvatarView:SetShowInteractive(arg_4_1)
	self.isShowInteractive_ = arg_4_1

	if arg_4_1 then
		if self.interactionTimer_ then
			self.interactionTimer_:Reset()
		end

		if self.timer_ then
			self.timer_:Reset()
		end
	end
end

function HeroAvatarView:AddUIListener()
	self:AddDragListener(self.backGo_, function()
		self.startRot_ = self.heroModel_ and self.rotateNode_.localEulerAngles or Vector3.zero
		self.lastRotateY_ = nil
		self.lastDeltaX_ = 0
	end, function(arg_7_0, arg_7_1)
		if self.heroModel_ then
			local var_7_0 = self.lastRotateY_ or self.rotateNode_.localEulerAngles.y
			local var_7_1 = var_7_0 + (arg_7_0 - (self.lastDeltaX_ or 0)) * HeroConst.ROTATE_RATIO - var_7_0

			if var_7_0 + (arg_7_0 - (self.lastDeltaX_ or 0)) * HeroConst.ROTATE_RATIO - var_7_0 < -HeroConst.MAX_RORATE_ANGLE then
				var_7_1 = -HeroConst.MAX_RORATE_ANGLE
			elseif var_7_0 + (arg_7_0 - (self.lastDeltaX_ or 0)) * HeroConst.ROTATE_RATIO - var_7_0 > HeroConst.MAX_RORATE_ANGLE then
				var_7_1 = HeroConst.MAX_RORATE_ANGLE
			end

			self.lastRotateY_ = var_7_0 + var_7_1
			self.lastDeltaX_ = arg_7_0
			self.rotateNode_.localRotation = Quaternion.RotateTowards(self.rotateNode_.localRotation, Quaternion.Euler(self.startRot_.x, var_7_0 + var_7_1, self.startRot_.z), HeroConst.MAX_RORATE_ANGLE)
		end
	end)
end

function HeroAvatarView:SetSkinId(arg_8_1)
	if self.skinId_ == arg_8_1 then
		return
	end

	self:Finish()
	manager.audio:AddCue("voice", string.format("vo_sys_%d", SkinCfg[arg_8_1].hero), true)
	self:LoadModel(arg_8_1)

	self.isShow_ = true
	self.skinId_ = arg_8_1

	local var_8_0 = self.interactiveSkinId_ == nil

	self.interactiveSkinId_ = arg_8_1

	if not self.isShowInteractive_ then
		return
	end

	HeroTools.StopTalk()

	if self.talkDelayTimer_ then
		self.talkDelayTimer_:Stop()

		self.talkDelayTimer_ = nil
	end

	self.playingInteraction_ = false

	if var_8_0 then
		if self.isEnterToThisView then
			self.isEnterToThisView = false

			self:PlayInteractionAnimation("roleChange")
		end
	else
		if self.interactionTimer_ then
			self.interactionTimer_:Stop()

			self.interactionTimer_ = nil
		end

		self.interactionTimer_ = TimeTools.StartAfterSeconds(1, handler(self, self.PlayInteractionAnimation), {
			"roleChange"
		})
	end

	if self.timer_ then
		self.timer_:Reset()
	end
end

function HeroAvatarView:PlayChangeRoleInteraction()
	self:PlayInteractionAnimation("roleChange")
end

function HeroAvatarView:SetCameraToPage(arg_10_1)
	manager.ui.mainCamera.transform.localPosition = Vector3(CameraCfg[arg_10_1].position[1], CameraCfg[arg_10_1].position[2], CameraCfg[arg_10_1].position[3])
	manager.ui.mainCamera.transform.localEulerAngles = Vector3(CameraCfg[arg_10_1].rotate[1], CameraCfg[arg_10_1].rotate[2], CameraCfg[arg_10_1].rotate[3])
	manager.ui.mainCameraCom_.fieldOfView = CameraCfg[arg_10_1].fieldOfView
end

function HeroAvatarView:ShowHeroModel(arg_11_1)
	self.isShow_ = arg_11_1

	if self.heroModel_ then
		SetActive(self.heroModel_, arg_11_1)
		manager.resourcePool:ResetBlendShapes(self.heroModel_)
	end

	SetActive(self.backGo_, arg_11_1)
end

function HeroAvatarView:GetHeroModelIsShow()
	return self.isShow_
end

function HeroAvatarView:SwitchCameraToWeapon()
	manager.ui.mainCamera.transform.localPosition = Vector3(CameraCfg.hero2.position[1], CameraCfg.hero2.position[2], CameraCfg.hero2.position[3])
	manager.ui.mainCamera.transform.localEulerAngles = Vector3(CameraCfg.hero2.rotate[1], CameraCfg.hero2.rotate[2], CameraCfg.hero2.rotate[3])
	manager.ui.mainCameraCom_.fieldOfView = CameraCfg.hero2.fieldOfView
end

function HeroAvatarView:SwitchCameraToCurrentHero(arg_14_1)
	if self.go_ == nil then
		return
	end

	local var_14_0 = self.go_:GetComponent("UIPoseMoveController")

	self.go_.transform.localPosition = var_14_0:GetInitPosition()
	self.go_.transform.localEulerAngles = var_14_0:GetInitRotation()
	self.go_.transform.localScale = Vector3(1, 1, 1)

	if arg_14_1 then
		local var_14_1 = manager.ui.mainCamera
		local var_14_2 = manager.ui.mainCamera.transform.localPosition.x
		local var_14_3 = manager.ui.mainCamera.transform.localPosition.y
		local var_14_4 = manager.ui.mainCamera.transform.localPosition.z
		local var_14_5 = manager.ui.mainCamera.transform.localEulerAngles.x
		local var_14_6 = manager.ui.mainCamera.transform.localEulerAngles.y
		local var_14_7 = manager.ui.mainCamera.transform.localEulerAngles.z
		local var_14_8 = manager.ui.mainCameraCom_.fieldOfView
		local var_14_9 = var_14_0:GetCameraPosition() + self.cameraPosOffSet_
		local var_14_10 = var_14_0:GetCameraRotation() + self.cameraRotateOffSet_
		local var_14_11 = var_14_9.x
		local var_14_12 = var_14_9.y
		local var_14_13 = var_14_9.z
		local var_14_14 = var_14_10.x
		local var_14_15 = var_14_10.y
		local var_14_16 = var_14_10.z
		local var_14_17 = var_14_0:GetCameraFOV()

		self:RemoveTween()

		self.tweenValue_ = LeanTween.value(0, 1, (var_14_0:GetTweenTime())):setOnUpdate(LuaHelper.FloatAction(function(arg_15_0)
			var_14_1.transform.localPosition = Vector3(Mathf.Lerp(var_14_2, var_14_11, arg_15_0), Mathf.Lerp(var_14_3, var_14_12, arg_15_0), Mathf.Lerp(var_14_4, var_14_13, arg_15_0))
			var_14_1.transform.localEulerAngles = Vector3(Mathf.Lerp(var_14_5, var_14_14, arg_15_0), Mathf.Lerp(var_14_6, var_14_15, arg_15_0), Mathf.Lerp(var_14_7, var_14_16, arg_15_0))
			manager.ui.mainCameraCom_.fieldOfView = Mathf.Lerp(var_14_8, var_14_17, arg_15_0)
		end)):setOnComplete(LuaHelper.VoidAction(function()
			self:RemoveTween()
		end)):setEase(LeanTweenType.easeOutQuad)
	else
		manager.ui.mainCamera.transform.localPosition = var_14_0:GetCameraPosition() + self.cameraPosOffSet_
		manager.ui.mainCamera.transform.localEulerAngles = var_14_0:GetCameraRotation() + self.cameraRotateOffSet_
		manager.ui.mainCameraCom_.fieldOfView = var_14_0:GetCameraFOV()
	end
end

function HeroAvatarView:SetCameraOffset(arg_17_1, arg_17_2)
	self.cameraPosOffSet_ = arg_17_1
	self.cameraRotateOffSet_ = arg_17_2
end

function HeroAvatarView:ClearOffset()
	self.cameraPosOffSet_ = Vector3.zero
	self.cameraRotateOffSet_ = Vector3.zero
end

function HeroAvatarView:RemoveTween()
	if self.tweenValue_ then
		self.tweenValue_:setOnComplete(nil):setOnUpdate(nil):setEase(nil)
		LeanTween.cancel(self.tweenValue_.id)

		self.tweenValue_ = nil
	end
end

function HeroAvatarView:Finish()
	if self.animator_ then
		if self.playable_ then
			self.playable_:Stop()
		end

		local var_20_0 = self.animator_.gameObject:GetComponent("LipSync")

		if var_20_0 then
			var_20_0:ResetEmotion(0)
		end
	end

	self.skinId_ = nil

	if self.heroModel_ then
		self:RefreshActive()
		manager.resourcePool:DestroyOrReturn(self.heroModel_, ASSET_TYPE.TPOSE)

		self.heroModel_ = nil
		self.animator_ = nil
		self.weapomNode_ = nil
		self.weapomNode2_ = nil
		self.weapomNode3_ = nil
	end
end

function HeroAvatarView:RefreshActive()
	if self.weapomNode_ then
		SetActive(self.weapomNode_, true)
	end

	if self.weapomNode2_ then
		SetActive(self.weapomNode2_, true)
	end

	if self.weapomNode3_ then
		SetActive(self.weapomNode3_, true)
	end
end

function HeroAvatarView:LoadModel(arg_22_1)
	local var_22_0 = manager.resourcePool:Get("Char/" .. SkinCfg[arg_22_1].modelId, ASSET_TYPE.TPOSE)

	self.go_ = var_22_0

	local var_22_1 = var_22_0:GetComponent("UIPoseMoveController")

	var_22_0.transform.localPosition = var_22_1:GetInitPosition()
	var_22_0.transform.localEulerAngles = var_22_1:GetInitRotation()
	var_22_0.transform.localScale = Vector3(1, 1, 1)

	self:SwitchCameraToCurrentHero(self.isShow_)
	self:InitModel(var_22_0, SkinCfg[arg_22_1].id)
end

function HeroAvatarView:InitModel(arg_23_1, arg_23_2)
	self.heroModel_ = arg_23_1
	self.animator_ = self:FindCom(typeof(Animator), "", self.heroModel_.transform)

	local var_23_1 = self:FindTrs(string.format("%dui/%dui_tpose", arg_23_2, arg_23_2), self.heroModel_.transform)

	if var_23_1 then
		if self.animator_ == nil then
			self.animator_ = self:FindCom(typeof(Animator), "", var_23_1)
		end

		HeroTools.SetHeroModelWeaponActivity(var_23_1, true)
	end

	self.rotateNode_ = self:FindTrs(string.format("%dui", arg_23_2), self.heroModel_.transform)
	self.rotateNode_.localEulerAngles = Vector3.zero

	if self.animator_ then
		self:PlayAction("ui_stand")
	end

	if not self.firstAppeared_ then
		self.firstAppeared_ = true

		self:PlayEffect()
	else
		self:PlayEffect()
	end
end

function HeroAvatarView:PlayEffect()
	manager.audio:PlayUIAudioByVoice("hero_change")
	LuaForUtil.PlayEffect(self.heroModel_.transform, "Effect/tongyong/fx_appear_UI", Vector3(0, 0, 0), Vector3(1, 1, 1), Vector3(0, 0, 0), Vector3(0, 0, 0), false, 1, 0, 0.8)
end

function HeroAvatarView:TimerToPlayMainAnimation()
	if self.timer_ == nil then
		self.timer_ = Timer.New(function()
			self:PlayInteractionAnimation("roleIdle")
		end, 30, -1)
	end

	self.timer_:Start()
end

function HeroAvatarView:ResetTimer()
	if self.timer_ then
		self.timer_:Reset()
	end
end

function HeroAvatarView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function HeroAvatarView:OnPlayHeroSound(arg_29_1, arg_29_2, arg_29_3)
	if self.curTalkHeroId_ == arg_29_1 and self.curTalkType_ == arg_29_2 and self.systemType_ == arg_29_3 then
		return
	end

	self:PlayAction("ui_stand")
end

function HeroAvatarView:OnEnter()
	self.pause_ = false

	self:TimerToPlayMainAnimation()

	self.handler_ = handler(self, self.OnPlayHeroSound)

	manager.notify:RegistListener(HERO_SOUND_PLAY, self.handler_)
end

function HeroAvatarView:OnExit()
	self:RemoveTween()
	manager.notify:RemoveListener(HERO_SOUND_PLAY, self.handler_)

	if self.interactionTimer_ then
		self.interactionTimer_:Stop()

		self.interactionTimer_ = nil
	end

	self.handler_ = nil
	self.isShow_ = false
	self.firstAppeared_ = false
	self.playingInteraction_ = false
	self.interactiveSkinId_ = nil
	self.pause_ = true

	AnimatorTools.Stop()
	self:Finish()
	self:StopTimer()

	if self.isShowInteractive_ then
		HeroTools.StopTalk()
	end

	self:ClearOffset()
end

function HeroAvatarView:OnTop()
	print("OnTop")

	self.pause_ = false
end

function HeroAvatarView:OnBehind()
	print("OnBehind")

	self.pause_ = true
end

function HeroAvatarView:PlayAction(arg_34_1)
	if self.animator_ == nil then
		return
	end

	AnimatorTools.CrossFade(self.animator_, arg_34_1)
end

function HeroAvatarView:PlayInteractionAnimation(arg_35_1)
	if not self.isShowInteractive_ then
		return
	end

	if self.pause_ then
		return
	end

	if self.interactionTimer_ then
		self.interactionTimer_:Stop()

		self.interactionTimer_ = nil
	end

	local var_35_1 = HeroTools.GetOldInteractionCfg(skinID)

	if var_35_1 and var_35_1[arg_35_1 .. "_talk"] ~= nil and #var_35_1[arg_35_1 .. "_talk"] > 0 then
		local var_35_2 = #var_35_1[arg_35_1] > 0

		if #var_35_1[arg_35_1 .. "_talk"] == 1 then
			self:PlaySpecialAnimation((var_35_2 or nil) and (var_35_1[arg_35_1][1] or nil), var_35_1[arg_35_1 .. "_talk"][1], var_35_1[arg_35_1 .. "_delay"][1])
		else
			local var_35_3 = self:RandomIndexOfInteractionType(arg_35_1 .. "_talk")

			self:PlaySpecialAnimation((var_35_2 or nil) and (var_35_1[arg_35_1][var_35_3] or nil), var_35_1[arg_35_1 .. "_talk"][var_35_3], var_35_1[arg_35_1 .. "_delay"][var_35_3])
		end
	else
		print(string.format("%d这个皮肤没有配置%s的声音，请检查hero_interaction表", self.interactiveSkinId_, arg_35_1))
	end
end

function HeroAvatarView:RandomIndexOfInteractionType(arg_36_1)
	local var_36_0 = tostring(self.interactiveSkinId_) .. "_" .. arg_36_1

	self.lastRandom_ = self.lastRandom_ or {}

	local var_36_2 = self.lastRandom_[var_36_0] or 0
	local var_36_3 = {}
	local var_36_4 = {}

	for iter_36_0, iter_36_1 in ipairs(HeroTools.GetOldInteractionCfg(skinID)[arg_36_1]) do
		if iter_36_0 ~= var_36_2 then
			table.insert(var_36_3, iter_36_1)
			table.insert(var_36_4, iter_36_0)
		end
	end

	local var_36_5 = math.round(math.random(#var_36_4))

	self.lastRandom_[var_36_0] = var_36_5

	return var_36_5
end

function HeroAvatarView:PlaySpecialAnimation(arg_37_1, arg_37_2, arg_37_3)
	if self.playingInteraction_ then
		return
	end

	if self.interactionTimer_ then
		self.interactionTimer_:Reset()
	end

	if self.timer_ then
		self.timer_:Reset()
	end

	if self.animator_ ~= nil and arg_37_1 ~= nil then
		AnimatorTools.PlayAnimationWithCallback(self.animator_, arg_37_1, handler(self, self.OnPlaySpecialCallback))

		self.playingInteraction_ = true
	else
		self.playingInteraction_ = false
	end

	self.curTalkHeroId_ = SkinCfg[self.interactiveSkinId_].hero
	self.curTalkType_ = arg_37_2
	self.systemType_ = 1

	local var_37_0 = string.split(self.curTalkType_, "_")

	print(string.format("播放%d的%s动作，声音为%s， 延迟为 %d 毫秒", self.skinId_, tostring(arg_37_1), tostring(arg_37_2), arg_37_3))

	local var_37_1

	if self.animator_ then
		var_37_1 = self.animator_.transform
	end

	if arg_37_3 > 0 then
		if self.talkDelayTimer_ then
			self.talkDelayTimer_:Stop()

			self.talkDelayTimer_ = nil
		end

		self.talkDelayTimer_ = Timer.New(function()
			HeroTools.PlayTalk(var_37_0[1], var_37_0[2], nil, var_37_1)
		end, arg_37_3 / 1000)

		self.talkDelayTimer_:Start()
	else
		HeroTools.PlayTalk(var_37_0[1], var_37_0[2], nil, var_37_1)
	end
end

function HeroAvatarView:OnPlaySpecialCallback()
	self.playingInteraction_ = false

	self:PlayAction("ui_stand")
end

function HeroAvatarView:OnMainHomeViewTop()
	self.isEnterToThisView = true
end

function HeroAvatarView:Dispose()
	self:RemoveAllListeners()
	self:Finish()
	HeroAvatarView.super.Dispose(self)
end

return HeroAvatarView
