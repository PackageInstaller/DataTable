local HomeSceneViewCfg = require("game.config.HomeSceneViewCfg")
local PosterGirlDlcActor = class("PosterGirlDlcActor", PosterGirlDlcActor)
local var_0_2 = PosterGirlConst.ViewDirect.center

local function var_0_3(arg_1_0, arg_1_1)
	return HomeSceneSettingData:HasSpecialViewUnlocked(arg_1_0, arg_1_1)
end

local function var_0_4(arg_2_0)
	local var_2_0 = {}

	for iter_2_0, iter_2_1 in ipairs((PosterGirlTools.GetSceneCamViews(arg_2_0))) do
		if var_0_3(arg_2_0, iter_2_1) then
			table.insert(var_2_0, iter_2_1)
		end
	end

	return var_2_0, #var_2_0
end

local function var_0_5(arg_3_0, arg_3_1, arg_3_2)
	return (arg_3_1 + arg_3_2 + arg_3_0 - 1) % arg_3_0 + 1
end

local function var_0_6(arg_4_0, arg_4_1, arg_4_2)
	return math.max(1, math.min(arg_4_1 + arg_4_2, arg_4_0))
end

local function var_0_7(arg_5_0, arg_5_1)
	local var_5_0 = manager.posterGirl:GetCurScene()
	local var_5_1, var_5_2 = var_0_4(var_5_0)
	local var_5_3 = table.indexof(var_5_1, arg_5_1)

	if var_5_3 and var_5_2 >= 1 then
		return var_5_1[((PosterGirlTools.IsLoopSwitch(var_5_0) or nil) and (var_0_5 or var_0_6))(var_5_2, var_5_3, arg_5_0)]
	else
		return PosterGirlConst.ViewDirect.center
	end
end

PosterGirlDlcActor.SwipeDir = PosterGirlConst.SwipeDir

function PosterGirlDlcActor:Init()
	self:SetViewDirect(HomeSceneSettingData:HasSpecialViewCfg((manager.posterGirl:GetCurScene())) or var_0_2 or PosterGirlConst.ViewDirect.center)
	self:InitSceneInfo()
end

function PosterGirlDlcActor:GetTag()
	return PosterGirlConst.PosterGirlTag.t0
end

function PosterGirlDlcActor:GetViewDirect()
	return self:EnsureViewDirection(manager.posterGirl:GetViewTag() == PosterGirlConst.ViewTag.preview and (HomeSceneSettingData:HasSpecialViewCfg((manager.posterGirl:GetCurScene())) or var_0_2) or var_0_2)
end

function PosterGirlDlcActor:GetViewCnt()
	local var_10_0, var_10_1 = var_0_4((manager.posterGirl:GetCurScene()))

	return var_10_1
end

function PosterGirlDlcActor:SetViewDirect(arg_11_1)
	if manager.posterGirl:GetViewTag() == PosterGirlConst.ViewTag.preview and arg_11_1 == HomeSceneSettingData:HasSpecialViewCfg((manager.posterGirl:GetCurScene())) then
		return
	end

	var_0_2 = self:EnsureViewDirection(arg_11_1)
end

function PosterGirlDlcActor:GetCurSceneDefaultViewDirection()
	return HomeSceneSettingData:HasSpecialViewCfg((manager.posterGirl:GetCurScene())) or PosterGirlConst.ViewDirect.center
end

function PosterGirlDlcActor:EnsureViewDirection(arg_13_1)
	if not self:GetDirectIsExist(var_0_2) then
		return self:GetCurSceneDefaultViewDirection()
	end

	if not var_0_3(HomeSceneSettingData:GetCurScene(), arg_13_1) then
		return self:GetCurSceneDefaultViewDirection()
	end

	return arg_13_1
end

function PosterGirlDlcActor:GetHeroPosAndRotCfg(arg_14_1)
	local var_14_1 = CustomCenterTools.GetDlcMatchSkinIndex(self:GetSceneID(), self.skinId)

	return nullable(HeroPosAndRotCfg, (var_14_1 or nil) and self.skinId * 100 + arg_14_1 + (var_14_1 - 1) * 10)
end

function PosterGirlDlcActor:GetDirectIsExist(arg_15_1)
	return table.indexof(PosterGirlTools.GetSceneCamViews((self:GetSceneID())), arg_15_1)
end

function PosterGirlDlcActor:BeforeDebut()
	self:SetViewDirect(HomeSceneSettingData:HasSpecialViewCfg((manager.posterGirl:GetCurScene())) or PosterGirlConst.ViewDirect.center)
	self:UpdateCameraParams()
end

PosterGirlDlcActor.camMoveXFactor = 0.05
PosterGirlDlcActor.TweenEaseType = {
	LeanTweenType.easeInCubic,
	LeanTweenType.easeOutCubic
}

local function var_0_9(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	if arg_17_0.cameraManager_ == nil then
		if arg_17_3 then
			arg_17_3()
		end
	else
		arg_17_2 = arg_17_2 or arg_17_0.curSwipeDir

		arg_17_0.cameraManager_:SetCameraParams(arg_17_1)
		arg_17_0.cameraManager_:ResetCameraDefaultCfg()
		arg_17_0.cameraManager_:SetCameraPosWithMoveX(arg_17_2 * PosterGirlDlcActor.camMoveXFactor, function()
			arg_17_0.cameraManager_:ResetCameraDefaultCfg()

			if arg_17_3 then
				arg_17_3()
			end
		end, PosterGirlDlcActor.TweenEaseType[2])
	end
end

local function var_0_10(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	if arg_19_0.cameraManager_ == nil then
		if arg_19_3 then
			arg_19_3()
		end
	else
		arg_19_0.cameraManager_:RemoveTween()
		arg_19_0.cameraManager_:SetCameraParams(arg_19_1)
		arg_19_0:SetSelfCamera(0, true)

		if arg_19_3 then
			arg_19_3()
		end
	end
end

function PosterGirlDlcActor:UpdateCameraParamsByViewPoint(arg_20_1, arg_20_2, arg_20_3)
	((arg_20_1 or nil) and (var_0_10 or var_0_9))(self, self:GetViewDirect(), arg_20_2, arg_20_3)
end

function PosterGirlDlcActor:UpdateCameraParams()
	var_0_10(self, self:GetViewDirect())
end

function PosterGirlDlcActor:SwipeViewDir(arg_22_1)
	local var_22_0 = self:GetViewDirect()

	if arg_22_1 == PosterGirlDlcActor.SwipeDir.None then
		return var_22_0
	end

	self.startSwipeView = self.startSwipeView or var_22_0
	self.startSwipeDir = self.startSwipeDir or arg_22_1
	self.endSwipeView = self.endSwipeView or var_0_7(arg_22_1, self.startSwipeView)

	if arg_22_1 == self.startSwipeDir then
		return self.endSwipeView
	else
		return var_0_7(arg_22_1, self.endSwipeView)
	end
end

function PosterGirlDlcActor:CanSwipe(arg_23_1, arg_23_2)
	if self.cameraManager_.IsTweening then
		return false
	end

	if arg_23_1 == PosterGirlDlcActor.SwipeDir.None then
		return false
	end

	arg_23_2 = arg_23_2 or self:GetViewDirect()

	return arg_23_2 ~= (arg_23_1 == self.startSwipeDir and (self.endSwipeView or var_0_7(arg_23_1, arg_23_2)) or var_0_7(arg_23_1, arg_23_2))
end

local function var_0_11(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	arg_24_0.cameraManager_:AddCameraPosWithMoveX(-arg_24_3 * PosterGirlDlcActor.camMoveXFactor, function()
		arg_24_0:SetViewDirect(arg_24_2)
		arg_24_0:ChangeState(PosterGirlConst.StateKay.init_no_blend, true)
		arg_24_0:UpdateCameraParamsByViewPoint(false, arg_24_3, function()
			manager.notify:CallUpdateFunc("UpdatePosterGirlBtn")
		end)
		arg_24_0:OnViewDirectChange(arg_24_2, arg_24_1)
	end, PosterGirlDlcActor.TweenEaseType[1])
end

local var_0_12 = {
	[PosterGirlConst.ViewDirect.left] = {
		[PosterGirlConst.ViewDirect.center] = PosterGirlConst.StateKay.left2mid,
		[PosterGirlConst.ViewDirect.right] = PosterGirlConst.StateKay.left2right
	},
	[PosterGirlConst.ViewDirect.center] = {
		[PosterGirlConst.ViewDirect.left] = PosterGirlConst.StateKay.mid2left,
		[PosterGirlConst.ViewDirect.right] = PosterGirlConst.StateKay.mid2right
	},
	[PosterGirlConst.ViewDirect.right] = {
		[PosterGirlConst.ViewDirect.center] = PosterGirlConst.StateKay.right2mid,
		[PosterGirlConst.ViewDirect.left] = PosterGirlConst.StateKay.right2left
	}
}

local function var_0_13(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	local var_27_0 = nullable(var_0_12, arg_27_1, arg_27_2)

	if var_27_0 == nil then
		return
	end

	arg_27_0:SetViewDirect(arg_27_2)
	arg_27_0:ChangeState(var_27_0)
	arg_27_0:OnViewDirectChange(arg_27_2, arg_27_1)
end

function PosterGirlDlcActor:SwipeAction(arg_28_1)
	if self.cameraManager_.IsTweening then
		return
	end

	self.curSwipeDir = arg_28_1

	local var_28_0 = self:GetViewDirect()
	local var_28_1 = self:SwipeViewDir(arg_28_1)

	if var_28_0 ~= var_28_1 then
		if PosterGirlTools.GetSceneChangeViewType((manager.posterGirl:GetCurScene())) == PosterGirlConst.ChangeViewType.ChangeState then
			var_0_13(self, var_28_0, var_28_1, arg_28_1)
		else
			var_0_11(self, var_28_0, var_28_1, arg_28_1)
		end
	end
end

function PosterGirlDlcActor:SwipeToLeft()
	local var_29_0 = self:GetCurrentState()

	if var_29_0.SwipeToLeft then
		local var_29_1, var_29_2 = var_29_0:SwipeToLeft(PosterGirlDlcActor.SwipeDir.Left)

		self:OnViewDirectChange(var_29_1, var_29_2)
	else
		self:SwipeAction(PosterGirlDlcActor.SwipeDir.Left)
	end
end

function PosterGirlDlcActor:SwipeToRight()
	local var_30_0 = self:GetCurrentState()

	if var_30_0.SwipeToRight then
		local var_30_1, var_30_2 = var_30_0:SwipeToRight(PosterGirlDlcActor.SwipeDir.Right)

		self:OnViewDirectChange(var_30_1, var_30_2)
	else
		self:SwipeAction(PosterGirlDlcActor.SwipeDir.Right)
	end
end

function PosterGirlDlcActor:OnViewDirectChange(arg_31_1, arg_31_2)
	local var_31_0 = manager.posterGirl:GetCurScene()

	if arg_31_1 ~= arg_31_2 then
		if PosterGirlTools.IsInterruptCurAni(var_31_0) then
			manager.notify:CallUpdateFunc("ClearHomePosterTalk")
			self:StopHeroTalk()
		end

		HomeSceneSettingAction.SelectSceneView(var_31_0, arg_31_1)
		manager.notify:CallUpdateFunc("UpdatePosterGirlBtn")
	end
end

function PosterGirlDlcActor:TouchHelpSingleDrag(arg_32_1, arg_32_2)
	local var_32_0

	if GameSetting.drag_to_move_speed then
		var_32_0 = GameSetting.drag_to_move_speed.value[1] or 200
	end

	if self.cameraManager_ == nil or not PosterGirlTools.CanInterruptCurAni() then
		return
	end

	local var_32_1 = SettingData:GetGameSettingData().home_scene_dlc_btn == 0

	if var_32_1 and arg_32_1 < -1 * var_32_0 and self:CanSwipe(PosterGirlConst.SwipeDir.Left) then
		self:SwipeToLeft()
	elseif var_32_1 and var_32_0 < arg_32_1 and self:CanSwipe(PosterGirlConst.SwipeDir.Right) then
		self:SwipeToRight()
	elseif not self.cameraManager_.IsTweening then
		self.curSwipeDir = PosterGirlDlcActor.SwipeDir.None

		self.cameraManager_:RotateCamera(arg_32_1, arg_32_2)
	end
end

local function var_0_14(arg_33_0)
	local var_33_0 = tonumber(arg_33_0)

	for iter_33_0, iter_33_1 in ipairs(HomeSceneCfg.get_id_list_by_type[SceneConst.HOME_SCENE_IMPACT.TIME]) do
		if HomeSceneCfg[iter_33_1].start_time <= var_33_0 and var_33_0 <= HomeSceneCfg[iter_33_1].end_time then
			return HomeSceneCfg[iter_33_1].action_suffix
		end
	end

	return nil
end

function PosterGirlDlcActor:InitSceneInfo()
	local var_34_0 = manager.time:GetServerTime()

	for iter_34_0, iter_34_1 in ipairs(HomeSceneSettingCfg[self:GetSceneID()].impact) do
		if iter_34_1 == SceneConst.HOME_SCENE_IMPACT.WEATHER then
			-- block empty
		elseif iter_34_1 == SceneConst.HOME_SCENE_IMPACT.DATA then
			-- block empty
		elseif iter_34_1 == SceneConst.HOME_SCENE_IMPACT.TIME then
			self.time_param = var_0_14((manager.time:STimeDescS(var_34_0, "!%H")))
		end
	end
end

function PosterGirlDlcActor:GetTimeParam()
	return self.time_param
end

function PosterGirlDlcActor:DOEndDrag()
	PosterGirlDlcActor.super.DOEndDrag(self)

	self.startSwipeDir = nil
	self.startSwipeView = nil
	self.endSwipeView = nil
end

return PosterGirlDlcActor
