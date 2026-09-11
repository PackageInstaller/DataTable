local PosterGirlDlcActor = class("PosterGirlDlcActor", PosterGirlBaseActor)

function PosterGirlDlcActor:Ctor(arg_1_1, arg_1_2)
	PosterGirlDlcActor.super.Ctor(self, arg_1_1, arg_1_2)
	manager.ui:AddMainCameraCom(typeof(CinemachineBrain))

	self.playable_list = {}

	self:Init()
	self:InitSceneEffect()
	self:InitCameraParams()
end

function PosterGirlDlcActor:Init()
	self.view_direct = PosterGirlConst.ViewDirect.center
end

function PosterGirlDlcActor:InitCameraParams()
	local var_3_0 = manager.ui.mainCamera:GetComponent("CameraExtension")

	if var_3_0 then
		self.originShadowRotationImmediately = var_3_0.shadowRotationImmediately
		var_3_0.shadowRotationImmediately = true
	end
end

function PosterGirlDlcActor:RevertCameraParams()
	local var_4_0 = manager.ui.mainCamera:GetComponent("CameraExtension")

	if var_4_0 then
		var_4_0.shadowRotationImmediately = self.originShadowRotationImmediately or true
	end
end

function PosterGirlDlcActor:LoadModel()
	PosterGirlDlcActor.super.LoadModel(self)

	local var_5_0 = self.tpose.transform:Find("camera")

	self.cameraManager_ = var_5_0 and var_5_0:GetComponent("CharacterCameraManager") or nil

	self:UpdateCameraParams()
	self:GetHeroTimelineMgr():BindHero(self:GetSkinId(), self:GetModelId(), self.tpose)
end

function PosterGirlDlcActor:RegisterEvents()
	self:RegisterActorEvents("ON_SCENE_INTERACT", self.OnSceneInteract)
end

function PosterGirlDlcActor:GetHeroPosAndRotCfg(arg_7_1)
	return HeroPosAndRotCfg[self.skinId * 100]
end

function PosterGirlDlcActor:GetTag()
	return PosterGirlConst.PosterGirlTag.t0
end

function PosterGirlDlcActor:CheckDebut()
	if PlayerData:IsRandomHero() and PlayerData:GetRandomHeroMode() == HomeSceneSettingConst.RANDOM_MODE.EACH_ENTER and HomeSceneSettingData:GetIsPlay(self.skinId) and not PlayerData:IsRandomHeroShowEachDebutAnim() then
		return false
	end

	if HomeSceneSettingData:GetIsPlay(self.skinId) and (not PlayerData:IsRandomHero() or PlayerData:GetRandomHeroMode() ~= HomeSceneSettingConst.RANDOM_MODE.EACH_ENTER or not PlayerData:IsRandomHeroShowEachDebutAnim()) then
		return false
	end

	self:ChangeState(PosterGirlConst.StateKay.debut)

	return true
end

function PosterGirlDlcActor:SkipDebut()
	local var_10_0 = self:GetCurrentState()

	if not var_10_0 or var_10_0:GetStateKey() ~= PosterGirlConst.StateKay.debut then
		return false
	end

	var_10_0:SkipToEnd()
	self:ChangeState(PosterGirlConst.StateKay.init_no_blend, true)
	self:AddInteractionsTimes()

	return true
end

function PosterGirlDlcActor:PlayTalkVoice(arg_11_1, arg_11_2, arg_11_3)
	return HeroTools.PlayTalkBySkinID(arg_11_1, arg_11_2, arg_11_3, self:GetModel().transform)
end

function PosterGirlDlcActor:BeforeDebut()
	return
end

function PosterGirlDlcActor:AfterDebut()
	return
end

local var_0_1 = {
	[PosterGirlConst.StateKay.init] = true,
	[PosterGirlConst.StateKay.init_spec] = true,
	[PosterGirlConst.StateKay.init_no_blend] = true
}

function PosterGirlDlcActor:CheckInitState()
	local var_14_0 = self:GetCurrentState()

	return var_14_0 and var_0_1[var_14_0:GetStateKey()]
end

function PosterGirlDlcActor:InitTouchHelp(arg_15_1)
	if self.cameraManager_ then
		self.cameraManager_.touchHelper = arg_15_1
	end
end

function PosterGirlDlcActor:TouchHelpIdle()
	if self.cameraManager_ and (self:CheckInitState() or self:CheckOpenDrag()) then
		self.cameraManager_:TweenToDefaultCameraPos()
	end
end

function PosterGirlDlcActor:CheckOpenDrag()
	local var_17_0 = self:GetCurrentState()

	return var_17_0 and PosterGirlTools.IsStateOpenDrag(var_17_0:GetStateKey()) or false
end

function PosterGirlDlcActor:TouchHelpSingleDrag(arg_18_1, arg_18_2)
	if self.cameraManager_ == nil or isNil(self.cameraManager_) then
		return
	end

	if self:CheckInitState() or self:CheckOpenDrag() then
		self.cameraManager_:RotateCamera(arg_18_1, arg_18_2)
	end
end

function PosterGirlDlcActor:TouchHelpMutiDrag(arg_19_1)
	local var_19_0 = self:GetCurrentState()

	if var_19_0.ZoomToCamera then
		var_19_0:ZoomToCamera(arg_19_1)
	else
		self:DefaultZoomToCameraImpl(arg_19_1, 1, 0)
	end
end

function PosterGirlDlcActor:DefaultZoomToCameraImpl(arg_20_1, arg_20_2, arg_20_3)
	self = self or manager.posterGirl.actor

	if self.cameraManager_ == nil or isNil(self.cameraManager_) then
		return
	end

	local var_20_0 = nullable(GameSetting.delta_to_zoom, "value", 1) or 10

	if var_20_0 < arg_20_1 then
		self.zoom = true

		self.cameraManager_:SetActiveCamera(arg_20_2)
	elseif arg_20_1 < -1 * var_20_0 then
		self.zoom = nil

		self.cameraManager_:SetActiveCamera(arg_20_3)
	end
end

function PosterGirlDlcActor:SetSelfCamera(arg_21_1, arg_21_2)
	if self.cameraManager_ == nil or isNil(self.cameraManager_) then
		return
	end

	if arg_21_1 == -1 then
		self.cameraManager_:RemoveActiveCamera()
	else
		self.cameraManager_:SetActiveCamera(arg_21_1, arg_21_2 or false)
	end

	self:ResetCameraPos()
end

function PosterGirlDlcActor:SetCameraInputMode(arg_22_1)
	if self.cameraManager_ then
		self.cameraManager_:SwitchCamearInputmode(arg_22_1)
	end
end

function PosterGirlDlcActor:ResetCameraPos()
	if self.cameraManager_ then
		self.cameraManager_:ResetCameraDefaultCfg()
	end
end

function PosterGirlDlcActor:UpdateCameraParams()
	if not self.cameraManager_ then
		return
	end

	self.cameraManager_:SetCameraParams(self:GetViewDirect())
	self:SetSelfCamera(0)
end

function PosterGirlDlcActor:MuteCamera(arg_25_1)
	if self.cameraManager_ then
		SetActive(self.cameraManager_.gameObject, not arg_25_1)
	end
end

function PosterGirlDlcActor:SetCameraParams(arg_26_1)
	if self.cameraManager_ then
		self.cameraManager_:SetCameraParams(arg_26_1)
	end
end

function PosterGirlDlcActor:GetState(arg_27_1)
	local var_27_0 = PosterGirlTools.DlcStateShouldCache(arg_27_1)
	local var_27_1 = nullable(self._states, var_27_0)

	if var_27_1 == nil then
		var_27_1 = PosterGirlTools.ProduceDlcState(arg_27_1, self, {
			isViewPointChange = PosterGirlTools.IsLoopSwitch((HomeSceneSettingData:GetCurScene()))
		})

		if var_27_1 ~= nil and var_27_0 then
			self._states[var_27_0] = var_27_1
		end
	end

	if arg_27_1.key ~= nil then
		var_27_1:SetStateKey(arg_27_1.key)
	else
		var_27_1:SetStateKey(arg_27_1)
	end

	return var_27_1
end

function PosterGirlDlcActor:DoShacking()
	if not self:CheckInitState() or PosterGirlConst.ViewDirect.center ~= self.view_direct then
		return
	end

	self:ChangeState(PosterGirlConst.StateKay.shake)
	PosterGirlDlcActor.super.DoShacking(self)
end

function PosterGirlDlcActor:AcceptTouch()
	local var_29_0 = self:GetCurrentState()

	if var_29_0 and var_29_0:AcceptTouch() then
		return true
	end

	return PosterGirlDlcActor.super.AcceptTouch(self)
end

function PosterGirlDlcActor:DoTouch()
	local var_30_0 = self:GetCurrentState()

	if var_30_0 and var_30_0:CanPlayNextAni() then
		var_30_0:PlayNextAni()

		return
	end

	if not self:CheckInitState() then
		return
	end

	self:ChangeState(PosterGirlConst.StateKay.touch)
	PosterGirlDlcActor.super.DoTouch(self)
end

function PosterGirlDlcActor:DoQuickTouch()
	local var_31_0 = self:GetCurrentState()

	if var_31_0 and var_31_0:CanPlayNextAni() then
		var_31_0:PlayNextAni()

		return
	end

	if not self:CheckInitState() or PosterGirlConst.ViewDirect.center ~= self.view_direct then
		return
	end

	self:ChangeState(PosterGirlConst.StateKay.quickclick)
	PosterGirlDlcActor.super.DoQuickTouch(self)
end

function PosterGirlDlcActor:DoShowing()
	if not self:CheckInitState() or PosterGirlConst.ViewDirect.center ~= self.view_direct then
		return
	end

	self:ChangeState(PosterGirlConst.StateKay.show)
	PosterGirlDlcActor.super.DoShowing(self)
end

function PosterGirlDlcActor:DoInit(arg_33_1)
	if arg_33_1 == PosterGirlConst.ViewTag.home then
		self:ChangeState(PosterGirlConst.StateKay.init)
	else
		self:ChangeState(PosterGirlConst.StateKay.init_spec, true)
	end
end

function PosterGirlDlcActor:DoIdle()
	if not self:CheckIdle() then
		return
	end

	self:ChangeState(PosterGirlConst.StateKay.idle)
end

function PosterGirlDlcActor:Dispose()
	local var_35_0 = self:GetHeroTimelineMgr()

	if var_35_0 then
		var_35_0:Unbind()
	end

	self:RevertCameraParams()
	PosterGirlDlcActor.super.Dispose(self)
end

function PosterGirlDlcActor:ResetBlendShapes()
	return
end

function PosterGirlDlcActor:PlayEffect(arg_37_1, arg_37_2, arg_37_3)
	return self:GetHeroTimelineMgr():_GetTimeline():GetTimelineBrain():PlayEffect(arg_37_1, arg_37_2, arg_37_3)
end

function PosterGirlDlcActor:StopEffect(arg_38_1)
	self:GetHeroTimelineMgr():_GetTimeline():GetTimelineBrain():StopEffect(arg_38_1)
end

function PosterGirlDlcActor:SwipeToLeft()
	return
end

function PosterGirlDlcActor:SwipeToRight()
	return
end

function PosterGirlDlcActor:DOEndDrag()
	self:AddInteractionsTimes()
end

local var_0_2 = 0.4

function PosterGirlDlcActor:DoActionChain(arg_42_1, arg_42_2, ...)
	if arg_42_1 == nil then
		self:ChangeState(PosterGirlConst.StateKay.init)
	else
		self:ChangeState(PosterDlcCustomState)
		self:AddInteractionsTimes()

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

		local var_42_2 = self:GetCurrentState()

		var_42_2:PlayAni(arg_42_1, var_42_1)
		var_42_2:SetCompleteCallback(function()
			self:DoActionChain(unpack(var_42_0))
		end)
	end
end

local var_0_3 = {
	play = function(self, ...)
		self:DoActionChain(...)
		self:RecordDoActionChain({
			...
		})
	end,
	talk = function(self, ...)
		self:DoSpecialTalk(...)
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

function PosterGirlDlcActor:OnSceneInteract(arg_51_1, ...)
	local var_51_0 = nullable(var_0_3, arg_51_1)

	if manager.posterGirl:GetViewTag() == PosterGirlConst.ViewTag.home and var_51_0 then
		var_51_0(self, ...)
	end
end

local cjson = require("cjson")

function PosterGirlDlcActor:RecordDoActionChain(arg_52_1)
	SDKTools.SendMessageToSDK("activity_combat_over", {
		sys_id = 101,
		skin_id = self.skinId,
		scene_id = HomeSceneSettingData:GetCurScene(),
		other_data = cjson.encode(arg_52_1)
	})
end

return PosterGirlDlcActor
