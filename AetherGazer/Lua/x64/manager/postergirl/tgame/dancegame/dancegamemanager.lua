local var_0_0 = import("..T0GameManagerBase")
local var_0_1 = class("DanceGameManager", var_0_0)
local var_0_2 = import(".States.Include")
local var_0_3 = {
	"head",
	"breast",
	"butt"
}

function var_0_1.Init(arg_1_0)
	var_0_1.super.Init(arg_1_0)

	arg_1_0.gameData = {}
	arg_1_0.startTime = manager.time:GetServerTime()

	local var_1_0 = manager.posterGirl.actor

	arg_1_0:SetZoomCam(var_1_0, true)
	arg_1_0:GoToState(var_0_2.EnterState)

	arg_1_0.recordData = {
		action1_2_dance_101_game = {
			0,
			0,
			0,
			0,
			0,
			0
		},
		action1_2_dance_102_game = {
			0,
			0,
			0,
			0,
			0,
			0
		},
		action1_2_dance_103_game = {
			0,
			0,
			0,
			0,
			0,
			0
		}
	}
end

function var_0_1.Reset(arg_2_0)
	arg_2_0.gameData = nil
	arg_2_0.enter = nil

	local var_2_0 = manager.posterGirl.actor

	var_2_0.zoom = nil

	var_2_0:SetCameraParams(var_2_0:GetViewDirect())
	var_2_0:SetSelfCamera(0)
	arg_2_0:RemoveAllStateEvents()
	var_0_1.super.Reset(arg_2_0)
end

var_0_1.cameraIdx = {
	beforeEnter = {
		0,
		1
	},
	game = {
		2,
		3
	}
}

function var_0_1.SetZoomCam(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0
	local var_3_1
	local var_3_2 = arg_3_0.enter and var_0_1.cameraIdx.game or var_0_1.cameraIdx.beforeEnter

	if arg_3_1.zoom then
		var_3_1, var_3_0 = unpack(var_3_2)
	else
		var_3_0, var_3_1 = unpack(var_3_2)
	end

	arg_3_0:SyncCameraAxis(var_3_0, var_3_1)
	arg_3_1.cameraManager_:SetActiveCamera(var_3_0, false, arg_3_2)
end

function var_0_1.ZoomToCamera(arg_4_0, arg_4_1)
	local var_4_0 = manager.posterGirl.actor
	local var_4_1 = GameSetting.delta_to_zoom and GameSetting.delta_to_zoom.value[1] or 10
	local var_4_2

	if var_4_1 < arg_4_1 then
		var_4_2 = true
	elseif arg_4_1 < -1 * var_4_1 then
		var_4_2 = nil
	end

	if var_4_2 ~= var_4_0.zoom then
		var_4_0.zoom = var_4_2

		arg_4_0:SetZoomCam(var_4_0)
	end
end

function var_0_1.SyncCameraAxis(arg_5_0, arg_5_1, arg_5_2)
	manager.posterGirl.actor.cameraManager_:SyncFreelookVCamMove(arg_5_1, arg_5_2)
end

function var_0_1.StartGame()
	var_0_1.super.StartGameImpl(var_0_1)
end

function var_0_1.InitGuideEffect(arg_7_0)
	local var_7_0 = manager.posterGirl.actor:GetModel().transform:Find("102003ui/effect_tips")

	arg_7_0.effect_tips = {}

	ComponentBinder.GetInstance():BindCfgUI(arg_7_0.effect_tips, var_7_0)
end

function var_0_1.SetAllGuideEffect(arg_8_0, arg_8_1)
	for iter_8_0 = 1, 3 do
		arg_8_0:SetGuideEffect(var_0_3[iter_8_0], arg_8_1)
	end
end

local function var_0_4(arg_9_0)
	local var_9_0 = UnityEngine.Camera.main.transform.forward

	var_9_0.y = 0

	local var_9_1 = arg_9_0.transform.forward

	var_9_1.y = 0

	return Vector3.Angle(-var_9_0, var_9_1) <= 30
end

function var_0_1.UpdateAllGuideEffect(arg_10_0, arg_10_1)
	for iter_10_0, iter_10_1 in pairs(var_0_3) do
		local var_10_0 = arg_10_0.effect_tips[iter_10_1]

		if not isNil(var_10_0) then
			SetActive(var_10_0, arg_10_1 and var_0_4(var_10_0))
		end
	end
end

function var_0_1.CheckInRange(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0.effect_tips[arg_11_1]

	return var_0_4(var_11_0)
end

function var_0_1.SetGuideEffect(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_0.effect_tips and arg_12_0.effect_tips[arg_12_1] then
		SetActive(arg_12_0.effect_tips[arg_12_1].gameObject, arg_12_2)
	end
end

function var_0_1.GetStateName(arg_13_0)
	return PosterGirlConst.StateKay.danceGame
end

function var_0_1.ExitGame(arg_14_0)
	local var_14_0 = manager.posterGirl.actor:GetCurrentState()

	if var_14_0 and var_14_0.gameInst then
		local var_14_1 = var_14_0.gameInst

		var_14_1:SetAllGuideEffect(false)
		var_14_1:OnExitSendMsgToSDK()
		var_14_1:GetCurMainActor():ChangeState(arg_14_0 or PosterGirlConst.StateKay.init)
		var_14_1:Reset()
	end

	manager.posterGirl:SetStateCanChange(true)
	manager.notify:Invoke(HOME_BTN_VISIBE, true)
	manager.posterGirl:ExitMiniGame()
end

var_0_1.GameResult = {
	Canceled = 3,
	Lose = 2,
	Win = 1
}

function var_0_1.OnExitSendMsgToSDK(arg_15_0)
	local var_15_0 = PlayerData:GetPosterGirlHeroSkinId()
	local var_15_1 = HomeSceneSettingData:GetCurScene()

	SDKTools.SendMessageToSDK("activity_combat_over", {
		stage_id = 1,
		sys_id = 101,
		skin_id = var_15_0,
		scene_id = var_15_1,
		posture_list = arg_15_0.lastAction or "",
		start_time = arg_15_0.startTime,
		other_data = SDKTools.JsonEncode(arg_15_0.recordData)
	})
end

return var_0_1
