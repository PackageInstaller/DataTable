local SkinCfg = require("game.config.SkinCfg")
local HeroPosAndRotCfg = require("game.config.HeroPosAndRotCfg")
local PosterGirlBaseActor = class("PosterGirlBaseActor")

function PosterGirlBaseActor:Ctor(arg_1_1, arg_1_2)
	self.skinId = arg_1_1
	self.modelId = arg_1_2
	self.tpose = nil
	self.ui_tpose = nil
	self._currentState = nil
	self._inTransition = nil
	self._states = {}
	self.interactionTimes = 0
	LuaForUtil.IsManualAnimatorBlend = true
	self.listener = EventListener.New()

	self:RegisterEvents()
end

function PosterGirlBaseActor:RegisterActorEvents(arg_2_1, arg_2_2)
	self.listener:Register(arg_2_1, function(...)
		arg_2_2(self, ...)
	end)
end

function PosterGirlBaseActor:RemoveAllActorEvents()
	self.listener:RemoveAll()
end

function PosterGirlBaseActor:RegisterEvents()
	return
end

function PosterGirlBaseActor:GetHeroTimelineMgr()
	if self:IsValid() then
		return self.overrideHeroTimelineMgr or manager.heroUiTimeline
	end
end

function PosterGirlBaseActor:UseOwnHeroTimelineMgr()
	if self.overrideHeroTimelineMgr == nil then
		self.overrideHeroTimelineMgr = HeroUITimelineMgr.New()
	end
end

function PosterGirlBaseActor:SetActive(arg_8_1)
	if self.tpose and not isNil(self.tpose) then
		SetActive(self.tpose.gameObject, arg_8_1)
	end
end

function PosterGirlBaseActor:GetSkinId()
	return self.skinId
end

function PosterGirlBaseActor:GetModelId()
	return self.modelId
end

function PosterGirlBaseActor:GetTag()
	return PosterGirlConst.PosterGirlTag.null
end

function PosterGirlBaseActor:GetViewDirect()
	return PosterGirlConst.ViewDirect.center
end

function PosterGirlBaseActor:GetViewCnt()
	return 1
end

function PosterGirlBaseActor:GetModelPath()
	return "Char/" .. self.modelId
end

local function var_0_3(arg_15_0)
	local var_15_0 = nullable(manager.posterGirl, "view_data", "oath")

	if var_15_0 ~= nil then
		return var_15_0
	end

	return OathTools.IsOath(arg_15_0)
end

function PosterGirlBaseActor:LoadModel()
	self.tpose = manager.resourcePool:Get(self:GetModelPath(), ASSET_TYPE.TPOSE)
	self.ui_tpose = self.tpose.transform:Find(string.format("%dui/%dui_tpose", self.skinId, self.skinId))

	local var_16_0 = nullable(SkinCfg[self.skinId], "hero") or HeroTools.FindOriginalFormHeroID(self.skinId)

	HeroTools.SetHeroModelWeaponActivity(self.ui_tpose, (nullable(SkinCfg[self.skinId], "home_weapon_show") or 0) ~= 0)

	if HeroCfg[var_16_0] and var_0_3(HeroCfg[var_16_0].id) then
		self:AttachOathRing()
	end
end

function PosterGirlBaseActor:GetModel()
	return self.tpose
end

function PosterGirlBaseActor:IsValid()
	return not isNil(self:GetModel())
end

function PosterGirlBaseActor:PlayTalkVoice(arg_19_1, arg_19_2, arg_19_3)
	return
end

function PosterGirlBaseActor:PlayHeroTalk(arg_20_1, arg_20_2, arg_20_3)
	if PosterGirlTools.ShouldMuteHomePosterTalk() then
		return
	end

	local var_20_0, var_20_1, var_20_2 = self:PlayTalkVoice(arg_20_1, arg_20_2, arg_20_3)

	if var_20_0 == nil then
		return
	end

	local var_20_3 = manager.audio:GetVoiceLength(var_20_0, var_20_1, var_20_2)
	local var_20_4 = HeroTools.FindMatchSkinVoiceID(arg_20_1, arg_20_2)

	if var_20_4 then
		manager.notify:Invoke(HOME_POSTER_TALK, arg_20_1, var_20_4, var_20_3)
	end
end

function PosterGirlBaseActor:StopHeroTalk()
	return HeroTools.StopTalk(self.skinId, self:GetModel().transform)
end

function PosterGirlBaseActor:DoSpecialTalk(arg_22_1, arg_22_2)
	self:GetCurrentState():PlaySpecialTalk(arg_22_1, arg_22_2)
end

function PosterGirlBaseActor:UpdateViewTag(arg_23_1)
	local var_23_0

	if PosterGirlConst.ViewTag.home == arg_23_1 then
		var_23_0 = "main"
	elseif PosterGirlConst.ViewTag.chat == arg_23_1 then
		var_23_0 = "chat"
	elseif PosterGirlConst.ViewTag.playerInfo == arg_23_1 or PosterGirlConst.ViewTag.playerInfo_other == arg_23_1 then
		var_23_0 = "playerInfo"
	elseif PosterGirlConst.ViewTag.preview == arg_23_1 then
		var_23_0 = "main"
	else
		error("UpdateViewParams")

		return
	end

	local var_23_1 = self:GetHeroPosAndRotCfg(self:GetViewDirect())
	local var_23_2 = nullable(var_23_1, "position_" .. var_23_0) or {
		0,
		0,
		0
	}
	local var_23_3 = nullable(var_23_1, "rotation_" .. "main") or {
		0,
		0,
		0
	}
	local var_23_4 = nullable(var_23_1, "scale_" .. "main") or {
		1,
		1,
		1
	}
	local var_23_5 = nullable(var_23_1, "offset") or 0
	local var_23_6 = Vector3.one

	if arg_23_1 ~= PosterGirlConst.ViewTag.playerInfo_other then
		local var_23_7 = manager.posterGirl:GetCurScene()

		var_23_2 = nullable(var_23_1, "position_scene_" .. var_23_7) or var_23_2
		var_23_3 = nullable(var_23_1, "rotation_scene_" .. var_23_7) or var_23_3
	end

	if var_23_0 ~= "chat" then
		if var_23_0 == "playerInfo" then
			self.tpose.transform.localPosition = Vector3.New(var_23_2[1], var_23_2[2], var_23_2[3]) + Vector3(var_23_5 * (Screen.safeArea.width / Screen.safeArea.height / 1.7777777777777777), 0, 0)
			var_23_6 = GameSetting.chat_model_rotation.value

			goto label_23_0
		end
	end

	self.tpose.transform.localPosition = Vector3.New(var_23_2[1], var_23_2[2], var_23_2[3])

	::label_23_0::

	self.tpose.transform.localEulerAngles = (var_23_0 == "chat" or var_23_0 == "playerInfo") and (self:GetViewDirect() == 0 or manager.posterGirl:GetViewTag() == PosterGirlConst.ViewTag.playerInfo) and Vector3.New(var_23_3[1] + var_23_6[1], var_23_3[2] + var_23_6[2], var_23_3[3] + var_23_6[3]) or Vector3.New(var_23_3[1], var_23_3[2], var_23_3[3])
	self.tpose.transform.localScale = Vector3.New(var_23_4[1], var_23_4[2], var_23_4[3])

	self:ResetTpose()
end

function PosterGirlBaseActor:GetHeroPosAndRotCfg(arg_24_1)
	return (not HeroPosAndRotCfg[self.skinId] or nil) and HeroPosAndRotCfg[nullable(SkinCfg, self.skinId, "hero") or HeroTools.GetHeroIDFromFormID(self.skinId)]
end

function PosterGirlBaseActor:ResetTpose()
	local var_25_0 = self.tpose.transform:Find(self.skinId .. "ui")

	if var_25_0 then
		var_25_0.localEulerAngles = Vector3.zero
	end

	local var_25_1 = self.tpose.transform:Find(string.format("%dui/%dui_tpose", self.skinId, self.skinId))

	if var_25_1 then
		var_25_1.localEulerAngles = Vector3.zero
	end
end

function PosterGirlBaseActor:ResetBlendShapes()
	manager.resourcePool:ResetBlendShapes(self.tpose.transform)
end

function PosterGirlBaseActor:EnableEyeController(arg_27_1)
	LuaForUtil.EnableEyeController(self.ui_tpose.transform, arg_27_1)
end

function PosterGirlBaseActor:GetCurrentState()
	return self._currentState
end

function PosterGirlBaseActor:ChangeState(arg_29_1, arg_29_2)
	local var_29_0 = self:GetState(arg_29_1)

	if arg_29_2 == nil then
		arg_29_2 = false
	end

	if var_29_0 then
		self:Transition(var_29_0, arg_29_2)
	end
end

function PosterGirlBaseActor:Transition(arg_30_1, arg_30_2)
	if self._currentState == arg_30_1 or self._inTransition then
		self._currentState:Update()

		return
	end

	self._inTransition = true

	if self._currentState ~= nil then
		self._currentState:Exit(arg_30_2)
	end

	self._currentState = arg_30_1

	if self._currentState ~= nil then
		self._currentState:Enter()
		manager.notify:Invoke(ON_POSTERGIRL_TRANSITION_END, arg_30_1)
	end

	self._inTransition = false
end

function PosterGirlBaseActor:GetState(arg_31_1)
	return nil
end

function PosterGirlBaseActor:AddManagedVfx(arg_32_1)
	if self.managedVfx == nil then
		self.managedVfx = {}
	end

	table.insert(self.managedVfx, arg_32_1)
end

function PosterGirlBaseActor:DisposeVfx()
	if self.managedVfx then
		for iter_33_0, iter_33_1 in ipairs(self.managedVfx) do
			LuaForUtil.StopEffect(iter_33_1)
		end

		self.managedVfx = nil
	end
end

function PosterGirlBaseActor:AttachOathRing()
	self:AddManagedVfx((LuaForUtil.PlayAttachEffect(LuaForUtil.GetRoleAttachPoint(self.tpose.transform, OathTools.OathRingAttachPoint), OathTools.OathRingAssetPath, Vector3(0, 0, 0), Vector3(1, 1, 1), Vector3(0, 0, 0), Vector3(0, 0, 0), true, 1, 0, math.huge)))
end

function PosterGirlBaseActor:Dispose()
	self:DisposeVfx()
	self:RemoveAllActorEvents()

	if self._currentState then
		self._currentState:Dispose()
	end

	self._currentState = nil

	if self.tpose then
		LuaForUtil.StopCriLipsync(self.tpose.transform)
		manager.resourcePool:DestroyOrReturn(self.tpose, ASSET_TYPE.TPOSE)

		self.tpose = nil
	end

	if self.overrideHeroTimelineMgr then
		self.overrideHeroTimelineMgr:Dispose()

		self.overrideHeroTimelineMgr = nil
	end

	self.tpose = nil
	self.ui_tpose = nil
	self._states = nil
end

function PosterGirlBaseActor:InitTouchHelp(arg_36_1)
	return
end

function PosterGirlBaseActor:TouchHelpIdle()
	return
end

function PosterGirlBaseActor:TouchHelpSingleDrag(arg_38_1, arg_38_2)
	return
end

function PosterGirlBaseActor:TouchHelpMutiDrag(arg_39_1)
	return
end

function PosterGirlBaseActor:CheckInitState()
	local var_40_0 = self:GetCurrentState()

	if var_40_0 then
		local var_40_1 = var_40_0:GetStateKey()

		return var_40_1 == PosterGirlConst.StateKay.init or var_40_1 == PosterGirlConst.StateKay.init_no_blend or var_40_1 == PosterGirlConst.StateKay.init_spec
	end

	return false
end

function PosterGirlBaseActor:CheckDebut()
	return false
end

function PosterGirlBaseActor:SkipDebut()
	return false
end

function PosterGirlBaseActor:IsPlayingDebut()
	local var_43_0 = self:GetCurrentState()

	return var_43_0 and var_43_0:GetStateKey() == PosterGirlConst.StateKay.debut or false
end

function PosterGirlBaseActor:_GetInteractionCfg(arg_44_1)
	if self.cacheInteractionCfg_ then
		return self.cacheInteractionCfg_
	end

	local var_44_0 = HomeSceneSettingCfg[self:GetSceneID()]

	self.cacheInteractionCfg_ = HeroTools:GetUnlockInteractionCfg(arg_44_1, {
		var_44_0 and var_44_0.action_suffix,
		(self:GetTimeParam())
	})

	return self.cacheInteractionCfg_
end

function PosterGirlBaseActor:GetTimeParam()
	return nil
end

function PosterGirlBaseActor:GetInteractionCfg()
	return self:_GetInteractionCfg(self:GetSkinId())
end

function PosterGirlBaseActor:DoShacking()
	self:AddInteractionsTimes()
end

function PosterGirlBaseActor:AcceptTouch()
	local var_48_0 = self:GetInteractionCfg()

	if var_48_0[PosterGirlConst.InteractionKey.mainTouch] and #var_48_0[PosterGirlConst.InteractionKey.mainTouch] ~= 0 then
		return true
	end
end

function PosterGirlBaseActor:DoTouch()
	self:AddInteractionsTimes()
end

function PosterGirlBaseActor:DoQuickTouch()
	self:AddInteractionsTimes()
end

function PosterGirlBaseActor:DoShowing()
	self:AddInteractionsTimes()
end

function PosterGirlBaseActor:DoGreeting()
	return
end

function PosterGirlBaseActor:CheckIdle()
	return self:CheckInitState() and not manager.story:IsPlay()
end

function PosterGirlBaseActor:DoIdle()
	return
end

function PosterGirlBaseActor:DoInit(arg_55_1)
	return
end

function PosterGirlBaseActor:DOEndDrag()
	return
end

function PosterGirlBaseActor:InitSceneEffect()
	local var_57_0 = self:GetViewDirect()
	local var_57_1, var_57_2 = PosterGirlTools.GetLoadLightEffect(var_57_0, var_57_0)

	if var_57_1 then
		manager.ui:SetSceneLightEffect(var_57_2)
	else
		manager.ui:SetSceneLightEffect(nil)
	end

	manager.loadScene:SetSceneWeather(manager.loadScene:GetCurWeather())
end

function PosterGirlBaseActor:OnChangeScene()
	self.cacheInteractionCfg_ = nil

	self:InitSceneEffect()
end

function PosterGirlBaseActor:SetSceneID(arg_59_1)
	if self.cacheSceneId_ and self.cacheSceneId_ ~= arg_59_1 then
		self.cacheSceneId_ = arg_59_1

		self:OnChangeScene()
	elseif self.cacheSceneId_ == nil then
		self.cacheSceneId_ = arg_59_1

		self:OnChangeScene()
	else
		self.cacheSceneId_ = arg_59_1
	end
end

function PosterGirlBaseActor:GetSceneID()
	return self.cacheSceneId_ or manager.posterGirl:GetCurScene()
end

function PosterGirlBaseActor:GetInteractionsTimes()
	return self.interactionTimes
end

function PosterGirlBaseActor:AddInteractionsTimes()
	self.interactionTimes = self.interactionTimes + 1
end

function PosterGirlBaseActor:DebugTestBindID(arg_63_1, arg_63_2)
	local var_63_0 = self:GetHeroTimelineMgr():_GetTimeline()

	var_63_0:BindHero(arg_63_1, arg_63_2, var_63_0.modelGo_)
end

function PosterGirlBaseActor:CanSwipe(arg_64_1)
	return false
end

return PosterGirlBaseActor
