local StoryMgr = class("StoryMgr", import("game.extend.BaseView"))
local var_0_1 = 1
local var_0_2 = {}

function StoryMgr:Ctor()
	self.BEFORE = 1
	self.WIN = 2
	self.LOSE = 3
	self.uiShow_ = true
	self.cameraChanged_ = false
end

function StoryMgr:InitPlayer(arg_2_1)
	self.timer_ = self.timer_ or FuncTimerManager.inst:CreateFuncFrameTimer(function()
		if self.player_ then
			self.player_:Update(Time.deltaTime)
		end
	end, -1, true)
	self.stage_ = Object.Instantiate(Asset.Load("StoryTimeline/StoryStage"))
	self.player_ = StoryPlayer.New(self.stage_)
	self.uiShow_ = true
	self.cameraChanged_ = false
end

function StoryMgr:RemovePlayer()
	manager.video:HidePlayer()

	if self.player_ then
		self:ShowMainUI()
		manager.notify:CallUpdateFunc(WIN_STORY_END)
		self.player_:Dispose()

		self.player_ = nil
	end
end

function StoryMgr:StartStory(arg_5_1)
	local var_5_0 = manager.ui:GetUISeparateRender()
	local var_5_1 = StoryCfg[arg_5_1]

	if StoryCfg[arg_5_1].trigger[4] == 1 then
		gameContext:Go("/blank")
		manager.audio:Pause("music", true)
		manager.video:Play(StoryCfg[arg_5_1].videoPath, function(arg_6_0)
			SDKTools.SendMessageToSDK("story_oper", {
				oper = arg_6_0,
				is_first = PlayerData:GetStoryList()[arg_5_1] and 0 or 1,
				story_id = string.format(arg_5_1)
			})
			gameContext:Back()
			PlayerAction.ChangeStoryList(arg_5_1)
			manager.audio:Pause("music", false)
		end, nil, nil, nil, StoryCfg[arg_5_1].videoId)

		return
	end

	self:InitPlayer()
	self:SetStagePos()

	local var_5_2, var_5_3 = self:SetCameraParam()

	self:HideMainUI()

	function self.player_.onStoryFinished_(arg_7_0)
		self:SendStoryToSdk(arg_5_1, arg_7_0)
		self:ShowMainUI()
		manager.notify:CallUpdateFunc(WIN_STORY_END)
		self:ResetCameraParam(var_5_2, var_5_3)

		Input.multiTouchEnabled = true

		self.player_:Dispose()

		self.player_ = nil

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

	self.player_:Play(arg_5_1)
end

function StoryMgr:StartStoryById(arg_9_1, arg_9_2, arg_9_3)
	if StoryCfg[arg_9_1].trigger[4] == 1 then
		manager.audio:Pause("music", true)
		manager.video:Play(StoryCfg[arg_9_1].videoPath, function(arg_10_0)
			SDKTools.SendMessageToSDK("story_oper", {
				oper = arg_10_0,
				is_first = PlayerData:GetStoryList()[arg_9_1] and 0 or 1,
				story_id = string.format(arg_9_1)
			})
			arg_9_2()
			PlayerAction.ChangeStoryList(arg_9_1)
			manager.audio:Pause("music", false)
		end, nil, nil, nil, StoryCfg[arg_9_1].videoId)

		return
	end

	self:InitPlayer()
	self:SetStagePos()

	local var_9_0, var_9_1 = self:SetCameraParam()

	self:HideMainUI()

	function self.player_.onStoryFinished_(arg_11_0)
		self:SendStoryToSdk(arg_9_1, arg_11_0)
		self:ShowMainUI()
		manager.notify:CallUpdateFunc(WIN_STORY_END)
		self:ResetCameraParam(var_9_0, var_9_1)

		Input.multiTouchEnabled = true

		self.player_:Dispose()

		self.player_ = nil

		PlayerAction.ChangeStoryList(arg_9_1)
		arg_9_2()
	end

	self.player_:HideSkipBtn(arg_9_3)
	self.player_:Play(arg_9_1)
end

function StoryMgr:StartStoryOnEnterChessMap(arg_12_1, arg_12_2)
	self:InitPlayer()
	self:SetStagePos()

	local var_12_0, var_12_1 = self:SetCameraParam()

	self:HideMainUI()

	function self.player_.onStoryFinished_(arg_13_0)
		self:SendStoryToSdk(arg_12_1, arg_13_0)
		arg_12_2()
		manager.notify:CallUpdateFunc(WIN_STORY_END)
		self:ResetCameraParam(var_12_0, var_12_1)

		Input.multiTouchEnabled = true

		self.player_:Dispose()

		self.player_ = nil

		PlayerAction.ChangeStoryList(arg_12_1)
	end

	self.player_:Play(arg_12_1)
end

function StoryMgr:StartBattleStory(arg_14_1, arg_14_2, arg_14_3)
	if arg_14_3 == nil then
		arg_14_3 = true
	end

	local var_14_0 = StoryCfg[arg_14_1]

	if StoryCfg[arg_14_1].trigger[4] == 1 then
		gameContext:Go("/blank")
		manager.audio:Pause("music", true)
		manager.video:Play(var_14_0.videoPath, function(arg_15_0)
			SDKTools.SendMessageToSDK("story_oper", {
				oper = arg_15_0,
				is_first = PlayerData:GetStoryList()[arg_14_1] and 0 or 1,
				story_id = string.format(arg_14_1)
			})
			gameContext:Back()
			arg_14_2()
			PlayerAction.ChangeStoryList(arg_14_1)
			manager.audio:Pause("music", false)
		end, true, nil, nil, var_14_0.videoId)

		return
	end

	if arg_14_3 and self:IsStoryPlayed(arg_14_1) then
		arg_14_2()
	else
		self:InitPlayer()

		local var_14_1 = Vector3(0, 1, -10)

		manager.ui.mainCamera.transform.forward.y = 0
		manager.ui.mainCamera.transform.localEulerAngles.z = 0
		manager.ui.mainCamera.transform.localEulerAngles.x = 0
		self.stage_.transform.position = manager.ui.mainCamera.transform.position - Vector3(0, var_14_1.y, 0) - manager.ui.mainCamera.transform.forward * var_14_1.z
		self.stage_.transform.localEulerAngles = manager.ui.mainCamera.transform.localEulerAngles

		local var_14_2, var_14_3 = self:SetCameraParam()

		self:HideMainUI()

		function self.player_.onStoryFinished_(arg_16_0)
			self:SendStoryToSdk(arg_14_1, arg_16_0)
			self:ShowMainUI()
			manager.notify:CallUpdateFunc(WIN_STORY_END)
			self:ResetCameraParam(var_14_2, var_14_3)

			Input.multiTouchEnabled = true

			self.player_:Dispose()

			self.player_ = nil

			arg_14_2()
		end

		self.player_:Play(arg_14_1)
	end
end

function StoryMgr:CheckBattleStory(arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	if arg_17_4 == nil then
		arg_17_4 = true
	end

	local var_17_0
	local var_17_1

	for iter_17_0, iter_17_1 in pairs(StoryCfg) do
		if iter_17_1.trigger[1] == var_0_1 and iter_17_1.trigger[2] == arg_17_1 and iter_17_1.trigger[3] == arg_17_2 then
			var_17_0 = iter_17_0
			var_17_1 = iter_17_1

			if iter_17_1.trigger[4] == 1 then
				manager.audio:Stop("music", true)
				manager.video:Play(iter_17_1.videoPath, function(arg_18_0)
					SDKTools.SendMessageToSDK("story_oper", {
						oper = arg_18_0,
						is_first = PlayerData:GetStoryList()[var_17_0] and 0 or 1,
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

	if not var_17_0 or arg_17_4 and self:IsStoryPlayed(var_17_0) then
		arg_17_3()
	else
		local function var_17_2()
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
		LuaExchangeHelper.LoadEmpty(LuaHelper.VoidAction(var_17_2))
	end
end

function StoryMgr:CheckBeforeBattleStory(arg_23_1, arg_23_2, arg_23_3)
	if arg_23_2 == nil then
		arg_23_2 = true
	end

	local var_23_0 = arg_23_1
	local var_23_1

	for iter_23_0, iter_23_1 in pairs(StoryCfg) do
		if iter_23_1.trigger[1] == var_0_1 and iter_23_1.trigger[2] == var_23_0 and iter_23_1.trigger[3] == self.BEFORE then
			var_23_1 = iter_23_0

			if iter_23_1.trigger[4] == 1 then
				manager.audio:Stop("music", true)
				manager.video:Play(iter_23_1.videoPath, function(arg_24_0)
					SDKTools.SendMessageToSDK("story_oper", {
						oper = arg_24_0,
						is_first = PlayerData:GetStoryList()[var_23_1] and 0 or 1,
						story_id = string.format(var_23_1)
					})
					arg_23_3()
					PlayerAction.ChangeStoryList(var_23_1, function(arg_25_0, arg_25_1)
						return
					end, nil, nil, nil, iter_23_1.id)
				end)

				return
			end

			break
		end
	end

	if not var_23_1 or arg_23_2 and self:IsStoryPlayed(var_23_1) then
		arg_23_3()
	else
		self:InitPlayer()
		self:SetStagePos()

		local var_23_2, var_23_3 = self:SetCameraParam()

		self:HideMainUI()

		function self.player_.onStoryFinished_(arg_26_0)
			self:SendStoryToSdk(var_23_1, arg_26_0)

			self.player_.playNext_ = nil
			self.player_.isPlay_ = false

			self:ResetCameraParam(var_23_2, var_23_3)

			Input.multiTouchEnabled = true

			arg_23_3()
			PlayerAction.ChangeStoryList(var_23_1)
		end

		self.player_:Play(var_23_1)
	end
end

function StoryMgr:CheckChessBattleStory(arg_27_1, arg_27_2)
	local var_27_0 = WarChessData:GetTemporaryData("battle" .. arg_27_1)

	if var_27_0 and not self:IsStoryPlayed(var_27_0) then
		self:InitPlayer()
		self:SetStagePos()

		local var_27_1, var_27_2 = self:SetCameraParam()

		self:HideMainUI()

		function self.player_.onStoryFinished_(arg_28_0)
			self:SendStoryToSdk(var_27_0, arg_28_0)
			self:ResetCameraParam(var_27_1, var_27_2)

			Input.multiTouchEnabled = true
			self.player_.playNext_ = nil
			self.player_.isPlay_ = false

			arg_27_2()
			PlayerAction.ChangeStoryList(var_27_0)
		end

		self.player_:Play(var_27_0)
	else
		arg_27_2()
	end
end

function StoryMgr:CheckRepeatBattleStory(arg_29_1, arg_29_2, arg_29_3)
	self:CheckBeforeBattleStory(arg_29_1, false, arg_29_3)
end

function StoryMgr:SetChessBG(arg_30_1)
	WaitRenderFrameUtil.inst.StartScreenShot(function()
		local var_31_0 = ScreenSnap.New(Screen.width, Screen.height)

		var_31_0:Take()
		arg_30_1()

		if self.player_.bgs_.ChessBG == nil then
			local var_31_1 = Object.Instantiate(self.player_.paintGo_)

			var_31_1:GetComponent("SpriteRenderer").sprite = var_31_0:GetSprite()
			var_31_1.name = "ChessBG"
			var_31_1.transform.parent = self.player_.stage_.transform
			var_31_1.transform.localPosition = Vector3.New(0, 100, 0)
			self.player_.bgs_.ChessBG = var_31_1
		end

		local var_31_2 = manager.ui.mainCamera.transform.localPosition
		local var_31_3 = self.player_.bgs_.ChessBG

		self.player_.bgs_.ChessBG.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
		var_31_3.transform.localEulerAngles = Vector3(0, 0, 0)

		local var_31_4 = var_31_3:GetComponent("SpriteRenderer")

		if var_31_4 and var_31_4.sprite then
			local var_31_5 = 2 * (var_31_3.transform.localPosition - var_31_2).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

			var_31_3.transform.localScale = Vector3.New(var_31_5 / var_31_4.sprite.bounds.size.y < var_31_5 * manager.ui.mainCameraCom_.aspect / var_31_4.sprite.bounds.size.x and var_31_5 * manager.ui.mainCameraCom_.aspect / var_31_4.sprite.bounds.size.x or var_31_5 / var_31_4.sprite.bounds.size.y, var_31_5 / var_31_4.sprite.bounds.size.y < var_31_5 * manager.ui.mainCameraCom_.aspect / var_31_4.sprite.bounds.size.x and var_31_5 * manager.ui.mainCameraCom_.aspect / var_31_4.sprite.bounds.size.x or var_31_5 / var_31_4.sprite.bounds.size.y, 0)
		end
	end)
end

function StoryMgr:StartChessStoryLine(arg_32_1, arg_32_2)
	self:HideMainUI()
	self:InitPlayer()
	self:SetStagePos()

	function self.player_.onStoryFinished_(arg_33_0)
		self:ShowMainUI()
		manager.notify:CallUpdateFunc(WIN_STORY_END)

		Input.multiTouchEnabled = true

		self.player_:Dispose()

		self.player_ = nil

		arg_32_2()
	end

	self.player_:Play(arg_32_1)
end

function StoryMgr:StartChessStoryWithBackground(arg_34_1, arg_34_2)
	self:InitPlayer()
	self:SetStagePos()

	local var_34_0, var_34_1 = self:SetCameraParam()

	self:HideMainUI()

	function self.player_.onStoryFinished_(arg_35_0)
		self:SendStoryToSdk(arg_34_1, arg_35_0)
		self:ShowMainUI()
		manager.notify:CallUpdateFunc(WIN_STORY_END)
		self:ResetCameraParam(var_34_0, var_34_1)

		Input.multiTouchEnabled = true

		arg_34_2()
		self.player_:Dispose()

		self.player_ = nil

		PlayerAction.ChangeStoryList(arg_34_1)
	end

	self.player_:Play(arg_34_1)
end

function StoryMgr:SetStagePos()
	self.stage_.transform.position = Vector3(0, -500, 0)
	self.stage_.transform.localEulerAngles = Vector3(0, 0, 0)
end

function StoryMgr:SetCameraParam(arg_37_1)
	self.cameraChanged_ = true
	arg_37_1 = arg_37_1 or 0

	local var_37_1 = Mathf.Lerp(25, 30, math.abs((manager.ui.mainCameraCom_.pixelWidth / manager.ui.mainCameraCom_.pixelHeight - 2.335766423357664) / -1.0024330900243308))

	manager.ui:SetMainCameraCom("CinemachineBrain", false)

	manager.ui.mainCamera.transform.parent = self.stage_.transform
	manager.ui.mainCamera.transform.localPosition = Vector3(0, 1, -10)

	manager.ui:SetMainCameraRot(Vector3.zero)

	local var_37_2 = manager.ui.mainCameraCom_.fieldOfView

	if arg_37_1 == 0 then
		manager.ui.mainCameraCom_.fieldOfView = var_37_1
	else
		local var_37_3 = LeanTween.value(var_37_2, var_37_1, arg_37_1)

		var_37_3:setOnUpdate(LuaHelper.FloatAction(function(arg_38_0)
			manager.ui.mainCameraCom_.fieldOfView = arg_38_0
		end))
		var_37_3:setOnComplete(System.Action(function()
			manager.ui.mainCameraCom_.fieldOfView = var_37_1

			var_37_3:setOnUpdate(nil):setOnComplete(nil)
		end))
	end

	local var_37_4 = false
	local var_37_5 = 0

	self.delay_timer_ = Timer.New(function()
		local var_40_0 = manager.ui.mainCamera:GetComponent("CameraExtension")

		if var_40_0 then
			var_37_4 = var_40_0.shadowRotationImmediately
			var_40_0.shadowRotationImmediately = true
			var_37_5 = var_40_0.radialBlurScale
			var_40_0.radialBlurScale = 0
			var_40_0.radialWarpLerp = 0
			var_40_0.radialWarpScale = 0
			var_40_0.radialWarpDensity = 0
			var_40_0.radialAbberationIntensity = 0
		end
	end, 0.05, false, true)

	self.delay_timer_:Start()

	self.fov_, self.shadowRotationImmediately_ = var_37_2, var_37_4
	self.radialBlurScal_ = 0
end

function StoryMgr:ResetCameraParam()
	self.cameraChanged_ = false

	manager.ui:SetMainCameraCom("CinemachineBrain", true)

	manager.ui.mainCameraCom_.fieldOfView = self.fov_ or 35
	manager.ui.mainCamera.transform.parent = nil

	manager.ui:SetMainCameraRot()
	manager.ui:SetMainCameraPos()

	local var_41_0 = manager.ui.mainCamera:GetComponent("CameraExtension")

	if var_41_0 then
		var_41_0.shadowRotationImmediately = self.shadowRotationImmediately_
		var_41_0.radialBlurScale = self.radialBlurScal_
		var_41_0.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
	end

	if self.delay_timer_ then
		self.delay_timer_:Stop()

		self.delay_timer_ = nil
	end
end

function StoryMgr:IsStoryPlayed(arg_42_1)
	return PlayerData:GetPlayerInfo().storylist[arg_42_1] or false
end

function StoryMgr:SendStoryToSdk(arg_43_1, arg_43_2)
	if not arg_43_2 then
		SDKTools.SendMessageToSDK("story_oper", {
			story_id = arg_43_1,
			is_first = PlayerData:GetStoryList()[arg_43_1] and 0 or 1,
			oper = StoryOperDefine.NORMAL
		})
	end
end

function StoryMgr:HideMainUI()
	self.uiShow_ = false

	if manager.ui and manager.ui.uiMain then
		manager.ui:SetMainActive(false)
		manager.ui.uiPop.gameObject:SetActive(false)
	end

	manager.notify:Invoke(STORY_AVG_HIDE_MAIN_UI, true)
end

function StoryMgr:ShowMainUI()
	self.uiShow_ = true

	if manager.ui and manager.ui.uiMain then
		manager.ui:SetMainActive(true)
		manager.ui.uiPop.gameObject:SetActive(true)
	end

	manager.notify:Invoke(STORY_AVG_HIDE_MAIN_UI, false)
end

function StoryMgr:ResetStoryChoice()
	var_0_2 = {}
end

function StoryMgr:IsPlay()
	if self.player_ then
		return self.player_.isPlay_
	end

	return false
end

function StoryMgr:SetStoryChoice(arg_48_1)
	table.insert(var_0_2, arg_48_1)
end

function StoryMgr:GetStoryChoice()
	return var_0_2
end

function StoryMgr:Dispose()
	if not self.uiShow_ then
		self:ShowMainUI()
	end

	if self.cameraChanged_ then
		self:ResetCameraParam()
	end

	if self.player_ then
		self.player_:Dispose()

		self.player_ = nil
	end

	if self.timer_ then
		FuncTimerManager.inst:RemoveFuncTimer(self.timer_)

		self.timer_ = nil
	end

	manager.audio:PauseAll(false)
end

return StoryMgr
