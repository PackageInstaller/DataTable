local DanceGameManager = class("DanceGameManager", (import("..T0GameManagerBase")))
local Include = import(".States.Include")
local var_0_2 = {
	"head",
	"breast",
	"butt"
}

function DanceGameManager:Init()
	DanceGameManager.super.Init(self)

	self.gameData = {}
	self.startTime = manager.time:GetServerTime()

	self:SetZoomCam(manager.posterGirl.actor, true)
	self:GoToState(Include.EnterState)

	self.recordData = {
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

function DanceGameManager:Reset()
	self.gameData = nil
	self.enter = nil
	manager.posterGirl.actor.zoom = nil

	manager.posterGirl.actor:SetCameraParams(manager.posterGirl.actor:GetViewDirect())
	manager.posterGirl.actor:SetSelfCamera(0)
	self:RemoveAllStateEvents()
	DanceGameManager.super.Reset(self)
end

DanceGameManager.cameraIdx = {
	beforeEnter = {
		0,
		1
	},
	game = {
		2,
		3
	}
}

function DanceGameManager:SetZoomCam(arg_3_1, arg_3_2)
	local var_3_0
	local var_3_1
	local var_3_2

	if self.enter then
		var_3_2 = DanceGameManager.cameraIdx.game or DanceGameManager.cameraIdx.beforeEnter

		if arg_3_1.zoom then
			var_3_1, var_3_0 = unpack(var_3_2)

			goto label_3_0
		end
	end

	var_3_0, var_3_1 = unpack(var_3_2)

	::label_3_0::

	self:SyncCameraAxis(var_3_0, var_3_1)
	arg_3_1.cameraManager_:SetActiveCamera(var_3_0, false, arg_3_2)
end

function DanceGameManager:ZoomToCamera(arg_4_1)
	local var_4_0 = manager.posterGirl.actor
	local var_4_1

	if GameSetting.delta_to_zoom then
		var_4_1 = GameSetting.delta_to_zoom.value[1] or 10
	end

	local var_4_2

	if var_4_1 < arg_4_1 then
		var_4_2 = true
	elseif arg_4_1 < -1 * var_4_1 then
		var_4_2 = nil
	end

	if var_4_2 ~= var_4_0.zoom then
		var_4_0.zoom = var_4_2

		self:SetZoomCam(var_4_0)
	end
end

function DanceGameManager:SyncCameraAxis(arg_5_1, arg_5_2)
	manager.posterGirl.actor.cameraManager_:SyncFreelookVCamMove(arg_5_1, arg_5_2)
end

function DanceGameManager.StartGame()
	DanceGameManager.super.StartGameImpl(DanceGameManager)
end

function DanceGameManager:InitGuideEffect()
	self.effect_tips = {}

	ComponentBinder.GetInstance():BindCfgUI(self.effect_tips, (manager.posterGirl.actor:GetModel().transform:Find("102003ui/effect_tips")))
end

function DanceGameManager:SetAllGuideEffect(arg_8_1)
	for iter_8_0 = 1, 3 do
		self:SetGuideEffect(var_0_2[iter_8_0], arg_8_1)
	end
end

local function var_0_3(arg_9_0)
	local var_9_0 = UnityEngine.Camera.main.transform.forward

	var_9_0.y = 0

	local var_9_1 = arg_9_0.transform.forward

	var_9_1.y = 0

	return Vector3.Angle(-var_9_0, var_9_1) <= 30
end

function DanceGameManager:UpdateAllGuideEffect(arg_10_1)
	for iter_10_0, iter_10_1 in pairs(var_0_2) do
		if not isNil(self.effect_tips[iter_10_1]) then
			SetActive(self.effect_tips[iter_10_1], arg_10_1 and var_0_3(self.effect_tips[iter_10_1]))
		end
	end
end

function DanceGameManager:CheckInRange(arg_11_1)
	return var_0_3(self.effect_tips[arg_11_1])
end

function DanceGameManager:SetGuideEffect(arg_12_1, arg_12_2)
	if self.effect_tips and self.effect_tips[arg_12_1] then
		SetActive(self.effect_tips[arg_12_1].gameObject, arg_12_2)
	end
end

function DanceGameManager:GetStateName()
	return PosterGirlConst.StateKay.danceGame
end

function DanceGameManager:ExitGame()
	local var_14_0 = manager.posterGirl.actor:GetCurrentState()

	if var_14_0 and var_14_0.gameInst then
		var_14_0.gameInst:SetAllGuideEffect(false)
		var_14_0.gameInst:OnExitSendMsgToSDK()
		var_14_0.gameInst:GetCurMainActor():ChangeState(self or PosterGirlConst.StateKay.init)
		var_14_0.gameInst:Reset()
	end

	manager.posterGirl:SetStateCanChange(true)
	manager.notify:Invoke(HOME_BTN_VISIBE, true)
	manager.posterGirl:ExitMiniGame()
end

DanceGameManager.GameResult = {
	Canceled = 3,
	Lose = 2,
	Win = 1
}

function DanceGameManager:OnExitSendMsgToSDK()
	local var_15_0 = {
		stage_id = 1,
		sys_id = 101,
		skin_id = PlayerData:GetPosterGirlHeroSkinId(),
		scene_id = HomeSceneSettingData:GetCurScene()
	}

	var_15_0.posture_list = self.lastAction or ""
	var_15_0.start_time = self.startTime
	var_15_0.other_data = SDKTools.JsonEncode(self.recordData)

	SDKTools.SendMessageToSDK("activity_combat_over", var_15_0)
end

return DanceGameManager
