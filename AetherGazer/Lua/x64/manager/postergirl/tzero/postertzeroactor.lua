local var_0_0 = require("game.config.HomeSceneViewCfg")
local var_0_1 = class("PosterGirlDlcActor", PosterGirlDlcActor)
local var_0_2 = PosterGirlConst.ViewDirect.center

local function var_0_3(arg_1_0, arg_1_1)
	return HomeSceneSettingData:HasSpecialViewUnlocked(arg_1_0, arg_1_1)
end

local function var_0_4(arg_2_0)
	local var_2_0 = PosterGirlTools.GetSceneCamViews(arg_2_0)
	local var_2_1 = {}

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		if var_0_3(arg_2_0, iter_2_1) then
			table.insert(var_2_1, iter_2_1)
		end
	end

	return var_2_1, #var_2_1
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
		return var_5_1[(PosterGirlTools.IsLoopSwitch(var_5_0) and var_0_5 or var_0_6)(var_5_2, var_5_3, arg_5_0)]
	else
		return PosterGirlConst.ViewDirect.center
	end
end

var_0_1.SwipeDir = PosterGirlConst.SwipeDir

local function var_0_8(arg_6_0)
	if arg_6_0 == var_0_1.SwipeDir.Left then
		return var_0_1.SwipeDir.Right
	elseif arg_6_0 == var_0_1.SwipeDir.Right then
		return var_0_1.SwipeDir.Left
	end

	return var_0_1.SwipeDir.None
end

function var_0_1.Init(arg_7_0)
	local var_7_0 = manager.posterGirl:GetCurScene()

	arg_7_0:SetViewDirect(HomeSceneSettingData:HasSpecialViewCfg(var_7_0) or var_0_2 or PosterGirlConst.ViewDirect.center)
	arg_7_0:InitSceneInfo()
end

function var_0_1.GetTag(arg_8_0)
	return PosterGirlConst.PosterGirlTag.t0
end

function var_0_1.GetViewDirect(arg_9_0)
	local var_9_0

	if manager.posterGirl:GetViewTag() == PosterGirlConst.ViewTag.preview then
		local var_9_1 = manager.posterGirl:GetCurScene()

		var_9_0 = HomeSceneSettingData:HasSpecialViewCfg(var_9_1) or var_0_2
	else
		var_9_0 = var_0_2
	end

	return arg_9_0:EnsureViewDirection(var_9_0)
end

function var_0_1.GetViewCnt(arg_10_0)
	local var_10_0 = manager.posterGirl:GetCurScene()
	local var_10_1, var_10_2 = var_0_4(var_10_0)

	return var_10_2
end

function var_0_1.SetViewDirect(arg_11_0, arg_11_1)
	if manager.posterGirl:GetViewTag() == PosterGirlConst.ViewTag.preview then
		local var_11_0 = manager.posterGirl:GetCurScene()

		if arg_11_1 == HomeSceneSettingData:HasSpecialViewCfg(var_11_0) then
			return
		end
	end

	var_0_2 = arg_11_0:EnsureViewDirection(arg_11_1)
end

function var_0_1.GetCurSceneDefaultViewDirection(arg_12_0)
	local var_12_0 = manager.posterGirl:GetCurScene()

	return HomeSceneSettingData:HasSpecialViewCfg(var_12_0) or PosterGirlConst.ViewDirect.center
end

function var_0_1.EnsureViewDirection(arg_13_0, arg_13_1)
	if not arg_13_0:GetDirectIsExist(var_0_2) then
		return arg_13_0:GetCurSceneDefaultViewDirection()
	end

	if not var_0_3(HomeSceneSettingData:GetCurScene(), arg_13_1) then
		return arg_13_0:GetCurSceneDefaultViewDirection()
	end

	return arg_13_1
end

function var_0_1.GetHeroPosAndRotCfg(arg_14_0, arg_14_1)
	local var_14_0
	local var_14_1 = arg_14_0:GetSceneID()
	local var_14_2 = CustomCenterTools.GetDlcMatchSkinIndex(var_14_1, arg_14_0.skinId)

	if var_14_2 then
		var_14_0 = arg_14_0.skinId * 100 + arg_14_1 + (var_14_2 - 1) * 10
	end

	return nullable(HeroPosAndRotCfg, var_14_0)
end

function var_0_1.GetDirectIsExist(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0:GetSceneID()
	local var_15_1 = PosterGirlTools.GetSceneCamViews(var_15_0)

	return table.indexof(var_15_1, arg_15_1)
end

function var_0_1.BeforeDebut(arg_16_0)
	local var_16_0 = manager.posterGirl:GetCurScene()
	local var_16_1 = HomeSceneSettingData:HasSpecialViewCfg(var_16_0) or PosterGirlConst.ViewDirect.center

	arg_16_0:SetViewDirect(var_16_1)
	arg_16_0:UpdateCameraParams()
end

var_0_1.camMoveXFactor = 0.05
var_0_1.TweenEaseType = {
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
		arg_17_0.cameraManager_:SetCameraPosWithMoveX(arg_17_2 * var_0_1.camMoveXFactor, function()
			arg_17_0.cameraManager_:ResetCameraDefaultCfg()

			if arg_17_3 then
				arg_17_3()
			end
		end, var_0_1.TweenEaseType[2])
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

function var_0_1.UpdateCameraParamsByViewPoint(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	(arg_20_1 and var_0_10 or var_0_9)(arg_20_0, arg_20_0:GetViewDirect(), arg_20_2, arg_20_3)
end

function var_0_1.UpdateCameraParams(arg_21_0)
	var_0_10(arg_21_0, arg_21_0:GetViewDirect())
end

function var_0_1.SwipeViewDir(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0:GetViewDirect()

	if arg_22_1 == var_0_1.SwipeDir.None then
		return var_22_0
	end

	arg_22_0.startSwipeView = arg_22_0.startSwipeView or var_22_0
	arg_22_0.startSwipeDir = arg_22_0.startSwipeDir or arg_22_1
	arg_22_0.endSwipeView = arg_22_0.endSwipeView or var_0_7(arg_22_1, arg_22_0.startSwipeView)

	if arg_22_1 == arg_22_0.startSwipeDir then
		return arg_22_0.endSwipeView
	else
		return var_0_7(arg_22_1, arg_22_0.endSwipeView)
	end
end

function var_0_1.CanSwipe(arg_23_0, arg_23_1, arg_23_2)
	if arg_23_0.cameraManager_.IsTweening then
		return false
	end

	if arg_23_1 == var_0_1.SwipeDir.None then
		return false
	end

	arg_23_2 = arg_23_2 or arg_23_0:GetViewDirect()

	local var_23_0

	if arg_23_1 == arg_23_0.startSwipeDir then
		var_23_0 = arg_23_0.endSwipeView or var_0_7(arg_23_1, arg_23_2)
	else
		var_23_0 = var_0_7(arg_23_1, arg_23_2)
	end

	return arg_23_2 ~= var_23_0
end

local function var_0_11(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	arg_24_0.cameraManager_:AddCameraPosWithMoveX(-arg_24_3 * var_0_1.camMoveXFactor, function()
		arg_24_0:SetViewDirect(arg_24_2)
		arg_24_0:ChangeState(PosterGirlConst.StateKay.init_no_blend, true)
		arg_24_0:UpdateCameraParamsByViewPoint(false, arg_24_3, function()
			manager.notify:CallUpdateFunc("UpdatePosterGirlBtn")
		end)
		arg_24_0:OnViewDirectChange(arg_24_2, arg_24_1)
	end, var_0_1.TweenEaseType[1])
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

function var_0_1.SwipeAction(arg_28_0, arg_28_1)
	if arg_28_0.cameraManager_.IsTweening then
		return
	end

	arg_28_0.curSwipeDir = arg_28_1

	local var_28_0 = arg_28_0:GetViewDirect()
	local var_28_1 = arg_28_0:SwipeViewDir(arg_28_1)

	if var_28_0 ~= var_28_1 then
		local var_28_2 = manager.posterGirl:GetCurScene()

		if PosterGirlTools.GetSceneChangeViewType(var_28_2) == PosterGirlConst.ChangeViewType.ChangeState then
			var_0_13(arg_28_0, var_28_0, var_28_1, arg_28_1)
		else
			var_0_11(arg_28_0, var_28_0, var_28_1, arg_28_1)
		end
	end
end

function var_0_1.SwipeToLeft(arg_29_0)
	local var_29_0 = arg_29_0:GetCurrentState()

	if var_29_0.SwipeToLeft then
		local var_29_1, var_29_2 = var_29_0:SwipeToLeft(var_0_1.SwipeDir.Left)

		arg_29_0:OnViewDirectChange(var_29_1, var_29_2)
	else
		arg_29_0:SwipeAction(var_0_1.SwipeDir.Left)
	end
end

function var_0_1.SwipeToRight(arg_30_0)
	local var_30_0 = arg_30_0:GetCurrentState()

	if var_30_0.SwipeToRight then
		local var_30_1, var_30_2 = var_30_0:SwipeToRight(var_0_1.SwipeDir.Right)

		arg_30_0:OnViewDirectChange(var_30_1, var_30_2)
	else
		arg_30_0:SwipeAction(var_0_1.SwipeDir.Right)
	end
end

function var_0_1.OnViewDirectChange(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = manager.posterGirl:GetCurScene()

	if arg_31_1 ~= arg_31_2 then
		if PosterGirlTools.IsInterruptCurAni(var_31_0) then
			manager.notify:CallUpdateFunc("ClearHomePosterTalk")
			arg_31_0:StopHeroTalk()
		end

		HomeSceneSettingAction.SelectSceneView(var_31_0, arg_31_1)
		manager.notify:CallUpdateFunc("UpdatePosterGirlBtn")
	end
end

function var_0_1.TouchHelpSingleDrag(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = GameSetting.drag_to_move_speed and GameSetting.drag_to_move_speed.value[1] or 200
	local var_32_1 = PosterGirlTools.CanInterruptCurAni()

	if arg_32_0.cameraManager_ == nil or not var_32_1 then
		return
	end

	local var_32_2 = SettingData:GetGameSettingData().home_scene_dlc_btn == 0

	if var_32_2 and arg_32_1 < -1 * var_32_0 and arg_32_0:CanSwipe(PosterGirlConst.SwipeDir.Left) then
		arg_32_0:SwipeToLeft()
	elseif var_32_2 and var_32_0 < arg_32_1 and arg_32_0:CanSwipe(PosterGirlConst.SwipeDir.Right) then
		arg_32_0:SwipeToRight()
	elseif not arg_32_0.cameraManager_.IsTweening then
		arg_32_0.curSwipeDir = var_0_1.SwipeDir.None

		arg_32_0.cameraManager_:RotateCamera(arg_32_1, arg_32_2)
	end
end

local function var_0_14(arg_33_0)
	local var_33_0 = tonumber(arg_33_0)
	local var_33_1 = HomeSceneCfg.get_id_list_by_type[SceneConst.HOME_SCENE_IMPACT.TIME]

	for iter_33_0, iter_33_1 in ipairs(var_33_1) do
		local var_33_2 = HomeSceneCfg[iter_33_1]
		local var_33_3 = var_33_2.start_time
		local var_33_4 = var_33_2.end_time

		if var_33_3 <= var_33_0 and var_33_0 <= var_33_4 then
			return var_33_2.action_suffix
		end
	end

	return nil
end

function var_0_1.InitSceneInfo(arg_34_0)
	local var_34_0 = arg_34_0:GetSceneID()
	local var_34_1 = HomeSceneSettingCfg[var_34_0]
	local var_34_2 = manager.time:GetServerTime()

	for iter_34_0, iter_34_1 in ipairs(var_34_1.impact) do
		if iter_34_1 == SceneConst.HOME_SCENE_IMPACT.WEATHER then
			-- block empty
		elseif iter_34_1 == SceneConst.HOME_SCENE_IMPACT.DATA then
			-- block empty
		elseif iter_34_1 == SceneConst.HOME_SCENE_IMPACT.TIME then
			local var_34_3 = manager.time:STimeDescS(var_34_2, "!%H")

			arg_34_0.time_param = var_0_14(var_34_3)
		end
	end
end

function var_0_1.GetTimeParam(arg_35_0)
	return arg_35_0.time_param
end

function var_0_1.DOEndDrag(arg_36_0)
	var_0_1.super.DOEndDrag(arg_36_0)

	arg_36_0.startSwipeDir = nil
	arg_36_0.startSwipeView = nil
	arg_36_0.endSwipeView = nil
end

return var_0_1
