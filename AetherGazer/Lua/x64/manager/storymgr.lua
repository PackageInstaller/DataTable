local var_0_0 = class("StoryMgr", import("game.extend.BaseView"))
local var_0_1 = 1
local var_0_2 = {}

function var_0_0.Ctor(arg_1_0)
	arg_1_0.BEFORE = 1
	arg_1_0.WIN = 2
	arg_1_0.LOSE = 3
	arg_1_0.uiShow_ = true
	arg_1_0.cameraChanged_ = false
end

function var_0_0.InitPlayer(arg_2_0, arg_2_1)
	if not arg_2_0.timer_ then
		arg_2_0.timer_ = FuncTimerManager.inst:CreateFuncFrameTimer(function()
			if arg_2_0.player_ then
				arg_2_0.player_:Update(Time.deltaTime)
			end
		end, -1, true)
	end

	arg_2_0.stage_ = Object.Instantiate(Asset.Load("StoryTimeline/StoryStage"))
	arg_2_0.player_ = StoryPlayer.New(arg_2_0.stage_)
	arg_2_0.uiShow_ = true
	arg_2_0.cameraChanged_ = false
end

function var_0_0.RemovePlayer(arg_4_0)
	manager.video:HidePlayer()

	if arg_4_0.player_ then
		arg_4_0:ShowMainUI()
		manager.notify:CallUpdateFunc(WIN_STORY_END)
		arg_4_0.player_:Dispose()

		arg_4_0.player_ = nil
	end
end

function var_0_0.StartStory(arg_5_0, arg_5_1)
	local var_5_0 = manager.ui:GetUISeparateRender()
	local var_5_1 = StoryCfg[arg_5_1]

	if var_5_1.trigger[4] == 1 then
		gameContext:Go("/blank")
		manager.audio:Pause("music", true)
		manager.video:Play(var_5_1.videoPath, function(arg_6_0)
			local var_6_0 = PlayerData:GetStoryList()
			local var_6_1
			local var_6_2 = var_6_0[arg_5_1] and 0 or 1

			SDKTools.SendMessageToSDK("story_oper", {
				oper = arg_6_0,
				is_first = var_6_2,
				story_id = string.format(arg_5_1)
			})
			gameContext:Back()
			PlayerAction.ChangeStoryList(arg_5_1)
			manager.audio:Pause("music", false)
		end, nil, nil, nil, var_5_1.videoId)

		return
	end

	arg_5_0:InitPlayer()
	arg_5_0:SetStagePos()

	local var_5_2, var_5_3 = arg_5_0:SetCameraParam()

	arg_5_0:HideMainUI()

	function arg_5_0.player_.onStoryFinished_(arg_7_0)
		arg_5_0:SendStoryToSdk(arg_5_1, arg_7_0)
		arg_5_0:ShowMainUI()
		manager.notify:CallUpdateFunc(WIN_STORY_END)
		arg_5_0:ResetCameraParam(var_5_2, var_5_3)

		Input.multiTouchEnabled = true

		arg_5_0.player_:Dispose()

		arg_5_0.player_ = nil

		PlayGameSetBGM()
		manager.ui:SetUISeparateRender(var_5_0)

		if var_5_1.videoPath and var_5_1.videoPath ~= "" then
			gameContext:Go("/blank")
			manager.audio:PauseAll(true)
			manager.video:Play(var_5_1.videoPath, function()
				gameContext:Back()
				PlayerAction.ChangeStoryList(arg_5_1)
				manager.audio:PauseAll(false)
			end, nil, nil, nil, var_5_1.videoId)

			return
		end

		manager.notify:Invoke(PLAY_STORY_FINISH)
	end

	arg_5_0.player_:Play(arg_5_1)
end

function var_0_0.StartStoryById(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = StoryCfg[arg_9_1]

	if var_9_0.trigger[4] == 1 then
		manager.audio:Pause("music", true)
		manager.video:Play(var_9_0.videoPath, function(arg_10_0)
			local var_10_0 = PlayerData:GetStoryList()
			local var_10_1
			local var_10_2 = var_10_0[arg_9_1] and 0 or 1

			SDKTools.SendMessageToSDK("story_oper", {
				oper = arg_10_0,
				is_first = var_10_2,
				story_id = string.format(arg_9_1)
			})
			arg_9_2()
			PlayerAction.ChangeStoryList(arg_9_1)
			manager.audio:Pause("music", false)
		end, nil, nil, nil, var_9_0.videoId)

		return
	end

	arg_9_0:InitPlayer()
	arg_9_0:SetStagePos()

	local var_9_1, var_9_2 = arg_9_0:SetCameraParam()

	arg_9_0:HideMainUI()

	function arg_9_0.player_.onStoryFinished_(arg_11_0)
		arg_9_0:SendStoryToSdk(arg_9_1, arg_11_0)
		arg_9_0:ShowMainUI()
		manager.notify:CallUpdateFunc(WIN_STORY_END)
		arg_9_0:ResetCameraParam(var_9_1, var_9_2)

		Input.multiTouchEnabled = true

		arg_9_0.player_:Dispose()

		arg_9_0.player_ = nil

		PlayerAction.ChangeStoryList(arg_9_1)
		arg_9_2()
	end

	arg_9_0.player_:HideSkipBtn(arg_9_3)
	arg_9_0.player_:Play(arg_9_1)
end

function var_0_0.StartStoryOnEnterChessMap(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0:InitPlayer()
	arg_12_0:SetStagePos()

	local var_12_0, var_12_1 = arg_12_0:SetCameraParam()

	arg_12_0:HideMainUI()

	function arg_12_0.player_.onStoryFinished_(arg_13_0)
		arg_12_0:SendStoryToSdk(arg_12_1, arg_13_0)
		arg_12_2()
		manager.notify:CallUpdateFunc(WIN_STORY_END)
		arg_12_0:ResetCameraParam(var_12_0, var_12_1)

		Input.multiTouchEnabled = true

		arg_12_0.player_:Dispose()

		arg_12_0.player_ = nil

		PlayerAction.ChangeStoryList(arg_12_1)
	end

	arg_12_0.player_:Play(arg_12_1)
end

function var_0_0.StartBattleStory(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	if arg_14_3 == nil then
		arg_14_3 = true
	end

	local var_14_0 = StoryCfg[arg_14_1]

	if var_14_0.trigger[4] == 1 then
		gameContext:Go("/blank")
		manager.audio:Pause("music", true)
		manager.video:Play(var_14_0.videoPath, function(arg_15_0)
			local var_15_0 = PlayerData:GetStoryList()
			local var_15_1
			local var_15_2 = var_15_0[arg_14_1] and 0 or 1

			SDKTools.SendMessageToSDK("story_oper", {
				oper = arg_15_0,
				is_first = var_15_2,
				story_id = string.format(arg_14_1)
			})
			gameContext:Back()
			arg_14_2()
			PlayerAction.ChangeStoryList(arg_14_1)
			manager.audio:Pause("music", false)
		end, true, nil, nil, var_14_0.videoId)

		return
	end

	if arg_14_3 and arg_14_0:IsStoryPlayed(arg_14_1) then
		arg_14_2()
	else
		arg_14_0:InitPlayer()

		local var_14_1 = Vector3(0, 1, -10)
		local var_14_2 = arg_14_0.stage_
		local var_14_3 = manager.ui.mainCamera.transform.forward

		var_14_3.y = 0

		local var_14_4 = manager.ui.mainCamera.transform.position - Vector3(0, var_14_1.y, 0) - var_14_3 * var_14_1.z
		local var_14_5 = manager.ui.mainCamera.transform.localEulerAngles

		var_14_5.z = 0
		var_14_5.x = 0
		var_14_2.transform.position = var_14_4
		var_14_2.transform.localEulerAngles = var_14_5

		local var_14_6, var_14_7 = arg_14_0:SetCameraParam()

		arg_14_0:HideMainUI()

		function arg_14_0.player_.onStoryFinished_(arg_16_0)
			arg_14_0:SendStoryToSdk(arg_14_1, arg_16_0)
			arg_14_0:ShowMainUI()
			manager.notify:CallUpdateFunc(WIN_STORY_END)
			arg_14_0:ResetCameraParam(var_14_6, var_14_7)

			Input.multiTouchEnabled = true

			arg_14_0.player_:Dispose()

			arg_14_0.player_ = nil

			arg_14_2()
		end

		arg_14_0.player_:Play(arg_14_1)
	end
end

function var_0_0.CheckBattleStory(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	if arg_17_4 == nil then
		arg_17_4 = true
	end

	local var_17_0
	local var_17_1

	for iter_17_0, iter_17_1 in pairs(StoryCfg) do
		local var_17_2 = iter_17_1.trigger

		if var_17_2[1] == var_0_1 and var_17_2[2] == arg_17_1 and var_17_2[3] == arg_17_2 then
			var_17_0 = iter_17_0
			var_17_1 = iter_17_1

			if var_17_2[4] == 1 then
				manager.audio:Stop("music", true)
				manager.video:Play(iter_17_1.videoPath, function(arg_18_0)
					local var_18_0 = PlayerData:GetStoryList()
					local var_18_1
					local var_18_2 = var_18_0[var_17_0] and 0 or 1

					SDKTools.SendMessageToSDK("story_oper", {
						oper = arg_18_0,
						is_first = var_18_2,
						story_id = string.format(var_17_0)
					})
					arg_17_3()
					PlayerAction.ChangeStoryList(var_17_0)
				end, false, nil, nil, iter_17_1.videoId)

				return
			end

			break
		end
	end

	if not var_17_0 or arg_17_4 and arg_17_0:IsStoryPlayed(var_17_0) then
		arg_17_3()
	else
		local function var_17_3()
			manager.uiInit()
			manager.story:InitPlayer()
			manager.story:SetStagePos()

			local var_19_0, var_19_1 = manager.story:SetCameraParam()

			manager.story:HideMainUI()

			function manager.story.player_.onStoryFinished_(arg_20_0)
				manager.story:SendStoryToSdk(var_17_0, arg_20_0)

				manager.story.player_.playNext_ = nil
				manager.story.player_.isPlay_ = false
				Input.multiTouchEnabled = true

				if var_17_1.videoPath and var_17_1.videoPath ~= "" then
					if manager.story.player_.skipView_ then
						manager.story.player_.skipView_:Dispose()

						manager.story.player_.skipView_ = nil
					end

					manager.audio:StopAll()

					manager.story.player_.blackMask_.alpha = 1

					manager.video:Play(var_17_1.videoPath, function()
						manager.story:ResetCameraParam(var_19_0, var_19_1)
						PlayerAction.ChangeStoryList(var_17_0)
						arg_17_3()
					end, nil, nil, nil, var_17_1.videoId)

					return
				end

				if arg_20_0 then
					LeanTween.cancel(manager.story.player_.blackMask_.gameObject)
					manager.story:ResetCameraParam(var_19_0, var_19_1)
					PlayerAction.ChangeStoryList(var_17_0)
					arg_17_3()
				else
					manager.story.player_.blackMask_.blocksRaycasts = true

					LeanTween.cancel(manager.story.player_.blackMask_.gameObject)
					LeanTween.alphaCanvas(manager.story.player_.blackMask_, 1, 0.5):setOnComplete(LuaHelper.VoidAction(function()
						manager.story:ResetCameraParam(var_19_0, var_19_1)
						PlayerAction.ChangeStoryList(var_17_0)
						arg_17_3()
					end))
				end
			end

			manager.story.player_:Play(var_17_0)

			if whereami ~= "battle" and whereami ~= "battleResult" then
				gameContext:SetSystemLayer("battleResult")
			end
		end

		DestroyLua()
		LuaExchangeHelper.LoadEmpty(LuaHelper.VoidAction(var_17_3))
	end
end

function var_0_0.CheckBeforeBattleStory(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	local var_23_0 = arg_23_0.BEFORE

	if arg_23_2 == nil then
		arg_23_2 = true
	end

	local var_23_1 = arg_23_1
	local var_23_2

	for iter_23_0, iter_23_1 in pairs(StoryCfg) do
		local var_23_3 = iter_23_1.trigger

		if var_23_3[1] == var_0_1 and var_23_3[2] == var_23_1 and var_23_3[3] == var_23_0 then
			var_23_2 = iter_23_0

			if var_23_3[4] == 1 then
				manager.audio:Stop("music", true)
				manager.video:Play(iter_23_1.videoPath, function(arg_24_0)
					local var_24_0 = PlayerData:GetStoryList()
					local var_24_1
					local var_24_2 = var_24_0[var_23_2] and 0 or 1

					SDKTools.SendMessageToSDK("story_oper", {
						oper = arg_24_0,
						is_first = var_24_2,
						story_id = string.format(var_23_2)
					})
					arg_23_3()
					PlayerAction.ChangeStoryList(var_23_2, function(arg_25_0, arg_25_1)
						return
					end, nil, nil, nil, iter_23_1.id)
				end)

				return
			end

			break
		end
	end

	if not var_23_2 or arg_23_2 and arg_23_0:IsStoryPlayed(var_23_2) then
		arg_23_3()
	else
		arg_23_0:InitPlayer()
		arg_23_0:SetStagePos()

		local var_23_4, var_23_5 = arg_23_0:SetCameraParam()

		arg_23_0:HideMainUI()

		function arg_23_0.player_.onStoryFinished_(arg_26_0)
			arg_23_0:SendStoryToSdk(var_23_2, arg_26_0)

			arg_23_0.player_.playNext_ = nil
			arg_23_0.player_.isPlay_ = false

			arg_23_0:ResetCameraParam(var_23_4, var_23_5)

			Input.multiTouchEnabled = true

			arg_23_3()
			PlayerAction.ChangeStoryList(var_23_2)
		end

		arg_23_0.player_:Play(var_23_2)
	end
end

function var_0_0.CheckChessBattleStory(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = WarChessData:GetTemporaryData("battle" .. arg_27_1)

	if var_27_0 and not arg_27_0:IsStoryPlayed(var_27_0) then
		arg_27_0:InitPlayer()
		arg_27_0:SetStagePos()

		local var_27_1, var_27_2 = arg_27_0:SetCameraParam()

		arg_27_0:HideMainUI()

		function arg_27_0.player_.onStoryFinished_(arg_28_0)
			arg_27_0:SendStoryToSdk(var_27_0, arg_28_0)
			arg_27_0:ResetCameraParam(var_27_1, var_27_2)

			Input.multiTouchEnabled = true
			arg_27_0.player_.playNext_ = nil
			arg_27_0.player_.isPlay_ = false

			arg_27_2()
			PlayerAction.ChangeStoryList(var_27_0)
		end

		arg_27_0.player_:Play(var_27_0)
	else
		arg_27_2()
	end
end

function var_0_0.CheckRepeatBattleStory(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	arg_29_0:CheckBeforeBattleStory(arg_29_1, false, arg_29_3)
end

function var_0_0.SetChessBG(arg_30_0, arg_30_1)
	WaitRenderFrameUtil.inst.StartScreenShot(function()
		local var_31_0 = ScreenSnap.New(Screen.width, Screen.height)

		var_31_0:Take()

		local var_31_1 = var_31_0:GetSprite()

		arg_30_1()

		local var_31_2 = arg_30_0.player_
		local var_31_3 = "ChessBG"

		if var_31_2.bgs_[var_31_3] == nil then
			local var_31_4 = Object.Instantiate(var_31_2.paintGo_)

			var_31_4:GetComponent("SpriteRenderer").sprite = var_31_1
			var_31_4.name = var_31_3
			var_31_4.transform.parent = var_31_2.stage_.transform
			var_31_4.transform.localPosition = Vector3.New(0, 100, 0)
			var_31_2.bgs_[var_31_3] = var_31_4
		end

		local var_31_5 = manager.ui.mainCamera.transform.localPosition
		local var_31_6 = Vector3.New(0, 0, 10) + Vector3.New(var_31_5.x, var_31_5.y, 0)
		local var_31_7 = var_31_2.bgs_[var_31_3]

		var_31_7.transform.localPosition = var_31_6
		var_31_7.transform.localEulerAngles = Vector3(0, 0, 0)

		local var_31_8 = var_31_7:GetComponent("SpriteRenderer")

		if var_31_8 and var_31_8.sprite then
			local var_31_9 = (var_31_7.transform.localPosition - var_31_5).z
			local var_31_10 = manager.ui.mainCameraCom_
			local var_31_11 = 2 * var_31_9 * Mathf.Tan(var_31_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
			local var_31_12 = var_31_11 * var_31_10.aspect
			local var_31_13 = var_31_8.sprite.bounds.size.x
			local var_31_14 = var_31_8.sprite.bounds.size.y
			local var_31_15 = var_31_12 / var_31_13
			local var_31_16 = var_31_11 / var_31_14
			local var_31_17 = var_31_16 < var_31_15 and var_31_15 or var_31_16

			var_31_7.transform.localScale = Vector3.New(var_31_17, var_31_17, 0)
		end
	end)
end

function var_0_0.StartChessStoryLine(arg_32_0, arg_32_1, arg_32_2)
	arg_32_0:HideMainUI()
	arg_32_0:InitPlayer()
	arg_32_0:SetStagePos()

	function arg_32_0.player_.onStoryFinished_(arg_33_0)
		arg_32_0:ShowMainUI()
		manager.notify:CallUpdateFunc(WIN_STORY_END)

		Input.multiTouchEnabled = true

		arg_32_0.player_:Dispose()

		arg_32_0.player_ = nil

		arg_32_2()
	end

	arg_32_0.player_:Play(arg_32_1)
end

function var_0_0.StartChessStoryWithBackground(arg_34_0, arg_34_1, arg_34_2)
	arg_34_0:InitPlayer()
	arg_34_0:SetStagePos()

	local var_34_0, var_34_1 = arg_34_0:SetCameraParam()

	arg_34_0:HideMainUI()

	function arg_34_0.player_.onStoryFinished_(arg_35_0)
		arg_34_0:SendStoryToSdk(arg_34_1, arg_35_0)
		arg_34_0:ShowMainUI()
		manager.notify:CallUpdateFunc(WIN_STORY_END)
		arg_34_0:ResetCameraParam(var_34_0, var_34_1)

		Input.multiTouchEnabled = true

		arg_34_2()
		arg_34_0.player_:Dispose()

		arg_34_0.player_ = nil

		PlayerAction.ChangeStoryList(arg_34_1)
	end

	arg_34_0.player_:Play(arg_34_1)
end

function var_0_0.SetStagePos(arg_36_0)
	local var_36_0 = Vector3(0, -500, 0)

	arg_36_0.stage_.transform.position = var_36_0
	arg_36_0.stage_.transform.localEulerAngles = Vector3(0, 0, 0)
end

function var_0_0.SetCameraParam(arg_37_0, arg_37_1)
	arg_37_0.cameraChanged_ = true

	local var_37_0 = Vector3(0, 1, -10)
	local var_37_1 = 25
	local var_37_2 = arg_37_0.stage_

	arg_37_1 = arg_37_1 or 0

	local var_37_3 = manager.ui.mainCameraCom_.pixelWidth / manager.ui.mainCameraCom_.pixelHeight
	local var_37_4 = Mathf.Lerp(25, 30, math.abs((var_37_3 - 2.335766423357664) / -1.0024330900243308))

	manager.ui:SetMainCameraCom("CinemachineBrain", false)

	manager.ui.mainCamera.transform.parent = var_37_2.transform
	manager.ui.mainCamera.transform.localPosition = var_37_0

	manager.ui:SetMainCameraRot(Vector3.zero)

	local var_37_5 = manager.ui.mainCameraCom_.fieldOfView

	if arg_37_1 == 0 then
		manager.ui.mainCameraCom_.fieldOfView = var_37_4
	else
		local var_37_6 = LeanTween.value(var_37_5, var_37_4, arg_37_1)

		var_37_6:setOnUpdate(LuaHelper.FloatAction(function(arg_38_0)
			manager.ui.mainCameraCom_.fieldOfView = arg_38_0
		end))
		var_37_6:setOnComplete(System.Action(function()
			manager.ui.mainCameraCom_.fieldOfView = var_37_4

			var_37_6:setOnUpdate(nil):setOnComplete(nil)
		end))
	end

	local var_37_7 = false
	local var_37_8 = 0

	arg_37_0.delay_timer_ = Timer.New(function()
		local var_40_0 = manager.ui.mainCamera:GetComponent("CameraExtension")

		if var_40_0 then
			var_37_7 = var_40_0.shadowRotationImmediately
			var_40_0.shadowRotationImmediately = true
			var_37_8 = var_40_0.radialBlurScale
			var_40_0.radialBlurScale = 0
			var_40_0.radialWarpLerp = 0
			var_40_0.radialWarpScale = 0
			var_40_0.radialWarpDensity = 0
			var_40_0.radialAbberationIntensity = 0
		end
	end, 0.05, false, true)

	arg_37_0.delay_timer_:Start()

	arg_37_0.fov_, arg_37_0.shadowRotationImmediately_ = var_37_5, var_37_7
	arg_37_0.radialBlurScal_ = var_37_8
end

function var_0_0.ResetCameraParam(arg_41_0)
	arg_41_0.cameraChanged_ = false

	local var_41_0 = arg_41_0.fov_
	local var_41_1 = arg_41_0.shadowRotationImmediately_
	local var_41_2 = arg_41_0.radialBlurScal_

	manager.ui:SetMainCameraCom("CinemachineBrain", true)

	manager.ui.mainCameraCom_.fieldOfView = var_41_0 or 35
	manager.ui.mainCamera.transform.parent = nil

	manager.ui:SetMainCameraRot()
	manager.ui:SetMainCameraPos()

	local var_41_3 = manager.ui.mainCamera:GetComponent("CameraExtension")

	if var_41_3 then
		var_41_3.shadowRotationImmediately = var_41_1
		var_41_3.radialBlurScale = var_41_2
		var_41_3.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
	end

	if arg_41_0.delay_timer_ then
		arg_41_0.delay_timer_:Stop()

		arg_41_0.delay_timer_ = nil
	end
end

function var_0_0.IsStoryPlayed(arg_42_0, arg_42_1)
	return PlayerData:GetPlayerInfo().storylist[arg_42_1] or false
end

function var_0_0.SendStoryToSdk(arg_43_0, arg_43_1, arg_43_2)
	if not arg_43_2 then
		local var_43_0 = PlayerData:GetStoryList()
		local var_43_1
		local var_43_2 = var_43_0[arg_43_1] and 0 or 1

		SDKTools.SendMessageToSDK("story_oper", {
			story_id = arg_43_1,
			is_first = var_43_2,
			oper = StoryOperDefine.NORMAL
		})
	end
end

function var_0_0.HideMainUI(arg_44_0)
	arg_44_0.uiShow_ = false

	if manager.ui and manager.ui.uiMain then
		manager.ui:SetMainActive(false)
		manager.ui.uiPop.gameObject:SetActive(false)
	end

	manager.notify:Invoke(STORY_AVG_HIDE_MAIN_UI, true)
end

function var_0_0.ShowMainUI(arg_45_0)
	arg_45_0.uiShow_ = true

	if manager.ui and manager.ui.uiMain then
		manager.ui:SetMainActive(true)
		manager.ui.uiPop.gameObject:SetActive(true)
	end

	manager.notify:Invoke(STORY_AVG_HIDE_MAIN_UI, false)
end

function var_0_0.ResetStoryChoice(arg_46_0)
	var_0_2 = {}
end

function var_0_0.IsPlay(arg_47_0)
	if arg_47_0.player_ then
		return arg_47_0.player_.isPlay_
	end

	return false
end

function var_0_0.SetStoryChoice(arg_48_0, arg_48_1)
	table.insert(var_0_2, arg_48_1)
end

function var_0_0.GetStoryChoice(arg_49_0)
	return var_0_2
end

function var_0_0.Dispose(arg_50_0)
	if not arg_50_0.uiShow_ then
		arg_50_0:ShowMainUI()
	end

	if arg_50_0.cameraChanged_ then
		arg_50_0:ResetCameraParam()
	end

	if arg_50_0.player_ then
		arg_50_0.player_:Dispose()

		arg_50_0.player_ = nil
	end

	if arg_50_0.timer_ then
		FuncTimerManager.inst:RemoveFuncTimer(arg_50_0.timer_)

		arg_50_0.timer_ = nil
	end

	manager.audio:PauseAll(false)
end

return var_0_0
