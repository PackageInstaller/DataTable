local var_0_0 = class("PosterGirlDlcActor", PosterGirlBaseActor)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2)
	manager.ui:AddMainCameraCom(typeof(CinemachineBrain))

	arg_1_0.playable_list = {}

	arg_1_0:Init()
	arg_1_0:InitSceneEffect()
	arg_1_0:InitCameraParams()
end

function var_0_0.Init(arg_2_0)
	arg_2_0.view_direct = PosterGirlConst.ViewDirect.center
end

function var_0_0.InitCameraParams(arg_3_0)
	local var_3_0 = manager.ui.mainCamera:GetComponent("CameraExtension")

	if var_3_0 then
		arg_3_0.originShadowRotationImmediately = var_3_0.shadowRotationImmediately
		var_3_0.shadowRotationImmediately = true
	end
end

function var_0_0.RevertCameraParams(arg_4_0)
	local var_4_0 = manager.ui.mainCamera:GetComponent("CameraExtension")

	if var_4_0 then
		var_4_0.shadowRotationImmediately = arg_4_0.originShadowRotationImmediately or true
	end
end

function var_0_0.LoadModel(arg_5_0)
	var_0_0.super.LoadModel(arg_5_0)

	local var_5_0 = arg_5_0.tpose.transform:Find("camera")

	if var_5_0 then
		arg_5_0.cameraManager_ = var_5_0:GetComponent("CharacterCameraManager")
	else
		arg_5_0.cameraManager_ = nil
	end

	arg_5_0:UpdateCameraParams()
	arg_5_0:GetHeroTimelineMgr():BindHero(arg_5_0:GetSkinId(), arg_5_0:GetModelId(), arg_5_0.tpose)
end

function var_0_0.RegisterEvents(arg_6_0)
	arg_6_0:RegisterActorEvents("ON_SCENE_INTERACT", arg_6_0.OnSceneInteract)
end

function var_0_0.GetHeroPosAndRotCfg(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0.skinId * 100

	return HeroPosAndRotCfg[var_7_0]
end

function var_0_0.GetTag(arg_8_0)
	return PosterGirlConst.PosterGirlTag.t0
end

function var_0_0.CheckDebut(arg_9_0)
	if PlayerData:IsRandomHero() and PlayerData:GetRandomHeroMode() == HomeSceneSettingConst.RANDOM_MODE.EACH_ENTER and HomeSceneSettingData:GetIsPlay(arg_9_0.skinId) and not PlayerData:IsRandomHeroShowEachDebutAnim() then
		return false
	end

	if HomeSceneSettingData:GetIsPlay(arg_9_0.skinId) and (not PlayerData:IsRandomHero() or PlayerData:GetRandomHeroMode() ~= HomeSceneSettingConst.RANDOM_MODE.EACH_ENTER or not PlayerData:IsRandomHeroShowEachDebutAnim()) then
		return false
	end

	arg_9_0:ChangeState(PosterGirlConst.StateKay.debut)

	return true
end

function var_0_0.SkipDebut(arg_10_0)
	local var_10_0 = arg_10_0:GetCurrentState()

	if not var_10_0 or var_10_0:GetStateKey() ~= PosterGirlConst.StateKay.debut then
		return false
	end

	var_10_0:SkipToEnd()
	arg_10_0:ChangeState(PosterGirlConst.StateKay.init_no_blend, true)
	arg_10_0:AddInteractionsTimes()

	return true
end

function var_0_0.PlayTalkVoice(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = arg_11_1

	return HeroTools.PlayTalkBySkinID(var_11_0, arg_11_2, arg_11_3, arg_11_0:GetModel().transform)
end

function var_0_0.BeforeDebut(arg_12_0)
	return
end

function var_0_0.AfterDebut(arg_13_0)
	return
end

local var_0_1 = {
	[PosterGirlConst.StateKay.init] = true,
	[PosterGirlConst.StateKay.init_spec] = true,
	[PosterGirlConst.StateKay.init_no_blend] = true
}

function var_0_0.CheckInitState(arg_14_0)
	local var_14_0 = arg_14_0:GetCurrentState()

	return var_14_0 and var_0_1[var_14_0:GetStateKey()]
end

function var_0_0.InitTouchHelp(arg_15_0, arg_15_1)
	if arg_15_0.cameraManager_ then
		arg_15_0.cameraManager_.touchHelper = arg_15_1
	end
end

function var_0_0.TouchHelpIdle(arg_16_0)
	if arg_16_0.cameraManager_ and (arg_16_0:CheckInitState() or arg_16_0:CheckOpenDrag()) then
		arg_16_0.cameraManager_:TweenToDefaultCameraPos()
	end
end

function var_0_0.CheckOpenDrag(arg_17_0)
	local var_17_0 = arg_17_0:GetCurrentState()

	return var_17_0 and PosterGirlTools.IsStateOpenDrag(var_17_0:GetStateKey()) or false
end

function var_0_0.TouchHelpSingleDrag(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_0.cameraManager_ == nil or isNil(arg_18_0.cameraManager_) then
		return
	end

	if arg_18_0:CheckInitState() or arg_18_0:CheckOpenDrag() then
		arg_18_0.cameraManager_:RotateCamera(arg_18_1, arg_18_2)
	end
end

function var_0_0.TouchHelpMutiDrag(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0:GetCurrentState()

	if var_19_0.ZoomToCamera then
		var_19_0:ZoomToCamera(arg_19_1)
	else
		arg_19_0:DefaultZoomToCameraImpl(arg_19_1, 1, 0)
	end
end

function var_0_0.DefaultZoomToCameraImpl(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	arg_20_0 = arg_20_0 or manager.posterGirl.actor

	if arg_20_0.cameraManager_ == nil or isNil(arg_20_0.cameraManager_) then
		return
	end

	local var_20_0 = nullable(GameSetting.delta_to_zoom, "value", 1) or 10

	if var_20_0 < arg_20_1 then
		arg_20_0.zoom = true

		arg_20_0.cameraManager_:SetActiveCamera(arg_20_2)
	elseif arg_20_1 < -1 * var_20_0 then
		arg_20_0.zoom = nil

		arg_20_0.cameraManager_:SetActiveCamera(arg_20_3)
	end
end

function var_0_0.SetSelfCamera(arg_21_0, arg_21_1, arg_21_2)
	if arg_21_0.cameraManager_ == nil or isNil(arg_21_0.cameraManager_) then
		return
	end

	if arg_21_1 == -1 then
		arg_21_0.cameraManager_:RemoveActiveCamera()
	else
		arg_21_0.cameraManager_:SetActiveCamera(arg_21_1, arg_21_2 or false)
	end

	arg_21_0:ResetCameraPos()
end

function var_0_0.SetCameraInputMode(arg_22_0, arg_22_1)
	if arg_22_0.cameraManager_ then
		arg_22_0.cameraManager_:SwitchCamearInputmode(arg_22_1)
	end
end

function var_0_0.ResetCameraPos(arg_23_0)
	if arg_23_0.cameraManager_ then
		arg_23_0.cameraManager_:ResetCameraDefaultCfg()
	end
end

function var_0_0.UpdateCameraParams(arg_24_0)
	if not arg_24_0.cameraManager_ then
		return
	end

	arg_24_0.cameraManager_:SetCameraParams(arg_24_0:GetViewDirect())
	arg_24_0:SetSelfCamera(0)
end

function var_0_0.MuteCamera(arg_25_0, arg_25_1)
	if arg_25_0.cameraManager_ then
		SetActive(arg_25_0.cameraManager_.gameObject, not arg_25_1)
	end
end

function var_0_0.SetCameraParams(arg_26_0, arg_26_1)
	if arg_26_0.cameraManager_ then
		arg_26_0.cameraManager_:SetCameraParams(arg_26_1)
	end
end

function var_0_0.GetState(arg_27_0, arg_27_1)
	local var_27_0 = PosterGirlTools.DlcStateShouldCache(arg_27_1)
	local var_27_1 = nullable(arg_27_0._states, var_27_0)
	local var_27_2 = HomeSceneSettingData:GetCurScene()
	local var_27_3 = {
		isViewPointChange = PosterGirlTools.IsLoopSwitch(var_27_2)
	}

	if var_27_1 == nil then
		var_27_1 = PosterGirlTools.ProduceDlcState(arg_27_1, arg_27_0, var_27_3)

		if var_27_1 ~= nil and var_27_0 then
			arg_27_0._states[var_27_0] = var_27_1
		end
	end

	if arg_27_1.key ~= nil then
		var_27_1:SetStateKey(arg_27_1.key)
	else
		var_27_1:SetStateKey(arg_27_1)
	end

	return var_27_1
end

function var_0_0.DoShacking(arg_28_0)
	if not arg_28_0:CheckInitState() or PosterGirlConst.ViewDirect.center ~= arg_28_0.view_direct then
		return
	end

	arg_28_0:ChangeState(PosterGirlConst.StateKay.shake)
	var_0_0.super.DoShacking(arg_28_0)
end

function var_0_0.AcceptTouch(arg_29_0)
	local var_29_0 = arg_29_0:GetCurrentState()

	if var_29_0 and var_29_0:AcceptTouch() then
		return true
	end

	return var_0_0.super.AcceptTouch(arg_29_0)
end

function var_0_0.DoTouch(arg_30_0)
	local var_30_0 = arg_30_0:GetCurrentState()

	if var_30_0 and var_30_0:CanPlayNextAni() then
		var_30_0:PlayNextAni()

		return
	end

	if not arg_30_0:CheckInitState() then
		return
	end

	arg_30_0:ChangeState(PosterGirlConst.StateKay.touch)
	var_0_0.super.DoTouch(arg_30_0)
end

function var_0_0.DoQuickTouch(arg_31_0)
	local var_31_0 = arg_31_0:GetCurrentState()

	if var_31_0 and var_31_0:CanPlayNextAni() then
		var_31_0:PlayNextAni()

		return
	end

	if not arg_31_0:CheckInitState() or PosterGirlConst.ViewDirect.center ~= arg_31_0.view_direct then
		return
	end

	arg_31_0:ChangeState(PosterGirlConst.StateKay.quickclick)
	var_0_0.super.DoQuickTouch(arg_31_0)
end

function var_0_0.DoShowing(arg_32_0)
	if not arg_32_0:CheckInitState() or PosterGirlConst.ViewDirect.center ~= arg_32_0.view_direct then
		return
	end

	arg_32_0:ChangeState(PosterGirlConst.StateKay.show)
	var_0_0.super.DoShowing(arg_32_0)
end

function var_0_0.DoInit(arg_33_0, arg_33_1)
	if arg_33_1 == PosterGirlConst.ViewTag.home then
		arg_33_0:ChangeState(PosterGirlConst.StateKay.init)
	else
		arg_33_0:ChangeState(PosterGirlConst.StateKay.init_spec, true)
	end
end

function var_0_0.DoIdle(arg_34_0)
	if not arg_34_0:CheckIdle() then
		return
	end

	arg_34_0:ChangeState(PosterGirlConst.StateKay.idle)
end

function var_0_0.Dispose(arg_35_0)
	local var_35_0 = arg_35_0:GetHeroTimelineMgr()

	if var_35_0 then
		var_35_0:Unbind()
	end

	arg_35_0:RevertCameraParams()
	var_0_0.super.Dispose(arg_35_0)
end

function var_0_0.ResetBlendShapes(arg_36_0)
	return
end

function var_0_0.PlayEffect(arg_37_0, arg_37_1, arg_37_2, arg_37_3)
	return arg_37_0:GetHeroTimelineMgr():_GetTimeline():GetTimelineBrain():PlayEffect(arg_37_1, arg_37_2, arg_37_3)
end

function var_0_0.StopEffect(arg_38_0, arg_38_1)
	arg_38_0:GetHeroTimelineMgr():_GetTimeline():GetTimelineBrain():StopEffect(arg_38_1)
end

function var_0_0.SwipeToLeft(arg_39_0)
	return
end

function var_0_0.SwipeToRight(arg_40_0)
	return
end

function var_0_0.DOEndDrag(arg_41_0)
	arg_41_0:AddInteractionsTimes()
end

local var_0_2 = 0.4

function var_0_0.DoActionChain(arg_42_0, arg_42_1, arg_42_2, ...)
	if arg_42_1 == nil then
		arg_42_0:ChangeState(PosterGirlConst.StateKay.init)
	else
		arg_42_0:ChangeState(PosterDlcCustomState)
		arg_42_0:AddInteractionsTimes()

		local var_42_0
		local var_42_1

		if type(arg_42_2) == "number" then
			var_42_1 = arg_42_2
			var_42_0 = {
				...
			}
		else
			var_42_1 = var_0_2
			var_42_0 = {
				arg_42_2,
				...
			}
		end

		local var_42_2 = arg_42_0:GetCurrentState()

		var_42_2:PlayAni(arg_42_1, var_42_1)
		var_42_2:SetCompleteCallback(function()
			arg_42_0:DoActionChain(unpack(var_42_0))
		end)
	end
end

local var_0_3 = {
	play = function(arg_44_0, ...)
		arg_44_0:DoActionChain(...)
		arg_44_0:RecordDoActionChain({
			...
		})
	end,
	talk = function(arg_45_0, ...)
		arg_45_0:DoSpecialTalk(...)
	end,
	jump = function(arg_46_0, arg_46_1, arg_46_2)
		JumpTools.OpenPageByJump(arg_46_1, arg_46_2)
	end,
	record = function(arg_47_0, arg_47_1, arg_47_2, arg_47_3, arg_47_4)
		SDKTools.SendMessageToSDK("activity_combat_over", {
			sys_id = arg_47_1,
			skin_id = arg_47_2,
			scene_id = arg_47_3,
			other_data = arg_47_4
		})
	end,
	recordCustom = function(arg_48_0, arg_48_1, arg_48_2)
		SDKTools.SendMessageToSDK(arg_48_1, arg_48_2)
	end,
	print = function(arg_49_0, ...)
		print(...)
	end,
	debugHere = function(...)
		local var_50_0 = {
			...
		}

		print(...)
		debugger.WaitIDE()
		debugger.BreakHere()
	end
}

function var_0_0.OnSceneInteract(arg_51_0, arg_51_1, ...)
	local var_51_0 = nullable(var_0_3, arg_51_1)

	if manager.posterGirl:GetViewTag() == PosterGirlConst.ViewTag.home and var_51_0 then
		var_51_0(arg_51_0, ...)
	end
end

local var_0_4 = require("cjson")

function var_0_0.RecordDoActionChain(arg_52_0, arg_52_1)
	local var_52_0 = HomeSceneSettingData:GetCurScene()

	SDKTools.SendMessageToSDK("activity_combat_over", {
		sys_id = 101,
		skin_id = arg_52_0.skinId,
		scene_id = var_52_0,
		other_data = var_0_4.encode(arg_52_1)
	})
end

return var_0_0
