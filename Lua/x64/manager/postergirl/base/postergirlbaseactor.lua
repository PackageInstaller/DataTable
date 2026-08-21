local var_0_0 = require("game.config.SkinCfg")
local var_0_1 = require("game.config.HeroPosAndRotCfg")
local var_0_2 = class("PosterGirlBaseActor")

function var_0_2.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.skinId = arg_1_1
	arg_1_0.modelId = arg_1_2
	arg_1_0.tpose = nil
	arg_1_0.ui_tpose = nil
	arg_1_0._currentState = nil
	arg_1_0._inTransition = nil
	arg_1_0._states = {}
	arg_1_0.interactionTimes = 0
	LuaForUtil.IsManualAnimatorBlend = true
	arg_1_0.listener = EventListener.New()

	arg_1_0:RegisterEvents()
end

function var_0_2.RegisterActorEvents(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.listener:Register(arg_2_1, function(...)
		arg_2_2(arg_2_0, ...)
	end)
end

function var_0_2.RemoveAllActorEvents(arg_4_0)
	arg_4_0.listener:RemoveAll()
end

function var_0_2.RegisterEvents(arg_5_0)
	return
end

function var_0_2.GetHeroTimelineMgr(arg_6_0)
	if arg_6_0:IsValid() then
		return arg_6_0.overrideHeroTimelineMgr or manager.heroUiTimeline
	end
end

function var_0_2.UseOwnHeroTimelineMgr(arg_7_0)
	if arg_7_0.overrideHeroTimelineMgr == nil then
		arg_7_0.overrideHeroTimelineMgr = HeroUITimelineMgr.New()
	end
end

function var_0_2.SetActive(arg_8_0, arg_8_1)
	if arg_8_0.tpose and not isNil(arg_8_0.tpose) then
		SetActive(arg_8_0.tpose.gameObject, arg_8_1)
	end
end

function var_0_2.GetSkinId(arg_9_0)
	return arg_9_0.skinId
end

function var_0_2.GetModelId(arg_10_0)
	return arg_10_0.modelId
end

function var_0_2.GetTag(arg_11_0)
	return PosterGirlConst.PosterGirlTag.null
end

function var_0_2.GetViewDirect(arg_12_0)
	return PosterGirlConst.ViewDirect.center
end

function var_0_2.GetViewCnt(arg_13_0)
	return 1
end

function var_0_2.GetModelPath(arg_14_0)
	return "Char/" .. arg_14_0.modelId
end

local function var_0_3(arg_15_0)
	local var_15_0 = nullable(manager.posterGirl, "view_data", "oath")

	if var_15_0 ~= nil then
		return var_15_0
	end

	return OathTools.IsOath(arg_15_0)
end

function var_0_2.LoadModel(arg_16_0)
	local var_16_0 = arg_16_0:GetModelPath()

	arg_16_0.tpose = manager.resourcePool:Get(var_16_0, ASSET_TYPE.TPOSE)
	arg_16_0.ui_tpose = arg_16_0.tpose.transform:Find(string.format("%dui/%dui_tpose", arg_16_0.skinId, arg_16_0.skinId))

	local var_16_1 = var_0_0[arg_16_0.skinId]
	local var_16_2 = nullable(var_16_1, "hero") or HeroTools.FindOriginalFormHeroID(arg_16_0.skinId)
	local var_16_3 = nullable(var_16_1, "home_weapon_show") or 0

	HeroTools.SetHeroModelWeaponActivity(arg_16_0.ui_tpose, var_16_3 ~= 0)

	local var_16_4 = HeroCfg[var_16_2]

	if var_16_4 and var_0_3(var_16_4.id) then
		arg_16_0:AttachOathRing()
	end
end

function var_0_2.GetModel(arg_17_0)
	return arg_17_0.tpose
end

function var_0_2.IsValid(arg_18_0)
	return not isNil(arg_18_0:GetModel())
end

function var_0_2.PlayTalkVoice(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	return
end

function var_0_2.PlayHeroTalk(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	if PosterGirlTools.ShouldMuteHomePosterTalk() then
		return
	end

	local var_20_0, var_20_1, var_20_2 = arg_20_0:PlayTalkVoice(arg_20_1, arg_20_2, arg_20_3)

	if var_20_0 == nil then
		return
	end

	local var_20_3 = manager.audio:GetVoiceLength(var_20_0, var_20_1, var_20_2)
	local var_20_4 = HeroTools.FindMatchSkinVoiceID(arg_20_1, arg_20_2)

	if var_20_4 then
		manager.notify:Invoke(HOME_POSTER_TALK, arg_20_1, var_20_4, var_20_3)
	end
end

function var_0_2.StopHeroTalk(arg_21_0)
	return HeroTools.StopTalk(arg_21_0.skinId, arg_21_0:GetModel().transform)
end

function var_0_2.DoSpecialTalk(arg_22_0, arg_22_1, arg_22_2)
	arg_22_0:GetCurrentState():PlaySpecialTalk(arg_22_1, arg_22_2)
end

function var_0_2.UpdateViewTag(arg_23_0, arg_23_1)
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

	local var_23_1 = arg_23_0:GetHeroPosAndRotCfg(arg_23_0:GetViewDirect())
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

	if var_23_0 == "chat" or var_23_0 == "playerInfo" then
		local var_23_8 = Screen.safeArea
		local var_23_9 = var_23_8.width / var_23_8.height / 1.7777777777777777

		arg_23_0.tpose.transform.localPosition = Vector3.New(var_23_2[1], var_23_2[2], var_23_2[3]) + Vector3(var_23_5 * var_23_9, 0, 0)
		var_23_6 = GameSetting.chat_model_rotation.value
	else
		arg_23_0.tpose.transform.localPosition = Vector3.New(var_23_2[1], var_23_2[2], var_23_2[3])
	end

	if (var_23_0 == "chat" or var_23_0 == "playerInfo") and (arg_23_0:GetViewDirect() == 0 or manager.posterGirl:GetViewTag() == PosterGirlConst.ViewTag.playerInfo) then
		arg_23_0.tpose.transform.localEulerAngles = Vector3.New(var_23_3[1] + var_23_6[1], var_23_3[2] + var_23_6[2], var_23_3[3] + var_23_6[3])
	else
		arg_23_0.tpose.transform.localEulerAngles = Vector3.New(var_23_3[1], var_23_3[2], var_23_3[3])
	end

	arg_23_0.tpose.transform.localScale = Vector3.New(var_23_4[1], var_23_4[2], var_23_4[3])

	arg_23_0:ResetTpose()
end

function var_0_2.GetHeroPosAndRotCfg(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0.skinId
	local var_24_1 = nullable(var_0_0, var_24_0, "hero") or HeroTools.GetHeroIDFromFormID(var_24_0)

	return var_0_1[var_24_0] or var_0_1[var_24_1]
end

function var_0_2.ResetTpose(arg_25_0)
	local var_25_0 = arg_25_0.tpose.transform:Find(arg_25_0.skinId .. "ui")

	if var_25_0 then
		var_25_0.localEulerAngles = Vector3.zero
	end

	local var_25_1 = arg_25_0.tpose.transform:Find(string.format("%dui/%dui_tpose", arg_25_0.skinId, arg_25_0.skinId))

	if var_25_1 then
		var_25_1.localEulerAngles = Vector3.zero
	end
end

function var_0_2.ResetBlendShapes(arg_26_0)
	manager.resourcePool:ResetBlendShapes(arg_26_0.tpose.transform)
end

function var_0_2.EnableEyeController(arg_27_0, arg_27_1)
	LuaForUtil.EnableEyeController(arg_27_0.ui_tpose.transform, arg_27_1)
end

function var_0_2.GetCurrentState(arg_28_0)
	return arg_28_0._currentState
end

function var_0_2.ChangeState(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = arg_29_0:GetState(arg_29_1)

	if arg_29_2 == nil then
		arg_29_2 = false
	end

	if var_29_0 then
		arg_29_0:Transition(var_29_0, arg_29_2)
	end
end

function var_0_2.Transition(arg_30_0, arg_30_1, arg_30_2)
	if arg_30_0._currentState == arg_30_1 or arg_30_0._inTransition then
		arg_30_0._currentState:Update()

		return
	end

	arg_30_0._inTransition = true

	if arg_30_0._currentState ~= nil then
		arg_30_0._currentState:Exit(arg_30_2)
	end

	arg_30_0._currentState = arg_30_1

	if arg_30_0._currentState ~= nil then
		arg_30_0._currentState:Enter()
		manager.notify:Invoke(ON_POSTERGIRL_TRANSITION_END, arg_30_1)
	end

	arg_30_0._inTransition = false
end

function var_0_2.GetState(arg_31_0, arg_31_1)
	return nil
end

function var_0_2.AddManagedVfx(arg_32_0, arg_32_1)
	if arg_32_0.managedVfx == nil then
		arg_32_0.managedVfx = {}
	end

	table.insert(arg_32_0.managedVfx, arg_32_1)
end

function var_0_2.DisposeVfx(arg_33_0)
	if arg_33_0.managedVfx then
		for iter_33_0, iter_33_1 in ipairs(arg_33_0.managedVfx) do
			LuaForUtil.StopEffect(iter_33_1)
		end

		arg_33_0.managedVfx = nil
	end
end

function var_0_2.AttachOathRing(arg_34_0)
	local var_34_0 = LuaForUtil.GetRoleAttachPoint(arg_34_0.tpose.transform, OathTools.OathRingAttachPoint)
	local var_34_1 = LuaForUtil.PlayAttachEffect(var_34_0, OathTools.OathRingAssetPath, Vector3(0, 0, 0), Vector3(1, 1, 1), Vector3(0, 0, 0), Vector3(0, 0, 0), true, 1, 0, math.huge)

	arg_34_0:AddManagedVfx(var_34_1)
end

function var_0_2.Dispose(arg_35_0)
	arg_35_0:DisposeVfx()
	arg_35_0:RemoveAllActorEvents()

	if arg_35_0._currentState then
		arg_35_0._currentState:Dispose()
	end

	arg_35_0._currentState = nil

	if arg_35_0.tpose then
		LuaForUtil.StopCriLipsync(arg_35_0.tpose.transform)
		manager.resourcePool:DestroyOrReturn(arg_35_0.tpose, ASSET_TYPE.TPOSE)

		arg_35_0.tpose = nil
	end

	if arg_35_0.overrideHeroTimelineMgr then
		arg_35_0.overrideHeroTimelineMgr:Dispose()

		arg_35_0.overrideHeroTimelineMgr = nil
	end

	arg_35_0.tpose = nil
	arg_35_0.ui_tpose = nil
	arg_35_0._states = nil
end

function var_0_2.InitTouchHelp(arg_36_0, arg_36_1)
	return
end

function var_0_2.TouchHelpIdle(arg_37_0)
	return
end

function var_0_2.TouchHelpSingleDrag(arg_38_0, arg_38_1, arg_38_2)
	return
end

function var_0_2.TouchHelpMutiDrag(arg_39_0, arg_39_1)
	return
end

function var_0_2.CheckInitState(arg_40_0)
	local var_40_0 = arg_40_0:GetCurrentState()

	if var_40_0 then
		local var_40_1 = var_40_0:GetStateKey()

		return var_40_1 == PosterGirlConst.StateKay.init or var_40_1 == PosterGirlConst.StateKay.init_no_blend or var_40_1 == PosterGirlConst.StateKay.init_spec
	end

	return false
end

function var_0_2.CheckDebut(arg_41_0)
	return false
end

function var_0_2.SkipDebut(arg_42_0)
	return false
end

function var_0_2.IsPlayingDebut(arg_43_0)
	local var_43_0 = arg_43_0:GetCurrentState()

	return var_43_0 and var_43_0:GetStateKey() == PosterGirlConst.StateKay.debut or false
end

function var_0_2._GetInteractionCfg(arg_44_0, arg_44_1)
	if arg_44_0.cacheInteractionCfg_ then
		return arg_44_0.cacheInteractionCfg_
	end

	local var_44_0 = arg_44_0:GetSceneID()
	local var_44_1 = HomeSceneSettingCfg[var_44_0]
	local var_44_2 = var_44_1 and var_44_1.action_suffix
	local var_44_3 = arg_44_0:GetTimeParam()

	arg_44_0.cacheInteractionCfg_ = HeroTools:GetUnlockInteractionCfg(arg_44_1, {
		var_44_2,
		var_44_3
	})

	return arg_44_0.cacheInteractionCfg_
end

function var_0_2.GetTimeParam(arg_45_0)
	return nil
end

function var_0_2.GetInteractionCfg(arg_46_0)
	return arg_46_0:_GetInteractionCfg(arg_46_0:GetSkinId())
end

function var_0_2.DoShacking(arg_47_0)
	arg_47_0:AddInteractionsTimes()
end

function var_0_2.AcceptTouch(arg_48_0)
	local var_48_0 = arg_48_0:GetInteractionCfg()

	if var_48_0[PosterGirlConst.InteractionKey.mainTouch] and #var_48_0[PosterGirlConst.InteractionKey.mainTouch] ~= 0 then
		return true
	end
end

function var_0_2.DoTouch(arg_49_0)
	arg_49_0:AddInteractionsTimes()
end

function var_0_2.DoQuickTouch(arg_50_0)
	arg_50_0:AddInteractionsTimes()
end

function var_0_2.DoShowing(arg_51_0)
	arg_51_0:AddInteractionsTimes()
end

function var_0_2.DoGreeting(arg_52_0)
	return
end

function var_0_2.CheckIdle(arg_53_0)
	return arg_53_0:CheckInitState() and not manager.story:IsPlay()
end

function var_0_2.DoIdle(arg_54_0)
	return
end

function var_0_2.DoInit(arg_55_0, arg_55_1)
	return
end

function var_0_2.DOEndDrag(arg_56_0)
	return
end

function var_0_2.InitSceneEffect(arg_57_0)
	local var_57_0 = arg_57_0:GetViewDirect()
	local var_57_1, var_57_2 = PosterGirlTools.GetLoadLightEffect(var_57_0, var_57_0)

	if var_57_1 then
		manager.ui:SetSceneLightEffect(var_57_2)
	else
		manager.ui:SetSceneLightEffect(nil)
	end

	manager.loadScene:SetSceneWeather(manager.loadScene:GetCurWeather())
end

function var_0_2.OnChangeScene(arg_58_0)
	arg_58_0.cacheInteractionCfg_ = nil

	arg_58_0:InitSceneEffect()
end

function var_0_2.SetSceneID(arg_59_0, arg_59_1)
	if arg_59_0.cacheSceneId_ and arg_59_0.cacheSceneId_ ~= arg_59_1 then
		arg_59_0.cacheSceneId_ = arg_59_1

		arg_59_0:OnChangeScene()
	elseif arg_59_0.cacheSceneId_ == nil then
		arg_59_0.cacheSceneId_ = arg_59_1

		arg_59_0:OnChangeScene()
	else
		arg_59_0.cacheSceneId_ = arg_59_1
	end
end

function var_0_2.GetSceneID(arg_60_0)
	return arg_60_0.cacheSceneId_ or manager.posterGirl:GetCurScene()
end

function var_0_2.GetInteractionsTimes(arg_61_0)
	return arg_61_0.interactionTimes
end

function var_0_2.AddInteractionsTimes(arg_62_0)
	arg_62_0.interactionTimes = arg_62_0.interactionTimes + 1
end

function var_0_2.DebugTestBindID(arg_63_0, arg_63_1, arg_63_2)
	local var_63_0 = arg_63_0:GetHeroTimelineMgr():_GetTimeline()

	var_63_0:BindHero(arg_63_1, arg_63_2, var_63_0.modelGo_)
end

function var_0_2.CanSwipe(arg_64_0, arg_64_1)
	return false
end

return var_0_2
